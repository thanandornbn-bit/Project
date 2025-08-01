<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.springmvc.model.*"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
	<form name="formregister" action="Register" method="post">
	<h1>สมัครสมาชิก</h1>

	<label for="email">Email:</label>
	<input type="email" id="email" name="email" required placeholder="example@gmail.com"><br>

	<label for="firstName">First Name:</label>
	<input type="text" id="firstName" name="firstName" required placeholder="ชื่อ"><br>

	<label for="lastName">Last Name:</label>
	<input type="text" id="lastName" name="lastName" required placeholder="นามสกุล"><br>

	<label for="phoneNumber">Phone Number:</label>
	<input type="tel" id="phoneNumber" name="phoneNumber" required
	       pattern="^0[0-9]{9}$" maxlength="10"
	       placeholder="หมายเลขโทรศัพท์"><br>

	<label for="password">Password:</label>
	<input type="password" id="password" name="password" required placeholder="รหัสผ่าน"><br>

	<label for="confirmPassword">Confirm Password:</label>
	<input type="password" id="confirmPassword" name="confirmPassword" required placeholder="ยืนยันรหัสผ่าน"><br>

	<div class="error-message" style="color:red;">${add_result}</div>

	<input type="submit" value="สมัครสมาชิก">
	<hr>
	<a href="Login">เข้าสู่ระบบ</a>
</form>

</body>
</html>