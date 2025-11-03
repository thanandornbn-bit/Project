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
import com.springmvc.model.Reserve;
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
        List<Rent> activeRentals = manager.findActiveDepositsByMember(member);
        int activeRentalCount = activeRentals.size();

        // ดึงข้อมูลการจองทุกสถานะที่ยังใช้งานอยู่
        List<Reserve> memberReserves = manager.findReservesByMember(member);
        int approvedReservesCount = 0;
        int totalActiveReservesCount = 0; // นับทุกสถานะที่ยังใช้งาน

        for (Reserve reserve : memberReserves) {
            String reserveStatus = reserve.getStatus();
            // นับการจองที่ยังใช้งานอยู่ (ยกเว้นปฏิเสธและยกเลิก)
            if ("รอการอนุมัติ".equals(reserveStatus) ||
                    "อนุมัติแล้ว".equals(reserveStatus) ||
                    "ชำระค่ามัดจำแล้ว".equals(reserveStatus)) {
                totalActiveReservesCount++;
            }

            // นับเฉพาะที่อนุมัติแล้วเพื่อแสดง badge
            if ("อนุมัติแล้ว".equals(reserveStatus)) {
                approvedReservesCount++;
            }
        }

        // รวมจำนวนการเช่าและการจอง active
        int totalActiveCount = activeRentalCount + totalActiveReservesCount;

        ModelAndView mav = new ModelAndView("Homesucess");
        mav.addObject("roomList", roomList);
        mav.addObject("floor", floor);
        mav.addObject("status", status);
        mav.addObject("activeRentalCount", totalActiveCount); // ส่งจำนวนรวม
        mav.addObject("activeRentals", activeRentals);
        mav.addObject("approvedReservesCount", approvedReservesCount);
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

            // ค้นหา Reserve ของ Member และ Room นี้ (รอการอนุมัติหรืออนุมัติแล้ว)
            List<Reserve> memberReserves = thanachokManager.findReservesByMember(loginMember);
            Reserve targetReserve = null;
            for (Reserve reserve : memberReserves) {
                if (reserve.getRoom().getRoomID() == roomID &&
                        ("รอการอนุมัติ".equals(reserve.getStatus()) || "อนุมัติแล้ว".equals(reserve.getStatus()))) {
                    targetReserve = reserve;
                    break;
                }
            }

            // ตรวจสอบว่าพบการจองของ Member หรือไม่
            if (targetReserve == null) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "ไม่พบการจองสำหรับห้องนี้ กรุณาทำการจองห้องก่อน");
                return "redirect:/Homesucess";
            }

            // ตรวจสอบว่าห้องไม่ได้ถูกจองโดยคนอื่นในระหว่างนี้
            if (!"ว่าง".equals(room.getRoomStatus()) && !"ไม่ว่าง".equals(room.getRoomStatus())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "ห้อง " + room.getRoomNumber() + " ไม่สามารถจองได้ในขณะนี้");
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
            String[] existingFiles = uploadPath.list((_dir, name) -> name.matches("slipet\\d+\\.\\w+"));
            int nextNumber = existingFiles != null ? existingFiles.length + 1 : 1;
            String newFileName = String.format("slipet%02d%s", nextNumber, extension);

            File dest = new File(uploadPath, newFileName);
            paymentSlip.transferTo(dest);

            // ตรวจสอบว่าได้จ่ายค่ามัดจำสำหรับห้องนี้ไปแล้วหรือยัง
            List<Rent> existingRents = thanachokManager.findRentsByMemberAndRoom(loginMember, room);
            for (Rent existingRent : existingRents) {
                if ("ชำระแล้ว".equals(existingRent.getStatus()) ||
                        "เสร็จสมบูรณ์".equals(existingRent.getStatus()) ||
                        "รอคืนห้อง".equals(existingRent.getStatus())) {
                    redirectAttributes.addFlashAttribute("errorMessage",
                            "คุณได้จ่ายค่ามัดจำสำหรับห้องนี้ไปแล้ว ไม่สามารถจ่ายซ้ำได้");
                    return "redirect:/YourRoom";
                }
            }

            // อัปเดตสถานะ Reserve เป็น "ชำระแล้ว" เพื่อติดตามสถานะ
            targetReserve.setStatus("ชำระแล้ว");
            boolean reserveUpdated = thanachokManager.updateReserve(targetReserve);
            if (!reserveUpdated) {
                redirectAttributes.addFlashAttribute("errorMessage", "ไม่สามารถอัปเดตสถานะการจองได้");
                return "redirect:/Record";
            }

            // สร้าง Rent สถานะ "รออนุมัติ" (ยังไม่ได้ห้อง)
            Rent deposit = new Rent();
            deposit.setRentID(0);
            deposit.setMember(loginMember);
            deposit.setRoom(room);
            deposit.setTotalPrice(String.valueOf(depositAmount));
            deposit.setRentDate(new Date());
            // returnDate จะเป็น NULL จนกว่า Member จะคืนห้องและ Manager อนุมัติ
            deposit.setStatus("รออนุมัติ"); // รอ Manager อนุมัติ
            deposit.setPaymentSlipImage(uploadDir + "/" + newFileName);
            deposit.setTransferAccountName(transferAccountName);
            deposit.setDeadline(deadline);

            boolean depositInserted = thanachokManager.saveRent(deposit);
            if (!depositInserted) {
                redirectAttributes.addFlashAttribute("errorMessage", "ไม่สามารถสร้างรายการค่ามัดจำได้");
                return "redirect:/Record";
            }

            // ไม่ต้องอัปเดตสถานะห้องตอนนี้ รอ Manager อนุมัติก่อน

            redirectAttributes.addFlashAttribute("message",
                    "ชำระเงินสำเร็จ! กรุณารอ Manager อนุมัติค่ามัดจำของห้อง " + room.getRoomNumber());
            return "redirect:/Record";

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
        List<Rent> activeRentals = manager.findActiveDepositsByMember(loginMember);

        for (Rent rd : activeRentals) {
            System.out.println("Room: " + rd.getRoom().getRoomNumber() +
                    ", Status: " + rd.getStatus());
        }

        boolean hasActiveRental = !activeRentals.isEmpty();
        int activeCount = activeRentals.size();

        response.put("hasActiveRental", hasActiveRental);
        response.put("activeRentalCount", activeCount);

        List<String> roomNumbers = new ArrayList<>();
        for (Rent rd : activeRentals) {
            roomNumbers.add(rd.getRoom().getRoomNumber());
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
    public void getSlipImage(@RequestParam("RentId") int RentId, HttpServletResponse response) {
        try {
            ThanachokManager thanachokManager = new ThanachokManager();
            Rent deposit = thanachokManager.findRentByRentId(RentId);

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

    // ดึงรูปภาพห้อง (แบบเดียวกับ SlipImage)
    @RequestMapping(value = "/RoomImage", method = RequestMethod.GET)
    public void getRoomImage(@RequestParam("roomId") int roomId,
            @RequestParam("imageType") String imageType,
            HttpServletResponse response) {
        try {
            ThanachokManager manager = new ThanachokManager();
            Room room = manager.findRoomById(roomId);

            if (room != null) {
                String imagePath = null;

                switch (imageType) {
                    case "number":
                        imagePath = room.getRoomNumberImage();
                        break;
                    case "1":
                        imagePath = room.getRoomImage1();
                        break;
                    case "2":
                        imagePath = room.getRoomImage2();
                        break;
                    case "3":
                        imagePath = room.getRoomImage3();
                        break;
                    case "4":
                        imagePath = room.getRoomImage4();
                        break;
                }

                if (imagePath != null && !imagePath.isEmpty()) {
                    // อ่านจาก /tmp/ ที่ ManagerController บันทึกไว้
                    String basePath = "/tmp/";
                    String fullPath = basePath + imagePath;

                    File imageFile = new File(fullPath);

                    if (imageFile.exists()) {
                        String contentType = Files.probeContentType(imageFile.toPath());
                        response.setContentType(contentType != null ? contentType : "image/jpeg");

                        Files.copy(imageFile.toPath(), response.getOutputStream());
                        response.getOutputStream().flush();
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "ไม่พบไฟล์ภาพ");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "ไม่มีข้อมูลรูปภาพ");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "ไม่พบข้อมูลห้อง");
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
        List<Rent> currentRentals = manager.findCurrentRentalsByMember(loginMember);

        // สร้าง Map เก็บข้อมูลบิลค้างชำระแต่ละห้อง
        Map<Integer, String> unpaidInvoicesByRent = new HashMap<>();
        java.text.SimpleDateFormat monthFormat = new java.text.SimpleDateFormat("MMMM yyyy",
                java.util.Locale.forLanguageTag("th-TH"));

        for (Rent rental : currentRentals) {
            List<Invoice> unpaidInvoices = manager.getUnpaidInvoices(rental.getRentID());
            if (!unpaidInvoices.isEmpty()) {
                StringBuilder months = new StringBuilder();
                for (int i = 0; i < unpaidInvoices.size(); i++) {
                    months.append(monthFormat.format(unpaidInvoices.get(i).getIssueDate()));
                    if (i < unpaidInvoices.size() - 1) {
                        months.append(", ");
                    }
                }
                unpaidInvoicesByRent.put(rental.getRentID(), months.toString());
            }
        }

        ModelAndView mav = new ModelAndView("YourRoom");
        mav.addObject("currentRentals", currentRentals);
        mav.addObject("loginMember", loginMember);
        mav.addObject("rentalCount", currentRentals.size());
        mav.addObject("unpaidInvoicesByRent", unpaidInvoicesByRent);

        return mav;
    }

    @RequestMapping(value = "/Record", method = RequestMethod.GET)
    public ModelAndView showRecord(HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager manager = new ThanachokManager();

        // ปฏิเสธการจองที่หมดเวลาชำระเงิน (เกิน 24 ชั่วโมง) อัตโนมัติ
        manager.autoRejectExpiredReservations();

        // ดึงข้อมูลทั้งหมด
        List<Rent> allDeposits = manager.findAllDepositsByMemberForRecord(loginMember);

        // แบ่งกลุ่มตามสถานะ
        List<Rent> pendingApproval = new ArrayList<>(); // รออนุมัติ
        List<Rent> paidRents = new ArrayList<>(); // ชำระแล้ว
        List<Rent> completed = new ArrayList<>(); // คืนห้องแล้ว

        for (Rent deposit : allDeposits) {
            String status = deposit.getStatus();
            System.out.println("DEBUG Record - Rent ID: " + deposit.getRentID() + ", Status: '" + status + "'");

            if ("รออนุมัติ".equals(status)) {
                pendingApproval.add(deposit);
            } else if ("ชำระแล้ว".equals(status)) {
                paidRents.add(deposit);
            } else if ("คืนห้องแล้ว".equals(status)) {
                completed.add(deposit);
                System.out.println("✓ Added to completed (returned): Rent ID " + deposit.getRentID());
            } else if ("รอคืนห้อง".equals(status)) {
                // ถ้ามีสถานะ "รอคืนห้อง" ให้เพิ่มเข้าไปใน completed ด้วย
                completed.add(deposit);
                System.out.println("✓ Added to completed (pending return): Rent ID " + deposit.getRentID());
            }
        }

        System.out.println("=== Record Summary ===");
        System.out.println("Pending Approval: " + pendingApproval.size());
        System.out.println("Paid Rents: " + paidRents.size());
        System.out.println("Completed (Returned): " + completed.size());

        // ดึงข้อมูลการจอง (Reserve) ของ Member
        List<Reserve> memberReserves = manager.findReservesByMember(loginMember);

        // แยกการจองตามสถานะ (Reserve จบที่ "อนุมัติแล้ว" เท่านั้น)
        List<Reserve> pendingReserves = new ArrayList<>(); // รอการอนุมัติ
        List<Reserve> approvedReserves = new ArrayList<>(); // อนุมัติแล้ว (สามารถจ่ายเงินได้)
        List<Reserve> rejectedReserves = new ArrayList<>(); // ปฏิเสธ

        for (Reserve reserve : memberReserves) {
            String status = reserve.getStatus();
            if ("รอการอนุมัติ".equals(status)) {
                pendingReserves.add(reserve);
            } else if ("อนุมัติแล้ว".equals(status)) {
                approvedReserves.add(reserve);
            } else if ("ปฏิเสธ".equals(status)) {
                rejectedReserves.add(reserve);
            }
        }

        ModelAndView mav = new ModelAndView("Record");
        mav.addObject("pendingApproval", pendingApproval);
        mav.addObject("paidRents", paidRents); // เพิ่มรายการ Rent ที่ชำระแล้ว
        mav.addObject("returnedRentals", completed);
        mav.addObject("loginMember", loginMember);

        mav.addObject("pendingApprovalCount", pendingApproval.size());
        mav.addObject("paidReservesCount", paidRents.size()); // นับจำนวน Rent ที่ชำระแล้ว
        mav.addObject("returnedCount", completed.size());

        // กรอง approvedReserves: เอาเฉพาะที่ยังไม่มี Rent (ยังไม่ได้จ่ายเงิน)
        List<Reserve> filteredApprovedReserves = new ArrayList<>();
        for (Reserve reserve : approvedReserves) {
            boolean hasPaid = false;
            // เช็คว่ามี Rent ที่ตรงกับห้องและสมาชิกคนนี้หรือไม่
            for (Rent rent : paidRents) {
                if (rent.getRoom().getRoomID() == reserve.getRoom().getRoomID()
                        && rent.getMember().getMemberID() == reserve.getMember().getMemberID()) {
                    hasPaid = true;
                    break;
                }
            }
            for (Rent rent : pendingApproval) {
                if (rent.getRoom().getRoomID() == reserve.getRoom().getRoomID()
                        && rent.getMember().getMemberID() == reserve.getMember().getMemberID()) {
                    hasPaid = true;
                    break;
                }
            }

            // เพิ่มเฉพาะที่ยังไม่ได้จ่ายเงิน
            if (!hasPaid) {
                filteredApprovedReserves.add(reserve);
            }
        }

        // เพิ่มข้อมูลการจอง (Reserve จบที่ "อนุมัติแล้ว")
        mav.addObject("pendingReserves", pendingReserves);
        mav.addObject("approvedReserves", filteredApprovedReserves); // ใช้ list ที่กรองแล้ว
        mav.addObject("rejectedReserves", rejectedReserves);
        mav.addObject("pendingReservesCount", pendingReserves.size());
        mav.addObject("approvedReservesCount", filteredApprovedReserves.size()); // นับจากที่กรองแล้ว
        mav.addObject("rejectedReservesCount", rejectedReserves.size());

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

            // ตรวจสอบสถานะบิลค้างชำระ
            boolean hasUnpaidInvoices = manager.hasUnpaidInvoices(rentId);
            if (hasUnpaidInvoices) {
                // ดึงรายการบิลค้างชำระ
                List<Invoice> unpaidInvoices = manager.getUnpaidInvoices(rentId);

                // สร้างข้อความแจ้งเตือนพร้อมเดือนที่ค้างชำระ
                StringBuilder errorMsg = new StringBuilder("ไม่สามารถส่งคำขอคืนห้องได้ เนื่องจากมีบิลค้างชำระ: ");
                java.text.SimpleDateFormat monthFormat = new java.text.SimpleDateFormat("MMMM yyyy",
                        java.util.Locale.forLanguageTag("th-TH"));

                for (int i = 0; i < unpaidInvoices.size(); i++) {
                    errorMsg.append(monthFormat.format(unpaidInvoices.get(i).getIssueDate()));
                    if (i < unpaidInvoices.size() - 1) {
                        errorMsg.append(", ");
                    }
                }
                errorMsg.append(" - กรุณาชำระบิลให้ครบถ้วนก่อน");

                ModelAndView mav = new ModelAndView("redirect:/YourRoom");
                mav.addObject("error", errorMsg.toString());
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

        // ดึงข้อมูล Invoice ล่าสุด (getInvoiceWithDetails จะ clear cache อัตโนมัติ)
        Invoice invoice = manager.getInvoiceWithDetails(invoiceId);

        System.out.println("=== InvoiceDetail: Loading Invoice #" + invoiceId + " ===");
        if (invoice != null && invoice.getDetails() != null) {
            System.out.println("Invoice found with " + invoice.getDetails().size() + " details");
            System.out.println("Total amount: " + invoice.getTotalAmount());
        }

        // ตรวจสอบว่าใบแจ้งหนี้นี้เป็นของสมาชิกคนนี้หรือไม่
        if (invoice == null || invoice.getRent().getMember().getMemberID() != member.getMemberID()) {
            ModelAndView mav = new ModelAndView("redirect:/Listinvoice");
            mav.addObject("error", "ไม่พบใบแจ้งหนี้ที่ต้องการ หรือคุณไม่มีสิทธิ์เข้าถึง");
            return mav;
        }

        ModelAndView mav = new ModelAndView("InvoiceDetail");
        mav.addObject("invoice", invoice);
        mav.addObject("invoiceDetails", invoice.getDetails());

        // ป้องกัน browser cache
        mav.addObject("timestamp", System.currentTimeMillis());

        return mav;
    }

}
