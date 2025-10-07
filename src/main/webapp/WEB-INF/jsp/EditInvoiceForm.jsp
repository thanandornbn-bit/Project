<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page session="true"%>
<%@ page import="com.springmvc.model.Manager"%>

<%
Manager loginManager = (Manager) session.getAttribute("loginManager");
if (loginManager == null) {
    response.sendRedirect("Login");
    return;
}
%>

<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>แก้ไขใบแจ้งหนี้ #INV-${invoice.invoiceId} - ThanaChok Place</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 50%, #1a1a1a 100%);
            min-height: 100vh;
            color: #fff;
            position: relative;
            overflow-x: hidden;
        }

        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }

        .floating-shapes {
            position: absolute;
            width: 100px;
            height: 100px;
            background: rgba(255, 140, 0, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
            box-shadow: 0 0 30px rgba(255, 140, 0, 0.2);
        }

        .floating-shapes:nth-child(1) { top: 10%; left: 10%; animation-delay: 0s; }
        .floating-shapes:nth-child(2) { top: 20%; right: 10%; animation-delay: 2s; }
        .floating-shapes:nth-child(3) { bottom: 10%; left: 20%; animation-delay: 4s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }

        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(255, 140, 0, 0.5);
            border-radius: 50%;
            animation: particleFloat 8s linear infinite;
            box-shadow: 0 0 10px rgba(255, 140, 0, 0.5);
        }

        @keyframes particleFloat {
            0% { opacity: 0; transform: translateY(100vh) scale(0); }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { opacity: 0; transform: translateY(-100vh) scale(1); }
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
            position: relative;
            z-index: 1;
        }

        .page-header {
            text-align: center;
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            animation: glow 2s ease-in-out infinite;
        }

        @keyframes glow {
            0%, 100% { text-shadow: 0 0 20px rgba(255, 140, 0, 0.3); }
            50% { text-shadow: 0 0 30px rgba(255, 140, 0, 0.5), 0 0 40px rgba(255, 255, 255, 0.3); }
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 25px;
            padding: 12px 25px;
            background: rgba(255, 140, 0, 0.1);
            border: 1px solid rgba(255, 140, 0, 0.3);
            color: #ff8c00;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .back-btn:hover {
            background: rgba(255, 140, 0, 0.2);
            transform: translateX(-5px);
        }

        .main-card {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 140, 0, 0.3);
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card-header {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            padding: 30px;
            position: relative;
        }

        .card-header h2 {
            font-size: 1.8rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card-body {
            padding: 40px;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideInDown 0.5s ease;
        }

        @keyframes slideInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .alert-success {
            background: rgba(0, 255, 136, 0.15);
            border: 2px solid #00ff88;
            color: #00ff88;
        }

        .alert-danger {
            background: rgba(255, 68, 68, 0.15);
            border: 2px solid #ff4444;
            color: #ff4444;
        }

        .invoice-info-section {
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
        }

        .section-title {
            color: #ff8c00;
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }

        .info-item {
            background: rgba(0, 0, 0, 0.3);
            padding: 15px 20px;
            border-radius: 10px;
            border-left: 4px solid #ff8c00;
        }

        .info-label {
            color: #999;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        .info-value {
            color: #fff;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .invoice-number {
            color: #ff8c00;
            font-size: 1.3rem;
            font-weight: bold;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .status-paid {
            background: rgba(0, 255, 136, 0.2);
            color: #00ff88;
            border: 2px solid #00ff88;
        }

        .status-unpaid {
            background: rgba(255, 68, 68, 0.2);
            color: #ff4444;
            border: 2px solid #ff4444;
        }

        .table-container {
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            overflow-x: auto;
        }

        .detail-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .detail-table thead {
            background: rgba(255, 140, 0, 0.2);
        }

        .detail-table th {
            padding: 15px;
            text-align: left;
            color: #ff8c00;
            font-weight: 600;
            border-bottom: 2px solid rgba(255, 140, 0, 0.5);
        }

        .detail-table td {
            padding: 15px;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
            color: #ccc;
        }

        .detail-table tbody tr {
            transition: all 0.3s ease;
        }

        .detail-table tbody tr:hover {
            background: rgba(255, 140, 0, 0.1);
        }

        .amount {
            text-align: right;
            font-weight: 600;
            color: #00ff88;
        }

        .total-section {
            background: linear-gradient(135deg, rgba(255, 140, 0, 0.2), rgba(255, 107, 0, 0.2));
            border: 3px solid #ff8c00;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            margin-bottom: 30px;
        }

        .total-amount {
            font-size: 2rem;
            font-weight: bold;
            color: #ff8c00;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .form-section {
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #ff8c00;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }

        .form-control {
            width: 100%;
            max-width: 400px;
            padding: 15px;
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 10px;
            font-size: 1rem;
            color: #fff;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #ff8c00;
            box-shadow: 0 0 15px rgba(255, 140, 0, 0.3);
        }

        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 18px 40px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            min-width: 180px;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #00ff88, #00cc6f);
            color: #000;
            box-shadow: 0 5px 20px rgba(0, 255, 136, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 255, 136, 0.5);
        }

        .btn-secondary {
            background: rgba(255, 68, 68, 0.2);
            color: #ff4444;
            border: 2px solid #ff4444;
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            transform: translateY(-2px);
        }

        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 20px 25px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            z-index: 1001;
            display: none;
            animation: slideInRight 0.3s ease;
            border: 1px solid rgba(255, 140, 0, 0.3);
            color: white;
            max-width: 400px;
        }

        .toast.success { 
            border-left: 4px solid #00ff88; 
        }

        .toast.error { 
            border-left: 4px solid #ff4444; 
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .loading {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.9);
            z-index: 999;
            justify-content: center;
            align-items: center;
        }

        .spinner {
            width: 60px;
            height: 60px;
            border: 6px solid rgba(255, 140, 0, 0.3);
            border-top: 6px solid #ff8c00;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @media (max-width: 768px) {
            .container { padding: 15px; }
            .page-header { font-size: 2rem; }
            .card-body { padding: 25px 20px; }
            .info-grid { grid-template-columns: 1fr; }
            .btn-group { flex-direction: column; align-items: center; }
            .btn { width: 100%; max-width: 300px; }
            .total-amount { font-size: 1.5rem; }
            .detail-table { font-size: 0.9rem; }
        }
    </style>
</head>

<body>
    <div class="bg-animation">
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
        <div class="particles" id="particles"></div>
    </div>

    <div class="loading" id="loading">
        <div class="spinner"></div>
    </div>

    <div id="toast" class="toast">
        <div id="toast-message"></div>
    </div>

    <div class="container">
        <div class="page-header">
            <i class="fas fa-edit"></i>
            แก้ไขใบแจ้งหนี้
        </div>

        <a href="EditInvoice?roomID=${invoice.rent.room.roomID}" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            กลับไปรายการบิล
        </a>

        <div class="main-card">
            <div class="card-header">
                <h2>
                    <i class="fas fa-file-invoice"></i>
                    ใบแจ้งหนี้ #INV-${invoice.invoiceId}
                </h2>
            </div>

            <div class="card-body">
                <!-- Alert Messages -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        ${message}
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i>
                        ${error}
                    </div>
                </c:if>

                <!-- Invoice Information -->
                <div class="invoice-info-section">
                    <div class="section-title">
                        <i class="fas fa-info-circle"></i>
                        ข้อมูลใบแจ้งหนี้
                    </div>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">หมายเลขใบแจ้งหนี้</div>
                            <div class="info-value invoice-number">
                                <i class="fas fa-hashtag"></i>
                                INV-${invoice.invoiceId}
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-door-open"></i>
                                ห้องพัก
                            </div>
                            <div class="info-value">${invoice.rent.room.roomNumber}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-user"></i>
                                ผู้เช่า
                            </div>
                            <div class="info-value">
                                ${invoice.rent.member.firstName} ${invoice.rent.member.lastName}
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-calendar-plus"></i>
                                วันที่ออกบิล
                            </div>
                            <div class="info-value">${invoice.issueDate}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-calendar-check"></i>
                                วันครบกำหนด
                            </div>
                            <div class="info-value">${invoice.dueDate}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-flag"></i>
                                สถานะปัจจุบัน
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${invoice.status == 1}">
                                        <span class="status-badge status-paid">
                                            <i class="fas fa-check-circle"></i>
                                            ชำระแล้ว
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-unpaid">
                                            <i class="fas fa-clock"></i>
                                            ยังไม่ได้ชำระ
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Invoice Details Table -->
                <div class="table-container">
                    <div class="section-title">
                        <i class="fas fa-list-alt"></i>
                        รายละเอียดค่าใช้จ่าย
                    </div>
                    <table class="detail-table">
                        <thead>
                            <tr>
                                <th>
                                    <i class="fas fa-tag"></i>
                                    รายการ
                                </th>
                                <th style="text-align: center;">
                                    <i class="fas fa-sort-numeric-up"></i>
                                    จำนวน
                                </th>
                                <th style="text-align: right;">
                                    <i class="fas fa-dollar-sign"></i>
                                    ราคาต่อหน่วย
                                </th>
                                <th style="text-align: right;">
                                    <i class="fas fa-calculator"></i>
                                    รวม
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${invoiceDetails}">
                                <tr>
                                    <td>
                                        <strong>${detail.type.typeName}</strong>
                                    </td>
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
                </div>

                <!-- Total Section -->
                <div class="total-section">
                    <div style="font-size: 1.2rem; color: #ccc; margin-bottom: 10px;">
                        ยอดรวมทั้งสิ้น
                    </div>
                    <div class="total-amount">
                        ฿<fmt:formatNumber value="${invoice.totalAmount}" groupingUsed="true" minFractionDigits="2"/>
                    </div>
                </div>

                <!-- Edit Form -->
                <form action="UpdateInvoice" method="post" id="editForm">
                    <input type="hidden" name="invoiceId" value="${invoice.invoiceId}"/>
                    
                    <div class="form-section">
                        <div class="section-title">
                            <i class="fas fa-toggle-on"></i>
                            เปลี่ยนสถานะการชำระเงิน
                        </div>
                        
                        <div class="form-group">
                            <label for="status">
                                <i class="fas fa-exchange-alt"></i>
                                สถานะ:
                            </label>
                            <select name="status" id="status" class="form-control" required>
                                <option value="0" ${invoice.status == 0 ? 'selected' : ''}>
                                    ยังไม่ได้ชำระ
                                </option>
                                <option value="1" ${invoice.status == 1 ? 'selected' : ''}>
                                    ชำระแล้ว
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary" onclick="return confirmUpdate()">
                            <i class="fas fa-save"></i>
                            บันทึกการแก้ไข
                        </button>
                        <a href="EditInvoice?roomID=${invoice.rent.room.roomID}" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            ยกเลิก
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showToast(message, type = 'success') {
            const toast = document.getElementById('toast');
            const toastMessage = document.getElementById('toast-message');
            
            toastMessage.textContent = message;
            toast.className = `toast ${type}`;
            toast.style.display = 'block';
            
            setTimeout(() => {
                toast.style.display = 'none';
            }, 5000);
        }

        function confirmUpdate() {
            const status = document.getElementById('status').value;
            const statusText = status === '1' ? 'ชำระแล้ว' : 'ยังไม่ได้ชำระ';
            
            if (confirm(`คุณต้องการเปลี่ยนสถานะเป็น "${statusText}" ใช่หรือไม่?`)) {
                document.getElementById('loading').style.display = 'flex';
                return true;
            }
            return false;
        }

        // Show toast on page load if message exists
        window.addEventListener('load', function() {
            <c:if test="${not empty message}">
                showToast("${message}", "success");
            </c:if>
            
            <c:if test="${not empty error}">
                showToast("${error}", "error");
            </c:if>

            
            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            
            setTimeout(() => {
                document.body.style.opacity = '1';
            }, 100);

            setTimeout(() => {
                document.getElementById('loading').style.display = 'none';
            }, 500);
        });

        function createParticles() {
            const particlesContainer = document.getElementById('particles');
            const particleCount = 20;
            
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.animationDelay = Math.random() * 8 + 's';
                particle.style.animationDuration = (Math.random() * 5 + 5) + 's';
                particlesContainer.appendChild(particle);
            }
        }

        createParticles();

        document.addEventListener('DOMContentLoaded', function() {
            const sections = document.querySelectorAll('.invoice-info-section, .table-container, .total-section, .form-section');
            sections.forEach((section, index) => {
                section.style.animationDelay = (index * 0.1) + 's';
                section.classList.add('fade-in');
            });
        });
    </script>
</body>
</html>