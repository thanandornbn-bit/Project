<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ page session="true" %>
                <%@ page import="com.springmvc.model.Manager" %>

                    <% Manager loginManager=(Manager) session.getAttribute("loginManager"); if (loginManager==null) {
                        response.sendRedirect("Login"); return; } %>

                        <!DOCTYPE html>
                        <html lang="th">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>รายการคำขอคืนห้อง - ThanaChok Place</title>
                            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                                rel="stylesheet">
                            <link
                                href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
                                rel="stylesheet">
                            <style>
                                :root {
                                    --bg: #FFFFFF;
                                    --muted-bg: #F0F7FF;
                                    --primary: #5CA9E9;
                                    --primary-dark: #4A90E2;
                                    --primary-light: #7BC4FF;
                                    --accent: #E3F2FD;
                                    --text: #1E3A5F;
                                    --text-light: #FFFFFF;
                                    --muted-text: #5B7A9D;
                                    --bg-secondary: #F8FCFF;
                                    --border: #D1E8FF;
                                    --card-border: #D1E8FF;
                                    --hover-bg: #E8F4FF;
                                    --shadow: rgba(92, 169, 233, 0.15);
                                    --success: #4CAF50;
                                    --warning: #FF9800;
                                    --danger: #F44336;
                                }

                                * {
                                    margin: 0;
                                    padding: 0;
                                    box-sizing: border-box;
                                }

                                body {
                                    font-family: 'Sarabun', sans-serif;
                                    background: #F5F7FA;
                                    min-height: 100vh;
                                    color: var(--text);
                                }

                                .page-container {
                                    width: 100%;
                                    min-height: 100vh;
                                    display: flex;
                                    flex-direction: column;
                                }

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
                                    font-family: 'Sarabun', sans-serif;
                                    cursor: pointer;
                                    transition: all 0.3s ease;
                                    display: flex;
                                    align-items: center;
                                    gap: 8px;
                                    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
                                }

                                .logout-btn:hover {
                                    box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
                                    transform: translateY(-2px);
                                }

                                .container {
                                    width: 100%;
                                    padding: 40px 48px;
                                    flex: 1;
                                }

                                .page-title {
                                    font-size: 2rem;
                                    font-weight: 700;
                                    margin-bottom: 30px;
                                    display: flex;
                                    align-items: center;
                                    gap: 12px;
                                    color: var(--primary);
                                }

                                .stat-card {
                                    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                                    padding: 30px;
                                    border-radius: 16px;
                                    text-align: center;
                                    margin-bottom: 30px;
                                    box-shadow: 0 8px 24px var(--shadow);
                                }

                                .stat-number {
                                    font-size: 3rem;
                                    font-weight: 700;
                                    color: white;
                                    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                }

                                .stat-label {
                                    color: rgba(255, 255, 255, 0.9);
                                    font-size: 1.1rem;
                                    margin-top: 10px;
                                    font-weight: 500;
                                }

                                .alert {
                                    padding: 18px 25px;
                                    border-radius: 12px;
                                    margin-bottom: 25px;
                                    display: flex;
                                    align-items: center;
                                    gap: 10px;
                                    font-weight: 500;
                                }

                                .alert-success {
                                    background: rgba(76, 175, 80, 0.1);
                                    color: var(--success);
                                    border: 2px solid var(--success);
                                }

                                .alert-danger {
                                    background: rgba(244, 67, 54, 0.1);
                                    color: var(--danger);
                                    border: 2px solid var(--danger);
                                }

                                .requests-grid {
                                    display: flex;
                                    flex-wrap: wrap;
                                    gap: 20px;
                                }

                                .request-card {
                                    background: white;
                                    border-radius: 12px;
                                    overflow: hidden;
                                    border: 1px solid var(--border);
                                    transition: all 0.3s ease;
                                    flex: 0 0 calc(20% - 16px);
                                    max-width: calc(20% - 16px);
                                    box-shadow: 0 2px 6px rgba(92, 169, 233, 0.08);
                                    aspect-ratio: 1 / 1;
                                    display: flex;
                                    flex-direction: column;
                                }

                                .request-card:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 6px 16px rgba(92, 169, 233, 0.15);
                                    border-color: var(--primary);
                                }

                                .request-header {
                                    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                                    padding: 14px;
                                    text-align: center;
                                    border-bottom: 2px solid var(--primary-dark);
                                }

                                .room-number {
                                    font-size: 1.8rem;
                                    font-weight: 700;
                                    color: white;
                                    margin: 0;
                                    text-shadow: 0 1px 3px rgba(0, 0, 0, 0.15);
                                }

                                .request-body {
                                    padding: 12px;
                                    background: var(--bg);
                                    flex: 1;
                                    display: flex;
                                    flex-direction: column;
                                    justify-content: space-between;
                                }

                                .info-row {
                                    display: flex;
                                    align-items: center;
                                    gap: 8px;
                                    padding: 6px 0;
                                    border-bottom: 1px solid var(--accent);
                                }

                                .info-row:last-of-type {
                                    border-bottom: none;
                                }

                                .info-row i {
                                    color: var(--primary);
                                    width: 16px;
                                    text-align: center;
                                    font-size: 0.85rem;
                                }

                                .info-label {
                                    font-weight: 600;
                                    color: var(--muted-text);
                                    min-width: 65px;
                                    font-size: 0.8rem;
                                }

                                .info-value {
                                    color: var(--text);
                                    font-weight: 500;
                                    flex: 1;
                                    font-size: 0.8rem;
                                }

                                .actions {
                                    padding: 10px;
                                    background: var(--muted-bg);
                                    border-top: 1px solid var(--accent);
                                    display: flex;
                                    gap: 6px;
                                    justify-content: center;
                                }

                                .btn {
                                    flex: 1;
                                    padding: 8px 12px;
                                    border: none;
                                    border-radius: 8px;
                                    cursor: pointer;
                                    font-size: 0.75rem;
                                    font-weight: 600;
                                    font-family: 'Sarabun', sans-serif;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    gap: 5px;
                                    transition: all 0.3s ease;
                                    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
                                }

                                .btn-approve {
                                    background: linear-gradient(135deg, var(--success) 0%, #43a047 100%);
                                    color: white;
                                }

                                .btn-approve:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 6px 16px rgba(76, 175, 80, 0.3);
                                }

                                .btn-reject {
                                    background: linear-gradient(135deg, var(--danger) 0%, #e53935 100%);
                                    color: white;
                                }

                                .btn-reject:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 6px 16px rgba(244, 67, 54, 0.3);
                                }

                                .no-requests {
                                    text-align: center;
                                    padding: 80px 20px;
                                    background: white;
                                    border-radius: 16px;
                                    border: 2px solid var(--border);
                                    box-shadow: 0 4px 12px rgba(92, 169, 233, 0.08);
                                }

                                .no-requests i {
                                    font-size: 5rem;
                                    color: var(--accent);
                                    margin-bottom: 25px;
                                }

                                .no-requests h3 {
                                    color: var(--primary);
                                    margin-bottom: 15px;
                                    font-size: 1.8rem;
                                    font-weight: 700;
                                }

                                .no-requests p {
                                    color: var(--muted-text);
                                    font-size: 1.1rem;
                                }

                                @media (max-width: 1400px) {
                                    .request-card {
                                        flex: 0 0 calc(25% - 15px);
                                        max-width: calc(25% - 15px);
                                    }
                                }

                                @media (max-width: 1100px) {
                                    .request-card {
                                        flex: 0 0 calc(33.333% - 14px);
                                        max-width: calc(33.333% - 14px);
                                    }
                                }

                                @media (max-width: 800px) {
                                    .request-card {
                                        flex: 0 0 calc(50% - 10px);
                                        max-width: calc(50% - 10px);
                                    }
                                }

                                @media (max-width: 768px) {
                                    .header {
                                        padding: 15px 20px;
                                        flex-direction: column;
                                        gap: 15px;
                                    }

                                    .header h1 {
                                        font-size: 1.8rem;
                                    }

                                    .nav-menu {
                                        width: 100%;
                                        justify-content: center;
                                        flex-wrap: wrap;
                                    }

                                    .user-section {
                                        width: 100%;
                                        justify-content: center;
                                    }

                                    .container {
                                        padding: 20px;
                                    }

                                    .stat-number {
                                        font-size: 2.5rem;
                                    }
                                }

                                @media (max-width: 500px) {
                                    .request-card {
                                        flex: 0 0 100%;
                                        max-width: 100%;
                                    }
                                }
                            </style>
                        </head>

                        <body>
                            <div class="page-container">
                                <!-- Header -->
                                <div class="header">
                                    <h1>
                                        <i class="fas fa-building"></i>
                                        ThanaChok Place
                                    </h1>
                                    <nav class="nav-menu">
                                        <a href="OwnerHome" class="nav-link">
                                            <i class="fas fa-home"></i> หน้าหลัก
                                        </a>
                                        <a href="OViewReserve" class="nav-link">
                                            <i class="fas fa-list"></i> รายการเช่า
                                        </a>
                                        <a href="ListReservations" class="nav-link">
                                            <i class="fas fa-clipboard-list"></i> รายการจอง
                                        </a>
                                        <a href="ListReturnRoom" class="nav-link active">
                                            <i class="fas fa-clipboard-check"></i> คำขอคืนห้อง
                                        </a>
                                        <a href="AddRoom" class="nav-link">
                                            <i class="fas fa-plus"></i> เพิ่มห้อง
                                        </a>
                                    </nav>
                                    <div class="user-section">
                                        <div class="user-info">
                                            <i class="fas fa-user-circle"></i>
                                            <span>Manager@gmail.com</span>
                                        </div>
                                        <form action="Logout" method="post" style="display: inline;">
                                            <button type="submit" class="logout-btn">
                                                <i class="fas fa-sign-out-alt"></i> ออกจากระบบ
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <div class="container">
                                    <h2 class="page-title">
                                        <i class="fas fa-clipboard-check"></i>
                                        รายการคำขอคืนห้อง
                                    </h2>
                                    <div class="stat-card">
                                        <div class="stat-number">${requestCount}</div>
                                        <div class="stat-label">คำขอรอการอนุมัติ</div>
                                    </div>

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

                                    <c:choose>
                                        <c:when test="${empty returnRequests}">
                                            <div class="no-requests">
                                                <i class="fas fa-clipboard-check"></i>
                                                <h3>ไม่มีคำขอคืนห้อง</h3>
                                                <p>ไม่มีคำขอคืนห้องที่รอการอนุมัติในขณะนี้</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="requests-grid">
                                                <c:forEach var="request" items="${returnRequests}">
                                                    <div class="request-card">
                                                        <div class="request-header">
                                                            <div class="room-number">
                                                                ห้อง ${request.room.roomNumber}
                                                            </div>
                                                        </div>
                                                        <div class="request-body">
                                                            <div>
                                                                <div class="info-row">
                                                                    <i class="fas fa-user"></i>
                                                                    <span class="info-label">ผู้เช่า:</span>
                                                                    <span class="info-value">
                                                                        ${request.member.firstName}
                                                                    </span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <i class="fas fa-phone"></i>
                                                                    <span class="info-label">เบอร์:</span>
                                                                    <span class="info-value">
                                                                        ${request.member.phoneNumber}
                                                                    </span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <i class="fas fa-home"></i>
                                                                    <span class="info-label">ประเภท:</span>
                                                                    <span class="info-value">
                                                                        ${request.room.roomtype}
                                                                    </span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <i class="fas fa-calendar"></i>
                                                                    <span class="info-label">วันที่เช่า:</span>
                                                                    <span class="info-value">
                                                                        <fmt:formatDate value="${request.rentDate}"
                                                                            pattern="dd/MM/yyyy" />
                                                                    </span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <i class="fas fa-calendar-check"></i>
                                                                    <span class="info-label">ขอคืนเมื่อ:</span>
                                                                    <span class="info-value"
                                                                        style="color: var(--warning); font-weight: 600;">
                                                                        <fmt:formatDate value="${request.returnDate}"
                                                                            pattern="dd/MM/yyyy HH:mm" />
                                                                    </span>
                                                                </div>
                                                                <div class="info-row">
                                                                    <i class="fas fa-money-bill-wave"></i>
                                                                    <span class="info-label">มัดจำ:</span>
                                                                    <span class="info-value"
                                                                        style="color: var(--success); font-weight: 700;">
                                                                        ฿
                                                                        <fmt:formatNumber value="${request.totalPrice}"
                                                                            groupingUsed="true" />
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="actions">
                                                            <form action="ApproveReturnRoom" method="post"
                                                                style="flex: 1;">
                                                                <input type="hidden" name="rentId"
                                                                    value="${request.rentID}">
                                                                <input type="hidden" name="roomNumber"
                                                                    value="${request.room.roomNumber}">
                                                                <button type="submit" class="btn btn-approve"
                                                                    onclick="return confirm('ยืนยันการอนุมัติคืนห้อง ${request.room.roomNumber}?')">
                                                                    <i class="fas fa-check"></i> อนุมัติ
                                                                </button>
                                                            </form>
                                                            <form action="RejectReturnRoom" method="post"
                                                                style="flex: 1;">
                                                                <input type="hidden" name="rentId"
                                                                    value="${request.rentID}">
                                                                <input type="hidden" name="roomNumber"
                                                                    value="${request.room.roomNumber}">
                                                                <button type="submit" class="btn btn-reject"
                                                                    onclick="return confirm('ยืนยันการปฏิเสธคำขอคืนห้อง ${request.room.roomNumber}?')">
                                                                    <i class="fas fa-times"></i> ปฏิเสธ
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </body>

                        </html>