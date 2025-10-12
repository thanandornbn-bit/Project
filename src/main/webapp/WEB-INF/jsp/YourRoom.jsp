<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ page session="true"%>
<%@ page import="com.springmvc.model.Member"%>

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
    <title>ห้องของฉัน - ThanaChok Place</title>
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

        /* Background Animation */
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
        .floating-shapes:nth-child(4) { bottom: 20%; right: 20%; animation-delay: 1s; }

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

        /* Header */
        .page-header {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            text-align: center;
            padding: 30px 20px;
            position: relative;
            z-index: 10;
            box-shadow: 0 4px 20px rgba(255, 140, 0, 0.3);
        }

        .page-header::before {
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

        .page-header h1 {
            font-size: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            animation: glow 2s ease-in-out infinite;
        }

        @keyframes glow {
            0%, 100% { text-shadow: 0 0 20px rgba(0, 0, 0, 0.3); }
            50% { text-shadow: 0 0 30px rgba(0, 0, 0, 0.5), 0 0 40px rgba(255, 255, 255, 0.3); }
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

        /* Container */
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
            position: relative;
            z-index: 1;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 25px;
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

        /* Welcome Section */
        .welcome-section {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            border: 1px solid rgba(255, 140, 0, 0.3);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            animation: slideIn 0.6s ease-out;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .welcome-section h3 {
            color: #ff8c00;
            margin-bottom: 10px;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-section p {
            color: #ccc;
            font-size: 1rem;
        }

        /* Stats */
        .rental-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 140, 0, 0.3);
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(255, 140, 0, 0.4);
        }

        .stat-card.active-rooms::before { background: linear-gradient(90deg, #00ff88, #00cc6f); }
        .stat-card.active-rooms .stat-number,
        .stat-card.active-rooms .stat-icon { color: #00ff88; }

        .stat-card.pending-return::before { background: linear-gradient(90deg, #ffa726, #f57c00); }
        .stat-card.pending-return .stat-number,
        .stat-card.pending-return .stat-icon { color: #ffa726; }

        .stat-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .stat-label {
            color: #999;
            font-size: 1.1rem;
            font-weight: 500;
        }

        /* Alerts */
        .alert {
            padding: 18px 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
            animation: slideIn 0.5s ease-out;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .alert i { font-size: 1.2rem; }

        .alert-success {
            background: linear-gradient(135deg, #00ff88, #00cc6f);
            color: #000;
            border: 1px solid rgba(0, 255, 136, 0.5);
        }

        .alert-danger {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            border: 1px solid rgba(255, 68, 68, 0.5);
        }

        .alert-info {
            background: linear-gradient(135deg, #42a5f5, #1976d2);
            color: white;
            border: 1px solid rgba(66, 165, 245, 0.5);
        }

        .alert-warning {
            background: linear-gradient(135deg, #ffa726, #f57c00);
            color: white;
            border: 1px solid rgba(255, 167, 38, 0.5);
        }

        /* Room Grid */
        .room-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 25px;
            margin-top: 25px;
        }

        .room-card {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 15px;
            overflow: hidden;
            border: 2px solid rgba(255, 140, 0, 0.3);
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(255, 140, 0, 0.3);
        }

        /* Room Header */
        .room-header {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .room-number {
            font-size: 1.8rem;
            font-weight: bold;
        }

        .room-status {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .room-status.status-active {
            background: rgba(0, 255, 136, 0.2);
            border: 2px solid #00ff88;
            color: #00ff88;
        }

        .room-status.status-pending-return {
            background: rgba(255, 167, 38, 0.2);
            border: 2px solid #ffa726;
            color: #ffa726;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.8; transform: scale(1.02); }
        }

        /* Room Body */
        .room-body {
            padding: 25px;
        }

        .room-info {
            margin-bottom: 20px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
        }

        .info-label {
            color: #999;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-value {
            color: #fff;
            font-weight: 600;
            text-align: right;
            max-width: 60%;
        }

        .price {
            color: #00ff88;
            font-size: 1.2rem;
        }

        /* Room Actions */
        .room-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .btn-return {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            box-shadow: 0 4px 10px rgba(255, 68, 68, 0.3);
        }

        .btn-return:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(255, 68, 68, 0.5);
        }

        .btn-disabled {
            background: #666;
            color: #999;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .btn-disabled:hover {
            transform: none;
            box-shadow: none;
        }

        .btn-invoices {
            background: linear-gradient(135deg, #42a5f5, #1976d2);
            color: white;
            box-shadow: 0 4px 10px rgba(66, 165, 245, 0.3);
        }

        .btn-invoices:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(66, 165, 245, 0.5);
        }

        .btn-pending {
            background: linear-gradient(135deg, #ffa726, #f57c00);
            color: white;
            cursor: default;
            box-shadow: 0 4px 10px rgba(255, 167, 38, 0.3);
            animation: pulse 2s ease-in-out infinite;
        }

        /* No Room State */
        .no-room {
            text-align: center;
            padding: 80px 20px;
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 15px;
            border: 1px solid rgba(255, 140, 0, 0.3);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .no-room .no-room-icon {
            font-size: 5rem;
            color: #ff8c00;
            margin-bottom: 25px;
            opacity: 0.5;
            animation: bounce 2s ease-in-out infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .no-room h3 {
            color: #ff8c00;
            margin-bottom: 15px;
            font-size: 1.8rem;
        }

        .no-room p {
            color: #999;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .no-room .cta-btn {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            padding: 15px 30px;
            border-radius: 10px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin-top: 20px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
        }

        .no-room .cta-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 140, 0, 0.5);
        }

        /* Loading */
        .loading {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.9);
            z-index: 1000;
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

        /* Toast */
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            z-index: 1001;
            display: none;
            animation: slideInRight 0.3s ease;
            max-width: 400px;
            border: 1px solid rgba(255, 140, 0, 0.3);
            color: white;
        }

        .toast.success { border-left: 4px solid #00ff88; }
        .toast.error { border-left: 4px solid #ff4444; }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .room-grid {
                grid-template-columns: 1fr;
            }
            
            .page-header h1 {
                font-size: 1.5rem;
            }
            
            .nav a {
                padding: 12px 16px;
                font-size: 0.9rem;
            }
            
            .room-number {
                font-size: 1.5rem;
            }
            
            .room-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }

            .rental-stats {
                grid-template-columns: 1fr;
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

    <!-- Loading -->
    <div class="loading" id="loading">
        <div class="spinner"></div>
    </div>

    <!-- Toast -->
    <div id="toast" class="toast">
        <div id="toast-message"></div>
    </div>

    <!-- Header -->
    <div class="page-header">
        <h1>
            <i class="fas fa-door-open"></i>
            ห้องของฉัน
        </h1>
    </div>

    <!-- Navigation -->
    <div class="nav">
        <a href="Homesucess"><i class="fas fa-home"></i> หน้าหลัก</a>
        <a href="YourRoom" class="active"><i class="fas fa-door-open"></i> ห้องของฉัน</a>
        <a href="Listinvoice"><i class="fas fa-file-invoice"></i> บิลค่าใช้จ่าย</a>
        <a href="Record"><i class="fas fa-history"></i> ประวัติการจอง</a>
    </div>

    <!-- Container -->
    <div class="container">
        <a href="Homesucess" class="back-btn">
            <i class="fas fa-arrow-left"></i> กลับหน้าหลัก
        </a>

        <!-- Welcome Section -->
        <div class="welcome-section">
            <h3>
                <i class="fas fa-user-circle"></i>
                ${loginMember.firstName} ${loginMember.lastName}
            </h3>
            <p>ห้องที่คุณกำลังเช่าอยู่และสถานะต่างๆ</p>
        </div>

        <!-- Stats -->
        <div class="rental-stats">
            <div class="stat-card active-rooms">
                <div class="stat-icon"><i class="fas fa-home"></i></div>
                <div class="stat-number">
                    <c:set var="activeCount" value="0" />
                    <c:forEach var="rental" items="${currentRentals}">
                        <c:if test="${rental.status == 'เสร็จสมบูรณ์'}">
                            <c:set var="activeCount" value="${activeCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${activeCount}
                </div>
                <div class="stat-label">ห้องที่กำลังเช่า</div>
            </div>

            <div class="stat-card pending-return">
                <div class="stat-icon"><i class="fas fa-clock"></i></div>
                <div class="stat-number">
                    <c:set var="pendingCount" value="0" />
                    <c:forEach var="rental" items="${currentRentals}">
                        <c:if test="${rental.status == 'รอคืนห้อง'}">
                            <c:set var="pendingCount" value="${pendingCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${pendingCount}
                </div>
                <div class="stat-label">รอคืนห้อง</div>
            </div>
        </div>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <!-- Info Alert -->
        <c:if test="${not empty currentRentals}">
            <c:set var="hasPending" value="false" />
            <c:forEach var="rental" items="${currentRentals}">
                <c:if test="${rental.status == 'รอคืนห้อง'}">
                    <c:set var="hasPending" value="true" />
                </c:if>
            </c:forEach>
            
            <c:if test="${hasPending}">
                <div class="alert alert-warning">
                    <i class="fas fa-clock"></i>
                    <div>
                        <strong>แจ้งเตือน!</strong> คุณมีคำขอคืนห้องที่กำลังรอ Manager อนุมัติ
                        กรุณารอการตรวจสอบจากเจ้าหน้าที่ภายใน 1-2 วันทำการ
                    </div>
                </div>
            </c:if>
        </c:if>

        <!-- Room Cards -->
        <c:choose>
            <c:when test="${empty currentRentals}">
                <div class="no-room">
                    <div class="no-room-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <h3>คุณยังไม่มีห้องที่เช่าอยู่</h3>
                    <p>เริ่มค้นหาห้องพักที่เหมาะกับคุณ</p>
                    <a href="Homesucess" class="cta-btn">
                        <i class="fas fa-search"></i>
                        ค้นหาห้องพัก
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="room-grid">
                    <c:forEach var="rental" items="${currentRentals}">
                        <div class="room-card">
                            <div class="room-header">
                                <div class="room-number">
                                    <i class="fas fa-door-open"></i>
                                    ห้อง ${rental.rent.room.roomNumber}
                                </div>
                                <c:choose>
                                    <c:when test="${rental.status == 'รอคืนห้อง'}">
                                        <div class="room-status status-pending-return">
                                            <i class="fas fa-clock"></i> รอคืนห้อง
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="room-status status-active">
                                            <i class="fas fa-check-circle"></i> กำลังเช่า
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="room-body">
                                <div class="room-info">
                                    <div class="info-row">
                                        <span class="info-label">
                                            <i class="fas fa-info-circle"></i> รายละเอียด
                                        </span>
                                        <span class="info-value">${rental.rent.room.description}</span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">
                                            <i class="fas fa-tag"></i> ประเภทห้อง
                                        </span>
                                        <span class="info-value">${rental.rent.room.roomtype}</span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">
                                            <i class="fas fa-money-bill-wave"></i> ค่าเช่า/เดือน
                                        </span>
                                        <span class="info-value price">
                                            ฿<fmt:formatNumber value="${rental.rent.room.roomPrice}" groupingUsed="true"/>
                                        </span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">
                                            <i class="fas fa-calendar"></i> วันที่เช่า
                                        </span>
                                        <span class="info-value">
                                            <fmt:formatDate value="${rental.paymentDate}" pattern="dd/MM/yyyy"/>
                                        </span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">
                                            <i class="fas fa-coins"></i> เงินมัดจำ
                                        </span>
                                        <span class="info-value" style="color: #00ff88;">
                                            ฿<fmt:formatNumber value="${rental.totalPrice}" groupingUsed="true"/>
                                        </span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">
                                            <i class="fas fa-flag"></i> สถานะ
                                        </span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${rental.status == 'รอคืนห้อง'}">
                                                    <span style="color: #ffa726;">
                                                        <i class="fas fa-clock"></i> รอ Manager อนุมัติ
                                                    </span>
                                                </c:when>
                                                <c:when test="${rental.hasUnpaidInvoices}">
                                                    <span style="color: #ff4444;">
                                                        <i class="fas fa-exclamation-triangle"></i> มีบิลค้างชำระ
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #00ff88;">
                                                        <i class="fas fa-check-circle"></i> ปกติ
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="room-actions">
                                    <a href="Listinvoice" class="btn btn-invoices">
                                        <i class="fas fa-file-invoice"></i>
                                        ดูบิลค่าใช้จ่าย
                                    </a>
                                    <c:choose>
                                        <c:when test="${rental.status == 'รอคืนห้อง'}">
                                            <button class="btn btn-pending" disabled>
                                                <i class="fas fa-hourglass-half"></i> รอการอนุมัติ
                                            </button>
                                        </c:when>
                                        <c:when test="${rental.hasUnpaidInvoices}">
                                            <button class="btn btn-disabled" 
                                                    title="ไม่สามารถคืนห้องได้ เนื่องจากมีบิลค้างชำระ"
                                                    disabled>
                                                <i class="fas fa-ban"></i> มีหนี้ค้าง
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-return" 
                                                    onclick="confirmReturnRoom('${rental.rent.rentID}', '${rental.rent.room.roomNumber}')">
                                                <i class="fas fa-sign-out-alt"></i> ขอคืนห้อง
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Help Info -->
                <div class="alert alert-info" style="margin-top: 25px;">
                    <i class="fas fa-lightbulb"></i>
                    <div>
                        <strong>คำแนะนำ:</strong><br>
                        • <strong style="color: #00ff88;">กำลังเช่า</strong> - ห้องที่คุณกำลังใช้งานอยู่ปกติ<br>
                        • <strong style="color: #ffa726;">รอคืนห้อง</strong> - ส่งคำขอคืนห้องแล้ว รอ Manager ตรวจสอบและอนุมัติ<br>
                        • กรุณาชำระค่าใช้จ่ายทั้งหมดก่อนทำการส่งคำขอคืนห้อง<br>
                        • หลังส่งคำขอ Manager จะตรวจสอบภายใน 1-2 วันทำการ
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Toast Notification
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

        // Confirm Return Room
        function confirmReturnRoom(rentId, roomNumber) {
            const confirmMessage = `คุณต้องการส่งคำขอคืนห้อง ${roomNumber} ใช่หรือไม่?\n\n` +
                `หลังจากส่งคำขอแล้ว:\n` +
                `✓ Manager จะได้รับคำขอของคุณ\n` +
                `✓ รอ Manager ตรวจสอบและอนุมัติ (1-2 วันทำการ)\n` +
                `✓ เมื่ออนุมัติแล้วจะได้รับเงินมัดจำคืน\n\n` +
                `⚠️ กรุณาตรวจสอบให้แน่ใจว่าได้ชำระค่าใช้จ่ายทั้งหมดแล้ว`;
                
            if (confirm(confirmMessage)) {
                document.getElementById('loading').style.display = 'flex';
                window.location.href = 'ReturnRoom?rentId=' + rentId;
            }
        }

        // Create Particles
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

        // Page Load
        window.addEventListener('load', function() {
            createParticles();
            
            // Show messages
            <c:if test="${not empty message}">
                setTimeout(() => showToast("${message}", "success"), 500);
            </c:if>
            
            <c:if test="${not empty error}">
                setTimeout(() => showToast("${error}", "error"), 500);
            </c:if>

            // Hide loading
            setTimeout(() => {
                document.getElementById('loading').style.display = 'none';
            }, 1000);

            // Fade in animation
            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            
            setTimeout(function() {
                document.body.style.opacity = '1';
            }, 100);
        });

        // Smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Add animation to cards
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('.room-card').forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            card.style.transition = `all 0.5s ease ${index * 0.1}s`;
            observer.observe(card);
        });

        // Prevent double click
        let isSubmitting = false;
        document.querySelectorAll('.btn-return').forEach(btn => {
            btn.addEventListener('click', function() {
                if (isSubmitting) return false;
                isSubmitting = true;
                setTimeout(() => {
                    isSubmitting = false;
                }, 3000);
            });
        });

        // Auto refresh page when there are pending returns
        <c:if test="${not empty currentRentals}">
            <c:set var="hasPendingReturn" value="false" />
            <c:forEach var="rental" items="${currentRentals}">
                <c:if test="${rental.status == 'รอคืนห้อง'}">
                    <c:set var="hasPendingReturn" value="true" />
                </c:if>
            </c:forEach>
            
            <c:if test="${hasPendingReturn}">
                // Refresh page every 2 minutes to check for updates
                setTimeout(function() {
                    location.reload();
                }, 120000); // 2 minutes
            </c:if>
        </c:if>
    </script>
</body>
</html>