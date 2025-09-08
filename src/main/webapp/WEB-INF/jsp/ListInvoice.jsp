<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page session="true" %>
<%@ page import="com.springmvc.model.Member" %>

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
    <title>รายการใบแจ้งหนี้ - ThanaChok Place</title>
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
        
        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .invoice-table th {
            background-color: #3498db;
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: bold;
        }
        
        .invoice-table td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        
        .invoice-table tr:hover {
            background-color: #f8f9fa;
        }
        
        .status-paid {
            background-color: #27ae60;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .status-unpaid {
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
        }
        
        .btn-detail {
            background-color: #3498db;
            color: white;
        }
        
        .btn-detail:hover {
            background-color: #2980b9;
        }
        
        .no-invoice {
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
        
        .error-message {
            background-color: #e74c3c;
            color: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .amount {
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>

<body>
    <div class="header">
        ThanaChok Place - รายการใบแจ้งหนี้
    </div>
    
    <div class="nav">
        <a href="Homesucess">หน้าหลัก</a>
        <a href="MemberListinvoice" class="active">แจ้งหนี้</a>
        <a href="Record">ดูประวัติการจอง</a>
    </div>
    
    <div class="container">
        <a href="Homesucess" class="back-btn">← กลับหน้าหลัก</a>
        
        <div class="welcome-message">
            <h3>สวัสดี, ${loginMember.firstName} ${loginMember.lastName}</h3>
            <p>รายการใบแจ้งหนี้ของคุณ</p>
        </div>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty invoices}">
                <div class="no-invoice">
                    <h3>ไม่มีใบแจ้งหนี้</h3>
                    <p>ขณะนี้ยังไม่มีใบแจ้งหนี้สำหรับคุณ</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="invoice-table">
                    <thead>
                        <tr>
                            <th>เลขที่ใบแจ้งหนี้</th>
                            <th>ห้องที่</th>
                            <th>วันที่ออกใบแจ้งหนี้</th>
                            <th>วันครบกำหนด</th>
                            <th>จำนวนเงิน</th>
                            <th>สถานะ</th>
                            <th>การดำเนินการ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="invoice" items="${invoices}">
                            <tr>
                                <td>INV-${invoice.invoiceId}</td>
                                <td>${invoice.rent.room.roomNumber}</td>
                                <td>${invoice.issueDate}</td>
                                <td>${invoice.dueDate}</td>
                                <td class="amount">
                                    ฿<fmt:formatNumber value="${invoice.totalAmount}" 
                                                     groupingUsed="true" minFractionDigits="2"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${invoice.status == 1}">
                                            <span class="status-paid">ชำระแล้ว</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-unpaid">ยังไม่ได้ชำระ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="InvoiceDetail?invoiceId=${invoice.invoiceId}" 
                                       class="btn btn-detail">ดูรายละเอียด</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // แสดง alert ถ้ามีข้อความจาก server
        <c:if test="${not empty message}">
            alert("${message}");
        </c:if>
    </script>
</body>
</html>