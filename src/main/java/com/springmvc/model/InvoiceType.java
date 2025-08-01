package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity @Table(name = "invoicetype")
public class InvoiceType {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int billtypeID;

    @Column(nullable = false, length = 100)
    private String billname;        // Room, Water, Electricity, Internet, Fine

    @Column
    private Double defaultPrice;    // ใส่ได้ถ้าราคาคงที่

	public InvoiceType() {
		super();
		// TODO Auto-generated constructor stub
	}

	public InvoiceType(int billtypeID, String billname, Double defaultPrice) {
		super();
		this.billtypeID = billtypeID;
		this.billname = billname;
		this.defaultPrice = defaultPrice;
	}

	public int getBilltypeID() {
		return billtypeID;
	}

	public void setBilltypeID(int billtypeID) {
		this.billtypeID = billtypeID;
	}

	public String getBillname() {
		return billname;
	}

	public void setBillname(String billname) {
		this.billname = billname;
	}

	public Double getDefaultPrice() {
		return defaultPrice;
	}

	public void setDefaultPrice(Double defaultPrice) {
		this.defaultPrice = defaultPrice;
	}
    
    
}

