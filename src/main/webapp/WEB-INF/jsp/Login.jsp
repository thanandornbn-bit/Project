<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.springmvc.model.*"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>เข้าสู่ระบบ</title>
    <style>
        .hidden {
            display: none;
        }
    </style>
    <script>
        function showLogin(role) {
            document.getElementById("loginForm").classList.remove("hidden");
            document.getElementById("roleInput").value = role;
            document.getElementById("loginTitle").innerText = "เข้าสู่ระบบ " + (role === 'Manager' ? "Manager" : "Member");
        }
    </script>
</head>
<body>

<h2>เลือกประเภทผู้ใช้งาน</h2>
<button onclick="showLogin('Member')">Member</button>
<button onclick="showLogin('Manager')">Manager</button>

<!-- ฟอร์ม Login -->
<div id="loginForm" class="hidden">
    <h3 id="loginTitle">เข้าสู่ระบบ</h3>

    <!-- แสดงข้อความ error ถ้ามี -->
    <c:if test="${not empty error_message}">
        <p style="color:red;">${error_message}</p>
    </c:if>

    <!-- แสดงข้อความ success ถ้ามี -->
    <c:if test="${not empty success_message}">
        <p style="color:green;">${success_message}</p>
    </c:if>

    <form action="Login" method="post">
        <input type="hidden" id="roleInput" name="role" value="">

        <label for="email">อีเมล:</label><br>
        <input type="email" id="email" name="email" required><br><br>

        <label for="password">รหัสผ่าน:</label><br>
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="เข้าสู่ระบบ">
    </form>
</div>

</body>
</html>