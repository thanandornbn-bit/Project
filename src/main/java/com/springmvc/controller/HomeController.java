package com.springmvc.controller;

import java.io.File;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Invoice;
import com.springmvc.model.InvoiceDetail;
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

        // เพิ่มการตรวจสอบว่ามีการจอง active หรือไม่
        List<RentalDeposit> activeRentals = manager.findActiveDepositsByMember(member);
        int activeRentalCount = activeRentals.size();

        ModelAndView mav = new ModelAndView("Homesucess");
        mav.addObject("roomList", roomList);
        mav.addObject("floor", floor);
        mav.addObject("status", status);
        mav.addObject("activeRentalCount", activeRentalCount); 
        mav.addObject("activeRentals", activeRentals); 
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

            // ตรวจสอบสถานะห้องอีกครั้ง
            Room room = thanachokManager.findRoomById(roomID);
            if (room == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "ไม่พบห้องที่ต้องการจอง");
                return "redirect:/Homesucess";
            }

            if (!"ว่าง".equals(room.getRoomStatus())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "ห้อง " + room.getRoomNumber() + " ไม่ว่างแล้ว กรุณาเลือกห้องอื่น");
                return "redirect:/Homesucess";
            }

            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy", new Locale("th", "TH"));
            Date paymentDate = sdf.parse(paymentDateStr);
            Date deadline = sdf.parse(deadlineStr);

            String originalFileName = paymentSlip.getOriginalFilename();
            String extension = "";
            if (originalFileName != null && originalFileName.contains(".")) {
                extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            }

            String uploadDir = "slipet";
            String realPath = "/usr/local/tomcat/webapps/thanachok/slipet";// เปลี่ยน Path File

            File uploadPath = new File(realPath);
            if (!uploadPath.exists())
                uploadPath.mkdirs();

            // สร้างชื่อไฟล์ใหม่แบบเรียงลำดับ
            String[] existingFiles = uploadPath.list((dir, name) -> name.matches("slipet\\d+\\.\\w+"));
            int nextNumber = existingFiles != null ? existingFiles.length + 1 : 1;
            String newFileName = String.format("slipet%02d%s", nextNumber, extension);

            File dest = new File(uploadPath, newFileName);
            paymentSlip.transferTo(dest);

            // สร้างการจองห้อง
            Rent rent = new Rent();
            rent.setMember(loginMember);
            rent.setRoom(room);
            rent.setRentDate(paymentDate);

            // บันทึกการจองก่อน
            boolean rentSaved = thanachokManager.saveRent(rent);
            if (!rentSaved) {
                redirectAttributes.addFlashAttribute("errorMessage", "ไม่สามารถบันทึกการจองได้");
                return "redirect:/Homesucess";
            }

            // สร้างการชำระเงิน
            RentalDeposit deposit = new RentalDeposit();
            deposit.setRent(rent);
            deposit.setTransferAccountName(transferAccountName);
            deposit.setPaymentDate(paymentDate);
            deposit.setPaymentSlipImage(uploadDir + "/" + newFileName);
            deposit.setDeadlineDate(deadline);
            deposit.setStatus("รอดำเนินการ");
            deposit.setTotalPrice("500");

            boolean depositSaved = thanachokManager.saveRentalDeposit(deposit);
            if (!depositSaved) {
                redirectAttributes.addFlashAttribute("errorMessage", "ไม่สามารถบันทึกการชำระเงินได้");
                return "redirect:/Homesucess";
            }

            // อัปเดตสถานะห้อง
            room.setRoomStatus("ไม่ว่าง");
            boolean roomUpdated = thanachokManager.updateRoom(room);
            if (!roomUpdated) {
                redirectAttributes.addFlashAttribute("errorMessage", "ไม่สามารถอัปเดตสถานะห้องได้");
                return "redirect:/Homesucess";
            }

            redirectAttributes.addFlashAttribute("message",
                    "บันทึกการชำระเงินสำเร็จ! ห้อง " + room.getRoomNumber() + " ถูกจองแล้ว");
            return "redirect:/Homesucess";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage",
                    "เกิดข้อผิดพลาดในการบันทึกการชำระเงิน: " + e.getMessage());
            return "redirect:/Homesucess";
        }
    }

    @RequestMapping(value = "/checkActiveRental", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> checkActiveRental(HttpSession session, RedirectAttributes redirectAttributes) {
        Map<String, Object> response = new HashMap<>();

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            response.put("hasActiveRental", false);
            response.put("error", "ไม่พบข้อมูลผู้ใช้");
            return response;
        }

        ThanachokManager manager = new ThanachokManager();

        // ดึงข้อมูลการจองทั้งหมดที่ยังไม่ได้คืนห้อง
        List<RentalDeposit> activeRentals = manager.findActiveDepositsByMember(loginMember);

        for (RentalDeposit rd : activeRentals) {
            System.out.println("Room: " + rd.getRent().getRoom().getRoomNumber() +
                    ", Status: " + rd.getStatus());
        }

        boolean hasActiveRental = !activeRentals.isEmpty();
        int activeCount = activeRentals.size();

        response.put("hasActiveRental", hasActiveRental);
        response.put("activeRentalCount", activeCount);

        List<String> roomNumbers = new ArrayList<>();
        for (RentalDeposit rd : activeRentals) {
            roomNumbers.add(rd.getRent().getRoom().getRoomNumber());
        }
        response.put("activeRooms", roomNumbers);

        if (hasActiveRental) {
            response.put("message", "คุณมีการจองห้อง " + String.join(", ", roomNumbers) + " อยู่แล้ว");
        } else {
            response.put("message", "คุณสามารถจองห้องใหม่ได้");
        }

        System.out.println("Response: " + response);

        return response;
    }

    @RequestMapping(value = "/SlipImage", method = RequestMethod.GET)
    public void getSlipImage(@RequestParam("rentalDepositId") int rentalDepositId, HttpServletResponse response) {
        try {
            ThanachokManager thanachokManager = new ThanachokManager();
            RentalDeposit deposit = thanachokManager.findRentalDepositByRentId(rentalDepositId);

            if (deposit != null && deposit.getPaymentSlipImage() != null) {

                String basePath = "C:\\WebProject\\Project\\target\\Thanachok03-0.0.1-SNAPSHOT\\";
                String imagePath = basePath + deposit.getPaymentSlipImage();

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
            } catch (Exception ignored) {
            }
        }
    }

    // ออกจากระบบ
    @RequestMapping(value = "/Logout", method = RequestMethod.POST)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping(value = "/MemberDetailinvoice", method = RequestMethod.GET)
    public ModelAndView showInvoiceDetail(@RequestParam("billID") int billID, HttpSession session) {
        Member member = (Member) session.getAttribute("loginMember");
        if (member == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager manager = new ThanachokManager();
        Invoice invoice = manager.findInvoiceById(billID);
        List<InvoiceDetail> invoiceDetails = manager.findInvoiceDetailsByInvoiceId(billID);

        ModelAndView mav = new ModelAndView("MemberDetailinvoice");
        mav.addObject("invoice", invoice);
        mav.addObject("invoiceDetails", invoiceDetails);
        return mav;
    }

    @RequestMapping(value = "/Editprofile", method = RequestMethod.GET)
    public ModelAndView showEditProfile(HttpSession session) {
        Member member = (Member) session.getAttribute("loginMember");
        if (member == null) {
            return new ModelAndView("redirect:/Login");
        }
        return new ModelAndView("Editprofile");
    }

    // EditProfile
    @RequestMapping(value = "/Editprofile", method = RequestMethod.POST)
    public ModelAndView editProfile(HttpServletRequest request, HttpSession session) {
        Member currentMember = (Member) session.getAttribute("loginMember");
        if (currentMember == null) {
            return new ModelAndView("redirect:/Login");
        }
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        ModelAndView mav = new ModelAndView("Editprofile");

        // ตรวจสอบข้อมูล
        if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                phoneNumber == null || phoneNumber.trim().isEmpty()) {
            mav.addObject("edit_result", "กรุณากรอกข้อมูลให้ครบถ้วน");
            return mav;
        }

        if (!phoneNumber.matches("^0[0-9]{9}$")) {
            mav.addObject("edit_result", "หมายเลขโทรศัพท์ไม่ถูกต้อง (ต้องมี 10 หลัก)");
            return mav;
        }

        if (password != null && !password.trim().isEmpty()) {
            if (!password.equals(confirmPassword)) {
                mav.addObject("edit_result", "รหัสผ่านไม่ตรงกัน");
                return mav;
            }
            try {
                password = PasswordUtil.getInstance().createPassword(password, "Project");
                currentMember.setPassword(password);
            } catch (Exception e) {
                e.printStackTrace();
                mav.addObject("edit_result", "เกิดข้อผิดพลาดในการเข้ารหัสรหัสผ่าน");
                return mav;
            }
        }

        // อัปเดตข้อมูล
        currentMember.setFirstName(firstName);
        currentMember.setLastName(lastName);
        currentMember.setPhoneNumber(phoneNumber);

        ThanachokManager manager = new ThanachokManager();
        boolean success = manager.insertMember(currentMember);

        if (success) {
            session.setAttribute("loginMember", currentMember);
            mav.addObject("edit_result", "บันทึกข้อมูลเรียบร้อยแล้ว");
        } else {
            mav.addObject("edit_result", "ไม่สามารถบันทึกข้อมูลได้ กรุณาลองใหม่อีกครั้ง");
        }

        return mav;
    }

    // หน้าแสดงห้องที่กำลังเช่าอยู่
    @RequestMapping(value = "/YourRoom", method = RequestMethod.GET)
    public ModelAndView showYourRoom(HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager manager = new ThanachokManager();

        // ดึงห้องที่กำลังเช่าอยู่ทั้งหมด (รวมสถานะ "รอคืนห้อง")
        List<RentalDeposit> currentRentals = manager.findCurrentRentalsByMember(loginMember);

        ModelAndView mav = new ModelAndView("YourRoom");
        mav.addObject("currentRentals", currentRentals);
        mav.addObject("loginMember", loginMember);
        mav.addObject("rentalCount", currentRentals.size());

        return mav;
    }

    @RequestMapping(value = "/Record", method = RequestMethod.GET)
    public ModelAndView showRecord(HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager manager = new ThanachokManager();

        // ดึงข้อมูลทั้งหมด
        List<RentalDeposit> allDeposits = manager.findAllDepositsByMemberForRecord(loginMember);

        // แบ่งกลุ่มตามสถานะ - เอาเฉพาะ 2 กลุ่ม
        List<RentalDeposit> pendingApproval = new ArrayList<>(); // รอดำเนินการ
        List<RentalDeposit> completed = new ArrayList<>(); // คืนห้องแล้ว

        for (RentalDeposit deposit : allDeposits) {
            String status = deposit.getStatus();
            if ("รอดำเนินการ".equals(status)) {
                pendingApproval.add(deposit);
            } else if ("คืนห้องแล้ว".equals(status)) {
                completed.add(deposit);
            }
        }

        ModelAndView mav = new ModelAndView("Record");
        mav.addObject("pendingApproval", pendingApproval);
        mav.addObject("returnedRentals", completed);
        mav.addObject("loginMember", loginMember);

        mav.addObject("pendingApprovalCount", pendingApproval.size());
        mav.addObject("returnedCount", completed.size());

        return mav;
    }

    @RequestMapping(value = "/ReturnRoom", method = RequestMethod.GET)
    public ModelAndView returnRoom(@RequestParam("rentId") int rentId, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return new ModelAndView("redirect:/Login");
        }

        try {
            ThanachokManager manager = new ThanachokManager();

            Rent rent = manager.findRentById(rentId);
            if (rent == null || rent.getMember().getMemberID() != loginMember.getMemberID()) {
                ModelAndView mav = new ModelAndView("redirect:/YourRoom");
                mav.addObject("error", "ไม่พบข้อมูลการจองหรือไม่มีสิทธิ์เข้าถึง");
                return mav;
            }
            
            // ตรวจสอบระยะเวลาเช่า 6 เดือน
            Date rentDate = rent.getRentDate();
            Date currentDate = new Date();
            long diffInMillies = currentDate.getTime() - rentDate.getTime();
            long diffInMonths = diffInMillies / (24L * 60 * 60 * 1000 * 30);
            
            if (diffInMonths < 6) {
                ModelAndView mav = new ModelAndView("redirect:/YourRoom");
                mav.addObject("error", "ไม่สามารถคืนห้องได้ เนื่องจากต้องเช่าอย่างน้อย 6 เดือน (เหลืออีก " + (6 - diffInMonths) + " เดือน)");
                return mav;
            }

            // ตรวจสอบสถานะบิลค้างชำระ
            boolean hasUnpaidInvoices = manager.hasUnpaidInvoices(rentId);
            if (hasUnpaidInvoices) {
                ModelAndView mav = new ModelAndView("redirect:/YourRoom");
                mav.addObject("error",
                        "ไม่สามารถส่งคำขอคืนห้องได้ เนื่องจากมีค่าใช้จ่ายค้างชำระ กรุณาชำระบิลให้ครบถ้วนก่อน");
                return mav;
            }

            // ส่งคำขอคืนห้อง (ไม่ใช่คืนทันที)
            boolean success = manager.requestReturnRoom(rentId);

            ModelAndView mav = new ModelAndView("redirect:/YourRoom");
            if (success) {
                mav.addObject("message", "ส่งคำขอคืนห้อง " + rent.getRoom().getRoomNumber() +
                        " เรียบร้อยแล้ว รอ Manager อนุมัติ");
            } else {
                mav.addObject("error", "เกิดข้อผิดพลาดในการส่งคำขอ กรุณาลองใหม่อีกครั้ง");
            }

            return mav;

        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mav = new ModelAndView("redirect:/YourRoom");
            mav.addObject("error", "เกิดข้อผิดพลาดในระบบ: " + e.getMessage());
            return mav;
        }
    }

    @RequestMapping(value = "/Listinvoice", method = RequestMethod.GET)
    public ModelAndView listInvoices(HttpSession session) {
        Member member = (Member) session.getAttribute("loginMember");
        if (member == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager manager = new ThanachokManager();

        // ดึงรายการใบแจ้งหนี้ของสมาชิก
        List<Invoice> invoices = manager.findInvoicesByMember(member.getMemberID());

        ModelAndView mav = new ModelAndView("ListInvoice");
        mav.addObject("invoices", invoices);
        mav.addObject("loginMember", member);

        return mav;
    }

    // รายละเอียดใบแจ้งหนี้
    @RequestMapping(value = "/InvoiceDetail", method = RequestMethod.GET)
    public ModelAndView invoiceDetail(@RequestParam("invoiceId") int invoiceId, HttpSession session) {
        Member member = (Member) session.getAttribute("loginMember");
        if (member == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager manager = new ThanachokManager();
        Invoice invoice = manager.getInvoiceWithDetails(invoiceId);

        // ตรวจสอบว่าใบแจ้งหนี้นี้เป็นของสมาชิกคนนี้หรือไม่
        if (invoice == null || invoice.getRent().getMember().getMemberID() != member.getMemberID()) {
            ModelAndView mav = new ModelAndView("redirect:/Listinvoice");
            mav.addObject("error", "ไม่พบใบแจ้งหนี้ที่ต้องการ หรือคุณไม่มีสิทธิ์เข้าถึง");
            return mav;
        }

        ModelAndView mav = new ModelAndView("InvoiceDetail");
        mav.addObject("invoice", invoice);
        mav.addObject("invoiceDetails", invoice.getDetails());

        return mav;
    }

}
