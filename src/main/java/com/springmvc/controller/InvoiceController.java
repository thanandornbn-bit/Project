package com.springmvc.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Invoice;
import com.springmvc.model.InvoiceDetail;
import com.springmvc.model.InvoiceType;
import com.springmvc.model.Manager;
import com.springmvc.model.Rent;
import com.springmvc.model.Room;
import com.springmvc.model.ThanachokManager;

@Controller
public class InvoiceController {

    //แสดงฟอร์มเพิ่มบิลใหม่
    @RequestMapping(value = "/ManagerAddInvoice", method = RequestMethod.GET)
    public ModelAndView showAddInvoiceForm(@RequestParam("roomID") int roomID, 
                                           HttpSession session) {
        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager tm = new ThanachokManager();
        
        // ดึงข้อมูลห้อง
        Room room = tm.findRoomById(roomID);
        
        if (room == null) {
            ModelAndView mav = new ModelAndView("ManagerAddInvoice");
            mav.addObject("error", "ไม่พบข้อมูลห้องพักที่ระบุ");
            return mav;
        }
        
        // ตรวจสอบว่าห้องมีผู้เช่าหรือไม่
        if ("ว่าง".equals(room.getRoomStatus())) {
            ModelAndView mav = new ModelAndView("ManagerAddInvoice");
            mav.addObject("error", "ห้องนี้ยังไม่มีผู้เช่า ไม่สามารถสร้างบิลได้");
            return mav;
        }
        
        // ดึงข้อมูลการเช่าที่ active
        Rent rent = tm.getActiveRentByRoomID(roomID);
        
        if (rent == null) {
            ModelAndView mav = new ModelAndView("ManagerAddInvoice");
            mav.addObject("error", "ไม่พบข้อมูลการเช่าที่ใช้งานอยู่ของห้องนี้");
            return mav;
        }
        
        // คำนวณวันที่ออกบิลและวันครบกำหนด
        LocalDate today = LocalDate.now();
        LocalDate dueDate = today.plusDays(7); // ครบกำหนด 7 วัน
        
        ModelAndView mav = new ModelAndView("ManagerAddInvoice");
        mav.addObject("room", room);
        mav.addObject("rent", rent);
        mav.addObject("today", today);
        mav.addObject("dueDate", dueDate);
        
        System.out.println("=== AddInvoice Page Data ===");
        System.out.println("Room ID: " + room.getRoomID());
        System.out.println("Room Number: " + room.getRoomNumber());
        System.out.println("Rent ID: " + rent.getRentID());
        System.out.println("Today: " + today);
        System.out.println("Due Date: " + dueDate);
        
        return mav;
    }

    //บันทึกบิลใหม่
    @RequestMapping(value = "/SaveInvoice", method = RequestMethod.POST)
    public String saveInvoice(HttpServletRequest request, 
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return "redirect:/Login";
        }

        try {
            //รับข้อมูลจากฟอร์ม
            int rentId = Integer.parseInt(request.getParameter("rentId"));
            String issueDateStr = request.getParameter("issueDate");
            String dueDateStr = request.getParameter("dueDate");
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
            int statusId = Integer.parseInt(request.getParameter("statusId"));
            
            // ข้อมูลค่าสาธารณูปโภค
            double roomPrice = Double.parseDouble(request.getParameter("roomPrice"));
            double internetPrice = Double.parseDouble(request.getParameter("internetPrice"));
            double penalty = Double.parseDouble(request.getParameter("penalty"));
            
            // น้ำ
            int prevWater = Integer.parseInt(request.getParameter("prevWater"));
            int currWater = Integer.parseInt(request.getParameter("currWater"));
            double waterRate = Double.parseDouble(request.getParameter("waterRate"));
            
            // ไฟฟ้า
            int prevElectric = Integer.parseInt(request.getParameter("prevElectric"));
            int currElectric = Integer.parseInt(request.getParameter("currElectric"));
            double electricRate = Double.parseDouble(request.getParameter("electricRate"));
            
            System.out.println("=== Save Invoice Request ===");
            System.out.println("Rent ID: " + rentId);
            System.out.println("Issue Date: " + issueDateStr);
            System.out.println("Due Date: " + dueDateStr);
            System.out.println("Total Price: " + totalPrice);
            System.out.println("Status: " + statusId);
            
            //ตรวจสอบข้อมูล
            ThanachokManager tm = new ThanachokManager();
            
            // ดึงข้อมูล Rent
            Rent rent = tm.findRentById(rentId);
            if (rent == null) {
                redirectAttributes.addFlashAttribute("error", "ไม่พบข้อมูลการเช่า");
                return "redirect:/OwnerHome";
            }
            
            // แปลงวันที่
            LocalDate issueDate = LocalDate.parse(issueDateStr);
            LocalDate dueDate = LocalDate.parse(dueDateStr);
            
            //สร้าง Invoice
            Invoice invoice = new Invoice();
            invoice.setRent(rent);
            invoice.setIssueDate(issueDate);
            invoice.setDueDate(dueDate);
            invoice.setTotalAmount(BigDecimal.valueOf(totalPrice));
            invoice.setStatus(statusId);
            
            // ========== สร้าง InvoiceDetails ==========
            List<InvoiceDetail> details = new ArrayList<>();
            
            // ค่าห้อง
            InvoiceDetail roomDetail = createInvoiceDetail(tm, invoice, "ค่าห้อง", 
                roomPrice, 1, roomPrice);
            if (roomDetail != null) {
                details.add(roomDetail);
                System.out.println("Added: ค่าห้อง = " + roomPrice);
            }
            
            // ค่าอินเทอร์เน็ต
            if (internetPrice > 0) {
                InvoiceDetail internetDetail = createInvoiceDetail(tm, invoice, "ค่าอินเทอร์เน็ต", 
                    internetPrice, 1, internetPrice);
                if (internetDetail != null) {
                    details.add(internetDetail);
                    System.out.println("Added: ค่าอินเทอร์เน็ต = " + internetPrice);
                }
            }
            
            // ค่าน้ำ
            int waterUsage = currWater - prevWater;
            if (waterUsage > 0) {
                double waterTotal = waterUsage * waterRate;
                InvoiceDetail waterDetail = createInvoiceDetail(tm, invoice, "ค่าน้ำ", 
                    waterRate, waterUsage, waterTotal);
                if (waterDetail != null) {
                    details.add(waterDetail);
                    System.out.println("Added: ค่าน้ำ = " + waterTotal + 
                        " (Usage: " + waterUsage + " @ " + waterRate + ")");
                }
            }
            
            // ค่าไฟฟ้า
            int electricUsage = currElectric - prevElectric;
            if (electricUsage > 0) {
                double electricTotal = electricUsage * electricRate;
                InvoiceDetail electricDetail = createInvoiceDetail(tm, invoice, "ค่าไฟฟ้า", 
                    electricRate, electricUsage, electricTotal);
                if (electricDetail != null) {
                    details.add(electricDetail);
                    System.out.println("Added: ค่าไฟฟ้า = " + electricTotal + 
                        " (Usage: " + electricUsage + " @ " + electricRate + ")");
                }
            }
            
            // ค่าปรับ
            if (penalty > 0) {
                InvoiceDetail penaltyDetail = createInvoiceDetail(tm, invoice, "ค่าปรับ", 
                    penalty, 1, penalty);
                if (penaltyDetail != null) {
                    details.add(penaltyDetail);
                    System.out.println("Added: ค่าปรับ = " + penalty);
                }
            }
            
            // เพิ่ม details ลงใน invoice
            invoice.setDetails(details);
            
            System.out.println("Total details: " + details.size());
            
            //บันทึกลงฐานข้อมูล
            boolean success = tm.saveInvoice(invoice);
            
            if (success) {
                System.out.println("Invoice saved successfully! ID: " + invoice.getInvoiceId());
                redirectAttributes.addFlashAttribute("message", 
                    "สร้างบิล INV-" + invoice.getInvoiceId() + " สำเร็จ " +
                    "ยอดรวม ฿" + String.format("%,.2f", totalPrice));
                return "redirect:/EditInvoice?roomID=" + rent.getRoom().getRoomID();
            } else {
                System.out.println("Failed to save invoice");
                redirectAttributes.addFlashAttribute("error", 
                    "ไม่สามารถบันทึกบิลได้ กรุณาลองใหม่อีกครั้ง");
                return "redirect:/AddInvoice?roomID=" + rent.getRoom().getRoomID();
            }
            
        } catch (NumberFormatException e) {
            System.out.println("Number format error: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", 
                "ข้อมูลที่กรอกไม่ถูกต้อง กรุณาตรวจสอบตัวเลขที่กรอก");
            return "redirect:/OwnerHome";
        } catch (Exception e) {
            System.out.println("General error: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", 
                "เกิดข้อผิดพลาด: " + e.getMessage());
            return "redirect:/OwnerHome";
        }
    }
    private InvoiceDetail createInvoiceDetail(ThanachokManager tm, Invoice invoice, 
                                             String typeName, double price, 
                                             int quantity, double amount) {
        try {
            // ค้นหาหรือสร้าง InvoiceType
            InvoiceType type = tm.getInvoiceTypeByName(typeName);
            if (type == null) {
                System.out.println("Warning: Could not create/find InvoiceType: " + typeName);
                return null;
            }
            
            // สร้าง InvoiceDetail
            InvoiceDetail detail = new InvoiceDetail();
            detail.setInvoice(invoice);
            detail.setType(type);
            detail.setPrice(BigDecimal.valueOf(price));
            detail.setQuantity(quantity);
            detail.setAmount(BigDecimal.valueOf(amount));
            
            System.out.println("Created detail: " + typeName + 
                " (Price: " + price + ", Qty: " + quantity + ", Amount: " + amount + ")");
            
            return detail;
        } catch (Exception e) {
            System.out.println("Error creating invoice detail for " + typeName + ": " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}