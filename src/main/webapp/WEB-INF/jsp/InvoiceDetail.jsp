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
        
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .invoice-header {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .invoice-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .info-group {
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 6px;
        }
        
        .info-group h4 {
            margin: 0 0 10px 0;
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 5px;
        }
        
        .detail-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .detail-table th {
            background-color: #3498db;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: bold;
        }
        
        .detail-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }
        
        .detail-table tr:hover {
            background-color: #f8f9fa;
        }
        
        .total-section {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: right;
        }
        
        .total-amount {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
            border-top: 2px solid #3498db;
            padding-top: 10px;
            margin-top: 10px;
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
        
        .status-paid {
            background-color: #27ae60;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
        }
        
        .status-unpaid {
            background-color: #e74c3c;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
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
            text-align: right;
            font-weight: bold;
        }
        
        .invoice-number {
            font-size: 28px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
    <div class="header">
        ThanaChok Place - รายละเอียดใบแจ้งหนี้
    </div>
    
    <div class="container">
        <a href="MemberListinvoice" class="back-btn">← กลับรายการใบแจ้งหนี้</a>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty invoice}">
            <div class="invoice-header">
                <div class="invoice-number">ใบแจ้งหนี้ #INV-${invoice.invoiceId}</div>
                
                <div class="invoice-info">
                    <div class="info-group">
                        <h4>ข้อมูลการเช่า</h4>
                        <p><strong>ห้อง:</strong> ${invoice.rent.room.roomNumber}</p>
                        <p><strong>ผู้เช่า:</strong> ${invoice.rent.member.firstName} ${invoice.rent.member.lastName}</p>
                        <p><strong>ประเภทห้อง:</strong> ${invoice.rent.room.roomtype}</p>
                    </div>
                    
                    <div class="info-group">
                        <h4>ข้อมูลใบแจ้งหนี้</h4>
                        <p><strong>วันที่ออกใบแจ้งหนี้:</strong> ${invoice.issueDate}</p>
                        <p><strong>วันครบกำหนด:</strong> ${invoice.dueDate}</p>
                        <p><strong>สถานะ:</strong> 
                            <c:choose>
                                <c:when test="${invoice.status == 1}">
                                    <span class="status-paid">ชำระแล้ว</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-unpaid">ยังไม่ได้ชำระ</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            
            <table class="detail-table">
                <thead>
                    <tr>
                        <th>รายการ</th>
                        <th style="text-align: center;">จำนวน</th>
                        <th style="text-align: right;">ราคาต่อหน่วย</th>
                        <th style="text-align: right;">รวม</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="detail" items="${invoiceDetails}">
                        <tr>
                            <td>${detail.type.typeName}</td>
                            <td style="text-align: center;">
                                <c:choose>
                                    <c:when test="${detail.quantity > 1}">
                                        ${detail.quantity} หน่วย
                                    </c:when>
                                    <c:otherwise>
                                        1
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="amount">
                                ฿<fmt:formatNumber value="${detail.price}" groupingUsed="true" minFractionDigits="2"/>
                            </td>
                            <td class="amount">
                                ฿<fmt:formatNumber value="${detail.amount}" groupingUsed="true" minFractionDigits="2"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="total-section">
                <div class="total-amount">
                    ยอดรวมทั้งสิ้น: ฿<fmt:formatNumber value="${invoice.totalAmount}" groupingUsed="true" minFractionDigits="2"/>
                </div>
            </div>
        </c:if>
    </div>

    <script>
        <c:if test="${not empty message}">
            alert("${message}");
        </c:if>
        
        function printInvoice() {
            // ซ่อนปุ่มและ elements ที่ไม่ต้องการให้ปรากฏในการพิมพ์
            var backBtn = document.querySelector('.back-btn');
            var printBtn = document.querySelector('.print-btn');
            
            if (backBtn) backBtn.style.display = 'none';
            if (printBtn) printBtn.style.display = 'none';
            
            // เพิ่มข้อมูลวันที่พิมพ์
            var printDate = new Date().toLocaleDateString('th-TH', {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
            
            var printInfo = document.createElement('div');
            printInfo.innerHTML = '<p style="text-align: right; font-size: 12px; color: #666; margin-top: 20px;">พิมพ์เมื่อ: ' + printDate + '</p>';
            document.querySelector('.total-section').appendChild(printInfo);
            
            // พิมพ์
            window.print();
            
            // แสดงปุ่มกลับมาหลังจากพิมพ์
            setTimeout(function() {
                if (backBtn) backBtn.style.display = 'inline-block';
                if (printBtn) printBtn.style.display = 'inline-block';
                if (printInfo) printInfo.remove();
            }, 100);
        }
    </script>
</body>
</html>