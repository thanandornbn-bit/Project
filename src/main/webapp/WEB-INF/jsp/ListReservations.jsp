<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
taglib prefix="fmt" uri="jakarta.tags.fmt" %> <%@ page session="true" %> <%@
page import="com.springmvc.model.Manager" %> <% Manager loginManager=(Manager)
session.getAttribute("loginManager"); if (loginManager==null) {
response.sendRedirect("Login"); return; } %>

<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>รายการจองห้องพัก - ThanaChok Place</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <style>
      :root {
        --bg: #ffffff;
        --muted-bg: #f0f7ff;
        --primary: #5ca9e9;
        --primary-dark: #4a90e2;
        --primary-light: #7bc4ff;
        --accent: #e3f2fd;
        --text: #1e3a5f;
        --text-light: #ffffff;
        --muted-text: #5b7a9d;
        --bg-secondary: #f8fcff;
        --border: #d1e8ff;
        --card-border: #d1e8ff;
        --hover-bg: #e8f4ff;
        --shadow: rgba(92, 169, 233, 0.15);
        --success: #4caf50;
        --warning: #ff9800;
        --danger: #f44336;
      }

      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Sarabun", sans-serif;
        background: #f5f7fa;
        min-height: 100vh;
        color: var(--text);
        line-height: 1.6;
      }

      .page-container {
        width: 100%;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
      }

      /* Header เหมือน OwnerHome */
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
        display: flex;
        align-items: center;
        gap: 8px;
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
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 10px;
        font-weight: 700;
        font-family: "Sarabun", sans-serif;
        cursor: pointer;
        transition: all 0.3s ease;
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
        color: var(--primary);
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 30px;
        display: flex;
        align-items: center;
        gap: 12px;
      }

      .cards-container {
        background: var(--bg);
        border-radius: 0;
        padding: 0;
        box-shadow: none;
        border: none;
      }

      .cards-header {
        background: linear-gradient(135deg, var(--muted-bg) 0%, #e8f4ff 100%);
        color: var(--text);
        padding: 32px 0;
        border-radius: 0;
        margin-bottom: 40px;
        border-bottom: 2px solid var(--accent);
      }

      .cards-header h2 {
        font-size: 2rem;
        font-weight: 700;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 12px;
        color: var(--primary);
      }

      .reservations-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
      }

      .reservation-card {
        background: white;
        border: 1px solid var(--border);
        border-radius: 10px;
        overflow: hidden;
        transition: all 0.3s ease;
        flex: 0 0 calc(20% - 16px);
        max-width: calc(20% - 16px);
        box-shadow: 0 2px 6px rgba(92, 169, 233, 0.08);
        aspect-ratio: 1 / 1;
        display: flex;
        flex-direction: column;
      }

      .reservation-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(92, 169, 233, 0.15);
        border-color: var(--primary);
      }

      .card-header {
        background: linear-gradient(
          135deg,
          var(--primary) 0%,
          var(--primary-dark) 100%
        );
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

      .card-body {
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

      .card-footer {
        padding: 10px;
        background: var(--muted-bg);
        border-top: 1px solid var(--accent);
        display: flex;
        gap: 6px;
        justify-content: center;
      }

      .empty-state {
        text-align: center;
        padding: 80px 20px;
        color: var(--muted-text);
      }

      .empty-state i {
        font-size: 5rem;
        color: var(--accent);
        margin-bottom: 24px;
      }

      .empty-state h3 {
        color: var(--primary);
        font-size: 1.8rem;
        font-weight: 700;
        margin-bottom: 12px;
      }

      .empty-state p {
        font-size: 1.1rem;
        color: var(--muted-text);
      }

      .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 4px 10px;
        border-radius: 12px;
        font-weight: 600;
        font-size: 0.75rem;
      }

      .status-pending {
        background: rgba(255, 193, 7, 0.1);
        color: var(--warning);
        border: 2px solid var(--warning);
      }

      .status-approved {
        background: rgba(76, 175, 80, 0.1);
        color: var(--success);
        border: 2px solid var(--success);
      }

      .status-rejected {
        background: rgba(244, 67, 54, 0.1);
        color: var(--danger);
        border: 2px solid var(--danger);
      }

      .action-btn {
        padding: 8px 12px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 0.75rem;
        font-weight: 600;
        font-family: "Sarabun", sans-serif;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        flex: 1;
        justify-content: center;
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
      }

      .btn-approve {
        background: linear-gradient(135deg, var(--success) 0%, #43a047 100%);
        color: white;
      }

      .btn-approve:hover {
        box-shadow: 0 6px 16px rgba(76, 175, 80, 0.3);
        transform: translateY(-2px);
      }

      .btn-reject {
        background: linear-gradient(135deg, var(--danger) 0%, #e53935 100%);
        color: white;
      }

      .btn-reject:hover {
        box-shadow: 0 6px 16px rgba(244, 67, 54, 0.3);
        transform: translateY(-2px);
      }

      .message {
        padding: 18px 25px;
        border-radius: 12px;
        margin-bottom: 25px;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 12px;
      }

      .message.success {
        background: rgba(76, 175, 80, 0.1);
        color: var(--success);
        border: 2px solid var(--success);
      }

      .message.error {
        background: rgba(244, 67, 54, 0.1);
        color: var(--danger);
        border: 2px solid var(--danger);
      }

      @media (max-width: 1400px) {
        .reservation-card {
          flex: 0 0 calc(25% - 15px);
          max-width: calc(25% - 15px);
        }
      }

      @media (max-width: 1100px) {
        .reservation-card {
          flex: 0 0 calc(33.333% - 14px);
          max-width: calc(33.333% - 14px);
        }
      }

      @media (max-width: 800px) {
        .reservation-card {
          flex: 0 0 calc(50% - 10px);
          max-width: calc(50% - 10px);
        }
      }

      @media (max-width: 500px) {
        .reservation-card {
          flex: 0 0 100%;
          max-width: 100%;
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
          gap: 10px;
        }

        .user-section {
          width: 100%;
          justify-content: center;
        }

        .container {
          padding: 24px 20px;
        }

        .cards-header {
          padding: 24px 0;
        }

        .card-footer {
          flex-direction: column;
        }

        .action-btn {
          width: 100%;
        }
      }
    </style>
  </head>

  <body>
    <div class="page-container">
      <!-- Header เหมือน OwnerHome -->
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
          <a href="ListReservations" class="nav-link active">
            <i class="fas fa-clipboard-list"></i> รายการจอง
          </a>
          <a href="ListReturnRoom" class="nav-link">
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
          <form action="Logout" method="post" style="display: inline">
            <button type="submit" class="logout-btn">
              <i class="fas fa-sign-out-alt"></i>
              ออกจากระบบ
            </button>
          </form>
        </div>
      </div>

      <div class="container">
        <c:if test="${not empty message}">
          <div class="message success">
            <i class="fas fa-check-circle"></i>
            ${message}
          </div>
        </c:if>

        <c:if test="${not empty error}">
          <div class="message error">
            <i class="fas fa-exclamation-circle"></i>
            ${error}
          </div>
        </c:if>

        <div class="cards-container">
          <div class="cards-header">
            <h2>
              <i class="fas fa-clipboard-list"></i>
              รายการจองทั้งหมด
            </h2>
          </div>

          <c:choose>
            <c:when test="${empty reserveList}">
              <div class="empty-state">
                <i class="fas fa-clipboard-list"></i>
                <h3>ไม่มีรายการจอง</h3>
                <p>ยังไม่มีการจองห้องพักในระบบ</p>
              </div>
            </c:when>
            <c:otherwise>
              <div class="reservations-grid">
                <c:forEach var="reserve" items="${reserveList}">
                  <div class="reservation-card">
                    <div class="card-header">
                      <div class="room-number">
                        ห้อง ${reserve.room.roomNumber}
                      </div>
                    </div>

                    <div class="card-body">
                      <div class="info-row">
                        <i class="fas fa-user"></i>
                        <span class="info-label">ผู้จอง:</span>
                        <span class="info-value">
                          ${reserve.member.firstName} ${reserve.member.lastName}
                        </span>
                      </div>

                      <div class="info-row">
                        <i class="fas fa-calendar-plus"></i>
                        <span class="info-label">วันที่จอง:</span>
                        <span class="info-value">
                          <fmt:formatDate
                            value="${reserve.reserveDate}"
                            pattern="dd/MM/yyyy HH:mm"
                          />
                        </span>
                      </div>

                      <div class="info-row">
                        <i class="fas fa-calendar-check"></i>
                        <span class="info-label">วันที่เข้าพัก:</span>
                        <span class="info-value">
                          <fmt:formatDate
                            value="${reserve.checkInDate}"
                            pattern="dd/MM/yyyy"
                          />
                        </span>
                      </div>

                      <div class="info-row">
                        <i class="fas fa-info-circle"></i>
                        <span class="info-label">สถานะ:</span>
                        <span class="info-value">
                          <c:choose>
                            <c:when test="${reserve.status == 'รอการอนุมัติ'}">
                              <span class="status-badge status-pending">
                                <i class="fas fa-clock"></i> รอการอนุมัติ
                              </span>
                            </c:when>
                            <c:when test="${reserve.status == 'อนุมัติแล้ว'}">
                              <span class="status-badge status-approved">
                                <i class="fas fa-check-circle"></i> อนุมัติแล้ว
                              </span>
                            </c:when>
                            <c:when test="${reserve.status == 'ชำระแล้ว'}">
                              <span class="status-badge status-approved">
                                <i class="fas fa-money-check-alt"></i> ชำระแล้ว
                              </span>
                            </c:when>
                            <c:when test="${reserve.status == 'เช่าอยู่'}">
                              <span class="status-badge status-approved">
                                <i class="fas fa-home"></i> เช่าอยู่
                              </span>
                            </c:when>
                            <c:otherwise>
                              <span class="status-badge status-rejected">
                                <i class="fas fa-times-circle"></i> ปฏิเสธ
                              </span>
                            </c:otherwise>
                          </c:choose>
                        </span>
                      </div>
                    </div>

                    <c:if test="${reserve.status == 'รอการอนุมัติ'}">
                      <div class="card-footer">
                        <form action="ApproveReservation" method="post">
                          <input
                            type="hidden"
                            name="reserveId"
                            value="${reserve.reserveId}"
                          />
                          <button type="submit" class="action-btn btn-approve">
                            <i class="fas fa-check"></i> อนุมัติ
                          </button>
                        </form>
                        <form action="RejectReservation" method="post">
                          <input
                            type="hidden"
                            name="reserveId"
                            value="${reserve.reserveId}"
                          />
                          <button type="submit" class="action-btn btn-reject">
                            <i class="fas fa-times"></i> ปฏิเสธ
                          </button>
                        </form>
                      </div>
                    </c:if>
                  </div>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </body>
</html>
