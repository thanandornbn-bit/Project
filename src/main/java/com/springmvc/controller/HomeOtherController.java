package com.springmvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Manager;
import com.springmvc.model.Member;
import com.springmvc.model.RentalDeposit;
import com.springmvc.model.Room;
import com.springmvc.model.ThanachokManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeOtherController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView Home() {
		ThanachokManager manager = new ThanachokManager();
		List<Room> roomList = manager.getAllrooms();
		ModelAndView mav = new ModelAndView("Home");
		mav.addObject("roomList", roomList);
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
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String phoneNumber = request.getParameter("phoneNumber");
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

		if (!password.equals(confirmPassword)) {
			ModelAndView mav = new ModelAndView("Register");
			mav.addObject("add_result", "รหัสผ่านไม่ตรงกัน");
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

}
