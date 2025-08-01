package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "room")
public class Room {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int roomID;

	@Column(length = 255, nullable = false)
	private String description;

	@Column(length = 255, nullable = false)
	private String roomtype;

	@Column(length = 255, nullable = false)
	private String image1;

	@Column(length = 255, nullable = false)
	private String image2;

	@Column(length = 255, nullable = false)
	private String image3;

	@Column(length = 255, nullable = false)
	private String image4;

	@Column(length = 255, nullable = false)
	private String roomNumber;

	@Column(length = 255, nullable = false)
	private String roomPrice;

	@Column(length = 255, nullable = false)
	private String roomStatus;

	public Room() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Room(int roomID, String description, String roomtype, String image1, String image2, String image3,
			String image4, String roomNumber, String roomPrice, String roomStatus) {
		super();
		this.roomID = roomID;
		this.description = description;
		this.roomtype = roomtype;
		this.image1 = image1;
		this.image2 = image2;
		this.image3 = image3;
		this.image4 = image4;
		this.roomNumber = roomNumber;
		this.roomPrice = roomPrice;
		this.roomStatus = roomStatus;
	}

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

	public String getRoomtype() {
		return roomtype;
	}

	public void setRoomtype(String roomtype) {
		this.roomtype = roomtype;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public String getImage4() {
		return image4;
	}

	public void setImage4(String image4) {
		this.image4 = image4;
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

}
