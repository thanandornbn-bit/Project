package com.springmvc.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "invoice")
public class Invoice {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int billID;

    @Temporal(TemporalType.DATE)
    private Date billingDate;

    @Temporal(TemporalType.DATE)
    private Date dueDate;

    @Column(length = 20, nullable = false)
    private String status;          // pending / paid / overdue

    @Column(nullable = false)
    private double totalAmount;     // ราคารวม

    @ManyToOne @JoinColumn(name = "rent_rentID", nullable = false)
    private Rent rent;

	public Invoice() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Invoice(int billID, Date billingDate, Date dueDate, String status, double totalAmount, Rent rent) {
		super();
		this.billID = billID;
		this.billingDate = billingDate;
		this.dueDate = dueDate;
		this.status = status;
		this.totalAmount = totalAmount;
		this.rent = rent;
	}

	public int getBillID() {
		return billID;
	}

	public void setBillID(int billID) {
		this.billID = billID;
	}

	public Date getBillingDate() {
		return billingDate;
	}

	public void setBillingDate(Date billingDate) {
		this.billingDate = billingDate;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Rent getRent() {
		return rent;
	}

	public void setRent(Rent rent) {
		this.rent = rent;
	}
    
    
}

