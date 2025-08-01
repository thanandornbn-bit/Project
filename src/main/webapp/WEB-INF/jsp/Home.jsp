<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThanaChok Place - Home</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
}

.header {
	background-color: #2c3e50;
	color: white;
	text-align: center;
	padding: 20px;
	font-size: 28px;
}

.nav {
	text-align: center;
	margin-top: 15px;
}

.nav a {
	margin: 0 15px;
	font-size: 18px;
	text-decoration: none;
	color: #2980b9;
}

.login-register {
	text-align: center;
	margin: 20px 0;
}

.login-register a {
	margin: 0 10px;
	font-size: 18px;
	text-decoration: none;
	color: #27ae60;
}

table {
	width: 90%;
	margin: 20px auto;
	border-collapse: collapse;
	background-color: white;
}

th, td {
	padding: 10px;
	border: 1px solid #ccc;
	text-align: center;
}

th {
	background-color: #34495e;
	color: white;
}

.view-btn {
	padding: 5px 10px;
	background-color: #3498db;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.view-btn:hover {
	background-color: #1abc9c;
}
</style>
</head>
<body>
	<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
	</c:if>

	<div class="header">ThanaChok Place</div>

	<div class="login-register">
		<a href="Login">เข้าสู่ระบบ</a> | <a href="Register">สมัครสมาชิก</a>
	</div>

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
