package com.springmvc.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Invoice;
import com.springmvc.model.InvoiceDetail;
import com.springmvc.model.InvoiceType;
import com.springmvc.model.Member;
import com.springmvc.model.Rent;
import com.springmvc.model.ThanachokManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class InvoiceController {
	
	
	@RequestMapping(value = "/AddInvoice", method = RequestMethod.GET)
    public ModelAndView showAddInvoiceForm(@RequestParam("rentID") int rentID) {
        ThanachokManager manager = new ThanachokManager();
        Rent rent = manager.findRentById(rentID); // ดึงข้อมูล Rent จาก rentID
        List<InvoiceType> typeList = manager.getAllInvoiceTypes(); // ดึงประเภทของบิล

        ModelAndView mav = new ModelAndView("AddInvoice");
        mav.addObject("rent", rent); // ส่งข้อมูล Rent ไปยัง JSP
        mav.addObject("typeList", typeList); // ส่งรายการ InvoiceType ไปยัง JSP
        return mav;
    }

    // เมธอดบันทึกบิล
    @RequestMapping(value = "/SaveInvoice", method = RequestMethod.POST)
    public ModelAndView saveInvoice(HttpServletRequest request) {
        ThanachokManager manager = new ThanachokManager();

        try {
            int rentID = Integer.parseInt(request.getParameter("rentID"));
            String status = request.getParameter("status");
            Date billingDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("billingDate"));
            Date dueDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dueDate"));

            // ดึง Rent
            Rent rent = manager.findRentById(rentID);

            // บันทึก Invoice
            Invoice invoice = new Invoice();
            invoice.setBillingDate(billingDate);
            invoice.setDueDate(dueDate);
            invoice.setStatus(status);
            invoice.setRent(rent);

            // บิลหลักยังไม่รวมยอดรวม รอรวมจาก detail
            invoice.setTotalAmount(0.0);
            int billID = manager.saveInvoice(invoice);

            if (billID == -1) {
                return new ModelAndView("error").addObject("message", "ไม่สามารถบันทึกบิลหลักได้");
            }

            double total = 0.0;

            // ✅ อ่านข้อมูลบิลย่อยจากฟอร์ม
            String[] typeIDs = request.getParameterValues("typeID");
            String[] amounts = request.getParameterValues("amount");
            String[] units = request.getParameterValues("unit");

            for (int i = 0; i < typeIDs.length; i++) {
                int typeID = Integer.parseInt(typeIDs[i]);
                double amount = Double.parseDouble(amounts[i]);
                String unit = units[i];

                InvoiceType type = manager.findInvoiceTypeById(typeID);

                InvoiceDetail detail = new InvoiceDetail();
                detail.setAmount(amount);
                detail.setUnit(unit);
                detail.setInvoice(invoice); // ใส่ invoice ที่เพิ่งสร้าง
                detail.setBilltype(type);

                manager.saveInvoiceDetail(detail);
                total += amount;
            }

            // อัปเดตยอดรวมใน Invoice
            invoice.setTotalAmount(total);
            manager.updateInvoice(invoice);

            ModelAndView mav = new ModelAndView("redirect:/InvoiceSuccess");
            mav.addObject("message", "บันทึกบิลเรียบร้อยแล้ว");
            return mav;

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error").addObject("message", "เกิดข้อผิดพลาด: " + e.getMessage());
        }
    }
}


