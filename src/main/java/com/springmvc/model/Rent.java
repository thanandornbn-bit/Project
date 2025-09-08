package com.springmvc.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import java.util.Date;

@Entity
public class Rent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int rentID;

    @ManyToOne
    @JoinColumn(name = "memberID")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "roomID")
    private Room room;

    @Temporal(TemporalType.DATE)
    private Date rentDate;

    @OneToOne(mappedBy = "rent", cascade = CascadeType.ALL)
    private RentalDeposit rentalDeposit;

    @OneToMany(mappedBy = "rent", cascade = CascadeType.ALL)
    private java.util.List<Invoice> invoices;

    public Rent() {
        super();
    }

    public Rent(int rentID, Member member, Room room, Date rentDate, RentalDeposit rentalDeposit) {
        super();
        this.rentID = rentID;
        this.member = member;
        this.room = room;
        this.rentDate = rentDate;
        this.rentalDeposit = rentalDeposit;
    }

    public int getRentID() {
        return rentID;
    }

    public void setRentID(int rentID) {
        this.rentID = rentID;
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

    public Date getRentDate() {
        return rentDate;
    }

    public void setRentDate(Date rentDate) {
        this.rentDate = rentDate;
    }

    public RentalDeposit getRentalDeposit() {
        return rentalDeposit;
    }

    public void setRentalDeposit(RentalDeposit rentalDeposit) {
        this.rentalDeposit = rentalDeposit;
    }

    public java.util.List<Invoice> getInvoices() {
        return invoices;
    }

    public void setInvoices(java.util.List<Invoice> invoices) {
        this.invoices = invoices;
    }

    // ตรวจสอบว่าคืนห้องแล้วหรือยังจาก RentalDeposit status
    public boolean isReturned() {
        return rentalDeposit != null && "คืนห้องแล้ว".equals(rentalDeposit.getStatus());
    }

    @Override
    public String toString() {
        return "Rent [rentID=" + rentID + ", rentDate=" + rentDate + 
               ", member=" + (member != null ? member.getFirstName() + " " + member.getLastName() : "null") +
               ", room=" + (room != null ? room.getRoomNumber() : "null") + 
               ", returned=" + isReturned() + "]";
    }
}