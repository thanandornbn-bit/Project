package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "manager")
public class Manager {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer managerID;
	@Column(name = "email", length = 255, nullable = false)
	private String email;
	@Column(name = "password", length = 255, nullable = false)
	private String password;

	public Manager() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Manager(Integer managerID, String email, String password) {
		super();
		this.managerID = managerID;
		this.email = email;
		this.password = password;
	}

	public Integer getManagerID() {
		return managerID;
	}

	public void setManagerID(Integer managerID) {
		this.managerID = managerID;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	// Optional: ความสัมพันธ์ในอนาคต เช่น อนุมัติ invoice ฯลฯ
}