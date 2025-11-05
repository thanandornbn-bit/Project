package com.springmvc.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.springmvc.model.Reserve;
import com.springmvc.model.Room;
import com.springmvc.model.ThanachokManager;
import com.springmvc.model.UtilityRate;

@Controller
public class InvoiceController {

    // แสดงฟอร์มเพิ่มบิลใหม่
    @RequestMapping(value = "/ManagerAddInvoice", method = RequestMethod.GET)
    public ModelAndView showAddInvoiceForm(@RequestParam("roomID") int roomID,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager tm = new ThanachokManager();

        // ดึงข้อมูลห้อง
        Room room = tm.findRoomById(roomID);

        if (room == null) {
            redirectAttributes.addFlashAttribute("error", "ไม่พบข้อมูลห้องพักที่ระบุ");
            return new ModelAndView("redirect:/OwnerHome");
        }

        // ตรวจสอบว่าห้องมีผู้เช่าหรือไม่
        if ("ว่าง".equals(room.getRoomStatus())) {
            redirectAttributes.addFlashAttribute("error", "ห้องนี้ยังไม่มีผู้เช่า ไม่สามารถสร้างบิลได้");
            return new ModelAndView("redirect:/OwnerHome");
        }

       // ว่ามีบิลในเดือนนี้แล้วหรือยัง
        // boolean hasCurrentMonthInvoice = tm.hasInvoiceForCurrentMonth(roomID);
        // if (hasCurrentMonthInvoice) {
        //     redirectAttributes.addFlashAttribute("error",
        //             "ห้อง " + room.getRoomNumber()
        //                     + " มีบิลในเดือนนี้แล้ว ไม่สามารถสร้างบิลซ้ำได้ กรุณารอจนถึงเดือนหน้า");
        //     return new ModelAndView("redirect:/OwnerHome");
        // }

        
        // ดึงข้อมูลการเช่าที่ active
        Rent rent = tm.getActiveRentByRoomID(roomID);

        if (rent == null) {
            redirectAttributes.addFlashAttribute("error",
                    "ไม่พบข้อมูลการเช่าที่ใช้งานอยู่ของห้องนี้ (ห้อง " + room.getRoomNumber() +
                            ", สถานะห้อง: " + room.getRoomStatus() + "). " +
                            "กรุณาตรวจสอบว่ามีการจ่ายค่ามัดจำแล้วหรือไม่");
            return new ModelAndView("redirect:/OwnerHome");
        }
    // คำนวณวันที่ออกบิลและวันครบกำหนด
    Date today = new Date();
    java.util.Calendar cal = java.util.Calendar.getInstance();
    cal.setTime(today);
    cal.add(java.util.Calendar.DAY_OF_MONTH, 7);
    Date dueDate = cal.getTime();

    // ดึงเลขมิเตอร์จากบิลก่อนหน้า (use previous invoice before today)
    java.util.Map<String, Integer> prevReadings = tm.getPreviousMeterReadings(roomID);

        // ดึงข้อมูลหน่วยค่าน้ำ-ค่าไฟที่ใช้งานอยู่
        UtilityRate activeRate = tm.getActiveUtilityRate();
        double waterRatePerUnit = (activeRate != null) ? activeRate.getRatePerUnitWater() : 18.00;
        double electricRatePerUnit = (activeRate != null) ? activeRate.getRatePerUnitElectric() : 8.00;

        // ดึงราคาอินเทอร์เน็ตจาก Reserve โดยใช้ roomID และ memberID
        double internetPrice = 0.00;
        List<Reserve> reserves = tm.findReservesByRoomAndMember(rent.getRoom().getRoomID(),
                rent.getMember().getMemberID());
        if (reserves != null && !reserves.isEmpty()) {
            for (Reserve reserve : reserves) {
                if ("เช่าอยู่".equals(reserve.getStatus())) {
                    internetPrice = reserve.getInternetFee();
                    break;
                }
            }
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        ModelAndView mav = new ModelAndView("ManagerAddInvoice");
        mav.addObject("room", room);
        mav.addObject("rent", rent);
        mav.addObject("today", sdf.format(today));
        mav.addObject("dueDate", sdf.format(dueDate));

        // ส่งข้อมูลเลขมิเตอร์จากบิลก่อนหน้า
        mav.addObject("prevWater", prevReadings.get("prevWater"));
        mav.addObject("prevElectric", prevReadings.get("prevElectric"));
        mav.addObject("waterRate", waterRatePerUnit);
        mav.addObject("electricRate", electricRatePerUnit);
        mav.addObject("internetPrice", internetPrice);

        return mav;
    }

    // บันทึกบิลใหม่
    @RequestMapping(value = "/SaveInvoice", method = RequestMethod.POST)
    public String saveInvoice(HttpServletRequest request,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return "redirect:/Login";
        }

        try {
            // รับข้อมูลพื้นฐานจากฟอร์ม
            int rentId = Integer.parseInt(request.getParameter("rentId"));
            String issueDateStr = request.getParameter("issueDate");
            String dueDateStr = request.getParameter("dueDate");
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
            int statusId = Integer.parseInt(request.getParameter("statusId"));

            String itemCountStr = request.getParameter("itemCount");
            int itemCount = (itemCountStr != null) ? Integer.parseInt(itemCountStr) : 0;

            ThanachokManager tm = new ThanachokManager();

            // ดึงข้อมูล Rent
            Rent rent = tm.findRentById(rentId);
            if (rent == null) {
                redirectAttributes.addFlashAttribute("error", "ไม่พบข้อมูลการเช่า");
                return "redirect:/OwnerHome";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date issueDate = sdf.parse(issueDateStr);
            Date dueDate = sdf.parse(dueDateStr);

            // สร้าง Invoice
            Invoice invoice = new Invoice();
            invoice.setRent(rent);
            invoice.setIssueDate(issueDate);
            invoice.setDueDate(dueDate);
            invoice.setTotalAmount(totalPrice);
            invoice.setStatus(statusId);

            // สร้าง InvoiceDetails จาก items ที่ส่งมา
            List<InvoiceDetail> details = new ArrayList<>();

            for (int i = 0; i < itemCount; i++) {
                String typeParam = "item_" + i + "_type";
                String nameParam = "item_" + i + "_name";
                String amountParam = "item_" + i + "_amount";
                String priceParam = "item_" + i + "_rate";
                String currMeterParam = "item_" + i + "_currMeter";
                String prevMeterParam = "item_" + i + "_prevMeter";
                String remarkParam = "item_" + i + "_remark";

                String type = request.getParameter(typeParam);
                String name = request.getParameter(nameParam);
                String amountStr = request.getParameter(amountParam);
                String remark = request.getParameter(remarkParam);

                if (type == null || name == null || amountStr == null) {
                    continue;
                }

                double amount = Double.parseDouble(amountStr);

                // สำหรับน้ำ/ไฟ ไม่ต้องเช็ค amount > 0 (อนุญาตให้เป็น 0 ได้)
                if (amount < 0) {
                    continue;
                }

                InvoiceDetail detail = new InvoiceDetail();
                detail.setInvoice(invoice);
                detail.setAmount(amount);

                // จัดการตามประเภท
                if ("water".equals(type) || "electricity".equals(type)) {
                    // น้ำหรือไฟ - มีข้อมูลมิเตอร์
                    String currMeterStr = request.getParameter(currMeterParam);
                    String prevMeterStr = request.getParameter(prevMeterParam);
                    String rateStr = request.getParameter(priceParam);

                    if (currMeterStr != null && prevMeterStr != null && rateStr != null) {
                        int currMeter = Integer.parseInt(currMeterStr);
                        int prevMeter = Integer.parseInt(prevMeterStr);
                        double rate = Double.parseDouble(rateStr);

                        // ตรวจสอบว่ามิเตอร์ปัจจุบัน >= มิเตอร์เดือนก่อน (อนุญาตให้เท่ากันได้)
                        if (currMeter < prevMeter) {
                            redirectAttributes.addFlashAttribute("error",
                                    name + ": มิเตอร์ปัจจุบัน (" + currMeter +
                                            ") ต้องมากกว่าหรือเท่ากับมิเตอร์เดือนก่อน (" + prevMeter + ")");
                            return "redirect:/ManagerAddInvoice?roomID=" + rent.getRoom().getRoomID();
                        }

                        detail.setType(tm.getInvoiceTypeByName(name));
                        detail.setPrice(rate);
                        detail.setQuantity(currMeter); 
                        int usage = currMeter - prevMeter;

                    } else {
                        continue;
                    }
                } else if ("room".equals(type)) {
                    // ค่าห้อง
                    detail.setType(tm.getInvoiceTypeByName("ค่าห้อง"));
                    detail.setPrice(amount);
                    detail.setQuantity(1);
                } else if ("other".equals(type)) {
                    InvoiceType otherType = tm.getInvoiceTypeByName(name);
                    if (otherType == null) {
                        otherType = tm.getInvoiceTypeByName("อื่นๆ");
                    }
                    detail.setType(otherType);
                    detail.setPrice(amount);
                    detail.setQuantity(1);
                } else {
                    detail.setType(tm.getInvoiceTypeByName(name));
                    detail.setPrice(amount);
                    detail.setQuantity(1);

                    if ("penalty".equals(type) && remark != null && !remark.isEmpty()) {
                        detail.setRemark(remark);
                    }
                }

                details.add(detail);
            }

            // เพิ่ม details ลงใน invoice
            invoice.setDetails(details);

            // บันทึกลงฐานข้อมูล
            boolean success = tm.saveInvoice(invoice);

            if (success) {
                redirectAttributes.addFlashAttribute("message",
                        "สร้างบิล INV-" + invoice.getInvoiceId() + " สำเร็จ " +
                                "ยอดรวม ฿" + String.format("%,.2f", totalPrice));
                return "redirect:/EditInvoice?roomID=" + rent.getRoom().getRoomID();
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "ไม่สามารถบันทึกบิลได้ กรุณาลองใหม่อีกครั้ง");
                return "redirect:/ManagerAddInvoice?roomID=" + rent.getRoom().getRoomID();
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error",
                    "ข้อมูลที่กรอกไม่ถูกต้อง กรุณาตรวจสอบตัวเลขที่กรอก");
            return "redirect:/OwnerHome";
        } catch (Exception e) {
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
                return null;
            }

            // สร้าง InvoiceDetail
            InvoiceDetail detail = new InvoiceDetail();
            detail.setInvoice(invoice);
            detail.setType(type);
            detail.setPrice(price);
            detail.setQuantity(quantity);
            detail.setAmount(amount);

            return detail;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // แก้ไขใบแจ้งหนี้ของห้องที่เลือก
    @RequestMapping(value = "/EditInvoice", method = RequestMethod.GET)
    public ModelAndView showEditInvoice(@RequestParam("roomID") int roomID, HttpSession session) {
        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager tm = new ThanachokManager();

        Room room = tm.findRoomById(roomID);

        List<Invoice> invoices = tm.getInvoicesByRoomID(roomID);

        ModelAndView mav = new ModelAndView("EditInvoice");
        mav.addObject("room", room);
        mav.addObject("invoices", invoices);
        return mav;
    }

    @RequestMapping(value = "/EditInvoiceFormFull", method = RequestMethod.GET)
    public ModelAndView showEditInvoiceFormFull(@RequestParam("invoiceId") int invoiceId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager tm = new ThanachokManager();

        Invoice invoice = tm.getInvoiceWithDetails(invoiceId);

        if (invoice == null) {
            redirectAttributes.addFlashAttribute("error", "ไม่พบใบแจ้งหนี้ที่ต้องการแก้ไข");
            return new ModelAndView("redirect:/OwnerHome");
        }

        ModelAndView mav = new ModelAndView("EditInvoiceFormFull");
        mav.addObject("invoice", invoice);

        // แยกข้อมูลจาก InvoiceDetails
        double roomPrice = 0;
        double internetPrice = 0;
        double penalty = 0;
        String penaltyRemark = "";
        int prevWater = 0;
        int currWater = 0;
        double waterRate = 18;
        int prevElectric = 0;
        int currElectric = 0;
        double electricRate = 7;

        int waterDetailId = 0;
        int electricDetailId = 0;
        int internetDetailId = 0;
        int penaltyDetailId = 0;
        int roomDetailId = 0;

        int roomID = invoice.getRent().getRoom().getRoomID();

        Invoice previousInvoice = tm.getInvoiceBeforeDate(roomID, invoice.getIssueDate());

        if (previousInvoice != null && previousInvoice.getDetails() != null) {
            for (InvoiceDetail detail : previousInvoice.getDetails()) {
                String typeName = detail.getType().getTypeName();

                if ("ค่าน้ำ".equals(typeName)) {
                    prevWater = detail.getQuantity();
                    waterRate = detail.getPrice();
                } else if ("ค่าไฟฟ้า".equals(typeName)) {
                    prevElectric = detail.getQuantity();
                    electricRate = detail.getPrice();
                }
            }
        }

        if (invoice.getDetails() != null) {
            for (InvoiceDetail detail : invoice.getDetails()) {
                String typeName = detail.getType().getTypeName();

                switch (typeName) {
                    case "ค่าห้อง":
                        roomPrice = detail.getPrice();
                        roomDetailId = detail.getId();
                        break;
                    case "ค่าอินเทอร์เน็ต":
                        internetPrice = detail.getPrice();
                        internetDetailId = detail.getId();
                        break;
                    case "ค่าปรับ":
                        penalty = detail.getAmount();
                        penaltyDetailId = detail.getId();
                        penaltyRemark = detail.getRemark() != null ? detail.getRemark() : "";
                        break;
                    case "ค่าน้ำ":
                        currWater = detail.getQuantity();
                        waterRate = detail.getPrice();
                        waterDetailId = detail.getId();
                        break;
                    case "ค่าไฟฟ้า":
                        currElectric = detail.getQuantity();
                        electricRate = detail.getPrice();
                        electricDetailId = detail.getId();
                        break;
                }
            }
        }

        mav.addObject("roomPrice", roomPrice);
        mav.addObject("internetPrice", internetPrice);
        mav.addObject("penalty", penalty);
        mav.addObject("penaltyRemark", penaltyRemark);
        mav.addObject("prevWater", prevWater);
        mav.addObject("currWater", currWater);
        mav.addObject("waterRate", waterRate);
        mav.addObject("prevElectric", prevElectric);
        mav.addObject("currElectric", currElectric);
        mav.addObject("electricRate", electricRate);

        mav.addObject("waterDetailId", waterDetailId);
        mav.addObject("electricDetailId", electricDetailId);
        mav.addObject("internetDetailId", internetDetailId);
        mav.addObject("penaltyDetailId", penaltyDetailId);
        mav.addObject("roomDetailId", roomDetailId);

        return mav;
    }
    

    // บันทึกการแก้ไขใบแจ้งหนี้
    @RequestMapping(value = "/UpdateInvoice", method = RequestMethod.POST)
    public ModelAndView updateInvoice(HttpServletRequest request, HttpSession session) {
        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return new ModelAndView("redirect:/Login");
        }

        try {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            int status = Integer.parseInt(request.getParameter("status"));

            ThanachokManager tm = new ThanachokManager();
            Invoice invoice = tm.getInvoiceById(invoiceId);

            if (invoice != null) {
                invoice.setStatus(status);
                tm.updateInvoice(invoice);

                ModelAndView mav = new ModelAndView("redirect:/EditInvoice");
                mav.addObject("roomID", invoice.getRent().getRoom().getRoomID());
                mav.addObject("message", "อัปเดตใบแจ้งหนี้เรียบร้อยแล้ว");
                return mav;
            } else {
                ModelAndView mav = new ModelAndView("EditInvoiceForm");
                mav.addObject("error", "ไม่พบใบแจ้งหนี้ที่ต้องการอัปเดต");
                return mav;
            }

        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mav = new ModelAndView("EditInvoiceForm");
            mav.addObject("error", "เกิดข้อผิดพลาดในการอัปเดตข้อมูล: " + e.getMessage());
            return mav;
        }
    }

    // ลบใบแจ้งหนี้
    @RequestMapping(value = "/DeleteInvoice", method = RequestMethod.GET)
    public String deleteInvoice(@RequestParam("invoiceId") int invoiceId,
            @RequestParam("roomID") int roomID,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return "redirect:/Login";
        }

        try {
            ThanachokManager tm = new ThanachokManager();
            // ตรวจสอบว่าใบแจ้งหนี้มีอยู่จริงและดึงข้อมูล
            Invoice invoice = tm.getInvoiceWithStatus(invoiceId);
            if (invoice == null) {
                redirectAttributes.addFlashAttribute("error",
                        "ไม่พบใบแจ้งหนี้ที่ต้องการลบ (ID: " + invoiceId + ")");
                return "redirect:/EditInvoice?roomID=" + roomID;
            }
            // ตรวจสอบสถานะการชำระ
            if (invoice.getStatus() == 1) {
                redirectAttributes.addFlashAttribute("error",
                        "ไม่สามารถลบใบแจ้งหนี้ INV-" + invoiceId + " ได้ เนื่องจากได้ชำระเงินแล้ว");
                return "redirect:/EditInvoice?roomID=" + roomID;
            }
            boolean deleted = tm.deleteInvoice(invoiceId);

            if (deleted) {
                redirectAttributes.addFlashAttribute("message",
                        "ลบใบแจ้งหนี้ INV-" + invoiceId + " เรียบร้อยแล้ว");
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "ไม่สามารถลบใบแจ้งหนี้ได้ กรุณาลองใหม่อีกครั้ง");
            }

        } catch (RuntimeException re) {
            redirectAttributes.addFlashAttribute("error", re.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error",
                    "เกิดข้อผิดพลาดในระบบ: " + e.getMessage());
        }

        return "redirect:/EditInvoice?roomID=" + roomID;
    }

    // บันทึกการแก้ไขบิลแบบเต็ม (แบบใหม่ - รองรับ dynamic items)
    @RequestMapping(value = "/UpdateInvoiceFull", method = RequestMethod.POST)
    public String updateInvoiceFull(HttpServletRequest request,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return "redirect:/Login";
        }

        try {
            // รับข้อมูลพื้นฐานจากฟอร์ม
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            int roomID = Integer.parseInt(request.getParameter("roomID"));
            String issueDateStr = request.getParameter("issueDate");
            String dueDateStr = request.getParameter("dueDate");
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
            int status = Integer.parseInt(request.getParameter("status"));

            // รับจำนวน items ที่ส่งมา
            String itemCountStr = request.getParameter("itemCount");
            int itemCount = (itemCountStr != null) ? Integer.parseInt(itemCountStr) : 0;

            ThanachokManager tm = new ThanachokManager();

            // ดึงข้อมูล Invoice เดิม
            Invoice invoice = tm.getInvoiceWithDetails(invoiceId);
            if (invoice == null) {
                redirectAttributes.addFlashAttribute("error", "ไม่พบใบแจ้งหนี้ที่ต้องการแก้ไข");
                return "redirect:/EditInvoice?roomID=" + roomID;
            }

            // เก็บ details เดิมไว้
            List<InvoiceDetail> oldDetails = new ArrayList<>(invoice.getDetails());

            // แปลงวันที่
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date issueDate = sdf.parse(issueDateStr);
            Date dueDate = sdf.parse(dueDateStr);

            // อัปเดตข้อมูล Invoice
            invoice.setIssueDate(issueDate);
            invoice.setDueDate(dueDate);
            invoice.setTotalAmount(totalPrice);
            invoice.setStatus(status);

            // แก้ไข InvoiceDetails เดิมโดยใช้ ID 
            List<InvoiceDetail> newDetails = new ArrayList<>();

            for (int i = 0; i < itemCount; i++) {
                String detailIdParam = "item_" + i + "_detailId";
                String typeParam = "item_" + i + "_type";
                String nameParam = "item_" + i + "_name";
                String amountParam = "item_" + i + "_amount";
                String priceParam = "item_" + i + "_rate";
                String currMeterParam = "item_" + i + "_currMeter";
                String remarkParam = "item_" + i + "_remark";

                String detailIdStr = request.getParameter(detailIdParam);
                String type = request.getParameter(typeParam);
                String name = request.getParameter(nameParam);
                String amountStr = request.getParameter(amountParam);
                String remark = request.getParameter(remarkParam);

                if (type == null || name == null || amountStr == null) {
                    continue;
                }

                double amount = Double.parseDouble(amountStr);

                if (amount <= 0 && !"room".equals(type)) {
                    continue;
                }

                // ค้นหา detail เดิมจาก ID (ถ้ามี) หรือสร้างใหม่
                InvoiceDetail detail = null;
                if (detailIdStr != null && !detailIdStr.isEmpty() && !detailIdStr.equals("0")) {
                    int detailId = Integer.parseInt(detailIdStr);
                    // ค้นหา detail เดิมจาก oldDetails
                    for (InvoiceDetail oldDetail : oldDetails) {
                        if (oldDetail.getId() == detailId) {
                            detail = oldDetail;
                            break;
                        }
                    }
                }

                // ถ้าไม่เจอ detail เดิม (รายการใหม่) → สร้างใหม่
                if (detail == null) {
                    detail = new InvoiceDetail();
                    detail.setInvoice(invoice);
                }
                detail.setAmount(amount);
                if ("water".equals(type) || "electricity".equals(type)) {
                    // น้ำหรือไฟ - มีข้อมูลมิเตอร์
                    String currMeterStr = request.getParameter(currMeterParam);
                    String rateStr = request.getParameter(priceParam);

                    if (currMeterStr != null && rateStr != null) {
                        int currMeter = Integer.parseInt(currMeterStr);
                        double rate = Double.parseDouble(rateStr);

                        detail.setType(tm.getInvoiceTypeByName(name));
                        detail.setPrice(rate);
                        detail.setQuantity(currMeter); 
                    } else {
                        continue;
                    }
                } else if ("room".equals(type)) {
                    // ค่าห้อง
                    detail.setType(tm.getInvoiceTypeByName("ค่าห้อง"));
                    detail.setPrice(amount);
                    detail.setQuantity(1);
                } else if ("other".equals(type)) {
                    // รายการอื่นๆ - ใช้ชื่อที่ส่งมา
                    InvoiceType otherType = tm.getInvoiceTypeByName(name);
                    if (otherType == null) {
                        // สร้าง type ใหม่ถ้ายังไม่มี
                        otherType = tm.getInvoiceTypeByName("อื่นๆ");
                    }
                    detail.setType(otherType);
                    detail.setPrice(amount);
                    detail.setQuantity(1);
                } else {
                    // internet, penalty
                    detail.setType(tm.getInvoiceTypeByName(name));
                    detail.setPrice(amount);
                    detail.setQuantity(1);
                }

                // บันทึกหมายเหตุสำหรับค่าปรับ 
                if ("penalty".equals(type)) {
                    if (remark != null && !remark.isEmpty()) {
                        detail.setRemark(remark);
                    } else {
                        detail.setRemark(null);
                    }
                }
                newDetails.add(detail);
            }

            // อัปเดต invoice details
            invoice.setDetails(newDetails);

            // บันทึกการแก้ไข
            boolean success = tm.updateInvoiceFull(invoice, oldDetails);

            if (success) {
                redirectAttributes.addFlashAttribute("message",
                        "แก้ไขบิล INV-" + invoice.getInvoiceId() + " เรียบร้อยแล้ว " +
                                "ยอดรวม ฿" + String.format("%,.2f", totalPrice));
                return "redirect:/EditInvoice?roomID=" + roomID;
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "ไม่สามารถแก้ไขบิลได้ กรุณาลองใหม่อีกครั้ง");
                return "redirect:/EditInvoiceFormFull?invoiceId=" + invoiceId;
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error",
                    "ข้อมูลที่กรอกไม่ถูกต้อง กรุณาตรวจสอบตัวเลขที่กรอก");
            String invoiceId = request.getParameter("invoiceId");
            return "redirect:/EditInvoiceFormFull?invoiceId=" + invoiceId;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error",
                    "เกิดข้อผิดพลาด: " + e.getMessage());
            String invoiceId = request.getParameter("invoiceId");
            return "redirect:/EditInvoiceFormFull?invoiceId=" + invoiceId;
        }
    }
}