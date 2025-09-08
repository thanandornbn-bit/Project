package com.springmvc.controller;

import java.io.File;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

            String uploadDir = "slipet";
            String realPath = "C:\\WebProject\\Project\\src\\main\\webapp\\slipet";

            File uploadPath = new File(realPath);
            if (!uploadPath.exists())
                uploadPath.mkdirs();

            // สร้างชื่อไฟล์ใหม่แบบเรียงลำดับ
            String[] existingFiles = uploadPath.list((dir, name) -> name.matches("slipet\\d+\\.\\w+"));
            int nextNumber = existingFiles != null ? existingFiles.length + 1 : 1;
            String newFileName = String.format("slipet%02d%s", nextNumber, extension);

            File dest = new File(uploadPath, newFileName);
            paymentSlip.transferTo(dest);

            Room room = thanachokManager.findRoomById(roomID);

            // สร้างการจองห้อง
            Rent rent = new Rent();
            rent.setMember(loginMember);
            rent.setRoom(room);
            rent.setRentDate(paymentDate);
            thanachokManager.saveRent(rent);

            // สร้างการชำระเงิน
            RentalDeposit deposit = new RentalDeposit();
            deposit.setRent(rent);
            deposit.setTransferAccountName(transferAccountName);
            deposit.setPaymentDate(paymentDate);
            deposit.setPaymentSlipImage(uploadDir + "/" + newFileName); 
            deposit.setDeadlineDate(deadline);
            deposit.setStatus("รอดำเนินการ");
            deposit.setTotalPrice("500");
            thanachokManager.saveRentalDeposit(deposit);

            // อัปเดตสถานะห้อง
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
            } catch (Exception ignored) {
            }
        }
    }


    // ✅ ออกจากระบบ
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


    // เพิ่มเมท็อดเหล่านี้ใน Controller ที่จัดการหน้า Record

@RequestMapping(value = "/Record", method = RequestMethod.GET)
public ModelAndView showRecord(HttpSession session) {
    Member loginMember = (Member) session.getAttribute("loginMember");
    if (loginMember == null) {
        return new ModelAndView("redirect:/Login");
    }

    ThanachokManager manager = new ThanachokManager();
    
    // ดึงเฉพาะการจองที่ยังไม่ได้คืนห้อง (สถานะไม่ใช่ "คืนห้องแล้ว")
    List<RentalDeposit> rentalDeposits = manager.findActiveDepositsByMember(loginMember);
    
    // ตรวจสอบสถานะบิลสำหรับแต่ละการจอง
    for (RentalDeposit deposit : rentalDeposits) {
        if (deposit.getStatus().equals("เสร็จสมบูรณ์")) {
            // ตรวจสอบว่ามีบิลค้างชำระหรือไม่
            boolean hasUnpaidInvoices = manager.hasUnpaidInvoices(deposit.getRent().getRentID());
            deposit.setHasUnpaidInvoices(hasUnpaidInvoices);
        }
    }
    
    ModelAndView mav = new ModelAndView("Record");
    mav.addObject("rentalDeposits", rentalDeposits);
    mav.addObject("loginMember", loginMember);
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
        
        // ตรวจสอบว่า rent นี้เป็นของ member ที่ login หรือไม่
        Rent rent = manager.findRentById(rentId);
        if (rent == null || rent.getMember().getMemberID() != loginMember.getMemberID()) {
            ModelAndView mav = new ModelAndView("redirect:/Record");
            mav.addObject("error", "ไม่พบข้อมูลการจองหรือไม่มีสิทธิ์เข้าถึง");
            return mav;
        }

        // ตรวจสอบสถานะบิลค้างชำระ
        boolean hasUnpaidInvoices = manager.hasUnpaidInvoices(rentId);
        if (hasUnpaidInvoices) {
            ModelAndView mav = new ModelAndView("redirect:/Record");
            mav.addObject("error", "ไม่สามารถคืนห้องได้ เนื่องจากมีค่าใช้จ่ายค้างชำระ กรุณาชำระบิลให้ครบถ้วนก่อน");
            return mav;
        }

        // ดำเนินการคืนห้อง
        boolean success = manager.returnRoom(rentId);
        
        ModelAndView mav = new ModelAndView("redirect:/Record");
        if (success) {
            mav.addObject("message", "คืนห้องเรียบร้อยแล้ว ห้อง " + rent.getRoom().getRoomNumber() + " ได้ถูกเปลี่ยนสถานะเป็นว่างแล้ว");
        } else {
            mav.addObject("error", "เกิดข้อผิดพลาดในการคืนห้อง กรุณาลองใหม่อีกครั้ง");
        }
        
        return mav;
        
    } catch (Exception e) {
        e.printStackTrace();
        ModelAndView mav = new ModelAndView("redirect:/Record");
        mav.addObject("error", "เกิดข้อผิดพลาดในระบบ: " + e.getMessage());
        return mav;
    }
}







}
