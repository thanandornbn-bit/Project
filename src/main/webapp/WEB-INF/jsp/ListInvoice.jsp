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
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายการใบแจ้งหนี้ - ThanaChok Place</title>
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

        /* Animated Background */
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

        .floating-shapes:nth-child(1) {
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-shapes:nth-child(2) {
            top: 20%;
            right: 10%;
            animation-delay: 2s;
        }

        .floating-shapes:nth-child(3) {
            bottom: 10%;
            left: 20%;
            animation-delay: 4s;
        }

        .floating-shapes:nth-child(4) {
            bottom: 20%;
            right: 20%;
            animation-delay: 1s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            text-align: center;
            padding: 30px 20px;
            position: relative;
            z-index: 10;
            box-shadow: 0 4px 20px rgba(255, 140, 0, 0.3);
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.5), transparent);
            animation: scan 3s linear infinite;
        }

        @keyframes scan {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .header h1 {
            font-size: 2rem;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            animation: glow 2s ease-in-out infinite;
        }

        @keyframes glow {
            0%, 100% {
                text-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            }
            50% {
                text-shadow: 0 0 30px rgba(0, 0, 0, 0.5),
                             0 0 40px rgba(255, 255, 255, 0.3);
            }
        }

        /* Navigation */
        .nav {
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(10px);
            overflow: hidden;
            position: relative;
            z-index: 10;
            border-bottom: 2px solid rgba(255, 140, 0, 0.3);
        }

        .nav a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 16px 24px;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
            font-weight: 500;
        }

        .nav a:hover {
            background-color: rgba(255, 140, 0, 0.2);
            color: #ff8c00;
        }

        .nav a.active {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
        }

        .nav a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: #ff8c00;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav a:hover::after {
            width: 80%;
        }

        .nav a.active::after {
            width: 0;
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
            position: relative;
            z-index: 1;
        }

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
            padding: 12px 24px;
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

        /* Welcome Message */
        .welcome-message {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            backdrop-filter: blur(20px);
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 140, 0, 0.3);
            animation: slideIn 0.6s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .welcome-message h3 {
            color: #ff8c00;
            margin-bottom: 10px;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-message p {
            color: #ccc;
            font-size: 1rem;
        }

        /* Messages */
        .error-message {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            animation: slideIn 0.5s ease-out;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            border: 1px solid rgba(255, 68, 68, 0.5);
        }

        /* Table Container */
        .table-container {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 140, 0, 0.3);
            animation: slideIn 0.8s ease-out;
        }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
        }

        .invoice-table th {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            padding: 18px 15px;
            text-align: center;
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .invoice-table td {
            padding: 16px 15px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
            color: #ccc;
        }

        .invoice-table tr {
            transition: all 0.3s ease;
        }

        .invoice-table tbody tr:hover {
            background: rgba(255, 140, 0, 0.1);
            transform: scale(1.01);
        }

        /* Status Badges */
        .status-paid {
            background: linear-gradient(135deg, #00ff88, #00cc6f);
            color: #000;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
            box-shadow: 0 4px 10px rgba(0, 255, 136, 0.3);
        }

        .status-unpaid {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
            box-shadow: 0 4px 10px rgba(255, 68, 68, 0.3);
        }

        /* Buttons */
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-detail {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            box-shadow: 0 4px 10px rgba(255, 140, 0, 0.3);
        }

        .btn-detail:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(255, 140, 0, 0.5);
        }

        /* No Invoice Message */
        .no-invoice {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .no-invoice i {
            font-size: 4rem;
            color: #ff8c00;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .no-invoice h3 {
            color: #ff8c00;
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .no-invoice p {
            font-size: 1.1rem;
        }

        /* Amount Styling */
        .amount {
            font-weight: 700;
            color: #ff8c00;
            font-size: 1.05rem;
        }

        /* Invoice ID */
        .invoice-id {
            color: #ff8c00;
            font-weight: 600;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.5rem;
            }

            .nav a {
                padding: 12px 16px;
                font-size: 0.9rem;
            }

            .container {
                padding: 0 15px;
            }

            .table-container {
                overflow-x: auto;
            }

            .invoice-table {
                font-size: 0.85rem;
            }

            .invoice-table th,
            .invoice-table td {
                padding: 12px 8px;
            }

            .welcome-message h3 {
                font-size: 1.2rem;
            }

            .no-invoice i {
                font-size: 3rem;
            }

            .no-invoice h3 {
                font-size: 1.5rem;
            }
        }

        /* Particles Effect */
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
            0% {
                opacity: 0;
                transform: translateY(100vh) scale(0);
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                transform: translateY(-100vh) scale(1);
            }
        }

        /* Loading Animation */
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.5;
            }
        }
    </style>
</head>

<body>
    <!-- Animated Background -->
    <div class="bg-animation">
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
        <div class="particles" id="particles"></div>
    </div>

    <!-- Header -->
    <div class="header">
        <h1>
            <i class="fas fa-building"></i>
            ThanaChok Place - รายการใบแจ้งหนี้
        </h1>
    </div>

    <!-- Navigation -->
    <div class="nav">
        <a href="Homesucess"><i class="fas fa-home"></i> หน้าหลัก</a>
        <a href="MemberListinvoice" class="active"><i class="fas fa-file-invoice"></i> แจ้งหนี้</a>
        <a href="Record"><i class="fas fa-history"></i> ดูประวัติการจอง</a>
    </div>

    <!-- Container -->
    <div class="container">
        <a href="Homesucess" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            กลับหน้าหลัก
        </a>

        <!-- Welcome Message -->
        <div class="welcome-message">
            <h3>
                <i class="fas fa-user-circle"></i>
                สวัสดี, ${loginMember.firstName} ${loginMember.lastName}
            </h3>
            <p>รายการใบแจ้งหนี้ของคุณ</p>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>

        <!-- Invoice List -->
        <c:choose>
            <c:when test="${empty invoices}">
                <div class="table-container">
                    <div class="no-invoice">
                        <i class="fas fa-inbox"></i>
                        <h3>ไม่มีใบแจ้งหนี้</h3>
                        <p>ขณะนี้ยังไม่มีใบแจ้งหนี้สำหรับคุณ</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                    <table class="invoice-table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag"></i> เลขที่ใบแจ้งหนี้</th>
                                <th><i class="fas fa-door-open"></i> ห้องที่</th>
                                <th><i class="fas fa-calendar-plus"></i> วันที่ออก</th>
                                <th><i class="fas fa-calendar-check"></i> วันครบกำหนด</th>
                                <th><i class="fas fa-money-bill-wave"></i> จำนวนเงิน</th>
                                <th><i class="fas fa-info-circle"></i> สถานะ</th>
                                <th><i class="fas fa-cog"></i> การดำเนินการ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="invoice" items="${invoices}">
                                <tr>
                                    <td class="invoice-id">INV-${invoice.invoiceId}</td>
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
                                                <span class="status-paid">
                                                    <i class="fas fa-check-circle"></i> ชำระแล้ว
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-unpaid">
                                                    <i class="fas fa-exclamation-circle"></i> ยังไม่ได้ชำระ
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="InvoiceDetail?invoiceId=${invoice.invoiceId}" 
                                           class="btn btn-detail">
                                            <i class="fas fa-eye"></i> ดูรายละเอียด
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Alert message
        <c:if test="${not empty message}">
            alert("${message}");
        </c:if>

        // Create particles
        function createParticles() {
            const particles = document.getElementById('particles');
            const particleCount = 50;

            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.animationDelay = Math.random() * 8 + 's';
                particle.style.animationDuration = (Math.random() * 3 + 5) + 's';
                particles.appendChild(particle);
            }
        }

        // Initialize on load
        window.addEventListener('load', function() {
            createParticles();

            // Page load animation
            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            
            setTimeout(function() {
                document.body.style.opacity = '1';
            }, 100);
        });

        // Add hover effect to table rows
        document.querySelectorAll('.invoice-table tbody tr').forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.boxShadow = '0 4px 20px rgba(255, 140, 0, 0.2)';
            });

            row.addEventListener('mouseleave', function() {
                this.style.boxShadow = 'none';
            });
        });
    </script>
</body>
</html>