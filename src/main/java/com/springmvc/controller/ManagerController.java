package com.springmvc.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Room;
import com.springmvc.model.Manager;
import com.springmvc.model.Rent;
import com.springmvc.model.RentalDeposit;
import com.springmvc.model.ThanachokManager;

@Controller
public class ManagerController {
	
	
	/*// ✅ หน้าเจ้าของหอ (ดูห้องทั้งหมด)
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

			ModelAndView mav = new ModelAndView("OwnerHome");
			mav.addObject("roomList", roomList);
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
                           @RequestParam("images") MultipartFile[] images,
                           Model model) {

        String uploadPath = "C:\\Users\\USER\\Downloads\\Zprojectshabu2\\Zprojectshabu2\\src\\main\\webapp\\images\\";
        List<String> imagePaths = new ArrayList<>();

        for (MultipartFile file : images) {
            if (!file.isEmpty()) {
                String filename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                try {
                    if (file.getContentType().startsWith("image/")) {
                        file.transferTo(new File(uploadPath + filename));
                        imagePaths.add("images/" + filename);
                    } else {
                        model.addAttribute("message", "ไฟล์ไม่ถูกต้อง, กรุณาอัปโหลดเฉพาะไฟล์ภาพ");
                        return "AddRoom";
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    model.addAttribute("message", "เกิดข้อผิดพลาดในการอัปโหลดไฟล์");
                    return "AddRoom";
                }
            }
        }

        Room room = new Room();
        room.setRoomNumber(roomNumber);
        room.setDescription(description);
        room.setRoomPrice(roomPrice);
        room.setRoomStatus(roomStatus);
        room.setRoomtype(roomtype);

        for (int i = 0; i < imagePaths.size(); i++) {
            if (i == 0) room.setImage1(imagePaths.get(i));
            if (i == 1) room.setImage2(imagePaths.get(i));
            if (i == 2) room.setImage3(imagePaths.get(i));
            if (i == 3) room.setImage4(imagePaths.get(i));
        }

        ThanachokManager manager = new ThanachokManager();
        boolean success = manager.insertRoom(room);
        model.addAttribute("message", success ? "เพิ่มห้องเรียบร้อย" : "เกิดข้อผิดพลาด");

        return "AddRoom";
    }

    // GET: แสดงรายการจองทั้งหมด
    @GetMapping("/OViewReserve")
    public String viewAllReservations(Model model) {
        ThanachokManager manager = new ThanachokManager();
        List<Rent> rentList = manager.findAllRentsWithDeposits();
        model.addAttribute("rentList", rentList);
        return "OViewReserve";
    }

    // GET: แสดงรายละเอียดการจองแต่ละรายการ
    @GetMapping("/ViewReservationDetail")
    public String viewReservationDetail(@RequestParam("rentId") int rentId, Model model) {
        ThanachokManager manager = new ThanachokManager();
        Rent rent = manager.findRentById(rentId);
        model.addAttribute("rent", rent);
        return "ViewReservationDetail";
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
    }*/

    // GET: แสดงภาพสลิปการจ่ายเงินจากฐานข้อมูล
    
}
