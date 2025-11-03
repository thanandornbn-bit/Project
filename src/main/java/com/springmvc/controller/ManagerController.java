package com.springmvc.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Room;
import com.springmvc.model.Invoice;
import com.springmvc.model.Manager;
import com.springmvc.model.Rent;
import com.springmvc.model.ThanachokManager;
import com.springmvc.model.UtilityRate;

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

		// เรียกใช้ method ที่แก้ไขแล้ว - จะดึงทั้งหมดถ้าไม่มี parameter
		List<Room> roomList = tm.findRoomsByFloorAndStatus(floor, status);

		// เพิ่มข้อมูลสถานะการอนุมัติสำหรับแต่ละห้อง
		Map<Integer, Boolean> roomApprovalStatus = new HashMap<>();
		Map<Integer, String> roomDepositStatus = new HashMap<>();
		Map<Integer, Integer> roomRentId = new HashMap<>();

		for (Room room : roomList) {
			System.out.println("Room: " + room.getRoomNumber() + " - Status: " + room.getRoomStatus());

			if ("ไม่ว่าง".equals(room.getRoomStatus())) {
				boolean isApproved = tm.isRoomApproved(room.getRoomID());
				roomApprovalStatus.put(room.getRoomID(), isApproved);

				Rent deposit = tm.getRentByRoomID(room.getRoomID());
				if (deposit != null) {
					roomDepositStatus.put(room.getRoomID(), deposit.getStatus());
					// เก็บ rentID สำหรับห้องที่มีสถานะชำระแล้ว (สามารถคืนห้องได้)
					if ("ชำระแล้ว".equals(deposit.getStatus())) {
						roomRentId.put(room.getRoomID(), deposit.getRentID());
					}
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
		mav.addObject("roomRentId", roomRentId);
		mav.addObject("floor", floor == null ? "" : floor);
		mav.addObject("status", status == null ? "" : status);
		System.out.println("===== END DEBUG =====");
		return mav;
	}

	// แสดงฟอร์มเพิ่มห้อง
	@RequestMapping(value = "/AddRoom", method = RequestMethod.GET)
	public String showAddRoomForm() {
		return "AddRoom";
	}

	// บันทึกห้องใหม่
	@RequestMapping(value = "/AddRoom", method = RequestMethod.POST)
	public String saveRoom(@RequestParam("roomNumber") String roomNumber,
			@RequestParam("description") String description,
			@RequestParam("roomPrice") String roomPrice,
			@RequestParam("roomStatus") String roomStatus,
			@RequestParam("roomtype") String roomtype,
			@RequestParam("roomDeposit") String roomDeposit,
			@RequestParam(value = "roomNumberImage", required = false) MultipartFile roomNumberImage,
			@RequestParam(value = "roomImage1", required = false) MultipartFile roomImage1,
			@RequestParam(value = "roomImage2", required = false) MultipartFile roomImage2,
			@RequestParam(value = "roomImage3", required = false) MultipartFile roomImage3,
			@RequestParam(value = "roomImage4", required = false) MultipartFile roomImage4,
			HttpSession session,
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
			room.setRoomDeposit(roomDeposit);
			model.addAttribute("room", room);
			return "AddRoom";
		}

		Room room = new Room();
		room.setRoomNumber(roomNumber);
		room.setDescription(description);
		room.setRoomPrice(roomPrice);
		room.setRoomStatus(roomStatus);
		room.setRoomtype(roomtype);
		room.setRoomDeposit(roomDeposit);

		// อัปโหลดรูปภาพ
		try {
			String uploadDir = "room_images";
			// ใช้ /tmp/ เพื่อไม่ให้กระทบกับ WAR extraction
			String realPath = "/tmp/room_images";
			File uploadPath = new File(realPath);
			if (!uploadPath.exists()) {
				uploadPath.mkdirs();
			}

			// บันทึกรูปเลขห้อง (เก็บแบบ room_images/filename.jpg)
			if (roomNumberImage != null && !roomNumberImage.isEmpty()) {
				String fileName = saveImage(roomNumberImage, uploadPath, "room_" + roomNumber + "_number");
				if (fileName != null) {
					room.setRoomNumberImage(uploadDir + "/" + fileName);
				}
			}

			// บันทึกรูปภายในห้อง 1-4 (เก็บแบบ room_images/filename.jpg)
			if (roomImage1 != null && !roomImage1.isEmpty()) {
				String fileName = saveImage(roomImage1, uploadPath, "room_" + roomNumber + "_img1");
				if (fileName != null) {
					room.setRoomImage1(uploadDir + "/" + fileName);
				}
			}

			if (roomImage2 != null && !roomImage2.isEmpty()) {
				String fileName = saveImage(roomImage2, uploadPath, "room_" + roomNumber + "_img2");
				if (fileName != null) {
					room.setRoomImage2(uploadDir + "/" + fileName);
				}
			}

			if (roomImage3 != null && !roomImage3.isEmpty()) {
				String fileName = saveImage(roomImage3, uploadPath, "room_" + roomNumber + "_img3");
				if (fileName != null) {
					room.setRoomImage3(uploadDir + "/" + fileName);
				}
			}

			if (roomImage4 != null && !roomImage4.isEmpty()) {
				String fileName = saveImage(roomImage4, uploadPath, "room_" + roomNumber + "_img4");
				if (fileName != null) {
					room.setRoomImage4(uploadDir + "/" + fileName);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "เกิดข้อผิดพลาดในการอัปโหลดรูปภาพ: " + e.getMessage());
			return "AddRoom";
		}

		boolean success = manager.insertRoom(room);

		if (success) {
			model.addAttribute("message", "เพิ่มห้อง " + roomNumber + " เรียบร้อยแล้ว");
		} else {
			model.addAttribute("errorMessage", "เกิดข้อผิดพลาดในการเพิ่มห้อง กรุณาลองใหม่อีกครั้ง");
		}

		return "AddRoom";
	}

	// Helper method สำหรับบันทึกรูปภาพ
	private String saveImage(MultipartFile file, File uploadPath, String prefix) {
		try {
			String originalFileName = file.getOriginalFilename();
			String extension = "";
			if (originalFileName != null && originalFileName.contains(".")) {
				extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			}

			String newFileName = prefix + "_" + System.currentTimeMillis() + extension;
			File dest = new File(uploadPath, newFileName);
			file.transferTo(dest);

			return newFileName;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// แสดงรายการจองทั้งหมด
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

	// ยืนยันการชำระเงินและเปลี่ยนสถานะเป็น "เสร็จสมบูรณ์"
	@RequestMapping(value = "/ConfirmRent", method = RequestMethod.POST)
	public String confirmRent(@RequestParam("depositId") int depositId, Model model) {
		ThanachokManager manager = new ThanachokManager();
		Rent deposit = manager.getRentById(depositId);

		if (deposit != null && !"เสร็จสมบูรณ์".equals(deposit.getStatus())) {
			deposit.setStatus("เสร็จสมบูรณ์");
			manager.updateRent(deposit);
			model.addAttribute("message", "ยืนยันเรียบร้อยแล้ว");
		}

		model.addAttribute("rent", deposit);
		return "ViewReservationDetail";
	}

	@RequestMapping(value = "/approveDeposit", method = RequestMethod.POST)
	public String approveDeposit(@RequestParam("depositID") int depositID, RedirectAttributes redirectAttributes) {
		ThanachokManager manager = new ThanachokManager();
		boolean updated = manager.confirmRent(depositID);

		if (updated) {
			redirectAttributes.addFlashAttribute("message", "อนุมัติค่ามัดจำเรียบร้อยแล้ว Member จะได้รับห้องทันที");
			return "redirect:/OViewReserve";
		} else {
			redirectAttributes.addFlashAttribute("error", "ไม่สามารถอนุมัติค่ามัดจำได้ กรุณาลองใหม่อีกครั้ง");
			return "redirect:/OViewReserve";
		}
	}

	@RequestMapping(value = "/rejectDeposit", method = RequestMethod.POST)
	public String rejectDeposit(@RequestParam("depositID") int depositID, RedirectAttributes redirectAttributes) {
		ThanachokManager manager = new ThanachokManager();
		boolean deleted = manager.deleteRent(depositID);

		if (deleted) {
			redirectAttributes.addFlashAttribute("message", "ปฏิเสธค่ามัดจำเรียบร้อยแล้ว");
			return "redirect:/OViewReserve";
		} else {
			redirectAttributes.addFlashAttribute("error", "ไม่สามารถปฏิเสธค่ามัดจำได้ กรุณาลองใหม่อีกครั้ง");
			return "redirect:/OViewReserve";
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
	public String updateRoom(
			@RequestParam("roomID") int roomID,
			@RequestParam("roomNumber") String roomNumber,
			@RequestParam("description") String description,
			@RequestParam("roomPrice") String roomPrice,
			@RequestParam("roomDeposit") String roomDeposit,
			@RequestParam("roomtype") String roomtype,
			@RequestParam(value = "roomNumberImage", required = false) MultipartFile roomNumberImage,
			@RequestParam(value = "roomImage1", required = false) MultipartFile roomImage1,
			@RequestParam(value = "roomImage2", required = false) MultipartFile roomImage2,
			@RequestParam(value = "roomImage3", required = false) MultipartFile roomImage3,
			@RequestParam(value = "roomImage4", required = false) MultipartFile roomImage4,
			RedirectAttributes redirect) {

		ThanachokManager tm = new ThanachokManager();
		Room room = tm.findRoomById(roomID);

		// อัปเดตข้อมูลพื้นฐาน
		room.setRoomNumber(roomNumber);
		room.setDescription(description);
		room.setRoomPrice(roomPrice);
		room.setRoomDeposit(roomDeposit);
		room.setRoomtype(roomtype);

		// อัปเดตรูปภาพ (ถ้ามีการอัปโหลดใหม่)
		try {
			String uploadDir = "room_images";
			String realPath = "/tmp/room_images";
			File uploadPath = new File(realPath);
			if (!uploadPath.exists()) {
				uploadPath.mkdirs();
			}

			// บันทึกรูปเลขห้อง (ถ้ามีการอัปโหลดใหม่)
			if (roomNumberImage != null && !roomNumberImage.isEmpty()) {
				String fileName = saveImage(roomNumberImage, uploadPath, "room_" + roomNumber + "_number");
				if (fileName != null) {
					room.setRoomNumberImage(uploadDir + "/" + fileName);
				}
			}

			// บันทึกรูปภายในห้อง 1-4 (ถ้ามีการอัปโหลดใหม่)
			if (roomImage1 != null && !roomImage1.isEmpty()) {
				String fileName = saveImage(roomImage1, uploadPath, "room_" + roomNumber + "_img1");
				if (fileName != null) {
					room.setRoomImage1(uploadDir + "/" + fileName);
				}
			}

			if (roomImage2 != null && !roomImage2.isEmpty()) {
				String fileName = saveImage(roomImage2, uploadPath, "room_" + roomNumber + "_img2");
				if (fileName != null) {
					room.setRoomImage2(uploadDir + "/" + fileName);
				}
			}

			if (roomImage3 != null && !roomImage3.isEmpty()) {
				String fileName = saveImage(roomImage3, uploadPath, "room_" + roomNumber + "_img3");
				if (fileName != null) {
					room.setRoomImage3(uploadDir + "/" + fileName);
				}
			}

			if (roomImage4 != null && !roomImage4.isEmpty()) {
				String fileName = saveImage(roomImage4, uploadPath, "room_" + roomNumber + "_img4");
				if (fileName != null) {
					room.setRoomImage4(uploadDir + "/" + fileName);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			redirect.addFlashAttribute("error", "เกิดข้อผิดพลาดในการอัปโหลดรูปภาพ: " + e.getMessage());
			return "redirect:/editRoom?id=" + roomID;
		}

		tm.updateRoom(room);
		redirect.addFlashAttribute("message", "✅ แก้ไขห้อง " + roomNumber + " เรียบร้อยแล้ว");
		return "redirect:/OwnerHome";
	}

	// ลบห้อง
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

	// เช็คสถานะใบแจ้งหนี้
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

	// คืนห้อง / ยกเลิกการจอง (Manager สามารถทำได้เลยโดยไม่มีเงื่อนไข)
	@RequestMapping(value = "/ManagerReturnRoom", method = RequestMethod.POST)
	public String returnRoom(@RequestParam("rentId") int rentId,
			@RequestParam("roomNumber") String roomNumber,
			@RequestParam(value = "status", required = false) String status,
			RedirectAttributes redirectAttributes) {

		ThanachokManager tm = new ThanachokManager();

		// Manager สามารถคืนห้องได้เลย ไม่ต้องเช็คบิลค้างชำระ
		boolean success = tm.managerreturnRoom(rentId);

		if (success) {
			if ("รออนุมัติ".equals(status)) {
				redirectAttributes.addFlashAttribute("message",
						"✅ ยกเลิกการจองห้อง " + roomNumber + " เรียบร้อยแล้ว\n" +
								"ห้องพร้อมให้จองใหม่");
			} else {
				redirectAttributes.addFlashAttribute("message",
						"✅ คืนห้อง " + roomNumber + " เรียบร้อยแล้ว\n" +
								"ห้องพร้อมให้เช่าใหม่");
			}
		} else {
			redirectAttributes.addFlashAttribute("error",
					"❌ เกิดข้อผิดพลาดในการคืนห้อง กรุณาลองใหม่อีกครั้ง");
		}

		return "redirect:/OViewReserve";
	}

	// แสดงรายการคำขอคืนห้อง
	@RequestMapping(value = "/ListReturnRoom", method = RequestMethod.GET)
	public ModelAndView listReturnRequests(HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();
		List<Rent> returnRequests = tm.findPendingReturnRequests();

		ModelAndView mav = new ModelAndView("ListReturnRoom");
		mav.addObject("returnRequests", returnRequests);
		mav.addObject("requestCount", returnRequests.size());
		return mav;
	}

	// อนุมัติการคืนห้อง
	@RequestMapping(value = "/ApproveReturnRoom", method = RequestMethod.POST)
	public String approveReturnRoom(@RequestParam("rentId") int rentId,
			@RequestParam("roomNumber") String roomNumber,
			RedirectAttributes redirectAttributes) {

		ThanachokManager tm = new ThanachokManager();
		boolean success = tm.approveReturnRoom(rentId);

		if (success) {
			redirectAttributes.addFlashAttribute("message",
					"✅ อนุมัติการคืนห้อง " + roomNumber + " เรียบร้อยแล้ว\nห้องพร้อมให้เช่าใหม่");
		} else {
			redirectAttributes.addFlashAttribute("error",
					"❌ เกิดข้อผิดพลาดในการอนุมัติ กรุณาลองใหม่อีกครั้ง");
		}

		return "redirect:/ListReturnRoom";
	}

	// ยกเลิกคำขอคืนห้อง
	@RequestMapping(value = "/RejectReturnRoom", method = RequestMethod.POST)
	public String rejectReturnRoom(@RequestParam("rentId") int rentId,
			@RequestParam("roomNumber") String roomNumber,
			RedirectAttributes redirectAttributes) {

		ThanachokManager tm = new ThanachokManager();
		boolean success = tm.cancelReturnRequest(rentId);

		if (success) {
			redirectAttributes.addFlashAttribute("message",
					"❌ ปฏิเสธคำขอคืนห้อง " + roomNumber + " แล้ว");
		} else {
			redirectAttributes.addFlashAttribute("error",
					"เกิดข้อผิดพลาดในการปฏิเสธคำขอ");
		}

		return "redirect:/ListReturnRoom";
	}

	// Manager คืนห้องให้ลูกค้า (กรณีต้องการคืนห้องทันที)
	@RequestMapping(value = "/ManagerForceReturnRoom", method = RequestMethod.POST)
	public String managerForceReturnRoom(@RequestParam("rentId") int rentId,
			@RequestParam("notes") String notes,
			@RequestParam("roomNumber") String roomNumber,
			RedirectAttributes redirectAttributes) {

		ThanachokManager tm = new ThanachokManager();
		boolean success = tm.managerForceReturnRoom(rentId, notes);

		if (success) {
			redirectAttributes.addFlashAttribute("message",
					"✅ คืนห้อง " + roomNumber + " เรียบร้อยแล้ว");
		} else {
			redirectAttributes.addFlashAttribute("error",
					"เกิดข้อผิดพลาดในการคืนห้อง");
		}

		return "redirect:/OwnerHome";
	}

	// แสดงรายการจองที่รอการอนุมัติ
	@RequestMapping(value = "/ListReservations", method = RequestMethod.GET)
	public ModelAndView listReservations(HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();

		// ปฏิเสธการจองที่หมดเวลาชำระเงิน (เกิน 24 ชั่วโมง) อัตโนมัติ
		tm.autoRejectExpiredReservations();

		List<com.springmvc.model.Reserve> reserveList = tm.findAllReserves();

		ModelAndView mav = new ModelAndView("ListReservations");
		mav.addObject("reserveList", reserveList);
		return mav;
	}

	// Manager อนุมัติการจอง
	@RequestMapping(value = "/ApproveReservation", method = RequestMethod.POST)
	public String approveReservation(
			@RequestParam("reserveId") int reserveId,
			RedirectAttributes redirectAttributes) {

		ThanachokManager tm = new ThanachokManager();
		boolean success = tm.updateReserveStatus(reserveId, "อนุมัติแล้ว");

		if (success) {
			redirectAttributes.addFlashAttribute("message", "✅ อนุมัติการจองเรียบร้อยแล้ว");
		} else {
			redirectAttributes.addFlashAttribute("error", "เกิดข้อผิดพลาดในการอนุมัติ");
		}

		return "redirect:/ListReservations";
	}

	// Manager ปฏิเสธการจอง
	@RequestMapping(value = "/RejectReservation", method = RequestMethod.POST)
	public String rejectReservation(
			@RequestParam("reserveId") int reserveId,
			RedirectAttributes redirectAttributes) {

		ThanachokManager tm = new ThanachokManager();
		boolean success = tm.updateReserveStatus(reserveId, "ปฏิเสธ");

		if (success) {
			redirectAttributes.addFlashAttribute("message", "❌ ปฏิเสธการจองเรียบร้อยแล้ว");
		} else {
			redirectAttributes.addFlashAttribute("error", "เกิดข้อผิดพลาดในการปฏิเสธ");
		}

		return "redirect:/ListReservations";
	}

	// ดูประวัติการเข้าพักของห้อง
	@RequestMapping(value = "/ViewRoomHistory", method = RequestMethod.GET)
	public ModelAndView viewRoomHistory(@RequestParam("roomId") int roomId, HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();
		List<Rent> rentHistory = tm.getRoomRentalHistory(roomId);
		Room room = tm.findRoomById(roomId);

		ModelAndView mav = new ModelAndView("ViewRoomHistory");
		mav.addObject("rentHistory", rentHistory);
		mav.addObject("room", room);

		return mav;
	}

	// ==================== Utility Rate Management ====================

	// แสดงหน้าจัดการหน่วยค่าน้ำ-ค่าไฟ
	@RequestMapping(value = "/ManageUtilityRates", method = RequestMethod.GET)
	public ModelAndView showManageUtilityRates(HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();
		UtilityRate activeRate = tm.getActiveUtilityRate();
		List<UtilityRate> allRates = tm.getAllUtilityRates();

		ModelAndView mav = new ModelAndView("ManageUtilityRates");
		mav.addObject("activeRate", activeRate);
		mav.addObject("allRates", allRates);

		return mav;
	}

	// บันทึกหน่วยค่าน้ำ-ค่าไฟใหม่
	@RequestMapping(value = "/SaveUtilityRate", method = RequestMethod.POST)
	public String saveUtilityRate(
			@RequestParam("ratePerUnitWater") double ratePerUnitWater,
			@RequestParam("ratePerUnitElectric") double ratePerUnitElectric,
			@RequestParam(value = "notes", required = false) String notes,
			RedirectAttributes redirectAttributes) {

		ThanachokManager tm = new ThanachokManager();
		UtilityRate newRate = new UtilityRate(ratePerUnitWater, ratePerUnitElectric);
		newRate.setNotes(notes);

		boolean success = tm.saveUtilityRate(newRate);

		if (success) {
			redirectAttributes.addFlashAttribute("message",
					"✅ บันทึกหน่วยค่าน้ำ-ค่าไฟใหม่เรียบร้อยแล้ว");
		} else {
			redirectAttributes.addFlashAttribute("error",
					"❌ เกิดข้อผิดพลาดในการบันทึก");
		}

		return "redirect:/ManageUtilityRates";
	}

	// คืนห้อง
	@RequestMapping(value = "/returnRoom", method = RequestMethod.POST)
	public String returnRoom(
			@RequestParam("rentId") int rentId,
			@RequestParam(value = "notes", required = false) String notes,
			RedirectAttributes redirectAttributes) {

		ThanachokManager tm = new ThanachokManager();

		// อัปเดต returnDate และ notes
		Rent rent = tm.getRentById(rentId);
		if (rent != null) {
			java.util.Calendar calReturn = java.util.Calendar.getInstance();
			calReturn.add(java.util.Calendar.HOUR_OF_DAY, 7); // Thai time
			rent.setReturnDate(calReturn.getTime());
			rent.setStatus("เสร็จสมบูรณ์");

			boolean success = tm.updateRent(rent);

			if (success) {
				// เปลี่ยนสถานะห้องเป็น "ว่าง"
				Room room = rent.getRoom();
				room.setRoomStatus("ว่าง");
				tm.updateRoom(room);

				redirectAttributes.addFlashAttribute("message", "✅ คืนห้องเรียบร้อยแล้ว");
				return "redirect:/ViewRoomHistory?roomId=" + room.getRoomID();
			} else {
				redirectAttributes.addFlashAttribute("error", "เกิดข้อผิดพลาดในการคืนห้อง");
				return "redirect:/ViewRoomHistory?roomId=" + rent.getRoom().getRoomID();
			}
		}

		redirectAttributes.addFlashAttribute("error", "ไม่พบข้อมูลการเช่า");
		return "redirect:/OwnerHome";
	}

	// ยกเลิกการคืนห้อง (แก้ไขผิดพลาด)
	@RequestMapping(value = "/undoReturnRoom", method = RequestMethod.POST)
	public String undoReturnRoom(
			@RequestParam("rentId") int rentId,
			@RequestParam(value = "notes", required = false) String notes,
			RedirectAttributes redirectAttributes) {

		ThanachokManager tm = new ThanachokManager();
		boolean success = tm.undoRoomReturn(rentId);

		if (success) {
			Rent rent = tm.getRentById(rentId);
			redirectAttributes.addFlashAttribute("message",
					"✅ ยกเลิกการคืนห้องสำเร็จ\nสถานะกลับมาเป็นปกติแล้ว");
			return "redirect:/ViewRoomHistory?roomId=" + rent.getRoom().getRoomID();
		} else {
			redirectAttributes.addFlashAttribute("error",
					"❌ ไม่สามารถยกเลิกการคืนห้องได้");
			return "redirect:/OwnerHome";
		}
	}

}
