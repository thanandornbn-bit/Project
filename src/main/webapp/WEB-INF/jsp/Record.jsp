<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page session="true"%>
<%@ page import="com.springmvc.model.Member"%>
<%@ page import="java.util.*"%>
<%@ page import="com.springmvc.model.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>รายละเอียดการจอง</title>
</head>
<body>

	<div class="nav">
		<a href="Homesucess">หน้าหลัก</a> 
		<a href="Bill">แจ้งหนี้</a>
		<a href="Record">ดูประวัติการจอง</a>
	</div>
	
    <h2>รายละเอียดการจอง</h2>
    <table border="1">
        <thead>
            <tr>
                <th>หมายเลขห้อง</th>
                <th>ชื่อสมาชิก</th>
                <th>รายละเอียด</th>
                <th>จำนวนเงินที่ชำระ</th>
                <th>วันหมดอายุ</th>
                <th>สถานะ</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="rentalDeposit" items="${rentalDeposits}">
                <tr>
                    <td>${rentalDeposit.rent.room.roomNumber}</td>
                    <td>${rentalDeposit.rent.member.firstName} ${rentalDeposit.rent.member.lastName}</td>
                    <td>${rentalDeposit.rent.room.description}</td>
                    <td>${rentalDeposit.totalPrice}</td>
                    <td>${rentalDeposit.deadlineDate}</td>
                    <td>${rentalDeposit.status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
