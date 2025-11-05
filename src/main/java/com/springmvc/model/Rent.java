package com.springmvc.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "rent")
public class Rent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "rentID", unique = true)
    private int rentID;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "rentDate")
    private Date rentDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "returnDate")
    private Date returnDate;

    @Column(name = "status", length = 255)
    private String status;

    @Column(name = "paymentSlipImage", length = 255)
    private String paymentSlipImage;

    @Column(name = "totalPrice", length = 255)
    private String totalPrice;

    @Column(name = "transferAccountName", length = 255)
    private String transferAccountName;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "deadline")
    private Date deadline;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;

    @ManyToOne
    @JoinColumn(name = "memberID")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "roomID")
    private Room room;

    public Rent() {
    }

    public Rent(int rentID, Date rentDate, Date returnDate, String status, String paymentSlipImage, String totalPrice,
            String transferAccountName, Date deadline, Member member, Room room) {
        this.rentID = rentID;
        this.rentDate = rentDate;
        this.returnDate = returnDate;
        this.status = status;
        this.paymentSlipImage = paymentSlipImage;
        this.totalPrice = totalPrice;
        this.transferAccountName = transferAccountName;
        this.deadline = deadline;
        this.member = member;
        this.room = room;
    }

    public int getRentID() {
        return rentID;
    }

    public void setRentID(int rentID) {
        this.rentID = rentID;
    }

    public Date getRentDate() {
        return rentDate;
    }

    public void setRentDate(Date rentDate) {
        this.rentDate = rentDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentSlipImage() {
        return paymentSlipImage;
    }

    public void setPaymentSlipImage(String paymentSlipImage) {
        this.paymentSlipImage = paymentSlipImage;
    }

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getTransferAccountName() {
        return transferAccountName;
    }

    public void setTransferAccountName(String transferAccountName) {
        this.transferAccountName = transferAccountName;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
