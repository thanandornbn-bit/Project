package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "invoice_detail")
public class InvoiceDetail {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int invoDetailID;

    @Column(nullable = false)
    private double amount;          // ยอด (บาท)

    @Column(length = 100)
    private String unit;            // “0 – 53 = 53 หน่วย” (ใส่ได้/ไม่ใส่ก็ได้)

    @ManyToOne @JoinColumn(name = "bill_billID")
    private Invoice invoice;

    @ManyToOne @JoinColumn(name = "billtype_BilltypeID")
    private InvoiceType billtype;

	public InvoiceDetail() {
		super();
		// TODO Auto-generated constructor stub
	}

	public InvoiceDetail(int invoDetailID, double amount, String unit, Invoice invoice, InvoiceType billtype) {
		super();
		this.invoDetailID = invoDetailID;
		this.amount = amount;
		this.unit = unit;
		this.invoice = invoice;
		this.billtype = billtype;
	}

	public int getInvoDetailID() {
		return invoDetailID;
	}

	public void setInvoDetailID(int invoDetailID) {
		this.invoDetailID = invoDetailID;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Invoice getInvoice() {
		return invoice;
	}

	public void setInvoice(Invoice invoice) {
		this.invoice = invoice;
	}

	public InvoiceType getBilltype() {
		return billtype;
	}

	public void setBilltype(InvoiceType billtype) {
		this.billtype = billtype;
	}
    
    
}

