package com.springmvc.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Invoice;
import com.springmvc.model.InvoiceDetail;
import com.springmvc.model.Manager;
import com.springmvc.model.Member;
import com.springmvc.model.Rent;
import com.springmvc.model.RentalDeposit;
import com.springmvc.model.Room;
import com.springmvc.model.ThanachokManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

    // แสดงรายการห้อง (หน้า Homesucess.jsp)
    @RequestMapping(value = "/Homesucess", method = RequestMethod.GET)
    public ModelAndView showAvailableRooms(HttpSession session,
            @RequestParam(value = "floor", required = false) String floor,
            @RequestParam(value = "status", required = false) String status) {

        Member member = (Member) session.getAttribute("loginMember");
        if (member == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager manager = new ThanachokManager();
        List<Room> roomList = manager.findRoomsByFloorAndStatus(floor, status);

        ModelAndView mav = new ModelAndView("Homesucess");
        mav.addObject("roomList", roomList);
        mav.addObject("floor", floor);
        mav.addObject("status", status);
        return mav;
    }

    // หน้าแสดงฟอร์มการชำระเงิน
    @RequestMapping(value = "/Payment", method = RequestMethod.GET)
    public ModelAndView showPaymentForm(@RequestParam("id") int roomID, HttpSession session) {
        Member member = (Member) session.getAttribute("loginMember");
        if (member == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager manager = new ThanachokManager();
        Room room = manager.findRoomById(roomID);

        ModelAndView mav = new ModelAndView("Payment");
        mav.addObject("room", room);
        return mav;
    }

    @SuppressWarnings("deprecation")
    @RequestMapping(value = "/confirmPayment", method = RequestMethod.POST)
    public String confirmPayment(@RequestParam("roomID") int roomID,
            @RequestParam("depositAmount") double depositAmount,
            @RequestParam("price") double price,
            @RequestParam("transferAccountName") String transferAccountName,
            @RequestParam("paymentDate") String paymentDateStr,
            @RequestParam("deadline") String deadlineStr,
            @RequestParam("paymentSlip") MultipartFile paymentSlip,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        try {
            ThanachokManager thanachokManager = new ThanachokManager();

            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy", new Locale("th", "TH"));
            Date paymentDate = sdf.parse(paymentDateStr);
            Date deadline = sdf.parse(deadlineStr);

            String originalFileName = paymentSlip.getOriginalFilename();
            String extension = "";
            if (originalFileName != null && originalFileName.contains(".")) {
                extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            }
            String newFileName = UUID.randomUUID().toString() + extension;

            String uploadDir = "Slipet";

            String realPath = "C:\\WebProject\\Project\\src\\main\\webapp\\slipet";

            File uploadPath = new File(realPath);
            if (!uploadPath.exists())
                uploadPath.mkdirs();

            File dest = new File(uploadPath, newFileName);
            paymentSlip.transferTo(dest);

            Room room = thanachokManager.findRoomById(roomID);

            // สร้างการจองห้อง (Rent)
            Rent rent = new Rent();
            rent.setMember(loginMember);
            rent.setRoom(room);
            rent.setRentDate(paymentDate);
            thanachokManager.saveRent(rent);

            // สร้างการชำระเงิน (RentalDeposit)
            RentalDeposit deposit = new RentalDeposit();
            deposit.setRent(rent);
            deposit.setTransferAccountName(transferAccountName);
            deposit.setPaymentDate(paymentDate);
            deposit.setPaymentSlipImage(uploadDir + "/" + newFileName); // Store relative file path
            deposit.setDeadlineDate(deadline);
            deposit.setStatus("รอดำเนินการ");
            deposit.setTotalPrice("500");
            thanachokManager.saveRentalDeposit(deposit);

            // อัปเดตสถานะของห้องเป็น "ไม่ว่าง"
            room.setRoomStatus("ไม่ว่าง");
            thanachokManager.updateRoom(room);

            redirectAttributes.addFlashAttribute("message", "บันทึกการชำระเงินสำเร็จและห้องถูกจองแล้ว");
            return "redirect:/Homesucess";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "เกิดข้อผิดพลาดในการบันทึกการชำระเงิน");
            return "redirect:/Homesucess";
        }
    }

    



@RequestMapping(value = "/SlipImage", method = RequestMethod.GET)
public void getSlipImage(@RequestParam("rentalDepositId") int rentalDepositId, HttpServletResponse response) {
    try {
        ThanachokManager thanachokManager = new ThanachokManager();
        RentalDeposit deposit = thanachokManager.findRentalDepositByRentId(rentalDepositId);

        if (deposit != null && deposit.getPaymentSlipImage() != null) {
            // Path ที่ใช้หลังจาก deploy แล้ว
            String basePath = "C:\\WebProject\\Project\\target\\Thanachok03-0.0.1-SNAPSHOT\\";
            String imagePath = basePath + deposit.getPaymentSlipImage(); // เช่น slipet/xxxx.png

            File imageFile = new File(imagePath);

            if (imageFile.exists()) {
                String contentType = Files.probeContentType(imageFile.toPath());
                response.setContentType(contentType != null ? contentType : "image/jpeg");

                Files.copy(imageFile.toPath(), response.getOutputStream());
                response.getOutputStream().flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "ไม่พบไฟล์ภาพ");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "ไม่พบข้อมูลการชำระเงิน");
        }
    } catch (Exception e) {
        e.printStackTrace();
        try {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "เกิดข้อผิดพลาดในการโหลดภาพ");
        } catch (Exception ignored) {}
    }
}





    // ประวัติการจองของสมาชิก
    @RequestMapping(value = "/Record", method = RequestMethod.GET)
    public ModelAndView showMemberRecord(HttpSession session) {
        Member member = (Member) session.getAttribute("loginMember");
        if (member == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager manager = new ThanachokManager();
        List<RentalDeposit> rentalDeposits = manager.findDepositsByMember(member);

        ModelAndView mav = new ModelAndView("Record");
        mav.addObject("rentalDeposits", rentalDeposits);
        return mav;
    }

    // ✅ ออกจากระบบ
    @RequestMapping(value = "/Logout", method = RequestMethod.POST)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

}
