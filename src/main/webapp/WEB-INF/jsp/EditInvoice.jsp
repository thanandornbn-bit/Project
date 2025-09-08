<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>แก้ไขใบแจ้งหนี้ - ห้อง ${room.roomNumber}</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .header {
            background-color: #2c5aa0;
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        
        .room-info {
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
        
        .btn-edit {
            background-color: #3498db;
            color: white;
        }
        
        .btn-edit:hover {
            background-color: #2980b9;
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
        
        .no-invoice {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
            font-size: 16px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .amount {
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="header">
        แก้ไขใบแจ้งหนี้ - ห้อง ${room.roomNumber}
    </div>
    
    <a href="OwnerHome" class="back-btn">← กลับหน้าหลัก</a>
    
    <div class="room-info">
        <h3>ข้อมูลห้อง</h3>
        <p><strong>หมายเลขห้อง:</strong> ${room.roomNumber}</p>
        <p><strong>ประเภท:</strong> ${room.roomtype}</p>
        <p><strong>ราคา:</strong> ${room.roomPrice} บาท/เดือน</p>
        <p><strong>สถานะ:</strong> ${room.roomStatus}</p>
    </div>
    
    <c:if test="${not empty message}">
        <div style="background-color: #d4edda; color: #155724; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
            ${message}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div style="background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
            ${error}
        </div>
    </c:if>
    
    <c:choose>
        <c:when test="${empty invoices}">
            <div class="no-invoice">
                <h3>ไม่มีใบแจ้งหนี้</h3>
                <p>ห้องนี้ยังไม่มีใบแจ้งหนี้</p>
                <a href="ManagerAddInvoice?roomID=${room.roomID}" class="btn btn-edit">สร้างใบแจ้งหนี้ใหม่</a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>เลขที่ใบแจ้งหนี้</th>
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
                                <a href="EditInvoiceForm?invoiceId=${invoice.invoiceId}" 
                                   class="btn btn-edit">แก้ไข</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>