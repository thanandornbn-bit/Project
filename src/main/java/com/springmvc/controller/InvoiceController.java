package com.springmvc.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Invoice;
import com.springmvc.model.InvoiceDetail;
import com.springmvc.model.InvoiceType;
import com.springmvc.model.Rent;
import com.springmvc.model.Room;
import com.springmvc.model.ThanachokManager;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class InvoiceController {

    ThanachokManager manager = new ThanachokManager();

    // ===== แสดงหน้าสร้าง Invoice =====
    @RequestMapping(value = "/ManagerAddInvoice", method = RequestMethod.GET)
    public ModelAndView showAddInvoice(@RequestParam("roomID") int roomID) {
        ModelAndView mv = new ModelAndView("ManagerAddInvoice");

        Room room = manager.findRoomById(roomID);
        mv.addObject("selectedRoomID", roomID);
        mv.addObject("selectedRoomPrice", room.getRoomPrice());

        List<Rent> rents = manager.getAllRents();
        mv.addObject("rents", rents);

        mv.addObject("today", LocalDate.now().toString());
        mv.addObject("dueDate", LocalDate.now().plusDays(7).toString());

        return mv;
    }

    // ===== บันทึก Invoice =====
    @RequestMapping(value = "/SaveInvoice", method = RequestMethod.POST)
    public ModelAndView saveInvoice(HttpServletRequest request) {
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            LocalDate issueDate = LocalDate.parse(request.getParameter("issueDate"));
            LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
            BigDecimal totalPrice = new BigDecimal(request.getParameter("totalPrice"));
            int status = Integer.parseInt(request.getParameter("statusId"));

            Rent rent = manager.findRentById(roomId);

            // ===== สร้าง Invoice =====
            Invoice invoice = new Invoice();
            invoice.setIssueDate(issueDate);
            invoice.setDueDate(dueDate);
            invoice.setTotalAmount(totalPrice);
            invoice.setStatus(status);
            invoice.setRent(rent);

            // ===== ค่าห้อง =====
            invoice.getDetails().add(createSimpleDetail(invoice, "ค่าห้อง", request.getParameter("roomPrice")));

            // ===== ค่าเน็ต =====
            invoice.getDetails().add(createSimpleDetail(invoice, "ค่าเน็ต", request.getParameter("internetPrice")));

            // ===== ค่าน้ำ =====
            int prevWater = Integer.parseInt(request.getParameter("prevWater"));
            int currWater = Integer.parseInt(request.getParameter("currWater"));
            BigDecimal waterRate = new BigDecimal(request.getParameter("waterRate"));
            invoice.getDetails().add(createUnitDetail(invoice, "ค่าน้ำ", prevWater, currWater, waterRate));

            // ===== ค่าไฟ =====
            int prevElectric = Integer.parseInt(request.getParameter("prevElectric"));
            int currElectric = Integer.parseInt(request.getParameter("currElectric"));
            BigDecimal electricRate = new BigDecimal(request.getParameter("electricRate"));
            invoice.getDetails().add(createUnitDetail(invoice, "ค่าไฟ", prevElectric, currElectric, electricRate));

            // ===== ค่าปรับ =====
            if (request.getParameter("penalty") != null && !request.getParameter("penalty").isEmpty()) {
                invoice.getDetails().add(createSimpleDetail(invoice, "ค่าปรับ", request.getParameter("penalty")));
            }

            // ===== บันทึก Invoice และรายละเอียด =====
            manager.saveInvoice(invoice);

            return new ModelAndView("redirect:/OwnerHome");

        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("ManagerAddInvoice");
            mv.addObject("error", "เกิดข้อผิดพลาด: " + e.getMessage());
            return mv;
        }
    }

    // ===== สร้าง InvoiceDetail  =====
    private InvoiceDetail createSimpleDetail(Invoice invoice, String typeName, String amountStr) {
        InvoiceType type = manager.getInvoiceTypeByName(typeName);
        BigDecimal amount = new BigDecimal(amountStr);

        InvoiceDetail detail = new InvoiceDetail();
        detail.setInvoice(invoice);
        detail.setType(type);
        detail.setQuantity(1);
        detail.setPrice(amount);  
        detail.setAmount(amount);

        return detail;
    }

    // ===== สร้าง InvoiceDetail สำหรับฟิลด์ค่าน้ำ/ค่าไฟแบบคิดตามหน่วย =====
    private InvoiceDetail createUnitDetail(Invoice invoice, String typeName, int prevUnit, int currUnit, BigDecimal unitPrice) {
        InvoiceType type = manager.getInvoiceTypeByName(typeName);

        int quantity = currUnit - prevUnit;
        if (quantity < 0) quantity = 0;

        BigDecimal amount = unitPrice.multiply(BigDecimal.valueOf(quantity));

        InvoiceDetail detail = new InvoiceDetail();
        detail.setInvoice(invoice);
        detail.setType(type);
        detail.setQuantity(quantity);
        detail.setPrice(unitPrice); 
        detail.setAmount(amount);   

        return detail;
    }
}
