package com.springmvc.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "reserve")
public class Reserve {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reserveId", unique = true)
    private int reserveId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "reserveDate")
    private Date reserveDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "checkInDate")
    private Date checkInDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "approvedDate")
    private Date approvedDate;

    @Column(name = "internetOption")
    private Boolean internetOption; // true = เอาอินเทอร์เน็ต, false = ไม่เอา

    @Column(name = "internetFee")
    private Integer internetFee; // ค่าอินเทอร์เน็ต (200 หรือ 0)

    @Column(name = "status", length = 45)
    private String status;

    @ManyToOne
    @JoinColumn(name = "room_roomID")
    private Room room;

    @ManyToOne
    @JoinColumn(name = "member_memberID")
    private Member member;

    // Default constructor
    public Reserve() {
    }

    public Reserve(int reserveId, Date reserveDate, Date checkInDate, String status, Room room, Member member) {
        this.reserveId = reserveId;
        this.reserveDate = reserveDate;
        this.checkInDate = checkInDate;
        this.status = status;
        this.room = room;
        this.member = member;
    }

    // Getter & Setter
    public int getReserveId() {
        return reserveId;
    }

    public void setReserveId(int reserveId) {
        this.reserveId = reserveId;
    }

    public Date getReserveDate() {
        return reserveDate;
    }

    public void setReserveDate(Date reserveDate) {
        this.reserveDate = reserveDate;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Date getApprovedDate() {
        return approvedDate;
    }

    public void setApprovedDate(Date approvedDate) {
        this.approvedDate = approvedDate;
    }

    public Boolean getInternetOption() {
        return internetOption;
    }

    public void setInternetOption(Boolean internetOption) {
        this.internetOption = internetOption;
    }

    public Integer getInternetFee() {
        return internetFee;
    }

    public void setInternetFee(Integer internetFee) {
        this.internetFee = internetFee;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }
}
