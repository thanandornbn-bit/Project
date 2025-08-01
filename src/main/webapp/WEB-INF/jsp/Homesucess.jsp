<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page session="true"%>
<%@ page import="com.springmvc.model.Member"%>
<%@ page import="java.util.*"%>
<%@ page import="com.springmvc.model.*"%>

<%
Member loginMember = (Member) session.getAttribute("loginMember");
if (loginMember == null) {
	response.sendRedirect("Login");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<script>
	function checkRoomStatus(roomStatus) {
		if (roomStatus !== "ว่าง") {
			alert("ห้องนี้มีคนจองแล้ว");
			return false; // ไม่ให้ไปที่หน้า roomDetail
		}
		return true; // หากห้องว่างให้ไปที่หน้า roomDetail
	}
</script>
</head>
<meta charset="UTF-8">
<title>ThanaChok Place</title>
<style>
table {
	width: 80%;
	border-collapse: collapse;
	margin: 20px auto;
}

th, td {
	padding: 10px;
	border: 1px solid #aaa;
	text-align: center;
}

.header {
	text-align: center;
	font-size: 24px;
	margin-top: 20px;
}

.welcome-message {
	text-align: center;
	font-size: 18px;
	margin-top: 10px;
}

.logout-btn {
	display: block;
	width: 100px;
	margin: 20px auto;
	padding: 10px;
	background-color: #f44336;
	color: white;
	border: none;
	cursor: pointer;
}

.logout-btn:hover {
	background-color: #d32f2f;
}
</style>
</head>
<body>
	<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
	</c:if>
	<div class="header">ThanaChok Place - รายการห้องพัก</div>

	<div class="welcome-message">
		Hello, ${loginMember.firstName} ${loginMember.lastName}! <br />
		<!-- แสดงชื่อสมาชิก -->
	</div>
	<div class="nav">
		<a href="Homesucess">หน้าหลัก</a> 
		<a href="Bill">แจ้งหนี้</a>
		<a href="Record">ดูประวัติการจอง</a>
	</div>

	<!-- ปุ่ม Logout -->
	<form action="Logout" method="post">
		<button type="submit" class="logout-btn">Logout</button>
	</form>

	<form method="get" action="Homesucess" style="text-align:center; margin-top: 20px;">
    ชั้น:
    <select name="floor">
        <option value="">ทั้งหมด</option>
        <c:forEach var="i" begin="1" end="9">
            <option value="${i}" ${param.floor == i ? 'selected' : ''}>ชั้น ${i}</option>
        </c:forEach>
    </select>

    สถานะ:
    <select name="status">
        <option value="">ทั้งหมด</option>
        <option value="ว่าง" ${param.status == 'ว่าง' ? 'selected' : ''}>ว่าง</option>
        <option value="ไม่ว่าง" ${param.status == 'ไม่ว่าง' ? 'selected' : ''}>ไม่ว่าง</option>
    </select>

    <button type="submit">ค้นหา</button>
</form>

	<table>
		<thead>
			<tr>
				<th>Room Number</th>
				<th>Room Type</th>
				<th>Price</th>
				<th>Status</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="room" items="${roomList}">
		<tr>
			<td>${room.roomNumber}</td>
			<td>${room.roomtype}</td>
			<td>${room.roomPrice}</td>
			<td>${room.roomStatus}</td>
			<td>
				<a href="roomDetail?id=${room.roomID}">
					<button class="view-btn" onclick="return checkRoomStatus('${room.roomStatus}')">View</button>
				</a>
			</td>
		</tr>
	</c:forEach>
		</tbody>
	</table>
</body>
</html>
