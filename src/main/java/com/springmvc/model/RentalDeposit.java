package com.springmvc.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import java.util.Date;

@Entity
public class RentalDeposit {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int depositID;

	@OneToOne
	@JoinColumn(name = "rentID")
	private Rent rent;

	private String transferAccountName;

	@Temporal(TemporalType.DATE)
	private Date paymentDate;

	@Temporal(TemporalType.DATE)
	private Date deadlineDate;

	private String paymentSlipImage;

	private String status;

	private String totalPrice;

	@Transient
	private boolean hasUnpaidInvoices = false;

	public RentalDeposit() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RentalDeposit(int depositID, Rent rent, String transferAccountName, Date paymentDate, Date deadlineDate,
			String paymentSlipImage, String status, String totalPrice) {
		super();
		this.depositID = depositID;
		this.rent = rent;
		this.transferAccountName = transferAccountName;
		this.paymentDate = paymentDate;
		this.deadlineDate = deadlineDate;
		this.paymentSlipImage = paymentSlipImage;
		this.status = status;
		this.totalPrice = totalPrice;
	}

	public int getDepositID() {
		return depositID;
	}

	public void setDepositID(int depositID) {
		this.depositID = depositID;
	}

	public Rent getRent() {
		return rent;
	}

	public void setRent(Rent rent) {
		this.rent = rent;
	}

	public String getTransferAccountName() {
		return transferAccountName;
	}

	public void setTransferAccountName(String transferAccountName) {
		this.transferAccountName = transferAccountName;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	public Date getDeadlineDate() {
		return deadlineDate;
	}

	public void setDeadlineDate(Date deadlineDate) {
		this.deadlineDate = deadlineDate;
	}

	public String getPaymentSlipImage() {
		return paymentSlipImage;
	}

	public void setPaymentSlipImage(String paymentSlipImage) {
		this.paymentSlipImage = paymentSlipImage;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}

	public boolean isHasUnpaidInvoices() {
		return hasUnpaidInvoices;
	}

	public void setHasUnpaidInvoices(boolean hasUnpaidInvoices) {
		this.hasUnpaidInvoices = hasUnpaidInvoices;
	}
	
	public boolean getHasUnpaidInvoices() {
		return hasUnpaidInvoices;
	}

	// ตรวจสอบว่าคืนห้องแล้วหรือยัง
	public boolean isReturned() {
		return "คืนห้องแล้ว".equals(status);
	}

	@Override
	public String toString() {
		return "RentalDeposit [depositID=" + depositID + ", transferAccountName=" + transferAccountName
				+ ", paymentDate=" + paymentDate + ", deadlineDate=" + deadlineDate + ", paymentSlipImage="
				+ paymentSlipImage + ", status=" + status + ", totalPrice=" + totalPrice + ", hasUnpaidInvoices="
				+ hasUnpaidInvoices + "]";
	}
}