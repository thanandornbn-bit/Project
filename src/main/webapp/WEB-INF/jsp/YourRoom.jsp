<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                <%@ page session="true" %>
                    <%@ page import="com.springmvc.model.Member" %>

                        <% Member loginMember=(Member) session.getAttribute("loginMember"); if (loginMember==null) {
                            response.sendRedirect("Login"); return; } %>

                            <!DOCTYPE html>
                            <html lang="th">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>ห้องของฉัน - ThanaChok Place</title>
                                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                                    rel="stylesheet">
                                <link
                                    href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
                                    rel="stylesheet">
                                <style>
                                    * {
                                        margin: 0;
                                        padding: 0;
                                        box-sizing: border-box;
                                    }

                                    :root {
                                        --bg: #FFFFFF;
                                        --muted-bg: #F0F7FF;
                                        --primary: #5CA9E9;
                                        --primary-dark: #4A90E2;
                                        --accent: #E3F2FD;
                                        --text: #1E3A5F;
                                        --muted-text: #5B7A9D;
                                        --card-border: #D1E8FF;
                                        --hover-bg: #E8F4FF;
                                        --success: #22C55E;
                                        --warning: #FFA500;
                                        --error: #EF4444;
                                    }

                                    body {
                                        font-family: 'Sarabun', system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
                                        background: var(--bg);
                                        min-height: 100vh;
                                        color: var(--text);
                                        position: relative;
                                        overflow-x: hidden;
                                    }

                                    /* Header */
                                    .header {
                                        background: var(--bg);
                                        padding: 18px 48px;
                                        display: flex;
                                        align-items: center;
                                        justify-content: space-between;
                                        border-bottom: 2px solid var(--accent);
                                        position: sticky;
                                        top: 0;
                                        z-index: 50;
                                        box-shadow: 0 2px 8px rgba(74, 144, 226, 0.08);
                                    }

                                    .header h1 {
                                        font-size: 2.5rem;
                                        color: var(--primary);
                                        font-weight: 700;
                                        display: flex;
                                        align-items: center;
                                        gap: 12px;
                                    }

                                    .nav-menu {
                                        display: flex;
                                        gap: 28px;
                                        align-items: center;
                                    }

                                    .nav-link {
                                        color: var(--muted-text);
                                        text-decoration: none;
                                        font-weight: 600;
                                        padding: 8px 12px;
                                        border-radius: 8px;
                                        transition: all 0.3s ease;
                                    }

                                    .nav-link.active {
                                        color: var(--primary);
                                        background: var(--accent);
                                    }

                                    .nav-link:hover {
                                        color: var(--primary);
                                        background: var(--hover-bg);
                                    }

                                    .user-section {
                                        display: flex;
                                        gap: 16px;
                                        align-items: center;
                                    }

                                    .user-info {
                                        display: flex;
                                        align-items: center;
                                        gap: 10px;
                                        color: var(--muted-text);
                                        font-weight: 600;
                                        padding: 10px 16px;
                                        background: var(--accent);
                                        border-radius: 10px;
                                    }

                                    .user-info i {
                                        color: var(--primary);
                                        font-size: 1.2rem;
                                    }

                                    .logout-btn {
                                        background: linear-gradient(135deg, #EF4444 0%, #DC2626 100%);
                                        color: white;
                                        border: none;
                                        padding: 10px 20px;
                                        border-radius: 10px;
                                        font-weight: 700;
                                        cursor: pointer;
                                        transition: all 0.3s ease;
                                        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
                                    }

                                    .logout-btn:hover {
                                        box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
                                        transform: translateY(-2px);
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
                                        background: var(--accent);
                                        border: 2px solid var(--card-border);
                                        color: var(--primary);
                                        text-decoration: none;
                                        border-radius: 10px;
                                        transition: all 0.3s ease;
                                        font-weight: 600;
                                    }

                                    .back-btn:hover {
                                        background: var(--hover-bg);
                                        transform: translateX(-5px);
                                        box-shadow: 0 4px 12px rgba(74, 144, 226, 0.2);
                                    }

                                    /* Welcome Section */
                                    .welcome-section {
                                        background: linear-gradient(135deg, var(--muted-bg) 0%, #E8F4FF 100%);
                                        padding: 25px 30px;
                                        border-radius: 15px;
                                        margin-bottom: 25px;
                                        border: 2px solid var(--card-border);
                                        box-shadow: 0 4px 16px rgba(74, 144, 226, 0.08);
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

                                    .welcome-section h3 {
                                        color: var(--primary);
                                        margin-bottom: 10px;
                                        font-size: 1.5rem;
                                        display: flex;
                                        align-items: center;
                                        gap: 10px;
                                        font-weight: 700;
                                    }

                                    .welcome-section p {
                                        color: var(--muted-text);
                                        font-size: 1rem;
                                        font-weight: 500;
                                    }

                                    /* Stats */
                                    .rental-stats {
                                        display: grid;
                                        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                                        gap: 20px;
                                        margin-bottom: 25px;
                                    }

                                    .stat-card {
                                        background: white;
                                        padding: 30px;
                                        border-radius: 15px;
                                        text-align: center;
                                        box-shadow: 0 4px 16px rgba(74, 144, 226, 0.08);
                                        transition: all 0.3s ease;
                                        border: 2px solid var(--card-border);
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
                                        box-shadow: 0 8px 24px rgba(74, 144, 226, 0.15);
                                    }

                                    .stat-card.active-rooms::before {
                                        background: linear-gradient(90deg, var(--success), #16A34A);
                                    }

                                    .stat-card.active-rooms .stat-number,
                                    .stat-card.active-rooms .stat-icon {
                                        color: var(--success);
                                    }

                                    .stat-card.pending-return::before {
                                        background: linear-gradient(90deg, var(--warning), #F57C00);
                                    }

                                    .stat-card.pending-return .stat-number,
                                    .stat-card.pending-return .stat-icon {
                                        color: var(--warning);
                                    }

                                    .stat-icon {
                                        font-size: 3rem;
                                        margin-bottom: 15px;
                                    }

                                    .stat-number {
                                        font-size: 3rem;
                                        font-weight: 700;
                                        margin-bottom: 10px;
                                    }

                                    .stat-label {
                                        color: var(--muted-text);
                                        font-size: 1.1rem;
                                        font-weight: 600;
                                    }

                                    /* Alerts */
                                    .alert {
                                        padding: 18px 25px;
                                        border-radius: 12px;
                                        margin-bottom: 25px;
                                        display: flex;
                                        align-items: center;
                                        gap: 12px;
                                        font-weight: 600;
                                        animation: slideIn 0.5s ease-out;
                                        box-shadow: 0 4px 12px rgba(74, 144, 226, 0.1);
                                    }

                                    .alert i {
                                        font-size: 1.3rem;
                                    }

                                    .alert-success {
                                        background: #D4F4DD;
                                        color: var(--success);
                                        border: 2px solid var(--success);
                                    }

                                    .alert-danger {
                                        background: #FFE4E6;
                                        color: var(--error);
                                        border: 2px solid var(--error);
                                    }

                                    .alert-info {
                                        background: var(--accent);
                                        color: var(--primary-dark);
                                        border: 2px solid var(--primary);
                                    }

                                    .alert-warning {
                                        background: #FFF3CD;
                                        color: #856404;
                                        border: 2px solid var(--warning);
                                    }

                                    /* Room Grid */
                                    .room-grid {
                                        display: grid;
                                        grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
                                        gap: 25px;
                                        margin-top: 25px;
                                    }

                                    .room-card {
                                        background: white;
                                        border-radius: 16px;
                                        overflow: hidden;
                                        border: 2px solid var(--card-border);
                                        transition: all 0.3s ease;
                                        animation: fadeInUp 0.6s ease-out;
                                        box-shadow: 0 8px 24px rgba(92, 169, 233, 0.12);
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
                                        transform: translateY(-8px);
                                        box-shadow: 0 12px 32px rgba(92, 169, 233, 0.2);
                                        border-color: var(--primary);
                                    }

                                    /* Room Header */
                                    .room-header {
                                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                                        padding: 20px;
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        color: white;
                                    }

                                    .room-number {
                                        font-size: 1.8rem;
                                        font-weight: bold;
                                    }

                                    .room-status {
                                        padding: 8px 16px;
                                        border-radius: 20px;
                                        font-weight: 700;
                                        font-size: 0.85rem;
                                        display: flex;
                                        align-items: center;
                                        gap: 6px;
                                        background: white;
                                    }

                                    .room-status.status-active {
                                        background: #D4F4DD;
                                        border: 2px solid var(--success);
                                        color: var(--success);
                                    }

                                    .room-status.status-pending-return {
                                        background: #FFF3CD;
                                        border: 2px solid var(--warning);
                                        color: #856404;
                                        animation: pulse 2s ease-in-out infinite;
                                    }

                                    @keyframes pulse {

                                        0%,
                                        100% {
                                            opacity: 1;
                                            transform: scale(1);
                                        }

                                        50% {
                                            opacity: 0.8;
                                            transform: scale(1.02);
                                        }
                                    }

                                    /* Room Body */
                                    .room-body {
                                        padding: 25px;
                                        background: white;
                                    }

                                    .room-info {
                                        margin-bottom: 20px;
                                    }

                                    .info-row {
                                        display: flex;
                                        justify-content: space-between;
                                        padding: 12px 0;
                                        border-bottom: 1px solid var(--accent);
                                    }

                                    .info-label {
                                        color: var(--muted-text);
                                        display: flex;
                                        align-items: center;
                                        gap: 8px;
                                        font-weight: 600;
                                    }

                                    .info-value {
                                        color: var(--text);
                                        font-weight: 700;
                                        text-align: right;
                                        max-width: 60%;
                                    }

                                    .price {
                                        color: var(--success);
                                        font-size: 1.2rem;
                                        font-weight: 700;
                                    }

                                    /* Room Actions */
                                    .room-actions {
                                        display: flex;
                                        gap: 12px;
                                        margin-top: 20px;
                                    }

                                    .btn {
                                        flex: 1;
                                        padding: 14px 28px;
                                        border: none;
                                        border-radius: 12px;
                                        cursor: pointer;
                                        font-weight: 700;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        gap: 10px;
                                        transition: all 0.3s ease;
                                        text-decoration: none;
                                        font-size: 1rem;
                                        position: relative;
                                        overflow: hidden;
                                    }

                                    .btn::before {
                                        content: '';
                                        position: absolute;
                                        top: 50%;
                                        left: 50%;
                                        width: 0;
                                        height: 0;
                                        border-radius: 50%;
                                        background: rgba(255, 255, 255, 0.3);
                                        transform: translate(-50%, -50%);
                                        transition: width 0.6s, height 0.6s;
                                    }

                                    .btn:hover::before {
                                        width: 300px;
                                        height: 300px;
                                    }

                                    .btn-return {
                                        background: linear-gradient(135deg, var(--error) 0%, #DC2626 100%);
                                        color: white;
                                        box-shadow: 0 4px 10px rgba(239, 68, 68, 0.3);
                                    }

                                    .btn-return:hover {
                                        transform: translateY(-2px);
                                        box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
                                    }

                                    .btn-disabled {
                                        background: #E5E7EB;
                                        color: #9CA3AF;
                                        cursor: not-allowed;
                                        opacity: 0.7;
                                    }

                                    .btn-disabled:hover {
                                        transform: none;
                                        box-shadow: none;
                                    }

                                    .btn-invoices {
                                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                                        color: white;
                                        box-shadow: 0 4px 10px rgba(74, 144, 226, 0.3);
                                    }

                                    .btn-invoices:hover {
                                        transform: translateY(-2px);
                                        box-shadow: 0 8px 20px rgba(74, 144, 226, 0.4);
                                    }

                                    .btn-pending {
                                        background: linear-gradient(135deg, var(--warning) 0%, #F97316 100%);
                                        color: white;
                                        cursor: not-allowed;
                                        box-shadow: 0 4px 10px rgba(255, 165, 0, 0.3);
                                        opacity: 0.7;
                                        animation: pulse 2s ease-in-out infinite;
                                    }

                                    /* No Room State */
                                    .no-room {
                                        text-align: center;
                                        padding: 80px 20px;
                                        background: white;
                                        border-radius: 16px;
                                        border: 2px solid var(--card-border);
                                        box-shadow: 0 8px 24px rgba(92, 169, 233, 0.12);
                                        animation: fadeIn 0.8s ease-out;
                                    }

                                    @keyframes fadeIn {
                                        from {
                                            opacity: 0;
                                        }

                                        to {
                                            opacity: 1;
                                        }
                                    }

                                    .no-room .no-room-icon {
                                        font-size: 5rem;
                                        color: var(--primary);
                                        margin-bottom: 25px;
                                        opacity: 0.6;
                                        animation: bounce 2s ease-in-out infinite;
                                    }

                                    @keyframes bounce {

                                        0%,
                                        100% {
                                            transform: translateY(0);
                                        }

                                        50% {
                                            transform: translateY(-10px);
                                        }
                                    }

                                    .no-room h3 {
                                        color: var(--primary);
                                        margin-bottom: 15px;
                                        font-size: 1.8rem;
                                        font-weight: 700;
                                    }

                                    .no-room p {
                                        color: var(--muted-text);
                                        font-size: 1.1rem;
                                        margin-bottom: 30px;
                                    }

                                    .no-room .cta-btn {
                                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                                        color: white;
                                        padding: 15px 30px;
                                        border-radius: 12px;
                                        text-decoration: none;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 10px;
                                        margin-top: 20px;
                                        font-weight: 700;
                                        transition: all 0.3s ease;
                                        box-shadow: 0 4px 15px rgba(74, 144, 226, 0.3);
                                    }

                                    .no-room .cta-btn:hover {
                                        transform: translateY(-2px);
                                        box-shadow: 0 8px 20px rgba(74, 144, 226, 0.4);
                                    }

                                    /* Loading */
                                    .loading {
                                        display: none;
                                        position: fixed;
                                        top: 0;
                                        left: 0;
                                        width: 100%;
                                        height: 100%;
                                        background: rgba(0, 0, 0, 0.7);
                                        backdrop-filter: blur(4px);
                                        z-index: 1000;
                                        justify-content: center;
                                        align-items: center;
                                    }

                                    .spinner {
                                        width: 60px;
                                        height: 60px;
                                        border: 6px solid rgba(92, 169, 233, 0.2);
                                        border-top: 6px solid var(--primary);
                                        border-radius: 50%;
                                        animation: spin 1s linear infinite;
                                    }

                                    @keyframes spin {
                                        0% {
                                            transform: rotate(0deg);
                                        }

                                        100% {
                                            transform: rotate(360deg);
                                        }
                                    }

                                    /* Toast */
                                    .toast {
                                        position: fixed;
                                        top: 20px;
                                        right: 20px;
                                        background: white;
                                        padding: 15px 20px;
                                        border-radius: 12px;
                                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                                        z-index: 1001;
                                        display: none;
                                        animation: slideInRight 0.3s ease;
                                        max-width: 400px;
                                        border: 2px solid var(--card-border);
                                        color: var(--text);
                                    }

                                    .toast.success {
                                        border-left: 4px solid var(--success);
                                    }

                                    .toast.error {
                                        border-left: 4px solid var(--error);
                                    }

                                    @keyframes slideInRight {
                                        from {
                                            transform: translateX(100%);
                                            opacity: 0;
                                        }

                                        to {
                                            transform: translateX(0);
                                            opacity: 1;
                                        }
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
                                <!-- Loading -->
                                <div class="loading" id="loading">
                                    <div class="spinner"></div>
                                </div>

                                <!-- Toast -->
                                <div id="toast" class="toast">
                                    <div id="toast-message"></div>
                                </div>

                                <!-- Header -->
                                <div class="header">
                                    <h1>
                                        <i class="fas fa-building"></i>
                                        ThanaChok Place
                                    </h1>

                                    <div class="nav-menu">
                                        <a href="Homesucess" class="nav-link"><i class="fas fa-home"></i> หน้าหลัก</a>
                                        <a href="YourRoom" class="nav-link active"><i class="fas fa-door-open"></i>
                                            ห้องของฉัน</a>
                                        <a href="Listinvoice" class="nav-link"><i class="fas fa-file-invoice"></i>
                                            บิลค่าใช้จ่าย</a>
                                        <a href="Record" class="nav-link"><i class="fas fa-history"></i>
                                            ประวัติการจอง</a>
                                    </div>

                                    <div class="user-section">
                                        <div class="user-info">
                                            <i class="fas fa-user-circle"></i>
                                            <span>${loginMember.firstName} ${loginMember.lastName}</span>
                                        </div>
                                        <form action="Logout" method="post" style="margin: 0;">
                                            <button type="submit" class="logout-btn">
                                                <i class="fas fa-sign-out-alt"></i>
                                                ออกจากระบบ
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <!-- Container -->
                                <div class="container">
                                    <!-- Welcome Section -->
                                    <div class="welcome-section">
                                        <h3>
                                            <i class="fas fa-door-open"></i>
                                            ห้องของฉัน
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
                                                    <c:if
                                                        test="${rental.status == 'เสร็จสมบูรณ์' || rental.status == 'ชำระแล้ว'}">
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
                                                    <strong>แจ้งเตือน!</strong> คุณมีคำขอคืนห้องที่กำลังรอ Manager
                                                    อนุมัติ
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
                                                                ห้อง ${rental.room.roomNumber}
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
                                                                    <span
                                                                        class="info-value">${rental.room.description}</span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <span class="info-label">
                                                                        <i class="fas fa-tag"></i> ประเภทห้อง
                                                                    </span>
                                                                    <span
                                                                        class="info-value">${rental.room.roomtype}</span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <span class="info-label">
                                                                        <i class="fas fa-money-bill-wave"></i>
                                                                        ค่าเช่า/เดือน
                                                                    </span>
                                                                    <span class="info-value price">
                                                                        ฿
                                                                        <fmt:formatNumber
                                                                            value="${rental.room.roomPrice}"
                                                                            groupingUsed="true" />
                                                                    </span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <span class="info-label">
                                                                        <i class="fas fa-calendar"></i> วันที่เริ่มเช่า
                                                                    </span>
                                                                    <span class="info-value">

                                                                        <fmt:formatDate value="${rental.rentDate}"
                                                                            pattern="yyyy" var="yearCE" />
                                                                        <c:set var="yearBE" value="${yearCE}" />
                                                                        <fmt:formatDate value="${rental.rentDate}"
                                                                            pattern="dd/MM/" />${yearBE}
                                                                    </span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <span class="info-label">
                                                                        <i class="fas fa-coins"></i> เงินมัดจำ
                                                                    </span>
                                                                    <span class="info-value" style="color: #00ff88;">
                                                                        ฿
                                                                        <fmt:formatNumber value="${rental.totalPrice}"
                                                                            groupingUsed="true" />
                                                                    </span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <span class="info-label">
                                                                        <i class="fas fa-flag"></i> สถานะ
                                                                    </span>
                                                                    <span class="info-value">
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${rental.status == 'รอคืนห้อง'}">
                                                                                <span style="color: #ffa726;">
                                                                                    <i class="fas fa-clock"></i> รอ
                                                                                    Manager อนุมัติ
                                                                                </span>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${rental.status == 'ชำระแล้ว'}">
                                                                                <span style="color: #00ff88;">
                                                                                    <i class="fas fa-check-circle"></i>
                                                                                    ชำระแล้ว
                                                                                </span>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${rental.status == 'เสร็จสมบูรณ์'}">
                                                                                <span style="color: #00ff88;">
                                                                                    <i class="fas fa-home"></i>
                                                                                    กำลังเช่าอยู่
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span style="color: #00ff88;">
                                                                                    <i class="fas fa-check-circle"></i>
                                                                                    ปกติ
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
                                                                            <i class="fas fa-hourglass-half"></i>
                                                                            รอการอนุมัติ
                                                                        </button>
                                                                    </c:when>
                                                                    <c:when test="${rental.status == 'ชำระแล้ว'}">
                                                                        <fmt:formatDate value="${rental.rentDate}"
                                                                            pattern="yyyy-MM-dd" var="rentDateISO" />
                                                                        <c:set var="unpaidMonths"
                                                                            value="${unpaidInvoicesByRent[rental.rentID]}" />
                                                                        <button class="btn btn-return"
                                                                            onclick="confirmReturnRoom(${rental.rentID}, '${rental.room.roomNumber}', '${fn:escapeXml(unpaidMonths)}', '${rentDateISO}')">
                                                                            <i class="fas fa-sign-out-alt"></i>
                                                                            ขอคืนห้อง
                                                                        </button>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <fmt:formatDate value="${rental.rentDate}"
                                                                            pattern="yyyy-MM-dd" var="rentDateISO" />
                                                                        <c:set var="unpaidMonths"
                                                                            value="${unpaidInvoicesByRent[rental.rentID]}" />
                                                                        <button class="btn btn-return"
                                                                            onclick="confirmReturnRoom(${rental.rentID}, '${rental.room.roomNumber}', '${fn:escapeXml(unpaidMonths)}', '${rentDateISO}')">
                                                                            <i class="fas fa-sign-out-alt"></i>
                                                                            ขอคืนห้อง
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
                                                    • <strong style="color: #00ff88;">กำลังเช่า</strong> -
                                                    ห้องที่คุณกำลังใช้งานอยู่ปกติ<br>
                                                    • <strong style="color: #ffa726;">รอคืนห้อง</strong> -
                                                    ส่งคำขอคืนห้องแล้ว รอ Manager ตรวจสอบและอนุมัติ<br>
                                                    • <strong>เงื่อนไขการคืนห้อง:</strong> ต้องอยู่ครบ 6 เดือน
                                                    และชำระค่าใช้จ่ายทั้งหมดให้ครบถ้วน<br>
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
                                    function confirmReturnRoom(rentId, roomNumber, unpaidMonths, rentDateISO) {
                                        // ตรวจสอบว่ามีบิลค้างชำระหรือไม่
                                        if (unpaidMonths && unpaidMonths.trim() !== '') {
                                            alert('ไม่สามารถส่งคำขอคืนห้องได้!\n\n' +
                                                'เนื่องจากมีบิลค้างชำระ: ' + unpaidMonths + '\n\n' +
                                                'กรุณาชำระบิลให้ครบถ้วนก่อนทำการคืนห้อง');
                                            return;
                                        }

                                        const rentDate = new Date(rentDateISO + 'T00:00:00');
                                        const today = new Date();

                                        // คำนวณจำนวนเดือนที่อยู่
                                        let monthsDiff = (today.getFullYear() - rentDate.getFullYear()) * 12 +
                                            (today.getMonth() - rentDate.getMonth());

                                        // ถ้าวันที่ปัจจุบันน้อยกว่าวันที่เริ่มเช่า
                                        if (today.getDate() < rentDate.getDate()) {
                                            monthsDiff--;
                                        }

                                        

                                        if (monthsDiff < 6) {
                                            const remainingMonths = 6 - monthsDiff;
                                            alert('ไม่สามารถส่งคำขอคืนห้องได้!\n\n' +
                                                  'เนื่องจากคุณต้องอยู่ครบ 6 เดือนก่อนจึงจะสามารถคืนห้องได้\n\n');
                                            return;
                                        }

                                        // ไม่มีบิลค้างชำระและอยู่ครบ 6 เดือนแล้ว - ถามยืนยันการคืนห้อง
                                        const confirmMessage = 'คุณต้องการคืนห้อง ' + roomNumber + ' ใช่หรือไม่?\n\n';


                                        if (confirm(confirmMessage)) {
                                            document.getElementById('loading').style.display = 'flex';
                                            window.location.href = 'ReturnRoom?rentId=' + rentId;
                                        }
                                    }

                                    // Create Particles
                                    function createParticles() {
                                        const particles = document.getElementById('particles');
                                        if (!particles) return; 

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
                                    window.addEventListener('load', function () {
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

                                        setTimeout(function () {
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
                                        btn.addEventListener('click', function () {
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