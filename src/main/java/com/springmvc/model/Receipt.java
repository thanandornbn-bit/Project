package com.springmvc.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "receipt")
public class Receipt {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int receiptID;

	@OneToOne
	@JoinColumn(name = "invoicedetail_invoiceDetailID", nullable = false)
	private InvoiceDetail invoiceDetail;

	public Receipt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Receipt(int receiptID, InvoiceDetail invoiceDetail) {
		super();
		this.receiptID = receiptID;
		this.invoiceDetail = invoiceDetail;
	}

	public int getReceiptID() {
		return receiptID;
	}

	public void setReceiptID(int receiptID) {
		this.receiptID = receiptID;
	}

	public InvoiceDetail getInvoiceDetail() {
		return invoiceDetail;
	}

	public void setInvoiceDetail(InvoiceDetail invoiceDetail) {
		this.invoiceDetail = invoiceDetail;
	}

	

}
