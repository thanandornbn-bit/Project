<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
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
    <meta charset="UTF-8">
    <title>ประวัติการจอง - ThanaChok Place</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        
        .header {
            background-color: #2c5aa0;
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        
        .nav {
            background-color: #34495e;
            overflow: hidden;
        }
        
        .nav a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        
        .nav a:hover {
            background-color: #2c3e50;
        }
        
        .nav a.active {
            background-color: #3498db;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .welcome-message {
            background-color: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .record-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .record-table th {
            background-color: #3498db;
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: bold;
        }
        
        .record-table td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        
        .record-table tr:hover {
            background-color: #f8f9fa;
        }
        
        .status-complete {
            background-color: #27ae60;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .status-pending {
            background-color: #f39c12;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .status-waiting {
            background-color: #e74c3c;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            transition: background-color 0.3s;
            margin: 2px;
        }
        
        .btn-return {
            background-color: #e74c3c;
            color: white;
        }
        
        .btn-return:hover {
            background-color: #c0392b;
        }
        
        .btn-disabled {
            background-color: #bdc3c7;
            color: #7f8c8d;
            cursor: not-allowed;
        }
        
        .no-record {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
            font-size: 16px;
        }
        
        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background-color: #95a5a6;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        
        .back-btn:hover {
            background-color: #7f8c8d;
        }
        
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
    </style>
</head>

<body>
    <div class="header">
        ThanaChok Place - ประวัติการจอง
    </div>
    
    <div class="nav">
        <a href="Homesucess">หน้าหลัก</a>
        <a href="MemberListinvoice">แจ้งหนี้</a>
        <a href="Record" class="active">ดูประวัติการจอง</a>
    </div>
    
    <div class="container">
        <a href="Homesucess" class="back-btn">← กลับหน้าหลัก</a>
        
        <div class="welcome-message">
            <h3>สวัสดี, ${loginMember.firstName} ${loginMember.lastName}</h3>
            <p>ประวัติการจองห้องพักของคุณ</p>
        </div>
        
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty warning}">
            <div class="alert alert-warning">${warning}</div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty rentalDeposits}">
                <div class="no-record">
                    <h3>ไม่มีประวัติการจอง</h3>
                    <p>คุณยังไม่เคยจองห้องพักกับเรา</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="record-table">
                    <thead>
                        <tr>
                            <th>หมายเลขห้อง</th>
                            <th>ชื่อสมาชิก</th>
                            <th>รายละเอียด</th>
                            <th>จำนวนเงินที่ชำระ</th>
                            <th>วันหมดอายุ</th>
                            <th>สถานะ</th>
                            <th>การดำเนินการ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="rentalDeposit" items="${rentalDeposits}">
                            <tr>
                                <td>${rentalDeposit.rent.room.roomNumber}</td>
                                <td>${rentalDeposit.rent.member.firstName} ${rentalDeposit.rent.member.lastName}</td>
                                <td>${rentalDeposit.rent.room.description}</td>
                                <td>
                                    <fmt:formatNumber value="${rentalDeposit.totalPrice}" type="currency" 
                                                    currencySymbol="฿" groupingUsed="true"/>
                                </td>
                                <td>
                                    <fmt:formatDate value="${rentalDeposit.deadlineDate}" pattern="dd/MM/yyyy"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${rentalDeposit.status == 'เสร็จสมบูรณ์'}">
                                            <span class="status-complete">เสร็จสมบูรณ์</span>
                                        </c:when>
                                        <c:when test="${rentalDeposit.status == 'รอการอนุมัติ'}">
                                            <span class="status-pending">รอการอนุมัติ</span>
                                        </c:when>
                                        <c:when test="${rentalDeposit.status == 'คืนห้องแล้ว'}">
                                            <span class="status-complete">คืนห้องแล้ว</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-waiting">รอดำเนินการ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${rentalDeposit.status == 'เสร็จสมบูรณ์'}">
                                            <!-- ตรวจสอบสถานะบิลก่อนแสดงปุ่มคืนห้อง -->
                                            <c:choose>
                                                <c:when test="${rentalDeposit.hasUnpaidInvoices}">
                                                    <button class="btn btn-disabled" 
                                                            title="ไม่สามารถคืนห้องได้ เนื่องจากมีค่าใช้จ่ายค้างชำระ">
                                                        คืนห้อง (ไม่พร้อมใช้)
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-return" 
                                                            onclick="confirmReturnRoom(${rentalDeposit.rent.rentID}, '${rentalDeposit.rent.room.roomNumber}')">
                                                        คืนห้อง
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #7f8c8d;">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function confirmReturnRoom(rentId, roomNumber) {
            if (confirm('คุณต้องการคืนห้อง ' + roomNumber + ' ใช่หรือไม่?\n\nหลังจากคืนห้องแล้ว คุณจะไม่สามารถเข้าพักในห้องนี้ได้อีก')) {
                // ส่งคำร้องขอคืนห้อง
                window.location.href = 'ReturnRoom?rentId=' + rentId;
            }
        }
        
        // แสดง alert ถ้ามีข้อความจาก server
        <c:if test="${not empty message}">
            alert("${message}");
        </c:if>
        
        <c:if test="${not empty error}">
            alert("${error}");
        </c:if>
        
        <c:if test="${not empty warning}">
            alert("${warning}");
        </c:if>
    </script>
</body>
</html>