package com.springmvc.model;

import com.springmvc.controller.PasswordUtil;

// หรือ package ที่คุณใช้กับ PasswordUtil

public class EncodePassword {
	public static void main(String[] args) throws Exception {
		// ใส่รหัสผ่านที่คุณต้องการเข้ารหัส
		String plainPassword = "123";

		// เข้ารหัสด้วย PasswordUtil
		String encoded = PasswordUtil.getInstance().createPassword(plainPassword, "Project");

		// แสดงผลลัพธ์
		System.out.println("Encoded Password: " + encoded);
	}
}
