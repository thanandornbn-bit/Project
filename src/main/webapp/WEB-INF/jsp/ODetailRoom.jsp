<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.springmvc.model.*"%>
<%@ page import="src.main.webapp.image.*"%>

<%
    Member loginMember = (Member) session.getAttribute("loginMember");
    boolean isLoggedIn = (loginMember != null);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Room Detail</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #eee;
	margin: 0;
	padding: 0;
}

.container {
	width: 90%;
	margin: auto;
	background: white;
	padding: 20px;
	box-shadow: 0px 0px 10px #ccc;
}

.header {
	text-align: center;
	font-size: 28px;
	margin-bottom: 20px;
	color: #2c3e50;
}

.images {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-bottom: 20px;
}

.images img {
	width: 200px;
	height: 140px;
	object-fit: cover;
	border-radius: 4px;
}

.info {
	font-size: 16px;
	line-height: 1.8;
	margin-bottom: 20px;
	color: #333;
}

.info span {
	font-weight: bold;
}

.buttons {
	text-align: center;
}

.buttons button {
	padding: 10px 20px;
	margin: 0 10px;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.reserve-btn {
	background-color: #3498db;
	color: white;
}

.back-btn {
	background-color: #e74c3c;
	color: white;
}
</style>




<script>
	function handleReserve() {
		var isLoggedIn =
		<%=isLoggedIn%>;
		var roomStatus = document.getElementById("roomStatus").value;

		if (!isLoggedIn) {
			alert("กรุณาเข้าสู่ระบบก่อนทำการจองห้องพัก");
			window.location.href = "Login";
		} else if (roomStatus !== "ว่าง") {
			alert("ห้องนี้มีคนจองแล้ว");
		} else {
			window.location.href = "Payment?id=${room.roomID}";
		}
	}


	function updateWifiPrice() {
		var select = document.getElementById("Routerwifi");
		var priceDisplay = document.getElementById("wifiPrice");
		if (select.value === "เอา") {
			priceDisplay.innerText = "200 บาท/เดือน";
		} else {
			priceDisplay.innerText = "0 บาท/เดือน";
		}
	}

	// เรียกตอนโหลดหน้า เพื่อกำหนดค่าครั้งแรก
	window.onload = updateWifiPrice;
</script>





</head>
<body>
	<div class="container">
		<div class="header">Room Detail</div>

		<div class="images">
			
			<img src="${pageContext.request.contextPath}/image/tc1.jpg" alt="รูปภาพ">
			<img src="${pageContext.request.contextPath}/image/tc2.jpg" alt="รูปภาพ">
			<img src="${pageContext.request.contextPath}/image/tc3.jpg" alt="รูปภาพ">
			<img src="${pageContext.request.contextPath}/image/tc4.jpg" alt="รูปภาพ">
		</div>

		<div class="info">
			<p>
				<span>Room Number:</span> ${room.roomNumber}
			</p>
			<p>
				<span>ประเภทห้อง:</span> ${room.roomtype}
			</p>
			<p>
				<span>ราคา:</span> ${room.roomPrice} บาท/เดือน
			</p>
			<p>
				<span>สถานะ:</span> ${room.roomStatus}
			</p>
			<p>
				<span>รายละเอียดภายในห้อง:</span> ${room.description}
			</p>
			<p>
				<span>ค่าไฟ:</span> หน่วยละ 7 บาท
			</p>
			<p>
				<span>ค่า Router Wi-Fi:</span> <select id="Routerwifi"
					name="Routerwifi" onchange="updateWifiPrice()" required>
					<option value="เอา">เอา</option>
					<option value="ไม่เอา">ไม่เอา</option>
				</select> <span id="wifiPrice">200 บาท/เดือน</span>
			</p>
			<p>
				<span><font color="red">** หมายเหตุ:</font></span> ค่า Router Wi-Fi
				สามารถเลือกเอาหรือไม่เอาได้
			</p>
		</div>
		<input type="hidden" id="roomStatus" value="${room.roomStatus}" />

		<div class="buttons">
			<button class="reserve-btn" onclick="handleReserve()">Reserve</button>
			<button class="back-btn" onclick="history.back()">Back</button>

		</div>

	</div>
</body>
</html>
