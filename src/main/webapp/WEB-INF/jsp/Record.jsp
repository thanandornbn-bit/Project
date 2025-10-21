<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="jakarta.tags.core"%> <%@
taglib prefix="fmt" uri="jakarta.tags.fmt"%> <%@ taglib prefix="fn"
uri="jakarta.tags.functions"%> <%@ page session="true"%> <%@ page
import="com.springmvc.model.Member"%> <% Member loginMember = (Member)
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
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(
          135deg,
          #1a1a1a 0%,
          #2d2d2d 50%,
          #1a1a1a 100%
        );
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
        background: rgba(155, 89, 182, 0.1);
        border-radius: 50%;
        animation: float 6s ease-in-out infinite;
        box-shadow: 0 0 30px rgba(155, 89, 182, 0.2);
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
        0%,
        100% {
          transform: translateY(0px) rotate(0deg);
        }
        50% {
          transform: translateY(-20px) rotate(180deg);
        }
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

      .page-header {
        background: linear-gradient(135deg, #ff8c00, #ff8c00);
        color: white;
        text-align: center;
        padding: 30px 20px;
        position: relative;
        z-index: 10;
        box-shadow: 0 4px 20px rgba(168, 92, 40, 0.3);
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
        0%,
        100% {
          text-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
        }
        50% {
          text-shadow: 0 0 30px rgba(0, 0, 0, 0.5),
            0 0 40px rgba(255, 255, 255, 0.3);
        }
      }

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
        background: linear-gradient(135deg, #ff8c00, #ff8c00);
        color: white;
      }

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
      }

      .back-btn:hover {
        background: rgba(255, 140, 0, 0.2);
        transform: translateX(-5px);
      }

      .welcome-section {
        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
        padding: 25px;
        border-radius: 15px;
        margin-bottom: 25px;
        border: 1px solid rgba(158, 71, 0, 0.466);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
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

      /* Stats Grid */
      .rental-stats {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
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
        border: 1px solid rgba(167, 120, 76, 0.3);
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
        box-shadow: 0 12px 40px rgba(167, 120, 76, 0.3);
      }

      .stat-card.pending-approval::before {
        background: linear-gradient(90deg, #ffa726, #f57c00);
      }
      .stat-card.pending-approval .stat-number,
      .stat-card.pending-approval .stat-icon {
        color: #ffa726;
      }

      .stat-card.completed::before {
        background: linear-gradient(90deg, #ff8c00, #ff8c00);
      }
      .stat-card.completed .stat-number,
      .stat-card.completed .stat-icon {
        color: #ff8c00;
      }

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

      /* Alert */
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

      .alert i {
        font-size: 1.2rem;
      }

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
        background: linear-gradient(135deg, #b67321, #fd8b00);
        color: white;
        border: 1px solid rgba(180, 128, 78, 0.5);
      }

      /* Section */
      .section {
        margin-bottom: 40px;
      }

      .section-header {
        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
        padding: 20px 25px;
        border-radius: 15px 15px 0 0;
        border: 1px solid rgba(255, 115, 0, 0.3);
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 15px;
      }

      .section-header h2 {
        font-size: 1.5rem;
        color: #ff8c00;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .section-badge {
        background: rgba(255, 123, 0, 0.274);
        color: #ff8c00;
        padding: 8px 20px;
        border-radius: 20px;
        font-weight: bold;
        font-size: 1rem;
        border: 1px solid rgba(255, 94, 0, 0.4);
      }

      /* Table */
      .table-container {
        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
        border-radius: 0 0 15px 15px;
        overflow: hidden;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 136, 0, 0.3);
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
        background: rgba(255, 115, 0, 0.192);
        color: #ff8c00;
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
        border-bottom: 1px solid rgba(255, 123, 0, 0.233);
        color: #ccc;
      }

      .record-table tbody tr {
        transition: all 0.3s ease;
      }

      .record-table tbody tr:hover {
        background: rgba(255, 123, 0, 0.219);
        transform: scale(1.01);
      }

      /* Status Badge */
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

      .status-pending-approval {
        background: linear-gradient(135deg, #ffa726, #f57c00);
        color: white;
        box-shadow: 0 4px 10px rgba(255, 167, 38, 0.3);
      }

      .status-completed {
        background: linear-gradient(135deg, #a16b27, #ff8c00);
        color: white;
        box-shadow: 0 4px 10px rgba(255, 102, 0, 0.3);
      }

      /* No Record */
      .no-record {
        text-align: center;
        padding: 60px 20px;
        color: #999;
      }

      .no-record i {
        font-size: 3rem;
        margin-bottom: 15px;
        opacity: 0.5;
        color: #ff8c00;
      }

      .no-record h4 {
        color: #ff8c00;
        margin-bottom: 10px;
        font-size: 1.2rem;
      }

      .no-record p {
        color: #666;
      }

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
        text-align: center;
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
        border: 6px solid rgba(236, 95, 0, 0.3);
        border-top: 6px solid #ff8c00;
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
        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
        padding: 15px 20px;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
        z-index: 1001;
        display: none;
        animation: slideInRight 0.3s ease;
        max-width: 400px;
        border: 1px solid rgba(255, 102, 0, 0.3);
        color: white;
      }

      .toast.success {
        border-left: 4px solid #00ff88;
      }
      .toast.error {
        border-left: 4px solid #ff4444;
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
        .rental-stats {
          grid-template-columns: 1fr;
        }

        .record-table {
          font-size: 0.85rem;
        }

        .record-table th,
        .record-table td {
          padding: 12px 8px;
        }

        .section-header {
          flex-direction: column;
          align-items: flex-start;
        }

        .page-header h1 {
          font-size: 1.5rem;
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
        <i class="fas fa-history"></i>
        ประวัติการจองห้องพัก
      </h1>
    </div>

    <!-- Navigation -->
    <div class="nav">
      <a href="Homesucess"><i class="fas fa-home"></i> หน้าหลัก</a>
      <a href="YourRoom"><i class="fas fa-door-open"></i> ห้องของฉัน</a>
      <a href="Listinvoice"
        ><i class="fas fa-file-invoice"></i> บิลค่าใช้จ่าย</a
      >
      <a href="Record" class="active"
        ><i class="fas fa-history"></i> ประวัติการจอง</a
      >
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
        <p>ประวัติการจองและการคืนห้อง</p>
      </div>

      <!-- Stats -->
      <div class="rental-stats">
        <div class="stat-card pending-approval">
          <div class="stat-icon"><i class="fas fa-clock"></i></div>
          <div class="stat-number">${pendingApprovalCount}</div>
          <div class="stat-label">การจองรอการอนุมัติ</div>
        </div>

        <div class="stat-card completed">
          <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
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
          <strong>หมายเหตุ:</strong> หน้านี้แสดงประวัติการจองและการคืนห้อง
          สำหรับห้องที่กำลังเช่าอยู่ ให้ดูที่เมนู <strong>"ห้องของฉัน"</strong>
        </div>
      </div>

      <!-- 1. รอการอนุมัติ -->
      <div class="section">
        <div class="section-header">
          <h2>
            <i class="fas fa-clock"></i>
            การจองที่รอการอนุมัติ
          </h2>
          <span class="section-badge">${pendingApprovalCount} รายการ</span>
        </div>
        <c:choose>
          <c:when test="${empty pendingApproval}">
            <div class="table-container">
              <div class="no-record">
                <i class="fas fa-clock"></i>
                <h4>ไม่มีการจองที่รอการอนุมัติ</h4>
                <p>ไม่มีการจองใหม่ที่รอ Manager อนุมัติในขณะนี้</p>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-container">
              <table class="record-table">
                <thead>
                  <tr>
                    <th><i class="fas fa-door-open"></i> หมายเลขห้อง</th>
                    <th><i class="fas fa-info-circle"></i> รายละเอียด</th>
                    <th><i class="fas fa-tag"></i> ประเภทห้อง</th>
                    <th><i class="fas fa-money-bill-wave"></i> ค่ามัดจำ</th>
                    <th><i class="fas fa-calendar"></i> วันที่จอง</th>
                    <th><i class="fas fa-tags"></i> สถานะ</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="rental" items="${pendingApproval}">
                    <tr>
                      <td class="room-number">
                        <i class="fas fa-door-closed"></i>
                        ${rental.rent.room.roomNumber}
                      </td>
                      <td>
                        <div class="room-description">
                          ${rental.rent.room.description}
                        </div>
                      </td>
                      <td>
                        <span style="color: #9b59b6; font-weight: 500">
                          ${rental.rent.room.roomtype}
                        </span>
                      </td>
                      <td class="price">
                        <i class="fas fa-coins"></i>
                        <fmt:formatNumber
                          value="${rental.totalPrice}"
                          type="currency"
                          currencySymbol="฿"
                          groupingUsed="true"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-alt"></i>
                        <fmt:formatDate
                          value="${rental.paymentDate}"
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

      <!-- 2. คืนห้องแล้ว -->
      <div class="section">
        <div class="section-header">
          <h2>
            <i class="fas fa-check-circle"></i>
            ประวัติที่คืนห้องแล้ว
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
                    <th><i class="fas fa-info-circle"></i> รายละเอียด</th>
                    <th><i class="fas fa-tag"></i> ประเภทห้อง</th>
                    <th><i class="fas fa-money-bill-wave"></i> ค่ามัดจำ</th>
                    <th><i class="fas fa-calendar-plus"></i> วันที่เช่า</th>
                    <th><i class="fas fa-calendar-check"></i> วันที่คืน</th>
                    <th><i class="fas fa-tags"></i> สถานะ</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="rental" items="${returnedRentals}">
                    <tr>
                      <td class="room-number">
                        <i class="fas fa-door-closed"></i>
                        ${rental.rent.room.roomNumber}
                      </td>
                      <td>
                        <div class="room-description">
                          ${rental.rent.room.description}
                        </div>
                      </td>
                      <td>
                        <span style="color: #9b59b6; font-weight: 500">
                          ${rental.rent.room.roomtype}
                        </span>
                      </td>
                      <td class="price">
                        <i class="fas fa-coins"></i>
                        <fmt:formatNumber
                          value="${rental.totalPrice}"
                          type="currency"
                          currencySymbol="฿"
                          groupingUsed="true"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-alt"></i>
                        <fmt:formatDate
                          value="${rental.paymentDate}"
                          pattern="dd/MM/yyyy"
                        />
                      </td>
                      <td>
                        <i class="fas fa-calendar-check"></i>
                        <c:choose>
                          <c:when test="${not empty rental.rent.returnDate}">
                            <fmt:formatDate
                              value="${rental.rent.returnDate}"
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
