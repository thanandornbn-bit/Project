package com.springmvc.model;

import javax.persistence.*;

@Entity
@Table(name = "room")
public class Room {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "roomID", unique = true)
	private int roomID;

	@Column(name = "description", length = 255)
	private String description;

	@Column(name = "roomNumber", length = 255)
	private String roomNumber;

	@Column(name = "roomPrice", length = 255)
	private String roomPrice;

	@Column(name = "roomStatus", length = 255)
	private String roomStatus;

	@Column(name = "roomtype", length = 255)
	private String roomtype;

	@Column(name = "roomDeposit", length = 255)
	private String roomDeposit;

	@Column(name = "roomNumberImage", length = 255)
	private String roomNumberImage;

	@Column(name = "roomImage1", length = 255)
	private String roomImage1;

	@Column(name = "roomImage2", length = 255)
	private String roomImage2;

	@Column(name = "roomImage3", length = 255)
	private String roomImage3;

	@Column(name = "roomImage4", length = 255)
	private String roomImage4;

	// Default constructor
	public Room() {
	}

	public Room(int roomID, String description, String roomNumber, String roomPrice, String roomStatus,
			String roomtype) {
		this.roomID = roomID;
		this.description = description;
		this.roomNumber = roomNumber;
		this.roomPrice = roomPrice;
		this.roomStatus = roomStatus;
		this.roomtype = roomtype;
	}

	// Getter & Setter
	public int getRoomID() {
		return roomID;
	}

	public void setRoomID(int roomID) {
		this.roomID = roomID;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRoomNumber() {
		return roomNumber;
	}

	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}

	public String getRoomPrice() {
		return roomPrice;
	}

	public void setRoomPrice(String roomPrice) {
		this.roomPrice = roomPrice;
	}

	public String getRoomStatus() {
		return roomStatus;
	}

	public void setRoomStatus(String roomStatus) {
		this.roomStatus = roomStatus;
	}

	public String getRoomtype() {
		return roomtype;
	}

	public void setRoomtype(String roomtype) {
		this.roomtype = roomtype;
	}

	public String getRoomDeposit() {
		return roomDeposit;
	}

	public void setRoomDeposit(String roomDeposit) {
		this.roomDeposit = roomDeposit;
	}

	public String getRoomNumberImage() {
		return roomNumberImage;
	}

	public void setRoomNumberImage(String roomNumberImage) {
		this.roomNumberImage = roomNumberImage;
	}

	public String getRoomImage1() {
		return roomImage1;
	}

	public void setRoomImage1(String roomImage1) {
		this.roomImage1 = roomImage1;
	}

	public String getRoomImage2() {
		return roomImage2;
	}

	public void setRoomImage2(String roomImage2) {
		this.roomImage2 = roomImage2;
	}

	public String getRoomImage3() {
		return roomImage3;
	}

	public void setRoomImage3(String roomImage3) {
		this.roomImage3 = roomImage3;
	}

	public String getRoomImage4() {
		return roomImage4;
	}

	public void setRoomImage4(String roomImage4) {
		this.roomImage4 = roomImage4;
	}
}
