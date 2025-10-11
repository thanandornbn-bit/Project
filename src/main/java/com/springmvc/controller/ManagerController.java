package com.springmvc.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Room;
import com.springmvc.model.Invoice;
import com.springmvc.model.InvoiceDetail;
import com.springmvc.model.InvoiceType;
import com.springmvc.model.Manager;
import com.springmvc.model.Member;
import com.springmvc.model.Rent;
import com.springmvc.model.RentalDeposit;
import com.springmvc.model.ThanachokManager;

@Controller
public class ManagerController {

	@RequestMapping(value = "/OwnerHome", method = RequestMethod.GET)
	public ModelAndView showOwnerRooms(HttpSession session,
			@RequestParam(value = "floor", required = false) String floor,
			@RequestParam(value = "status", required = false) String status) {

		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();
		List<Room> roomList = tm.findRoomsByFloorAndStatus(floor, status);

		//เพิ่มข้อมูลสถานะการอนุมัติสำหรับแต่ละห้อง
		Map<Integer, Boolean> roomApprovalStatus = new HashMap<>();
		Map<Integer, String> roomDepositStatus = new HashMap<>();

		for (Room room : roomList) {
			if ("ไม่ว่าง".equals(room.getRoomStatus())) {
				// ตรวจสอบว่าห้องนี้ได้รับการอนุมัติแล้วหรือไม่
				boolean isApproved = tm.isRoomApproved(room.getRoomID());
				roomApprovalStatus.put(room.getRoomID(), isApproved);

				// ดึงสถานะของ RentalDeposit
				RentalDeposit deposit = tm.getRentalDepositByRoomID(room.getRoomID());
				if (deposit != null) {
					roomDepositStatus.put(room.getRoomID(), deposit.getStatus());
				} else {
					roomDepositStatus.put(room.getRoomID(), "ไม่มีข้อมูล");
				}
			} else {
				roomApprovalStatus.put(room.getRoomID(), false);
				roomDepositStatus.put(room.getRoomID(), "ว่าง");
			}
		}

		ModelAndView mav = new ModelAndView("OwnerHome");
		mav.addObject("roomList", roomList);
		mav.addObject("roomApprovalStatus", roomApprovalStatus);
		mav.addObject("roomDepositStatus", roomDepositStatus);
		mav.addObject("floor", floor == null ? "" : floor);
		mav.addObject("status", status == null ? "" : status);
		return mav;
	}

	//แสดงฟอร์มเพิ่มห้อง
	@RequestMapping(value = "/AddRoom", method = RequestMethod.GET)
	public String showAddRoomForm() {
		return "AddRoom";
	}

	//บันทึกห้องใหม่
	@RequestMapping(value = "/AddRoom", method = RequestMethod.POST)
	public String saveRoom(@RequestParam("roomNumber") String roomNumber,
			@RequestParam("description") String description,
			@RequestParam("roomPrice") String roomPrice,
			@RequestParam("roomStatus") String roomStatus,
			@RequestParam("roomtype") String roomtype,
			Model model) {

		ThanachokManager manager = new ThanachokManager();

		// ตรวจสอบว่าหมายเลขห้องซ้ำหรือไม่
		if (manager.isRoomNumberExists(roomNumber)) {
			model.addAttribute("errorMessage", "หมายเลขห้อง " + roomNumber + " มีอยู่ในระบบแล้ว กรุณาใช้หมายเลขอื่น");
			// ส่งค่ากลับไปให้ user ไม่ต้องกรอกใหม่
			Room room = new Room();
			room.setRoomNumber(roomNumber);
			room.setDescription(description);
			room.setRoomPrice(roomPrice);
			room.setRoomStatus(roomStatus);
			room.setRoomtype(roomtype);
			model.addAttribute("room", room);
			return "AddRoom";
		}

		Room room = new Room();
		room.setRoomNumber(roomNumber);
		room.setDescription(description);
		room.setRoomPrice(roomPrice);
		room.setRoomStatus(roomStatus);
		room.setRoomtype(roomtype);

		boolean success = manager.insertRoom(room);

		if (success) {
			model.addAttribute("message", "เพิ่มห้อง " + roomNumber + " เรียบร้อยแล้ว");
		} else {
			model.addAttribute("errorMessage", "เกิดข้อผิดพลาดในการเพิ่มห้อง กรุณาลองใหม่อีกครั้ง");
		}

		return "AddRoom";
	}

	//แสดงรายการจองทั้งหมด
	@RequestMapping(value = "/OViewReserve", method = RequestMethod.GET)
	public String viewAllReservations(Model model) {
		ThanachokManager manager = new ThanachokManager();
		List<Rent> rentList = manager.findAllRentsWithDeposits();
		model.addAttribute("rentList", rentList);
		return "OViewReserve";
	}

	@RequestMapping(value = "/ViewReservationDetail", method = RequestMethod.GET)
	public ModelAndView viewReservationDetail(@RequestParam("rentId") int rentId, HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager thanachokManager = new ThanachokManager();
		Rent rent = thanachokManager.findRentById(rentId);

		ModelAndView mav = new ModelAndView("ViewReservationDetail");
		mav.addObject("rent", rent);

		// เพิ่ม error handling
		if (rent == null) {
			mav.addObject("error", "ไม่พบข้อมูลการจองที่ต้องการ");
		}

		return mav;
	}

	//ยืนยันการชำระเงินและเปลี่ยนสถานะเป็น "เสร็จสมบูรณ์"
	@RequestMapping(value = "/ConfirmRentalDeposit", method = RequestMethod.POST)
	public String confirmRentalDeposit(@RequestParam("depositId") int depositId, Model model) {
		ThanachokManager manager = new ThanachokManager();
		RentalDeposit deposit = manager.getRentalDepositById(depositId);

		if (deposit != null && !"เสร็จสมบูรณ์".equals(deposit.getStatus())) {
			deposit.setStatus("เสร็จสมบูรณ์");
			manager.updateRentalDeposit(deposit);
			model.addAttribute("message", "ยืนยันเรียบร้อยแล้ว");
		}

		Rent rent = manager.findRentById(deposit.getRent().getRentID());
		model.addAttribute("rent", rent);
		return "ViewReservationDetail";
	}

	@RequestMapping(value = "/approveDeposit", method = RequestMethod.POST)
	public String approveDeposit(@RequestParam("depositID") int depositID) {
		ThanachokManager manager = new ThanachokManager();
		boolean updated = manager.confirmRentalDeposit(depositID);

		if (updated) {
			return "redirect:/OViewReserve";
		} else {
			return "redirect:/ViewReservationDetail.jsp?error=approve_failed";
		}
	}

	@RequestMapping(value = "/editRoom", method = RequestMethod.GET)
	public ModelAndView showEditRoomForm(@RequestParam("id") int roomID, HttpSession session) {

		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();
		Room room = tm.findRoomById(roomID);

		ModelAndView mav = new ModelAndView("EditRoom");
		mav.addObject("room", room);
		return mav;
	}

	// อัปเดตข้อมูลห้อง
	@RequestMapping(value = "/UpdateRoom", method = RequestMethod.POST)
	public String updateRoom(@RequestParam("roomID") int roomID, @RequestParam("roomNumber") String roomNumber,
			@RequestParam("description") String description, @RequestParam("roomPrice") String roomPrice,
			@RequestParam("roomtype") String roomtype,
			RedirectAttributes redirect) {

		ThanachokManager tm = new ThanachokManager();
		Room room = tm.findRoomById(roomID);

		room.setRoomNumber(roomNumber);
		room.setDescription(description);
		room.setRoomPrice(roomPrice);

		room.setRoomtype(roomtype);

		tm.updateRoom(room);
		redirect.addFlashAttribute("message", "แก้ไขห้องเรียบร้อย");
		return "redirect:/OwnerHome";
	}

	//ลบห้อง
	@RequestMapping(value = "/deleteRoom", method = RequestMethod.GET)
	public String deleteRoom(@RequestParam(value = "id", required = false) Integer roomId,
			RedirectAttributes redirectAttributes) {

		if (roomId == null) {
			redirectAttributes.addFlashAttribute("error", "ไม่พบรหัสห้องที่ต้องการลบ");
			return "redirect:/OwnerHome";
		}

		ThanachokManager manager = new ThanachokManager();
		Room room = manager.findRoomById(roomId);

		if (room == null) {
			redirectAttributes.addFlashAttribute("error", "ไม่พบห้องที่ต้องการลบ");
			return "redirect:/OwnerHome";
		}

		if (!"ว่าง".equals(room.getRoomStatus())) {
			redirectAttributes.addFlashAttribute("error",
					"ไม่สามารถลบห้อง " + room.getRoomNumber() + " ได้ เนื่องจากห้องมีสถานะ: " + room.getRoomStatus());
			return "redirect:/OwnerHome";
		}

		boolean success = manager.deleteRoom(roomId);

		if (success) {
			redirectAttributes.addFlashAttribute("message", "ลบห้อง " + room.getRoomNumber() + " สำเร็จ");
		} else {
			redirectAttributes.addFlashAttribute("error", "เกิดข้อผิดพลาดในการลบห้อง");
		}

		return "redirect:/OwnerHome";
	}


	//เช็คสถานะใบแจ้งหนี้
	@RequestMapping(value = "/CheckInvoiceStatus", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> checkInvoiceStatus(@RequestParam("invoiceId") int invoiceId) {
		Map<String, Object> result = new HashMap<>();

		try {
			ThanachokManager tm = new ThanachokManager();
			boolean canDelete = tm.canDeleteInvoice(invoiceId);

			result.put("canDelete", canDelete);
			result.put("invoiceId", invoiceId);

			if (!canDelete) {
				result.put("reason", "ใบแจ้งหนี้นี้ได้ชำระเงินแล้ว จึงไม่สามารถลบได้");
			}

		} catch (Exception e) {
			result.put("canDelete", false);
			result.put("error", e.getMessage());
		}

		return result;
	}

	// ดูรายละเอียดใบแจ้งหนี้
	@RequestMapping(value = "/ViewInvoiceDetail", method = RequestMethod.GET)
	public ModelAndView viewInvoiceDetail(@RequestParam("invoiceId") int invoiceId,
			HttpSession session) {

		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();
		Invoice invoice = tm.getInvoiceWithDetails(invoiceId);

		if (invoice == null) {
			ModelAndView mav = new ModelAndView("redirect:/OwnerHome");
			mav.addObject("error", "ไม่พบใบแจ้งหนี้ที่ต้องการ");
			return mav;
		}

		ModelAndView mav = new ModelAndView("ViewInvoiceDetail");
		mav.addObject("invoice", invoice);
		mav.addObject("invoiceDetails", invoice.getDetails());
		return mav;
	}




}
