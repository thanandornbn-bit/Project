package com.springmvc.model;

import javax.persistence.*;

@Entity
@Table(name = "member")
public class Member {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "memberID", unique = true)
	private int memberID;

	@Column(name = "email", length = 255)
	private String email;

	@Column(name = "firstName", length = 255)
	private String firstName;

	@Column(name = "lastName", length = 255)
	private String lastName;

	@Column(name = "password", length = 255)
	private String password;

	@Column(name = "phoneNumber", length = 255)
	private String phoneNumber;

	// Default constructor
	public Member() {
	}

	// Getter & Setter
	public int getMemberID() {
		return memberID;
	}

	public void setMemberID(int memberID) {
		this.memberID = memberID;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Member(int memberID, String email, String firstName, String lastName, String password, String phoneNumber) {
		this.memberID = memberID;
		this.email = email;
		this.firstName = firstName;
		this.lastName = lastName;
		this.password = password;
		this.phoneNumber = phoneNumber;
	}

}
