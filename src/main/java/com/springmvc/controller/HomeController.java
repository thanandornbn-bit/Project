package com.springmvc.controller;

import java.io.File;
import java.io.IOException;
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

    // ✅ หน้าแสดงฟอร์มการชำระเงิน
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

            // Use path relative to the webapp directory
            String uploadDir = "Slipet"; // Path relative to the webapp folder
            String realPath = session.getServletContext().getRealPath(uploadDir);
            File uploadPath = new File(realPath);
            if (!uploadPath.exists()) uploadPath.mkdirs();

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



    // ✅ ประวัติการจองของสมาชิก
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
    
    
    /*--------------------------------Manager-------------------------------------*/
    
 // ✅ หน้าเจ้าของหอ (ดูห้องทั้งหมด)
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

         String uploadPath = "C:\\Project\\Thanachok\\src\\main\\webapp\\images";
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
     public ModelAndView showEditRoomForm(@RequestParam("id") int roomID,
                                          HttpSession session) {

         Manager manager = (Manager) session.getAttribute("loginManager");
         if (manager == null) {
             return new ModelAndView("redirect:/Login");
         }

         ThanachokManager tm = new ThanachokManager();
         Room room = tm.findRoomById(roomID);

         ModelAndView mav = new ModelAndView("EditRoom");
         mav.addObject("room", room);          // ส่ง object ไปให้ JSP
         return mav;
     }
     

     /* ----------   อัปเดตข้อมูลห้อง   ---------- */
     @RequestMapping(value = "/UpdateRoom", method = RequestMethod.POST)
     public String updateRoom(@RequestParam("roomID") int roomID,
                              @RequestParam("roomNumber") String roomNumber,
                              @RequestParam("description") String description,
                              @RequestParam("roomPrice") String roomPrice,
                              @RequestParam("roomtype")  String roomtype,
                              @RequestParam("images")    MultipartFile[] images,
                              RedirectAttributes redirect) {

         ThanachokManager tm = new ThanachokManager();
         Room room = tm.findRoomById(roomID);

         // ------ อัปเดตฟิลด์ข้อความ ------
         room.setRoomNumber(roomNumber);
         room.setDescription(description);
         room.setRoomPrice(roomPrice);
         
         room.setRoomtype(roomtype);

         // ------ ถ้ามีการอัปโหลดภาพใหม่ ------
         String uploadPath = "C:\\Project\\Thanachok\\src\\main\\webapp\\images";
         List<String> imagePaths = new ArrayList<>();

         for (MultipartFile file : images) {
             if (file != null && !file.isEmpty()) {
                 String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
                 try {
                     if (file.getContentType().startsWith("image/")) {
                         file.transferTo(new File(uploadPath + filename));
                         imagePaths.add("images/" + filename);
                     } else {
                         redirect.addFlashAttribute("message", "ไฟล์ไม่ถูกต้อง (อัปโหลดเฉพาะรูป)");
                         return "redirect:/editRoom?id=" + roomID;
                     }
                 } catch (IOException e) {
                     e.printStackTrace();
                     redirect.addFlashAttribute("message", "อัปโหลดรูปไม่สำเร็จ");
                     return "redirect:/editRoom?id=" + roomID;
                 }
             }
         }

         // ถ้ามีรูปใหม่ก็อัปเดต (จะทับช่องเก่า)
         for (int i = 0; i < imagePaths.size(); i++) {
             if (i == 0) room.setImage1(imagePaths.get(i));
             if (i == 1) room.setImage2(imagePaths.get(i));
             if (i == 2) room.setImage3(imagePaths.get(i));
             if (i == 3) room.setImage4(imagePaths.get(i));
         }

         tm.updateRoom(room);                       // บันทึกลง DB
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

         return "OwnerHome"; // เปลี่ยนตามชื่อจริงของหน้า JSP
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
     
     
     




}

