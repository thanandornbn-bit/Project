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
    <title>รายละเอียดใบแจ้งหนี้ - ThanaChok Place</title>
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
        
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 0 20px;
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
        
        .invoice-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .invoice-header {
            background-color: #3498db;
            color: white;
            padding: 20px;
            text-align: center;
        }
        
        .invoice-info {
            padding: 20px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .info-section h4 {
            margin-top: 0;
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        
        .info-item {
            margin-bottom: 10px;
        }
        
        .info-label {
            font-weight: bold;
            color: #34495e;
            display: inline-block;
            width: 120px;
        }
        
        .info-value {
            color: #2c3e50;
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
        
        .details-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .details-table th {
            background-color: #34495e;
            color: white;
            padding: 12px;
            text-align: left;
        }
        
        .details-table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }
        
        .details-table tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        .total-section {
            background-color: #ecf0f1;
            padding: 20px;
            text-align: right;
            border-top: 3px solid #3498db;
        }
        
        .total-amount {
            font-size: 24px;
            font-weight: bold;
            color: #e74c3c;
            margin-top: 10px;
        }
        
        .error-message {
            background-color: #e74c3c;
            color: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .print-btn {
            background-color: #16a085;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            float: right;
            margin-top: 20px;
        }
        
        .print-btn:hover {
            background-color: #138d75;
        }
        
        @media print {
            .nav, .back-btn, .print-btn {
                display: none;
            }
        }
    </style>
</head>

<body>
    <div class="header">
        ThanaChok Place - รายละเอียดใบแจ้งหนี้
    </div>
    
    <div class="nav">
        <a href="Homesucess">หน้าหลัก</a>
        <a href="MemberListinvoice">แจ้งหนี้</a>
        <a href="Record">ดูประวัติการจอง</a>
    </div>
    
    <div class="container">
        <a href="MemberListinvoice" class="back-btn">← กลับรายการใบแจ้งหนี้</a>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty invoice}">
            <div class="invoice-card">
                <div class="invoice-header">
                    <h2>ใบแจ้งหนี้เลขที่ INV-${invoice.invoiceId}</h2>
                </div>
                
                <div class="invoice-info">
                    <div class="info-section">
                        <h4>ข้อมูลลูกค้า</h4>
                        <div class="info-item">
                            <span class="info-label">ชื่อ:</span>
                            <span class="info-value">
                                ${invoice.rent.member.firstName} ${invoice.rent.member.lastName}
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">เบอร์โทร:</span>
                            <span class="info-value">${invoice.rent.member.phoneNumber}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">อีเมล:</span>
                            <span class="info-value">${invoice.rent.member.email}</span>
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h4>ข้อมูลใบแจ้งหนี้</h4>
                        <div class="info-item">
                            <span class="info-label">ห้องที่:</span>
                            <span class="info-value">${invoice.rent.room.roomNumber}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">วันที่ออก:</span>
                            <span class="info-value">
                                <fmt:formatDate value="${invoice.issueDate}" pattern="dd/MM/yyyy"/>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">วันครบกำหนด:</span>
                            <span class="info-value">
                                <fmt:formatDate value="${invoice.dueDate}" pattern="dd/MM/yyyy"/>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">สถานะ:</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${invoice.status == 1}">
                                        <span class="status-paid">ชำระแล้ว</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-unpaid">ยังไม่ได้ชำระ</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>
                
                <div style="padding: 0 20px;">
                    <h4 style="color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px;">
                        รายละเอียดค่าใช้จ่าย
                    </h4>
                    
                    <table class="details-table">
                        <thead>
                            <tr>
                                <th>รายการ</th>
                                <th>จำนวน/หน่วย</th>
                                <th>ราคาต่อหน่วย</th>
                                <th>จำนวนเงิน</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${invoice.details}">
                                <tr>
                                    <td>${detail.type.typeName}</td>
                                    <td style="text-align: center;">${detail.quantity}</td>
                                    <td style="text-align: right;">
                                        <fmt:formatNumber value="${detail.price}" type="currency" 
                                                        currencySymbol="฿" groupingUsed="true"/>
                                    </td>
                                    <td style="text-align: right;">
                                        <fmt:formatNumber value="${detail.amount}" type="currency" 
                                                        currencySymbol="฿" groupingUsed="true"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="total-section">
                    <h3>รวมทั้งสิ้น</h3>
                    <div class="total-amount">
                        <fmt:formatNumber value="${invoice.totalAmount}" type="currency" 
                                        currencySymbol="฿" groupingUsed="true"/>
                    </div>
                </div>
            </div>
            
            <button class="print-btn" onclick="window.print()">
                🖨️ พิมพ์ใบแจ้งหนี้
            </button>
        </c:if>
    </div>

    <script>
        // แสดง alert ถ้ามีข้อความจาก server
        <c:if test="${not empty message}">
            alert("${message}");
        </c:if>
    </script>
</body>
</html>