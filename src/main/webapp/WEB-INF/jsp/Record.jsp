<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
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
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ประวัติการจองห้องพัก - ThanaChok Place</title>
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

        .floating-shapes:nth-child(1) { top: 10%; left: 10%; animation-delay: 0s; }
        .floating-shapes:nth-child(2) { top: 20%; right: 10%; animation-delay: 2s; }
        .floating-shapes:nth-child(3) { bottom: 10%; left: 20%; animation-delay: 4s; }
        .floating-shapes:nth-child(4) { bottom: 20%; right: 20%; animation-delay: 1s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
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
            font-weight: bold;
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
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 140, 0, 0.3);
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
        }

        /* Stats Cards */
        .rental-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255, 140, 0, 0.3);
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
            box-shadow: 0 12px 40px rgba(255, 140, 0, 0.3);
        }

        .stat-card .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .stat-card .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-card .stat-label {
            color: #999;
            font-size: 1rem;
            font-weight: 500;
        }

        .stat-card.active-rentals::before { background: linear-gradient(90deg, #ff4444, #cc0000); }
        .stat-card.active-rentals .stat-number,
        .stat-card.active-rentals .stat-icon { color: #ff4444; }

        .stat-card.total-rentals::before { background: linear-gradient(90deg, #ff8c00, #ff6b00); }
        .stat-card.total-rentals .stat-number,
        .stat-card.total-rentals .stat-icon { color: #ff8c00; }

        .stat-card.completed-rentals::before { background: linear-gradient(90deg, #00ff88, #00cc6f); }
        .stat-card.completed-rentals .stat-number,
        .stat-card.completed-rentals .stat-icon { color: #00ff88; }

        /* Alerts */
        .alert {
            padding: 18px 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            animation: slideIn 0.5s ease-out;
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

        .alert-warning {
            background: linear-gradient(135deg, #ffa726, #f57c00);
            color: white;
            border: 1px solid rgba(255, 167, 38, 0.5);
        }

        .alert-info {
            background: linear-gradient(135deg, #42a5f5, #1976d2);
            color: white;
            border: 1px solid rgba(66, 165, 245, 0.5);
        }

        /* Table */
        .table-container {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 140, 0, 0.3);
            animation: slideIn 0.8s ease-out;
        }

        .record-table {
            width: 100%;
            border-collapse: collapse;
        }

        .record-table th {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            padding: 18px 15px;
            text-align: center;
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .record-table td {
            padding: 16px 15px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
            color: #ccc;
        }

        .record-table tbody tr {
            transition: all 0.3s ease;
        }

        .record-table tbody tr:hover {
            background: rgba(255, 140, 0, 0.1);
            transform: scale(1.01);
        }

        /* Status Badges */
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-complete {
            background: linear-gradient(135deg, #00ff88, #00cc6f);
            color: #000;
            box-shadow: 0 4px 10px rgba(0, 255, 136, 0.3);
        }

        .status-pending {
            background: linear-gradient(135deg, #ffa726, #f57c00);
            color: white;
            box-shadow: 0 4px 10px rgba(255, 167, 38, 0.3);
        }

        .status-waiting {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            box-shadow: 0 4px 10px rgba(255, 68, 68, 0.3);
        }

        .status-returned {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
            color: white;
            box-shadow: 0 4px 10px rgba(155, 89, 182, 0.3);
        }

        /* Buttons */
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
            margin: 3px;
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
        }

        .btn-disabled:hover {
            transform: none;
            box-shadow: none;
        }

        /* No Record */
        .no-record {
            text-align: center;
            padding: 80px 20px;
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 140, 0, 0.3);
        }

        .no-record .no-record-icon {
            font-size: 5rem;
            color: #ff8c00;
            margin-bottom: 25px;
            opacity: 0.5;
        }

        .no-record h3 {
            color: #ff8c00;
            margin-bottom: 15px;
            font-size: 1.8rem;
        }

        .no-record p {
            color: #999;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .no-record .cta-btn {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            padding: 15px 30px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
        }

        .no-record .cta-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 140, 0, 0.5);
        }

        /* Price */
        .price {
            font-weight: 600;
            color: #00ff88;
            font-size: 1.1rem;
        }

        .room-number {
            font-weight: 700;
            color: #ff8c00;
            font-size: 1.1rem;
        }

        .room-description {
            text-align: left;
            max-width: 200px;
            margin: 0 auto;
            color: #999;
            font-size: 0.9rem;
            line-height: 1.4;
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

        /* Particles */
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

        /* Responsive */
        @media (max-width: 768px) {
            .page-header h1 { font-size: 1.5rem; }
            .container { padding: 0 15px; }
            .record-table { font-size: 0.85rem; }
            .record-table th, .record-table td { padding: 12px 8px; }
            .rental-stats { grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); }
            .stat-card .stat-number { font-size: 2rem; }
            .stat-card .stat-icon { font-size: 2rem; }
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
            <i class="fas fa-building"></i>
            ThanaChok Place - ประวัติการจองห้องพัก
        </h1>
    </div>

    <!-- Navigation -->
    <div class="nav">
        <a href="Homesucess"><i class="fas fa-home"></i> หน้าหลัก</a>
        <a href="MemberListinvoice"><i class="fas fa-file-invoice"></i> แจ้งหนี้</a>
        <a href="Record" class="active"><i class="fas fa-history"></i> ประวัติการจอง</a>
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
                สวัสดี, ${loginMember.firstName} ${loginMember.lastName}
            </h3>
            <p>ประวัติการจองห้องพักของคุณ</p>
        </div>

        <!-- Stats -->
        <div class="rental-stats">
            <div class="stat-card active-rentals">
                <div class="stat-icon"><i class="fas fa-home"></i></div>
                <div class="stat-number">
                    <c:choose>
                        <c:when test="${not empty activeRentalCount}">${activeRentalCount}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-label">ห้องที่จองอยู่</div>
            </div>

            <div class="stat-card total-rentals">
                <div class="stat-icon"><i class="fas fa-clipboard-list"></i></div>
                <div class="stat-number">
                    <c:choose>
                        <c:when test="${not empty rentalDeposits}">${fn:length(rentalDeposits)}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-label">การจองทั้งหมด</div>
            </div>

            <div class="stat-card completed-rentals">
                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                <div class="stat-number">
                    <c:set var="completedCount" value="0" />
                    <c:forEach var="deposit" items="${rentalDeposits}">
                        <c:if test="${deposit.status == 'คืนห้องแล้ว'}">
                            <c:set var="completedCount" value="${completedCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${completedCount}
                </div>
                <div class="stat-label">คืนห้องแล้ว</div>
            </div>
        </div>

        <!-- Info Alert -->
        <c:if test="${not empty activeRentalCount && activeRentalCount > 0}">
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i>
                <div>
                    คุณมีการจองห้องที่ยัง Active อยู่ <strong>${activeRentalCount}</strong> ห้อง 
                    - คุณต้องคืนห้องเก่าก่อนจึงจะสามารถจองห้องใหม่ได้
                </div>
            </div>
        </c:if>

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

        <c:if test="${not empty warning}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i> ${warning}
            </div>
        </c:if>

        <!-- Records -->
        <c:choose>
            <c:when test="${empty rentalDeposits}">
                <div class="no-record">
                    <div class="no-record-icon"><i class="fas fa-home"></i></div>
                    <h3>ไม่มีประวัติการจอง</h3>
                    <p>คุณยังไม่เคยจองห้องพักกับเรา ลองเริ่มค้นหาห้องที่เหมาะกับคุณ</p>
                    <a href="Homesucess" class="cta-btn">
                        <i class="fas fa-search"></i> เริ่มค้นหาห้องพัก
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                    <table class="record-table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-door-open"></i> หมายเลขห้อง</th>
                                <th><i class="fas fa-user"></i> ชื่อผู้จอง</th>
                                <th><i class="fas fa-info-circle"></i> รายละเอียด</th>
                                <th><i class="fas fa-money-bill-wave"></i> จำนวนเงิน</th>
                                <th><i class="fas fa-calendar"></i> วันหมดอายุ</th>
                                <th><i class="fas fa-tags"></i> สถานะ</th>
                                <th><i class="fas fa-cogs"></i> การดำเนินการ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="rentalDeposit" items="${rentalDeposits}">
                                <tr>
                                    <td class="room-number">${rentalDeposit.rent.room.roomNumber}</td>
                                    <td>${rentalDeposit.rent.member.firstName} ${rentalDeposit.rent.member.lastName}</td>
                                    <td>
                                        <div class="room-description">
                                            ${rentalDeposit.rent.room.description}
                                        </div>
                                    </td>
                                    <td class="price">
                                        <fmt:formatNumber value="${rentalDeposit.totalPrice}" type="currency" 
                                                        currencySymbol="฿" groupingUsed="true"/>
                                    </td>
                                    <td>
                                        <i class="fas fa-calendar"></i>
                                        <fmt:formatDate value="${rentalDeposit.deadlineDate}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${rentalDeposit.status == 'เสร็จสมบูรณ์'}">
                                                <span class="status-badge status-complete">
                                                    <i class="fas fa-check-circle"></i> เสร็จสมบูรณ์
                                                </span>
                                            </c:when>
                                            <c:when test="${rentalDeposit.status == 'รอการอนุมัติ'}">
                                                <span class="status-badge status-pending">
                                                    <i class="fas fa-clock"></i> รอการอนุมัติ
                                                </span>
                                            </c:when>
                                            <c:when test="${rentalDeposit.status == 'รอดำเนินการ'}">
                                                <span class="status-badge status-waiting">
                                                    <i class="fas fa-hourglass-half"></i> รอดำเนินการ
                                                </span>
                                            </c:when>
                                            <c:when test="${rentalDeposit.status == 'คืนห้องแล้ว'}">
                                                <span class="status-badge status-returned">
                                                    <i class="fas fa-home"></i> คืนห้องแล้ว
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-waiting">
                                                    <i class="fas fa-question-circle"></i> ${rentalDeposit.status}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${rentalDeposit.status == 'เสร็จสมบูรณ์'}">
                                                <c:choose>
                                                    <c:when test="${rentalDeposit.hasUnpaidInvoices}">
                                                        <button class="btn btn-disabled" 
                                                                title="ไม่สามารถคืนห้องได้ เนื่องจากมีค่าใช้จ่ายค้างชำระ">
                                                            <i class="fas fa-ban"></i> คืนห้อง (มีหนี้ค้าง)
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-return" 
                                                                onclick="confirmReturnRoom('${rentalDeposit.rent.rentID}', '${rentalDeposit.rent.room.roomNumber}')"
                                                                title="คืนห้องและรับเงินมัดจำคืน">
                                                            <i class="fas fa-sign-out-alt"></i> คืนห้อง
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${rentalDeposit.status == 'คืนห้องแล้ว'}">
                                                <span style="color: #9b59b6; font-weight: 500;">
                                                    <i class="fas fa-check"></i> เสร็จสิ้น
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #ffa726; font-weight: 500;">
                                                    <i class="fas fa-hourglass-half"></i> รออนุมัติ
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Help Info -->
                <div class="alert alert-info" style="margin-top: 25px;">
                    <i class="fas fa-lightbulb"></i>
                    <div>
                        <strong>คำแนะนำ:</strong> คุณสามารถจองห้องใหม่ได้เฉพาะเมื่อคืนห้องเก่าเรียบร้อยแล้วเท่านั้น<br>
                        <small>* กรุณาชำระค่าใช้จ่ายทั้งหมดก่อนทำการคืนห้อง</small>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
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

        function confirmReturnRoom(rentId, roomNumber) {
            const confirmMessage = `คุณต้องการคืนห้อง ${roomNumber} ใช่หรือไม่?\n\n` +
                `หลังจากคืนห้องแล้ว:\n` +
                `✓ คุณจะได้รับเงินมัดจำคืน\n` +
                `✓ สามารถจองห้องใหม่ได้\n` +
                `✗ ไม่สามารถเข้าพักในห้องนี้ได้อีก\n\n` +
                `กรุณาตรวจสอบให้แน่ใจว่าได้ชำระค่าใช้จ่ายทั้งหมดแล้ว`;
                
            if (confirm(confirmMessage)) {
                document.getElementById('loading').style.display = 'flex';
                
                const buttons = document.querySelectorAll('.btn-return');
                buttons.forEach(btn => {
                    btn.disabled = true;
                    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> กำลังดำเนินการ...';
                });
                
                window.location.href = 'ReturnRoom?rentId=' + rentId;
            }
        }

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

        window.addEventListener('load', function() {
            createParticles();
            
            <c:if test="${not empty message}">
                setTimeout(() => showToast("${message}", "success"), 500);
            </c:if>
            
            <c:if test="${not empty error}">
                setTimeout(() => showToast("${error}", "error"), 500);
            </c:if>
            
            <c:if test="${not empty warning}">
                setTimeout(() => showToast("${warning}", "error"), 500);
            </c:if>

            setTimeout(() => {
                document.getElementById('loading').style.display = 'none';
            }, 1000);

            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            
            setTimeout(function() {
                document.body.style.opacity = '1';
            }, 100);
        });

        let isSubmitting = false;
        
        function preventDoubleSubmit() {
            if (isSubmitting) return false;
            isSubmitting = true;
            return true;
        }

        window.addEventListener('pageshow', function() {
            isSubmitting = false;
        });
    </script>
</body>
</html>