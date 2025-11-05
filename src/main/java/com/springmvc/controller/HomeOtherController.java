package com.springmvc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Manager;
import com.springmvc.model.Member;
import com.springmvc.model.Room;
import com.springmvc.model.ThanachokManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeOtherController {

	@RequestMapping(value = { "/", "/Home" }, method = RequestMethod.GET)
	public ModelAndView Home(
			@RequestParam(value = "floor", required = false) String floor,
			@RequestParam(value = "status", required = false) String status) {
		ThanachokManager manager = new ThanachokManager();
		List<Room> roomList = manager.findRoomsByFloorAndStatus(floor, status);
		ModelAndView mav = new ModelAndView("Home");
		mav.addObject("roomList", roomList);
		mav.addObject("floor", floor);
		mav.addObject("status", status);
		return mav;
	}

	@RequestMapping(value = "/Register", method = RequestMethod.GET)
	public String Register() {
		return "Register";
	}

	@RequestMapping(value = "/Login", method = RequestMethod.GET)
	public String Login() {
		return "Login";
	}

	@RequestMapping(value = "/Register", method = RequestMethod.POST)
	public ModelAndView registerMember(HttpServletRequest request, HttpSession session) {
		ThanachokManager manager = new ThanachokManager();

		String email = request.getParameter("email");
		String firstName = request.getParameter("firstName") != null
				? request.getParameter("firstName").trim().replace(" ", "")
				: null;
		String lastName = request.getParameter("lastName") != null
				? request.getParameter("lastName").trim().replace(" ", "")
				: null;
		String phoneNumber = request.getParameter("phoneNumber") != null
				? request.getParameter("phoneNumber").trim().replace(" ", "")
				: null;
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		if (email == null || email.trim().isEmpty() || firstName == null || firstName.trim().isEmpty()
				|| lastName == null || lastName.trim().isEmpty() || phoneNumber == null || phoneNumber.trim().isEmpty()
				|| password == null || password.trim().isEmpty() || confirmPassword == null
				|| confirmPassword.trim().isEmpty()) {
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result", "กรุณากรอกข้อมูลให้ครบถ้วน");
			return mav;
		}

		if (!phoneNumber.matches("^0[0-9]{9}$")) {
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result", "กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง (10 หลัก)");
			return mav;
		}

		if (manager.isNameDuplicate(firstName, lastName)) {
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result", "ชื่อ-นามสกุลนี้ถูกใช้งานแล้ว");
			return mav;
		}
		if (manager.isPhoneDuplicate(phoneNumber)) {
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result", "เบอร์โทรศัพท์นี้ถูกใช้งานแล้ว");
			return mav;
		}

		if (!password.equals(confirmPassword)) {
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result", "รหัสผ่านไม่ตรงกัน");
			return mav;
		}

		// ตรวจสอบรหัสผ่านต้องมีตัวใหญ่ ตัวเล็ก อย่างน้อย 1 ตัว และ 6-50 ตัวอักษร
		if (!isPasswordValid(password)) {
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result",
					"รหัสผ่านต้องมีตัวพิมพ์ใหญ่ ตัวพิมพ์เล็กอย่างน้อย 1 ตัว และความยาว 6-50 ตัวอักษร");
			return mav;
		}

		// ตรวจสอบว่า Email มีอยู่ในระบบแล้วหรือไม่ (ไม่สนใจตัวพิมพ์ใหญ่-เล็ก)
		if (manager.isEmailExists(email)) {
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result", "อีเมลนี้ถูกใช้งานแล้ว กรุณาใช้อีเมลอื่น");
			return mav;
		}

		try {
			password = PasswordUtil.getInstance().createPassword(password, "Project");
		} catch (Exception e) {
			e.printStackTrace();
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result", "เกิดข้อผิดพลาดในการเข้ารหัสรหัสผ่าน");
			return mav;
		}

		Member member = new Member();
		member.setEmail(email);
		member.setFirstName(firstName);
		member.setLastName(lastName);
		member.setPhoneNumber(phoneNumber);
		member.setPassword(password);

		session.setAttribute("memberRegister", member);

		if (manager.insertMember(member)) {
			ModelAndView mav = new ModelAndView("Login");
			mav.addObject("success_message", "สมัครสมาชิกสำเร็จ กรุณาเข้าสู่ระบบ");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result", "ไม่สามารถบันทึกข้อมูลได้ กรุณาลองใหม่");
			return mav;
		}
	}

	// ฟังก์ชันตรวจสอบรหัสผ่าน (helper method)
	private boolean isPasswordValid(String password) {
		if (password == null)
			return false;
		if (password.length() < 6 || password.length() > 50)
			return false;
		boolean hasUpper = false, hasLower = false;
		for (char c : password.toCharArray()) {
			if (Character.isUpperCase(c))
				hasUpper = true;
			if (Character.isLowerCase(c))
				hasLower = true;
		}
		return hasUpper && hasLower;
	}

	@RequestMapping(value = "/Login", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpSession session) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			return new ModelAndView("Login", "error_message", "กรุณากรอกข้อมูลให้ครบ");
		}

		try {
			password = PasswordUtil.getInstance().createPassword(password, "Project");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("Login", "error_message", "เกิดข้อผิดพลาดในการเข้ารหัสรหัสผ่าน");
		}

		ThanachokManager manager = new ThanachokManager();

		if ("Manager".equalsIgnoreCase(role)) {
			Manager m = manager.findManagerByEmailAndPassword(email, password);
			if (m != null) {
				session.setAttribute("loginManager", m);
				return new ModelAndView("redirect:/OwnerHome");
			} else {
				return new ModelAndView("Login", "error_message", "Email หรือรหัสผ่านของ Manager ไม่ถูกต้อง");
			}
		} else {
			Member member = manager.findMemberByEmailAndPassword(email, password);
			if (member != null) {
				session.setAttribute("loginMember", member);
				return new ModelAndView("redirect:/Homesucess");
			} else {
				return new ModelAndView("Login", "error_message", "Email หรือรหัสผ่านของ Member ไม่ถูกต้อง");
			}
		}
	}

	@RequestMapping(value = "/roomDetail", method = RequestMethod.GET)
	public ModelAndView roomDetail(@RequestParam("id") int roomID) {
		ThanachokManager manager = new ThanachokManager();
		Room room = manager.findRoomById(roomID);
		ModelAndView mav = new ModelAndView("ODetailRoom");
		mav.addObject("room", room);
		return mav;
	}

	// Member จองห้อง - บันทึกลง Reserve table
	@RequestMapping(value = "/MemberReserveRoom", method = RequestMethod.POST)
	public String memberReserveRoom(
			@RequestParam("roomID") int roomID,
			@RequestParam("checkInDate") String checkInDateStr,
			@RequestParam(value = "reserveTimestamp", required = false) String reserveTimestamp,
			@RequestParam(value = "internetOption", required = false, defaultValue = "false") boolean internetOption,
			HttpSession session) {

		Member loginMember = (Member) session.getAttribute("loginMember");
		if (loginMember == null) {
			return "redirect:/Login";
		}

		ThanachokManager manager = new ThanachokManager();

		try {
			// ตรวจสอบว่าสมาชิกเคยจองห้องนี้ไว้แล้วหรือไม่ (เฉพาะห้องเดียวกัน)
			List<com.springmvc.model.Reserve> existingReserves = manager.findReservesByMember(loginMember);
			boolean hasSameRoomReserve = false;

			for (com.springmvc.model.Reserve res : existingReserves) {
				// ถ้าจองห้องเดียวกัน และสถานะไม่ใช่ "ปฏิเสธ" หรือ "ยกเลิก" หรือ "คืนห้องแล้ว" =
				// ห้ามจองซ้ำ
				if (res.getRoom().getRoomID() == roomID
						&& !"ปฏิเสธ".equals(res.getStatus())
						&& !"ยกเลิก".equals(res.getStatus())
						&& !"คืนห้องแล้ว".equals(res.getStatus())) {
					hasSameRoomReserve = true;
					break;
				}
			}

			if (hasSameRoomReserve) {
				return "redirect:/Homesucess?reserveError=alreadyReservedThisRoom";
			}

			// แปลง String เป็น Date
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Date checkInDate = sdf.parse(checkInDateStr);

			// สร้าง Reserve object
			com.springmvc.model.Reserve reserve = new com.springmvc.model.Reserve();
			// บวกเวลา 7 ชั่วโมงสำหรับเวลาไทย
			java.util.Calendar calReserve = java.util.Calendar.getInstance();
			calReserve.add(java.util.Calendar.HOUR_OF_DAY, 7);
			reserve.setReserveDate(calReserve.getTime());
			reserve.setCheckInDate(checkInDate); // วันที่ต้องการเข้าพัก
			reserve.setStatus("รอการอนุมัติ");

			// ดึงข้อมูล Room และ Member
			com.springmvc.model.Room room = manager.findRoomById(roomID);
			reserve.setRoom(room);
			reserve.setMember(loginMember);

			// ตั้งค่าอินเทอร์เน็ต
			reserve.setInternetOption(internetOption);
			reserve.setInternetFee(internetOption ? 200 : 0);

			// ไม่ต้องตรวจสอบสถานะห้อง เพราะอนุญาตให้จองได้หลายคน
			// หลายคนสามารถจองห้องเดียวกันได้

			// บันทึกลงฐานข้อมูล
			boolean success = manager.insertReserve(reserve);
			if (success) {
				// ไม่เปลี่ยนสถานะห้อง ให้ห้องยังคงสถานะเดิม
				// สถานะห้องจะเปลี่ยนเมื่อมีการยืนยันการเช่าเท่านั้น

				return "redirect:/Homesucess?reserveSuccess=true";
			} else {
				return "redirect:/Homesucess?reserveError=true";
			}

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/Homesucess?reserveError=true";
		}
	}

	// API: ตรวจสอบว่ามีการจองที่ยังไม่ได้รับการอนุมัติหรือปฏิเสธ
	@RequestMapping(value = "/checkActiveReserve", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> checkActiveReserve(HttpSession session) {
		Map<String, Object> result = new HashMap<>();

		Member loginMember = (Member) session.getAttribute("loginMember");
		if (loginMember == null) {
			result.put("hasActiveReserve", false);
			result.put("activeReserveCount", 0);
			return result;
		}

		ThanachokManager manager = new ThanachokManager();
		List<com.springmvc.model.Reserve> reserves = manager.findReservesByMember(loginMember);

		int activeCount = 0;
		List<String> activeRooms = new ArrayList<>();

		for (com.springmvc.model.Reserve reserve : reserves) {
			String status = reserve.getStatus();
			// นับเฉพาะการจองที่ไม่ใช่ "ปฏิเสธ" หรือ "ยกเลิก"
			if (!"ปฏิเสธ".equals(status) && !"ยกเลิก".equals(status)) {
				activeCount++;
				if (reserve.getRoom() != null) {
					activeRooms.add(reserve.getRoom().getRoomNumber());
				}
			}
		}

		result.put("hasActiveReserve", activeCount > 0);
		result.put("activeReserveCount", activeCount);
		result.put("activeRooms", activeRooms);

		return result;
	}

}
