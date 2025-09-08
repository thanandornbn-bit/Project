<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>แก้ไขใบแจ้งหนี้ #INV-${invoice.invoiceId}</title>
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
        
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        
        .invoice-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        .detail-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .detail-table th {
            background-color: #3498db;
            color: white;
            padding: 12px;
            text-align: left;
        }
        
        .detail-table td {
            padding: 10px 12px;
            border-bottom: 1px solid #eee;
        }
        
        .amount {
            text-align: right;
            font-weight: bold;
        }
        
        .total-section {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            text-align: right;
            margin-bottom: 20px;
        }
        
        .total-amount {
            font-size: 20px;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-right: 10px;
        }
        
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
        }
        
        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #7f8c8d;
        }
        
        .status-paid {
            background-color: #27ae60;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
        }
        
        .status-unpaid {
            background-color: #e74c3c;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
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
    </style>
</head>
<body>
    <div class="header">
        แก้ไขใบแจ้งหนี้ #INV-${invoice.invoiceId}
    </div>
    
    <div class="form-container">
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <div class="invoice-info">
            <h3>ข้อมูลใบแจ้งหนี้</h3>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div>
                    <p><strong>หมายเลขใบแจ้งหนี้:</strong> INV-${invoice.invoiceId}</p>
                    <p><strong>ห้อง:</strong> ${invoice.rent.room.roomNumber}</p>
                    <p><strong>ผู้เช่า:</strong> ${invoice.rent.member.firstName} ${invoice.rent.member.lastName}</p>
                </div>
                <div>
                    <p><strong>วันที่ออกใบแจ้งหนี้:</strong> ${invoice.issueDate}</p>
                    <p><strong>วันครบกำหนด:</strong> ${invoice.dueDate}</p>
                    <p><strong>สถานะปัจจุบัน:</strong> 
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
        
        <h3>รายละเอียดค่าใช้จ่าย</h3>
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
        
        <form action="UpdateInvoice" method="post">
            <input type="hidden" name="invoiceId" value="${invoice.invoiceId}"/>
            
            <div class="form-group">
                <label for="status">เปลี่ยนสถานะการชำระ:</label>
                <select name="status" id="status" required>
                    <option value="0" ${invoice.status == 0 ? 'selected' : ''}>ยังไม่ได้ชำระ</option>
                    <option value="1" ${invoice.status == 1 ? 'selected' : ''}>ชำระแล้ว</option>
                </select>
            </div>
            
            <div style="text-align: center; margin-top: 30px;">
                <button type="submit" class="btn btn-primary">บันทึกการแก้ไข</button>
                <a href="EditInvoice?roomID=${invoice.rent.room.roomID}" class="btn btn-secondary">ยกเลิก</a>
            </div>
        </form>
    </div>

    <script>
        <c:if test="${not empty message}">
            alert("${message}");
        </c:if>
    </script>
</body>
</html>