<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="jakarta.tags.core"%> <%@
taglib prefix="fmt" uri="jakarta.tags.fmt"%> <%@ taglib prefix="fn"
uri="jakarta.tags.functions"%> <%@ page session="true"%> <%@ page
import="com.springmvc.model.Member"%>
<fmt:setTimeZone value="Asia/Bangkok" scope="page"/> <% Member loginMember = (Member)
session.getAttribute("loginMember"); if (loginMember == null) {
response.sendRedirect("Login"); return; } %>

<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ประวัติการจอง - ThanaChok Place</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
        position: relative;
      }

      .nav-link.active {
        color: var(--primary);
        background: var(--accent);
      }

      .nav-link:hover {
        color: var(--primary);
        background: var(--hover-bg);
      }

      .nav-badge {
        background: var(--success);
        color: white;
        padding: 2px 8px;
        border-radius: 10px;
        font-size: 0.75rem;
        font-weight: 700;
        margin-left: 5px;
        position: absolute;
        top: 0;
        right: -10px;
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

      .container {
        max-width: 1400px;
        margin: 30px auto;
        padding: 0 20px;
        position: relative;
        z-index: 1;
      }

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

      /* Stats Grid */
      .rental-stats {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
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
        content: "";
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

      .stat-card.pending-approval::before {
        background: linear-gradient(90deg, var(--warning), #F57C00);
      }
      .stat-card.pending-approval .stat-number,
      .stat-card.pending-approval .stat-icon {
        color: var(--warning);
      }

      .stat-card.completed::before {
        background: linear-gradient(90deg, var(--primary), var(--primary-dark));
      }
      .stat-card.completed .stat-number,
      .stat-card.completed .stat-icon {
        color: var(--primary);
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

      /* Alert */
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

      /* Section */
      .section {
        margin-bottom: 40px;
      }

      .section-header {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        padding: 20px 25px;
        border-radius: 15px 15px 0 0;
        border: 2px solid var(--primary);
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 15px;
      }

      .section-header h2 {
        font-size: 1.5rem;
        color: white;
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 700;
      }

      .section-badge {
        background: white;
        color: var(--primary);
        padding: 8px 20px;
        border-radius: 20px;
        font-weight: 700;
        font-size: 1rem;
        border: 2px solid white;
      }

      /* Table */
      .table-container {
        background: white;
        border-radius: 0 0 15px 15px;
        overflow: hidden;
        box-shadow: 0 8px 24px rgba(92, 169, 233, 0.12);
        border: 2px solid var(--card-border);
        border-top: none;
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

      .record-table {
        width: 100%;
        border-collapse: collapse;
      }

      .record-table th {
        background: var(--accent);
        color: var(--primary);
        padding: 18px 15px;
        text-align: center;
        font-weight: 700;
        font-size: 0.95rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .record-table td {
        padding: 16px 15px;
        text-align: center;
        border-bottom: 1px solid var(--accent);
        color: var(--text);
        font-weight: 600;
      }

      .record-table tbody tr {
        transition: all 0.3s ease;
      }

      .record-table tbody tr:hover {
        background: var(--hover-bg);
        transform: scale(1.01);
      }

      /* Status Badge */
      .status-badge {
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 700;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .status-pending-approval {
        background: #FFF3CD;
        color: #856404;
        border: 2px solid var(--warning);
        box-shadow: 0 4px 10px rgba(255, 165, 0, 0.2);
      }

      .status-completed {
        background: var(--accent);
        color: var(--primary);
        border: 2px solid var(--primary);
        box-shadow: 0 4px 10px rgba(92, 169, 233, 0.2);
      }

      /* No Record */
      .no-record {
        text-align: center;
        padding: 80px 20px;
        color: var(--muted-text);
      }

      .no-record i {
        font-size: 4rem;
        margin-bottom: 20px;
        opacity: 0.6;
        color: var(--primary);
        animation: bounce 2s ease-in-out infinite;
      }

      @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
      }

      .no-record h4 {
        color: var(--primary);
        margin-bottom: 10px;
        font-size: 1.3rem;
        font-weight: 700;
      }

      .no-record p {
        color: var(--muted-text);
        font-weight: 500;
      }

      .price {
        font-weight: 700;
        color: var(--success);
        font-size: 1.1rem;
      }

      .room-number {
        font-weight: 700;
        color: var(--primary);
        font-size: 1.1rem;
      }

      .room-description {
        text-align: center;
        max-width: 200px;
        margin: 0 auto;
        color: var(--muted-text);
        font-size: 0.9rem;
        line-height: 1.4;
        font-weight: 500;
      }

      /* Action Button */
      .action-btn {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 10px 20px;
        border-radius: 10px;
        font-weight: 700;
        font-size: 0.9rem;
        transition: all 0.3s ease;
        text-decoration: none;
        border: none;
        cursor: pointer;
      }

      .btn-payment {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(74, 144, 226, 0.3);
      }

      .btn-payment:hover {
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

      @media (max-width: 768px) {
        .header {
          padding: 15px 20px;
        }

        .header h1 {
          font-size: 1.5rem;
        }

        .nav-menu {
          gap: 15px;
        }

        .nav-link {
          padding: 6px 10px;
          font-size: 0.85rem;
        }

        .user-section {
          flex-direction: column;
          gap: 10px;
        }

        .rental-stats {
          grid-template-columns: 1fr;
      }
    }
    </style>
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
        <a href="YourRoom" class="nav-link"><i class="fas fa-door-open"></i> ห้องของฉัน</a>
        <a href="Listinvoice" class="nav-link"><i class="fas fa-file-invoice"></i> บิลค่าใช้จ่าย</a>
        <a href="Record" class="nav-link active">
          <i class="fas fa-history"></i> ประวัติการจอง
          <c:if test="${approvedReservesCount > 0}">
            <span class="nav-badge">${approvedReservesCount}</span>
          </c:if>
        </a>
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
          <i class="fas fa-history"></i>
          ประวัติการจอง
        </h3>
        <p>ประวัติการจองห้องพัก การเช่า และการคืนห้องทั้งหมดของคุณ</p>
      </div>

      <!-- Stats -->
      <div class="rental-stats">
        <div class="stat-card" style="border: 1px solid rgba(255, 193, 7, 0.3);">
          <div class="stat-icon" style="color: #ffc107;"><i class="fas fa-clipboard-list"></i></div>
          <div class="stat-number" style="color: #ffc107;">${pendingReservesCount}</div>
          <div class="stat-label">รอการอนุมัติจอง</div>
        </div>

        <div class="stat-card" style="border: 1px solid rgba(0, 255, 136, 0.3);">
          <div class="stat-icon" style="color: #00ff88;"><i class="fas fa-check-circle"></i></div>
          <div class="stat-number" style="color: #00ff88;">${approvedReservesCount}</div>
          <div class="stat-label">จองได้รับการอนุมัติ</div>
        </div>

        <div class="stat-card" style="border: 1px solid rgba(66, 165, 245, 0.3);">
          <div class="stat-icon" style="color: #42a5f5;"><i class="fas fa-receipt"></i></div>
          <div class="stat-number" style="color: #42a5f5;">${paidReservesCount}</div>
          <div class="stat-label">ชำระค่ามัดจำแล้ว</div>
        </div>

        <div class="stat-card pending-approval">
          <div class="stat-icon"><i class="fas fa-clock"></i></div>
          <div class="stat-number">${pendingApprovalCount}</div>
          <div class="stat-label">รอการอนุมัติเช่า</div>
        </div>

        <div class="stat-card completed">
          <div class="stat-icon"><i class="fas fa-door-open"></i></div>
          <div class="stat-number">${returnedCount}</div>
          <div class="stat-label">คืนห้องแล้ว</div>
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
      <div class="alert alert-info">
        <i class="fas fa-info-circle"></i>
        <div>
          <strong>หมายเหตุ:</strong> หน้านี้แสดงประวัติการจองห้องพักและการเช่า
          สำหรับห้องที่กำลังเช่าอยู่ ให้ดูที่เมนู <strong>"ห้องของฉัน"</strong>
        </div>
      </div>

      <!-- Alert for approved reservations -->
      <c:if test="${approvedReservesCount > 0}">
      <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <div>
          <strong>แจ้งเตือน!</strong> คุณมีการจองที่ได้รับการอนุมัติแล้ว <strong>${approvedReservesCount}</strong> รายการ 
          กรุณาคลิกปุ่ม <strong>"จ่ายค่ามัดจำ"</strong> เพื่อยืนยันการเช่าห้อง
        </div>
      </div>
      </c:if>

      <!-- ==================== ส่วนการจอง (Reserve) ==================== -->
      
      <!-- 1. การจองรอการอนุมัติ -->
      <div class="section">
        <div class="section-header">
          <h2>
            <i class="fas fa-clock"></i>
            การจองที่รอการอนุมัติจาก Manager
          </h2>
          <span class="section-badge">${pendingReservesCount} รายการ</span>
        </div>
        <c:choose>
          <c:when test="${empty pendingReserves}">
            <div class="table-container">
              <div class="no-record">
                <i class="fas fa-clipboard-list"></i>
                <h4>ไม่มีการจองที่รอการอนุมัติ</h4>
                <p>คุณไม่มีคำขอจองที่รอ Manager อนุมัติในขณะนี้</p>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-container">
              <table class="record-table">
                <thead>
                  <tr>
                    <th><i class="fas fa-door-open"></i> หมายเลขห้อง</th>
                    <th><i class="fas fa-money-bill-wave"></i> ราคาห้อง</th>
                    <th><i class="fas fa-calendar-plus"></i> วันที่ขอจอง</th>
                    <th><i class="fas fa-calendar-check"></i> วันที่ต้องการเข้าพัก</th>
                    <th><i class="fas fa-tags"></i> สถานะ</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="reserve" items="${pendingReserves}">
                    <tr>
                      <td class="room-number">
                        <i class="fas fa-door-closed"></i>
                        ${reserve.room.roomNumber}
                      </td>
                      <td class="price">
                        <i class="fas fa-coins"></i>
                        <fmt:formatNumber
                          value="${reserve.room.roomPrice}"
                          type="currency"
                          currencySymbol="฿"
                          groupingUsed="true"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-alt"></i>
                        <fmt:formatDate
                          value="${reserve.reserveDate}"
                          pattern="dd/MM/yyyy HH:mm"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-check"></i>
                        <fmt:formatDate
                          value="${reserve.checkInDate}"
                          pattern="dd/MM/yyyy"
                        />
                      </td>
                      <td>
                        <span class="status-badge" style="background: linear-gradient(135deg, #ffc107, #ff9800); color: white;">
                          <i class="fas fa-hourglass-half"></i> รอการอนุมัติ
                        </span>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- 2. การจองที่ได้รับการอนุมัติ -->
      <div class="section">
        <div class="section-header">
          <h2>
            <i class="fas fa-check-circle"></i>
            การจองที่ Manager อนุมัติแล้ว
          </h2>
          <span class="section-badge">${approvedReservesCount} รายการ</span>
        </div>
        <c:choose>
          <c:when test="${empty approvedReserves}">
            <div class="table-container">
              <div class="no-record">
                <i class="fas fa-check-circle"></i>
                <h4>ไม่มีการจองที่ได้รับการอนุมัติ</h4>
                <p>เมื่อ Manager อนุมัติการจอง คุณสามารถจ่ายค่ามัดจำเพื่อยืนยันการเช่า</p>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-container">
              <table class="record-table">
                <thead>
                  <tr>
                    <th><i class="fas fa-door-open"></i> หมายเลขห้อง</th>
                    <th><i class="fas fa-money-bill-wave"></i> ราคาห้อง</th>
                    <th><i class="fas fa-calendar-plus"></i> วันที่ขอจอง</th>
                    <th><i class="fas fa-calendar-check"></i> วันที่ต้องการเข้าพัก</th>
                    <th><i class="fas fa-tags"></i> สถานะ</th>
                    <th><i class="fas fa-cogs"></i> การจัดการ</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="reserve" items="${approvedReserves}">
                    <tr>
                      <td class="room-number">
                        <i class="fas fa-door-closed"></i>
                        ${reserve.room.roomNumber}
                      </td>
                      <td class="price">
                        <i class="fas fa-coins"></i>
                        <fmt:formatNumber
                          value="${reserve.room.roomPrice}"
                          type="currency"
                          currencySymbol="฿"
                          groupingUsed="true"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-alt"></i>
                        <fmt:formatDate
                          value="${reserve.reserveDate}"
                          pattern="dd/MM/yyyy HH:mm"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-check"></i>
                        <fmt:formatDate
                          value="${reserve.checkInDate}"
                          pattern="dd/MM/yyyy"
                        />
                      </td>
                      <td>
                        <span class="status-badge" style="background: linear-gradient(135deg, #00ff88, #00cc6f); color: #000;">
                          <i class="fas fa-check-double"></i> อนุมัติแล้ว
                        </span>
                        <br><small style="color: #00ff88; margin-top: 5px; display: block;">
                          <i class="fas fa-info-circle"></i> พร้อมจ่ายค่ามัดจำ
                        </small>
                      </td>
                      <td>
                        <a href="Payment?id=${reserve.room.roomID}" 
                           class="action-btn btn-payment"
                           style="display: inline-flex; align-items: center; gap: 6px; padding: 10px 20px; 
                                  background: linear-gradient(135deg, #ff8c00, #ff6b00); color: white; 
                                  text-decoration: none; border-radius: 8px; font-weight: 600; 
                                  transition: all 0.3s ease; border: none; cursor: pointer;">
                          <i class="fas fa-credit-card"></i>
                          จ่ายค่ามัดจำ
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

      <!-- 3. การจองที่ถูกปฏิเสธ -->
      <c:if test="${not empty rejectedReserves}">
      <div class="section">
        <div class="section-header">
          <h2>
            <i class="fas fa-times-circle"></i>
            การจองที่ถูกปฏิเสธ
          </h2>
          <span class="section-badge">${rejectedReservesCount} รายการ</span>
        </div>
        <div class="table-container">
          <table class="record-table">
            <thead>
              <tr>
                <th><i class="fas fa-door-open"></i> หมายเลขห้อง</th>
                <th><i class="fas fa-money-bill-wave"></i> ราคาห้อง</th>
                <th><i class="fas fa-calendar-plus"></i> วันที่ขอจอง</th>
                <th><i class="fas fa-calendar-check"></i> วันที่ต้องการเข้าพัก</th>
                <th><i class="fas fa-tags"></i> สถานะ</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="reserve" items="${rejectedReserves}">
                <tr>
                  <td class="room-number">
                    <i class="fas fa-door-closed"></i>
                    ${reserve.room.roomNumber}
                  </td>
                  <td class="price">
                    <i class="fas fa-coins"></i>
                    <fmt:formatNumber
                      value="${reserve.room.roomPrice}"
                      type="currency"
                      currencySymbol="฿"
                      groupingUsed="true"
                    />
                  </td>
                  <td>
                    <i class="fas fa-calendar-alt"></i>
                    <fmt:formatDate
                      value="${reserve.reserveDate}"
                      pattern="dd/MM/yyyy HH:mm"
                    />
                  </td>
                  <td>
                    <i class="fas fa-calendar-check"></i>
                    <fmt:formatDate
                      value="${reserve.checkInDate}"
                      pattern="dd/MM/yyyy"
                    />
                  </td>
                  <td>
                    <span class="status-badge" style="background: linear-gradient(135deg, #ff4444, #cc0000); color: white;">
                      <i class="fas fa-ban"></i> ปฏิเสธ
                    </span>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
      </c:if>

      <!-- ==================== ส่วนการเช่า (Rent) ==================== -->

      <!-- 4. การจองที่ชำระค่ามัดจำแล้ว -->
      <c:if test="${not empty paidRents}">
      <div class="section">
        <div class="section-header">
          <h2>
            <i class="fas fa-receipt"></i>
            ชำระค่ามัดจำแล้ว
          </h2>
          <span class="section-badge">${paidReservesCount} รายการ</span>
        </div>
        <div class="table-container">
          <table class="record-table">
            <thead>
              <tr>
                <th><i class="fas fa-door-open"></i> หมายเลขห้อง</th>
                <th><i class="fas fa-money-bill-wave"></i> ค่ามัดจำ</th>
                <th><i class="fas fa-calendar"></i> วันที่ชำระ</th>
                <th><i class="fas fa-tags"></i> สถานะ</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="rent" items="${paidRents}">
                <tr>
                  <td class="room-number">
                    <i class="fas fa-door-closed"></i>
                    ${rent.room.roomNumber}
                  </td>
                  <td class="price">
                    <i class="fas fa-coins"></i>
                    <fmt:formatNumber
                      value="${rent.totalPrice}"
                      type="currency"
                      currencySymbol="฿"
                      groupingUsed="true"
                    />
                  </td>
                  <td>
                    <i class="fas fa-calendar-alt"></i>
                    <fmt:formatDate
                      value="${rent.rentDate}"
                      pattern="dd/MM/yyyy HH:mm"
                    />
                  </td>
                  <td>
                    <span class="status-badge" style="background: linear-gradient(135deg, #42a5f5, #1976d2); color: white;">
                      <i class="fas fa-check-circle"></i> ชำระแล้ว
                    </span>
                    <br><small style="color: #42a5f5; margin-top: 5px; display: block;">
                      <i class="fas fa-home"></i> กำลังเช่าอยู่
                    </small>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
      </c:if>

      <!-- 5. รอการอนุมัติค่ามัดจำ -->
      <div class="section">
        <div class="section-header">
          <h2>
            <i class="fas fa-hourglass-half"></i>
            ค่ามัดจำรอการอนุมัติ
          </h2>
          <span class="section-badge">${pendingApprovalCount} รายการ</span>
        </div>
        <c:choose>
          <c:when test="${empty pendingApproval}">
            <div class="table-container">
              <div class="no-record">
                <i class="fas fa-hourglass-half"></i>
                <h4>ไม่มีค่ามัดจำที่รอการอนุมัติ</h4>
                <p>ไม่มีการจ่ายค่ามัดจำที่รอ Manager อนุมัติในขณะนี้</p>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-container">
              <table class="record-table">
                <thead>
                  <tr>
                    <th><i class="fas fa-door-open"></i> หมายเลขห้อง</th>
                    <th><i class="fas fa-tag"></i> ประเภทห้อง</th>
                    <th><i class="fas fa-money-bill-wave"></i> ค่ามัดจำ</th>
                    <th><i class="fas fa-calendar"></i> วันที่จอง</th>
                    <th><i class="fas fa-tags"></i> สถานะ</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="rent" items="${pendingApproval}">
                    <tr>
                      <td class="room-number">
                        <i class="fas fa-door-closed"></i>
                        ${rent.room.roomNumber}
                      </td>
                      <td>
                        <span style="color: #9b59b6; font-weight: 500">
                          ${rent.room.roomtype}
                        </span>
                      </td>
                      <td class="price">
                        <i class="fas fa-coins"></i>
                        <fmt:formatNumber
                          value="${rent.totalPrice}"
                          type="currency"
                          currencySymbol="฿"
                          groupingUsed="true"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-alt"></i>
                        <fmt:formatDate
                          value="${rent.rentDate}"
                          pattern="dd/MM/yyyy"
                        />
                      </td>
                      <td>
                        <span class="status-badge status-pending-approval">
                          <i class="fas fa-clock"></i> รอการอนุมัติ
                        </span>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- 6. คืนห้องแล้ว -->
      <div class="section">
        <div class="section-header">
          <h2>
            <i class="fas fa-door-open"></i>
            ประวัติการเช่าที่คืนห้องแล้ว
          </h2>
          <span class="section-badge">${returnedCount} รายการ</span>
        </div>
        <c:choose>
          <c:when test="${empty returnedRentals}">
            <div class="table-container">
              <div class="no-record">
                <i class="fas fa-history"></i>
                <h4>ยังไม่มีประวัติการคืนห้อง</h4>
                <p>
                  ประวัติจะแสดงหลังจากคุณคืนห้องและได้รับการอนุมัติจาก Manager
                </p>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-container">
              <table class="record-table">
                <thead>
                  <tr>
                    <th><i class="fas fa-door-open"></i> หมายเลขห้อง</th>
                    <th><i class="fas fa-tag"></i> ประเภทห้อง</th>
                    <th><i class="fas fa-money-bill-wave"></i> ค่ามัดจำ</th>
                    <th><i class="fas fa-calendar-plus"></i> วันที่เช่า</th>
                    <th><i class="fas fa-calendar-check"></i> วันที่คืน</th>
                    <th><i class="fas fa-tags"></i> สถานะ</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="rent" items="${returnedRentals}">
                    <tr>
                      <td class="room-number">
                        <i class="fas fa-door-closed"></i>
                        ${rent.room.roomNumber}
                      </td>
                      <td>
                        <span style="color: #9b59b6; font-weight: 500">
                          ${rent.room.roomtype}
                        </span>
                      </td>
                      <td class="price">
                        <i class="fas fa-coins"></i>
                        <fmt:formatNumber
                          value="${rent.totalPrice}"
                          type="currency"
                          currencySymbol="฿"
                          groupingUsed="true"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-alt"></i>
                        <fmt:formatDate
                          value="${rent.rentDate}"
                          pattern="dd/MM/yyyy"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-check"></i>
                        <c:choose>
                          <c:when test="${not empty rent.returnDate}">
                            <fmt:formatDate
                              value="${rent.returnDate}"
                              pattern="dd/MM/yyyy"
                            />
                          </c:when>
                          <c:otherwise>
                            <span style="color: #999">-</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <span class="status-badge status-completed">
                          <i class="fas fa-check-double"></i> คืนห้องแล้ว
                        </span>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- Summary Info -->
      <c:if test="${not empty returnedRentals}">
        <div class="alert alert-success" style="margin-top: 25px">
          <i class="fas fa-clipboard-check"></i>
          <div>
            <strong>สรุป:</strong> คุณเคยเช่าห้องพักทั้งหมด
            <strong>${returnedCount}</strong> ห้อง
            และคืนห้องเรียบร้อยแล้วทั้งหมด
          </div>
        </div>
      </c:if>
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

      window.addEventListener('load', function() {

          <c:if test="${not empty message}">
              setTimeout(() => showToast("${message}", "success"), 500);
          </c:if>

          <c:if test="${not empty error}">
              setTimeout(() => showToast("${error}", "error"), 500);
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

      // Add animation to table rows
      const observer = new IntersectionObserver((entries) => {
          entries.forEach(entry => {
              if (entry.isIntersecting) {
                  entry.target.style.opacity = '1';
                  entry.target.style.transform = 'translateY(0)';
              }
          });
      }, { threshold: 0.1 });

      document.querySelectorAll('tbody tr').forEach(row => {
          row.style.opacity = '0';
          row.style.transform = 'translateY(20px)';
          row.style.transition = 'all 0.5s ease';
          observer.observe(row);
      });
    </script>
  </body>
</html>
