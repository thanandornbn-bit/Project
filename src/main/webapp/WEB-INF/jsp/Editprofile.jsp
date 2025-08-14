<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.model.Member" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    Member member = (Member) session.getAttribute("loginMember");
    if (member == null) {
        response.sendRedirect("Login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>แก้ไขข้อมูลส่วนตัว</title>
    
</head>
<body>
    <form name="formEditProfile" action="Editprofile" method="post">
        <h1>แก้ไขข้อมูลส่วนตัว</h1>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="<%= member.getEmail() %>" required readonly><br>

        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" value="<%= member.getFirstName() %>" required><br>

        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" value="<%= member.getLastName() %>" required><br>

        <label for="phoneNumber">Phone Number:</label>
        <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= member.getPhoneNumber() %>" required
               pattern="^0[0-9]{9}$" maxlength="10"><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="กรอกรหัสผ่านใหม่ถ้าต้องการเปลี่ยน"><br>

        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="ยืนยันรหัสผ่านใหม่"><br>

        <div class="error-message" style="color:red;">${edit_result}</div>

        <input type="submit" value="บันทึกการแก้ไข">
        <hr>
        <a href="Homesucess">กลับหน้าหลัก</a>
    </form>
</body>
</html>
