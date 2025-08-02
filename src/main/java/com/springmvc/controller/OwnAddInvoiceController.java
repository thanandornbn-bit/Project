package com.springmvc.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Invoice;
import com.springmvc.model.InvoiceDetail;
import com.springmvc.model.InvoiceType;
import com.springmvc.model.Manager;
import com.springmvc.model.Rent;
import com.springmvc.model.ThanachokManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class OwnAddInvoiceController {

    @RequestMapping(value = "/AddInvoice", method = RequestMethod.GET)
    public ModelAndView showAddInvoiceForm(@RequestParam("id") int rentID, HttpSession session) {
        Manager manager = (Manager) session.getAttribute("loginManager");
        if (manager == null) {
            return new ModelAndView("redirect:/Login");
        }

        ThanachokManager thanachokManager = new ThanachokManager();
        Rent rent = thanachokManager.findRentById(rentID);
        List<InvoiceType> billTypes = thanachokManager.getAllInvoiceTypes();

        ModelAndView mav = new ModelAndView("AddInvoice");
        mav.addObject("rent", rent);
        mav.addObject("billTypes", billTypes);
        return mav;
    }

    @RequestMapping(value = "/SaveInvoice", method = RequestMethod.POST)
    public String saveInvoice(HttpServletRequest request) {
        int rentID = Integer.parseInt(request.getParameter("rentID"));
        Date billingDate = Date.valueOf(request.getParameter("billingDate"));
        Date dueDate = Date.valueOf(request.getParameter("dueDate"));
        String status = request.getParameter("status");

        ThanachokManager manager = new ThanachokManager();
        Rent rent = manager.findRentById(rentID);

        Invoice invoice = new Invoice();
        invoice.setRent(rent);
        invoice.setBillingDate(billingDate);
        invoice.setDueDate(dueDate);
        invoice.setStatus(status);

        List<InvoiceDetail> details = new ArrayList<>();
        double totalAmount = 0.0;

        List<InvoiceType> billTypes = manager.getAllInvoiceTypes();
        for (InvoiceType type : billTypes) {
            String amountStr = request.getParameter("amount_" + type.getBilltypeID());
            if (amountStr != null && !amountStr.isEmpty()) {
                double amount = Double.parseDouble(amountStr);
                String unit = request.getParameter("unit_" + type.getBilltypeID());

                InvoiceDetail detail = new InvoiceDetail();
                detail.setInvoice(invoice);
                detail.setBilltype(type);
                detail.setAmount(amount);
                detail.setUnit(unit);

                details.add(detail);
                totalAmount += amount;
            }
        }

        invoice.setTotalAmount(totalAmount);
        manager.saveInvoiceWithDetails(invoice, details);

        return "redirect:/OwnerHome";
    }

}
