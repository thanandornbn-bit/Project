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
	private String roomNumber;

	@Column(length = 255, nullable = false)
	private String roomPrice;

	@Column(length = 255, nullable = false)
	private String roomStatus;

	public Room() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Room(int roomID, String description, String roomtype, String roomNumber, String roomPrice, String roomStatus) {
		super();
		this.roomID = roomID;
		this.description = description;
		this.roomtype = roomtype;
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
