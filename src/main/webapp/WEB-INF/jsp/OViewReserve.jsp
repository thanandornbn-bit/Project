<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <%@ page session="true" %>
        <%@ page import="com.springmvc.model.Manager" %>
          <%@ page import="java.util.*" %>
            <% Manager loginManager=(Manager) session.getAttribute("loginManager"); if (loginManager==null) {
              response.sendRedirect("Login"); return; } %>

              <!DOCTYPE html>
              <html lang="th">

              <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>จัดการการจอง - ThanaChok Place</title>
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                  rel="stylesheet" />
                <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
                  rel="stylesheet" />
                <style>
                  :root {
                    --bg: #ffffff;
                    --text: #2c3e50;
                    --primary: #5ca9e9;
                    --primary-dark: #4a8ac7;
                    --muted-bg: #f0f7ff;
                    --accent: #e3f2fd;
                    --success: #4caf50;
                    --warning: #ffc107;
                    --danger: #f44336;
                    --card-border: #d1e8ff;
                    --hover-bg: #e8f4ff;
                  }

                  * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                  }

                  body {
                    font-family: "Sarabun", sans-serif;
                    background: var(--bg);
                    min-height: 100vh;
                    color: var(--text);
                    line-height: 1.6;
                  }

                  .page-container {
                    display: flex;
                    flex-direction: column;
                    min-height: 100vh;
                  }

                  /* Header Styles */
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
                    gap: 8px;
                    align-items: center;
                  }

                  .nav-link {
                    color: #7a8b99;
                    text-decoration: none;
                    padding: 10px 20px;
                    border-radius: 8px;
                    font-weight: 500;
                    font-size: 0.95rem;
                    transition: all 0.3s ease;
                    display: flex;
                    align-items: center;
                    gap: 8px;
                  }

                  .nav-link:hover {
                    background: var(--hover-bg);
                    color: var(--primary);
                  }

                  .nav-link.active {
                    background: var(--primary);
                    color: white;
                  }

                  /* User Section - ปรับแต่งตามรูปภาพ */
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

                  /* ปุ่มแก้ไขข้อมูล - สีฟ้าตามรูป */
                  .btn-edit-profile {
                    background: linear-gradient(135deg, #5CA9E9, #4A90E2);
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    border-radius: 25px;
                    font-weight: 600;
                    cursor: pointer;
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    transition: all 0.3s ease;
                    font-family: "Sarabun", sans-serif;
                    font-size: 0.95rem;
                    text-decoration: none;
                    box-shadow: 0 2px 8px rgba(92, 169, 233, 0.3);
                  }

                  .btn-edit-profile:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(92, 169, 233, 0.4);
                    background: linear-gradient(135deg, #4A90E2, #357ABD);
                  }

                  /* ปุ่มออกจากระบบ - สีแดงตามรูป */
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
                    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
                  }

                  .logout-btn:hover {
                    box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
                    transform: translateY(-2px);
                  }

                  .container {
                    width: 100%;
                    padding: 24px 28px;
                    flex: 1;
                  }

                  .stats-container {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 20px;
                    margin-bottom: 28px;
                  }

                  .stat-card {
                    background: white;
                    padding: 24px;
                    border-radius: 12px;
                    border: 1px solid var(--card-border);
                    box-shadow: 0 2px 8px rgba(92, 169, 233, 0.08);
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 12px;
                    transition: all 0.3s ease;
                  }

                  .stat-card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 4px 12px rgba(92, 169, 233, 0.15);
                  }

                  .stat-icon {
                    font-size: 2.5rem;
                    color: var(--primary);
                  }

                  .stat-number {
                    font-size: 2.5rem;
                    font-weight: 700;
                    color: var(--primary);
                  }

                  .stat-label {
                    font-size: 0.95rem;
                    color: #7a8b99;
                    font-weight: 500;
                    text-align: center;
                  }

                  .reservations-container {
                    margin-bottom: 28px;
                  }

                  .reservations-header {
                    background: linear-gradient(135deg,
                        var(--primary),
                        var(--primary-dark));
                    color: white;
                    padding: 20px 28px;
                    border-radius: 12px 12px 0 0;
                    margin-bottom: 24px;
                  }

                  .reservations-header h2 {
                    font-size: 1.5rem;
                    font-weight: 600;
                    margin: 0;
                    display: flex;
                    align-items: center;
                    gap: 12px;
                  }

                  .section-label {
                    background: var(--muted-bg);
                    padding: 12px 20px;
                    border-left: 4px solid;
                    font-weight: 600;
                    font-size: 1.05rem;
                    margin-bottom: 20px;
                    border-radius: 4px;
                  }

                  .label-pending {
                    border-left-color: var(--warning);
                    color: var(--warning);
                  }

                  .label-approved {
                    border-left-color: var(--success);
                    color: var(--success);
                  }

                  .label-returned {
                    border-left-color: var(--primary);
                    color: var(--primary);
                  }

                  .rooms-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                    gap: 20px;
                    margin-bottom: 32px;
                  }

                  .room-card {
                    background: white;
                    border-radius: 12px;
                    border: 1px solid var(--card-border);
                    overflow: hidden;
                    transition: all 0.3s ease;
                    box-shadow: 0 2px 8px rgba(92, 169, 233, 0.08);
                  }

                  .room-card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 8px 16px rgba(92, 169, 233, 0.15);
                  }

                  .room-card-header {
                    background: linear-gradient(135deg,
                        var(--primary),
                        var(--primary-dark));
                    padding: 24px;
                    text-align: center;
                    position: relative;
                  }

                  .room-number {
                    font-size: 3rem;
                    font-weight: 700;
                    color: white;
                    margin: 0;
                    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                  }

                  .room-type {
                    color: rgba(255, 255, 255, 0.9);
                    font-size: 0.95rem;
                    margin-top: 4px;
                  }

                  .room-card-body {
                    padding: 20px;
                  }

                  .room-info-row {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    padding: 10px 0;
                    border-bottom: 1px solid #f0f0f0;
                  }

                  .room-info-row:last-child {
                    border-bottom: none;
                  }

                  .room-info-row i {
                    color: var(--primary);
                    width: 20px;
                    text-align: center;
                  }

                  .room-info-label {
                    font-weight: 500;
                    color: #7a8b99;
                    min-width: 80px;
                  }

                  .room-info-value {
                    color: var(--text);
                    font-weight: 500;
                  }

                  .price {
                    color: var(--success);
                    font-weight: 600;
                    font-size: 1.1rem;
                  }

                  .room-card-footer {
                    padding: 16px 20px;
                    background: var(--muted-bg);
                    display: flex;
                    flex-direction: column;
                    gap: 8px;
                  }

                  .status-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    padding: 6px 14px;
                    border-radius: 20px;
                    font-weight: 600;
                    font-size: 0.875rem;
                    white-space: nowrap;
                  }

                  .status-pending {
                    background: #fff3e0;
                    color: var(--warning);
                    border: 1px solid var(--warning);
                  }

                  .status-approved {
                    background: #e8f5e9;
                    color: var(--success);
                    border: 1px solid var(--success);
                  }

                  .status-returned {
                    background: #e3f2fd;
                    color: var(--primary);
                    border: 1px solid var(--primary);
                  }

                  .status-waiting {
                    background: #f5f5f5;
                    color: #7a8b99;
                    border: 1px solid #bdbdbd;
                  }

                  .action-buttons {
                    display: flex;
                    gap: 8px;
                    flex-wrap: wrap;
                  }

                  .action-btn {
                    padding: 10px 18px;
                    border: none;
                    border-radius: 8px;
                    cursor: pointer;
                    font-size: 0.9rem;
                    font-weight: 600;
                    transition: all 0.3s ease;
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    white-space: nowrap;
                    font-family: "Sarabun", sans-serif;
                  }

                  .btn-view {
                    background: var(--primary);
                    color: white;
                  }

                  .btn-view:hover {
                    background: var(--primary-dark);
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(92, 169, 233, 0.3);
                  }

                  .btn-approve {
                    background: var(--success);
                    color: white;
                  }

                  .btn-approve:hover {
                    background: #45a049;
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
                  }

                  .btn-add-invoice {
                    background: var(--warning);
                    color: white;
                  }

                  .btn-add-invoice:hover {
                    background: #ffa000;
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(255, 193, 7, 0.3);
                  }

                  .btn-return {
                    background: var(--danger);
                    color: white;
                  }

                  .btn-return:hover {
                    background: #d32f2f;
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
                  }

                  .btn-disabled {
                    background: #e0e0e0;
                    color: #9e9e9e;
                    cursor: not-allowed;
                    opacity: 0.6;
                  }

                  .empty-state {
                    text-align: center;
                    padding: 60px 20px;
                    color: #7a8b99;
                  }

                  .empty-icon {
                    font-size: 4rem;
                    color: var(--primary);
                    opacity: 0.3;
                    margin-bottom: 20px;
                  }

                  .empty-state h3 {
                    color: var(--text);
                    margin-bottom: 10px;
                    font-size: 1.5rem;
                    font-weight: 600;
                  }

                  .loading {
                    display: none;
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(255, 255, 255, 0.95);
                    z-index: 999;
                    justify-content: center;
                    align-items: center;
                  }

                  .spinner {
                    width: 60px;
                    height: 60px;
                    border: 5px solid var(--muted-bg);
                    border-top: 5px solid var(--primary);
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

                  .toast {
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    background: white;
                    padding: 16px 20px;
                    border-radius: 8px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                    z-index: 1001;
                    display: none;
                    animation: slideInRight 0.3s ease;
                    color: var(--text);
                    max-width: 400px;
                    border: 1px solid var(--card-border);
                  }

                  .toast.success {
                    border-left: 4px solid var(--success);
                  }

                  .toast.error {
                    border-left: 4px solid var(--danger);
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
                    .container {
                      padding: 15px;
                    }

                    .header {
                      flex-direction: column;
                      gap: 15px;
                      padding: 15px 20px;
                    }

                    .header h1 {
                      font-size: 2rem;
                    }

                    .nav-menu {
                      flex-wrap: wrap;
                      justify-content: center;
                    }

                    .stats-container {
                      grid-template-columns: 1fr;
                    }

                    table {
                      font-size: 0.9rem;
                    }

                    th,
                    td {
                      padding: 12px 8px;
                    }

                    .action-buttons {
                      flex-direction: column;
                    }

                    .action-btn {
                      width: 100%;
                      justify-content: center;
                    }
                  }


                  .btn-edit-profile {
                    background: linear-gradient(135deg, #5CA9E9, #4A90E2);
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    border-radius: 10px;
                    font-weight: 600;
                    cursor: pointer;
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    transition: all 0.3s ease;
                    font-family: "Sarabun", sans-serif;
                    font-size: 0.95rem;
                    text-decoration: none;
                    box-shadow: 0 2px 8px rgba(92, 169, 233, 0.3);
                  }

                  .btn-edit-profile:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(92, 169, 233, 0.4);
                    background: linear-gradient(135deg, #4A90E2, #357ABD);
                  }
                </style>
              </head>

              <body>
                <div class="loading" id="loading">
                  <div class="spinner"></div>
                </div>

                <div id="toast" class="toast">
                  <div id="toast-message"></div>
                </div>

                <div class="page-container">
                  <div class="header">
                    <h1>
                      <i class="fas fa-building"></i>
                      ThanaChok Place
                    </h1>
                    <div class="nav-menu">
                      <a href="OwnerHome" class="nav-link">
                        <i class="fas fa-home"></i> หน้าหลัก
                      </a>
                      <a href="OViewReserve" class="nav-link active">
                        <i class="fas fa-list"></i> รายการเช่า
                      </a>
                      <a href="ListReservations" class="nav-link">
                        <i class="fas fa-clipboard-list"></i> รายการจอง
                      </a>
                      <a href="ListReturnRoom" class="nav-link">
                        <i class="fas fa-clipboard-check"></i> คำขอคืนห้อง
                      </a>
                      <a href="ManageUtilityRates" class="nav-link">
                        <i class="fas fa-cogs"></i> ตั้งค่าหน่วย
                      </a>
                      <a href="AddRoom" class="nav-link">
                        <i class="fas fa-plus"></i> เพิ่มห้อง
                      </a>
                    </div>
                    <div class="user-section">
                      <div class="user-info">
                        <i class="fas fa-user-circle"></i>
                        <span>${loginManager.email}</span>
                      </div>
                      <a href="EditManager" class="btn-edit-profile" style="margin-left:10px;">
                        <i class="fas fa-user-edit"></i> แก้ไขข้อมูล
                      </a>
                      <form action="Logout" method="post" style="display: inline">
                        <button type="submit" class="logout-btn">
                          <i class="fas fa-sign-out-alt"></i>
                          ออกจากระบบ
                        </button>
                      </form>
                    </div>
                  </div>

                  <div class="container">
                    <div class="stats-container">
                      <div class="stat-card stat-total">
                        <div class="stat-icon">
                          <i class="fas fa-clipboard-list"></i>
                        </div>
                        <div class="stat-number">
                          <c:set var="totalReservations" value="${rentList.size()}" />
                          ${totalReservations}
                        </div>
                        <div class="stat-label">การจองทั้งหมด</div>
                      </div>

                      <div class="stat-card stat-pending">
                        <div class="stat-icon">
                          <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-number">
                          <c:set var="pendingCount" value="0" />
                          <c:forEach var="rent" items="${rentList}">
                            <c:if test="${rent.status == 'รออนุมัติ'}">
                              <c:set var="pendingCount" value="${pendingCount + 1}" />
                            </c:if>
                          </c:forEach>
                          ${pendingCount}
                        </div>
                        <div class="stat-label">รออนุมัติ</div>
                      </div>

                      <div class="stat-card" style="border-color: #42a5f5">
                        <div class="stat-icon" style="color: #42a5f5">
                          <i class="fas fa-check-double"></i>
                        </div>
                        <div class="stat-number" style="color: #42a5f5">
                          <c:set var="paidCount" value="0" />
                          <c:forEach var="rent" items="${rentList}">
                            <c:if test="${rent.status == 'ชำระแล้ว'}">
                              <c:set var="paidCount" value="${paidCount + 1}" />
                            </c:if>
                          </c:forEach>
                          ${paidCount}
                        </div>
                        <div class="stat-label">ชำระแล้ว</div>
                      </div>

                      <div class="stat-card stat-approved">
                        <div class="stat-icon">
                          <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-number">
                          <c:set var="approvedCount" value="0" />
                          <c:forEach var="rent" items="${rentList}">
                            <c:if test="${rent.status == 'เสร็จสมบูรณ์' || rent.status == 'รอคืนห้อง'}">
                              <c:set var="approvedCount" value="${approvedCount + 1}" />
                            </c:if>
                          </c:forEach>
                          ${approvedCount}
                        </div>
                        <div class="stat-label">เช่าอยู่ / รอคืนห้อง</div>
                      </div>

                      <div class="stat-card stat-returned">
                        <div class="stat-icon">
                          <i class="fas fa-home"></i>
                        </div>
                        <div class="stat-number">
                          <c:set var="returnedCount" value="0" />
                          <c:forEach var="rent" items="${rentList}">
                            <c:if test="${rent.status == 'คืนห้องแล้ว'}">
                              <c:set var="returnedCount" value="${returnedCount + 1}" />
                            </c:if>
                          </c:forEach>
                          ${returnedCount}
                        </div>
                        <div class="stat-label">คืนห้องแล้ว</div>
                      </div>
                    </div>

                    <div class="reservations-container">
                      <div class="reservations-header">
                        <h2>
                          <i class="fas fa-list-alt"></i>
                          รายการการจองทั้งหมด
                        </h2>
                      </div>

                      <c:choose>
                        <c:when test="${empty rentList}">
                          <div class="empty-state">
                            <div class="empty-icon">
                              <i class="fas fa-clipboard-list"></i>
                            </div>
                            <h3>ไม่มีรายการจอง</h3>
                            <p>ยังไม่มีการจองห้องพักในระบบ</p>
                          </div>
                        </c:when>
                        <c:otherwise>
                          <c:set var="hasWaiting" value="false" />
                          <c:set var="hasPending" value="false" />
                          <c:set var="hasApproved" value="false" />
                          <c:set var="hasReturned" value="false" />

                          <c:forEach var="rent" items="${rentList}">
                            <c:if test="${rent.status == 'รออนุมัติ'}">
                              <c:set var="hasWaiting" value="true" />
                            </c:if>
                            <c:if test="${rent.status == 'ชำระแล้ว'}">
                              <c:set var="hasPending" value="true" />
                            </c:if>
                            <c:if test="${rent.status == 'เสร็จสมบูรณ์' || rent.status == 'รอคืนห้อง'}">
                              <c:set var="hasApproved" value="true" />
                            </c:if>
                            <c:if test="${rent.status == 'คืนห้องแล้ว'}">
                              <c:set var="hasReturned" value="true" />
                            </c:if>
                          </c:forEach>

                          <c:if test="${hasWaiting}">
                            <div class="section-label label-pending">
                              <i class="fas fa-clock"></i>
                              รออนุมัติ (${pendingCount} รายการ)
                            </div>
                            <div class="rooms-grid">
                              <c:forEach var="rent" items="${rentList}">
                                <c:if test="${rent.status == 'รออนุมัติ'}">
                                  <div class="room-card">
                                    <div class="room-card-header">
                                      <div class="room-number">${rent.room.roomNumber}</div>
                                      <div class="room-type">${rent.room.roomtype}</div>
                                    </div>
                                    <div class="room-card-body">
                                      <div class="room-info-row">
                                        <i class="fas fa-user"></i>
                                        <span class="room-info-label">ผู้เช่า:</span>
                                        <span class="room-info-value">${rent.member.firstName}
                                          ${rent.member.lastName}</span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-money-bill-wave"></i>
                                        <span class="room-info-label">ราคา:</span>
                                        <span class="price">฿${rent.room.roomPrice}</span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span class="room-info-label">วันที่เช่า:</span>
                                        <span class="room-info-value">
                                          <fmt:formatDate value="${rent.rentDate}" pattern="dd/MM/yyyy" />
                                        </span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-flag"></i>
                                        <span class="room-info-label">สถานะ:</span>
                                        <span class="status-badge status-pending">
                                          <i class="fas fa-clock"></i> รออนุมัติ
                                        </span>
                                      </div>
                                    </div>
                                    <div class="room-card-footer">
                                      <form action="ViewReservationDetail" method="get" style="width: 100%">
                                        <input type="hidden" name="rentId" value="${rent.rentID}" />
                                        <button type="submit" class="action-btn btn-view"
                                          style="width: 100%; justify-content: center">
                                          <i class="fas fa-eye"></i>
                                          ดูรายละเอียด
                                        </button>
                                      </form>
                                    </div>
                                  </div>
                                </c:if>
                              </c:forEach>
                            </div>
                          </c:if>

                          <c:if test="${hasPending}">
                            <div class="section-label" style="border-left-color: #42a5f5; color: #42a5f5">
                              <i class="fas fa-check-circle"></i>
                              ชำระแล้ว (${paidCount} รายการ)
                            </div>
                            <div class="rooms-grid">
                              <c:forEach var="rent" items="${rentList}">
                                <c:if test="${rent.status == 'ชำระแล้ว'}">
                                  <div class="room-card">
                                    <div class="room-card-header">
                                      <div class="room-number">${rent.room.roomNumber}</div>
                                      <div class="room-type">${rent.room.roomtype}</div>
                                    </div>
                                    <div class="room-card-body">
                                      <div class="room-info-row">
                                        <i class="fas fa-user"></i>
                                        <span class="room-info-label">ผู้เช่า:</span>
                                        <span class="room-info-value">${rent.member.firstName}
                                          ${rent.member.lastName}</span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-money-bill-wave"></i>
                                        <span class="room-info-label">ราคา:</span>
                                        <span class="price">฿${rent.room.roomPrice}</span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span class="room-info-label">วันที่เช่า:</span>
                                        <span class="room-info-value">
                                          <fmt:formatDate value="${rent.rentDate}" pattern="dd/MM/yyyy" />
                                        </span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-flag"></i>
                                        <span class="room-info-label">สถานะ:</span>
                                        <span class="status-badge" style="
                                background: rgba(66, 165, 245, 0.2);
                                color: #42a5f5;
                                border: 2px solid #42a5f5;
                              ">
                                          <i class="fas fa-check-circle"></i> ชำระแล้ว
                                        </span>
                                      </div>
                                    </div>
                                    <div class="room-card-footer">
                                      <form action="ViewReservationDetail" method="get" style="width: 100%">
                                        <input type="hidden" name="rentId" value="${rent.rentID}" />
                                        <button type="submit" class="action-btn btn-view"
                                          style="width: 100%; justify-content: center">
                                          <i class="fas fa-eye"></i>
                                          ดูรายละเอียด
                                        </button>
                                      </form>
                                    </div>
                                  </div>
                                </c:if>
                              </c:forEach>
                            </div>
                          </c:if>
                          <c:if test="${hasApproved}">
                            <div class="section-label label-approved">
                              <i class="fas fa-home"></i>
                              เช่าอยู่ / รอคืนห้อง (${approvedCount} รายการ)
                            </div>
                            <div class="rooms-grid">
                              <c:forEach var="rent" items="${rentList}">
                                <c:if test="${rent.status == 'เสร็จสมบูรณ์' || rent.status == 'รอคืนห้อง'}">
                                  <div class="room-card">
                                    <div class="room-card-header">
                                      <div class="room-number">${rent.room.roomNumber}</div>
                                      <div class="room-type">${rent.room.roomtype}</div>
                                    </div>
                                    <div class="room-card-body">
                                      <div class="room-info-row">
                                        <i class="fas fa-user"></i>
                                        <span class="room-info-label">ผู้เช่า:</span>
                                        <span class="room-info-value">${rent.member.firstName}
                                          ${rent.member.lastName}</span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-money-bill-wave"></i>
                                        <span class="room-info-label">ราคา:</span>
                                        <span class="price">฿${rent.room.roomPrice}</span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span class="room-info-label">วันที่เช่า:</span>
                                        <span class="room-info-value">
                                          <fmt:formatDate value="${rent.rentDate}" pattern="dd/MM/yyyy" />
                                        </span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-flag"></i>
                                        <span class="room-info-label">สถานะ:</span>
                                        <c:choose>
                                          <c:when test="${rent.status == 'เสร็จสมบูรณ์'}">
                                            <span class="status-badge status-approved">
                                              <i class="fas fa-check-circle"></i>
                                              เสร็จสมบูรณ์
                                            </span>
                                          </c:when>
                                          <c:when test="${rent.status == 'รอคืนห้อง'}">
                                            <span class="status-badge status-waiting">
                                              <i class="fas fa-hourglass-half"></i>
                                              รอคืนห้อง
                                            </span>
                                          </c:when>
                                        </c:choose>
                                      </div>
                                    </div>
                                    <div class="room-card-footer">
                                      <form action="ViewReservationDetail" method="get" style="margin-bottom: 8px">
                                        <input type="hidden" name="rentId" value="${rent.rentID}" />
                                        <button type="submit" class="action-btn btn-view"
                                          style="width: 100%; justify-content: center">
                                          <i class="fas fa-eye"></i>
                                          ดูรายละเอียด
                                        </button>
                                      </form>
                                      <c:if
                                        test="${rent.room.roomStatus == 'ไม่ว่าง' && (rent.status == 'เสร็จสมบูรณ์' || rent.status == 'ชำระแล้ว')}">
                                        <a href="ManagerAddInvoice?roomID=${rent.room.roomID}"
                                          class="action-btn btn-add-invoice" style="
                                width: 100%;
                                justify-content: center;
                                margin-bottom: 8px;
                              ">
                                          <i class="fas fa-plus-circle"></i>
                                          เพิ่มบิล
                                        </a>
                                      </c:if>
                                      <c:if test="${rent.status == 'เสร็จสมบูรณ์'}">
                                        <form action="ManagerReturnRoom" method="post">
                                          <input type="hidden" name="rentId" value="${rent.rentID}" />
                                          <input type="hidden" name="roomNumber" value="${rent.room.roomNumber}" />
                                          <input type="hidden" name="status" value="เสร็จสมบูรณ์" />
                                          <button type="submit" class="action-btn btn-return"
                                            onclick="return confirmReturn('${rent.room.roomNumber}', '${rent.member.firstName} ${rent.member.lastName}', 'เสร็จสมบูรณ์')"
                                            style="width: 100%; justify-content: center">
                                            <i class="fas fa-door-open"></i>
                                            คืนห้อง
                                          </button>
                                        </form>
                                      </c:if>
                                    </div>
                                  </div>
                                </c:if>
                              </c:forEach>
                            </div>
                          </c:if>

                          <c:if test="${hasReturned}">
                            <div class="section-label label-returned">
                              <i class="fas fa-home"></i>
                              คืนห้องแล้ว (${returnedCount} รายการ)
                            </div>
                            <div class="rooms-grid">
                              <c:forEach var="rent" items="${rentList}">
                                <c:if test="${rent.status == 'คืนห้องแล้ว'}">
                                  <div class="room-card">
                                    <div class="room-card-header">
                                      <div class="room-number">${rent.room.roomNumber}</div>
                                      <div class="room-type">${rent.room.roomtype}</div>
                                    </div>
                                    <div class="room-card-body">
                                      <div class="room-info-row">
                                        <i class="fas fa-user"></i>
                                        <span class="room-info-label">ผู้เช่า:</span>
                                        <span class="room-info-value">${rent.member.firstName}
                                          ${rent.member.lastName}</span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-money-bill-wave"></i>
                                        <span class="room-info-label">ราคา:</span>
                                        <span class="price">฿${rent.room.roomPrice}</span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span class="room-info-label">วันที่เช่า:</span>
                                        <span class="room-info-value">
                                          <fmt:formatDate value="${rent.rentDate}" pattern="dd/MM/yyyy" />
                                        </span>
                                      </div>
                                      <div class="room-info-row">
                                        <i class="fas fa-flag"></i>
                                        <span class="room-info-label">สถานะ:</span>
                                        <span class="status-badge status-returned">
                                          <i class="fas fa-home"></i> คืนห้องแล้ว
                                        </span>
                                      </div>
                                    </div>
                                    <div class="room-card-footer">
                                      <form action="ViewReservationDetail" method="get" style="width: 100%">
                                        <input type="hidden" name="rentId" value="${rent.rentID}" />
                                        <button type="submit" class="action-btn btn-view"
                                          style="width: 100%; justify-content: center">
                                          <i class="fas fa-eye"></i>
                                          ดูรายละเอียด
                                        </button>
                                      </form>
                                    </div>
                                  </div>
                                </c:if>
                              </c:forEach>
                            </div>
                          </c:if>
                        </c:otherwise>
                      </c:choose>
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
                  function confirmApproval(roomNumber, memberName) {
                    const message = `คุณต้องการอนุมัติการจองห้อง ${roomNumber}\nของคุณ ${memberName} ใช่หรือไม่?`;

                    return confirm(message);
                  }

                  function showLoading() {
                    document.getElementById('loading').style.display = 'flex';
                  }

                  function hideLoading() {
                    document.getElementById('loading').style.display = 'none';
                  }

                  document.querySelectorAll('form').forEach(form => {
                    form.addEventListener('submit', function (e) {
                      if (form.action.includes('ManagerReturnRoom')) {
                        const roomNumber = form.querySelector('input[name="roomNumber"]').value;
                        const status = form.querySelector('input[name="status"]').value;
                        if (!confirmReturn(roomNumber, '', status)) {
                          e.preventDefault();
                          return;
                        }
                      }
                      showLoading();
                    });
                  });


                  window.addEventListener('load', function () {
                    setTimeout(() => {
                      document.getElementById('loading').style.display = 'none';
                    }, 1000);

                    document.body.style.opacity = '0';
                    document.body.style.transition = 'opacity 0.5s ease-in-out';

                    setTimeout(function () {
                      document.body.style.opacity = '1';
                    }, 100);
                  });

                  const currentPath = window.location.pathname;
                  const navLinks = document.querySelectorAll('.nav a');

                  navLinks.forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === 'OViewReserve' &&
                      currentPath.includes('OViewReserve')) {
                      link.classList.add('active');
                    }
                  });

                  document.querySelectorAll('tbody tr').forEach(row => {
                    if (!row.querySelector('.section-label')) {
                      row.addEventListener('mouseenter', function () {
                        this.style.transform = 'scale(1.02)';
                      });

                      row.addEventListener('mouseleave', function () {
                        this.style.transform = 'scale(1)';
                      });
                    }
                  });

                  setInterval(() => {
                    if (document.visibilityState === 'visible') {
                      window.location.reload();
                    }
                  }, 120000);

                  window.addEventListener('online', function () {
                    showToast('เชื่อมต่อ อินเทอร์เน็ตแล้ว', 'success');
                  });

                  window.addEventListener('offline', function () {
                    showToast('ไม่มีการเชื่อมต่ออินเทอร์เน็ต', 'error');
                  });

                  <c:if test="${not empty message}">
                      setTimeout(() => {
                          showToast("${message}", "success");
                      }, 500);
                  </c:if>

                  <c:if test="${not empty error}">
                      setTimeout(() => {
                          showToast("${error}", "error");
                      }, 500);
                  </c:if>

                  function confirmReturn(roomNumber, memberName, status) {
                    let message = '';

                    if (status === 'รอดำเนินการ') {
                      message = `คุณต้องการยกเลิกการจองห้อง ${roomNumber}\n` +
                        `ของคุณ ${memberName} ใช่หรือไม่?`;
                    } else {
                      message = `⚠️ คุณต้องการคืนห้อง ${roomNumber}\n` +
                        `ของคุณ ${memberName} ใช่หรือไม่?`;
                    }

                    return confirm(message);
                  }
                </script>
              </body>

              </html>