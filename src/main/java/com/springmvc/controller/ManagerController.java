package com.springmvc.controller;

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
import com.springmvc.model.Manager;
import com.springmvc.model.Member;
import com.springmvc.model.Rent;
import com.springmvc.model.RentalDeposit;
import com.springmvc.model.ThanachokManager;

@Controller
public class ManagerController {

	// ✅ หน้าเจ้าของหอ (ดูห้องทั้งหมด)
	// แก้ไข Method showOwnerRooms ใน ManagerController.java

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

		// ✅ เพิ่มข้อมูลสถานะการอนุมัติสำหรับแต่ละห้อง
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

	// GET: แสดงฟอร์มเพิ่มห้อง
	@RequestMapping(value = "/AddRoom", method = RequestMethod.GET)
	public String showAddRoomForm() {
		return "AddRoom";
	}

	// POST: บันทึกห้องใหม่
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



	// GET: แสดงรายการจองทั้งหมด
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

	// POST: ยืนยันการชำระเงินและเปลี่ยนสถานะเป็น "เสร็จสมบูรณ์"
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

	/* อัปเดตข้อมูลห้อง */
	@RequestMapping(value = "/UpdateRoom", method = RequestMethod.POST)
	public String updateRoom(@RequestParam("roomID") int roomID, @RequestParam("roomNumber") String roomNumber,
			@RequestParam("description") String description, @RequestParam("roomPrice") String roomPrice,
			@RequestParam("roomtype") String roomtype, @RequestParam("images") MultipartFile[] images,
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

	@RequestMapping(value = "/deleteRoom", method = RequestMethod.GET)
	public String deleteRoom(@RequestParam("id") int roomId, Model model) {
		ThanachokManager manager = new ThanachokManager();
		boolean success = manager.deleteRoom(roomId);

		if (success) {
			model.addAttribute("message", "ลบห้องสำเร็จ");
		} else {
			model.addAttribute("error", "ไม่สามารถลบห้องได้ เพราะสถานะไม่ว่างหรือเกิดข้อผิดพลาด");
		}

		List<Room> rooms = manager.getAllrooms();
		model.addAttribute("rooms", rooms);
		return "OwnerHome";
	}

	@RequestMapping(value = "/Listinvoice", method = RequestMethod.GET)
	public ModelAndView listInvoices(HttpSession session) {
		Member member = (Member) session.getAttribute("loginMember");
		if (member == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager manager = new ThanachokManager();
		List<Invoice> invoiceList = manager.findInvoicesByMember(member.getMemberID());

		ModelAndView mav = new ModelAndView("Listinvoice");
		mav.addObject("invoiceList", invoiceList);
		return mav;
	}

	@RequestMapping(value = "/Detailinvoice", method = RequestMethod.GET)
	public ModelAndView invoiceDetail(@RequestParam("billID") int billID, HttpSession session) {
		Member member = (Member) session.getAttribute("loginMember");
		if (member == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager manager = new ThanachokManager();
		Invoice invoice = manager.findInvoiceById(billID);
		List<InvoiceDetail> details = manager.findInvoiceDetailsByInvoiceId(billID);

		ModelAndView mav = new ModelAndView("Detailinvoice");
		mav.addObject("invoice", invoice);
		mav.addObject("invoiceDetails", details);
		return mav;
	}

	// แสดงรายการใบแจ้งหนี้ของห้องที่เลือก
	@RequestMapping(value = "/EditInvoice", method = RequestMethod.GET)
	public ModelAndView showEditInvoice(@RequestParam("roomID") int roomID, HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();

		Room room = tm.findRoomById(roomID);

		List<Invoice> invoices = tm.getInvoicesByRoomID(roomID);

		ModelAndView mav = new ModelAndView("EditInvoice");
		mav.addObject("room", room);
		mav.addObject("invoices", invoices);
		return mav;
	}

	// แสดงฟอร์มแก้ไขใบแจ้งหนี้เฉพาะ
	@RequestMapping(value = "/EditInvoiceForm", method = RequestMethod.GET)
	public ModelAndView showEditInvoiceForm(@RequestParam("invoiceId") int invoiceId, HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();

		// ใช้ getInvoiceWithDetails แทน เพื่อให้ได้ข้อมูลครบถ้วน
		Invoice invoice = tm.getInvoiceWithDetails(invoiceId);

		if (invoice == null) {
			ModelAndView mav = new ModelAndView("EditInvoice");
			mav.addObject("error", "ไม่พบใบแจ้งหนี้ที่ต้องการแก้ไข");
			return mav;
		}

		ModelAndView mav = new ModelAndView("EditInvoiceForm");
		mav.addObject("invoice", invoice);
		mav.addObject("invoiceDetails", invoice.getDetails()); // ใช้จาก invoice.getDetails() แทน
		return mav;
	}

	// บันทึกการแก้ไขใบแจ้งหนี้
	@RequestMapping(value = "/UpdateInvoice", method = RequestMethod.POST)
	public ModelAndView updateInvoice(HttpServletRequest request, HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		try {
			int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
			int status = Integer.parseInt(request.getParameter("status"));

			ThanachokManager tm = new ThanachokManager();
			Invoice invoice = tm.getInvoiceById(invoiceId);

			if (invoice != null) {
				invoice.setStatus(status);
				tm.updateInvoice(invoice);

				ModelAndView mav = new ModelAndView("redirect:/EditInvoice");
				mav.addObject("roomID", invoice.getRent().getRoom().getRoomID());
				mav.addObject("message", "อัปเดตใบแจ้งหนี้เรียบร้อยแล้ว");
				return mav;
			} else {
				ModelAndView mav = new ModelAndView("EditInvoiceForm");
				mav.addObject("error", "ไม่พบใบแจ้งหนี้ที่ต้องการอัปเดต");
				return mav;
			}

		} catch (Exception e) {
			e.printStackTrace();
			ModelAndView mav = new ModelAndView("EditInvoiceForm");
			mav.addObject("error", "เกิดข้อผิดพลาดในการอัปเดตข้อมูล: " + e.getMessage());
			return mav;
		}
	}

	// เพิ่มเมธอดนี้ใน ManagerController.java

	// แก้ไขเมธอด deleteInvoice ใน ManagerController.java

	@RequestMapping(value = "/DeleteInvoice", method = RequestMethod.GET)
	public String deleteInvoice(@RequestParam("invoiceId") int invoiceId,
			@RequestParam("roomID") int roomID,
			HttpSession session,
			RedirectAttributes redirectAttributes) {

		System.out.println("=== Delete Invoice Request ===");
		System.out.println("Invoice ID: " + invoiceId);
		System.out.println("Room ID: " + roomID);

		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			System.out.println("No manager session - redirecting to login");
			return "redirect:/Login";
		}

		try {
			ThanachokManager tm = new ThanachokManager();

			// ตรวจสอบว่าใบแจ้งหนี้มีอยู่จริงและดึงข้อมูล
			Invoice invoice = tm.getInvoiceWithStatus(invoiceId);

			if (invoice == null) {
				redirectAttributes.addFlashAttribute("error",
						"ไม่พบใบแจ้งหนี้ที่ต้องการลบ (ID: " + invoiceId + ")");
				return "redirect:/EditInvoice?roomID=" + roomID;
			}

			// ตรวจสอบสถานะการชำระ
			if (invoice.getStatus() == 1) {
				redirectAttributes.addFlashAttribute("error",
						"ไม่สามารถลบใบแจ้งหนี้ INV-" + invoiceId + " ได้ เนื่องจากได้ชำระเงินแล้ว");
				System.out.println("Cannot delete paid invoice: " + invoiceId);
				return "redirect:/EditInvoice?roomID=" + roomID;
			}

			// ลบใบแจ้งหนี้
			System.out.println("Attempting to delete unpaid invoice: " + invoiceId);
			boolean deleted = tm.deleteInvoice(invoiceId);

			if (deleted) {
				redirectAttributes.addFlashAttribute("message",
						"ลบใบแจ้งหนี้ INV-" + invoiceId + " เรียบร้อยแล้ว");
				System.out.println("Successfully deleted invoice: " + invoiceId);
			} else {
				redirectAttributes.addFlashAttribute("error",
						"ไม่สามารถลบใบแจ้งหนี้ได้ กรุณาลองใหม่อีกครั้ง");
				System.out.println("Failed to delete invoice: " + invoiceId);
			}

		} catch (RuntimeException re) {
			// จัดการ error ที่เกิดจากการตรวจสอบสถานะ
			System.out.println("Runtime exception: " + re.getMessage());
			redirectAttributes.addFlashAttribute("error", re.getMessage());
		} catch (Exception e) {
			System.out.println("General exception: " + e.getMessage());
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error",
					"เกิดข้อผิดพลาดในระบบ: " + e.getMessage());
		}

		return "redirect:/EditInvoice?roomID=" + roomID;
	}

	// เพิ่มเมธอดสำหรับตรวจสอบสถานะก่อนแสดงปุ่มลบ (ไว้ใช้ใน JSP)
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

	// เพิ่มใน ManagerController.java สำหรับดูรายละเอียดใบแจ้งหนี้
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
