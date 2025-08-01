<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.springmvc.model.*"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Room</title>
</head>
<body>
    <h1>เพิ่มห้องพัก</h1>
    <!-- เปลี่ยน method เป็น POST แทน GET -->
    <form action="AddRoom" method="post" enctype="multipart/form-data">
    <label>เลขห้อง:</label>
    <input type="text" name="roomNumber" required><br><br>

	<label>ประเภทห้อง:</label>
	<select name="roomtype" required>
    <option value="แอร์">แอร์</option>
	</select><br>

    <label>คำอธิบาย:</label>
    <input type="text" name="description" required><br><br>

    <label>เลือกรูปภาพ (สูงสุด 4 รูป):</label>
    <input type="file" name="images" accept="image/*" multiple required><br><br>

    <label>ราคาห้อง:</label>
    <input type="text" name="roomPrice" required><br><br>

    <label>สถานะ:</label>
    <select name="roomStatus" required>
        <option value="ว่าง">ว่าง</option>
        <option value="ไม่ว่าง">ไม่ว่าง</option>
    </select><br><br>

    <input type="submit" value="บันทึกห้อง">
    <input type="button" value="ย้อนกลับ" onclick="window.location.href='OwnerHome';">


</form>

    <c:if test="${not empty message}">
        <p style="color: green">${message}</p>
    </c:if>
</body>
</html>
