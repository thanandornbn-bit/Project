<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
taglib prefix="fmt" uri="jakarta.tags.fmt" %> <%@ page session="true" %> <%@
page import="com.springmvc.model.Manager" %> <% Manager loginManager = (Manager)
session.getAttribute("loginManager"); if (loginManager == null) {
response.sendRedirect("Login"); return; } %>

<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>จัดการหน่วยค่าน้ำ-ค่าไฟ - ThanaChok Place</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
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
        background: var(--bg);
        color: var(--text);
        line-height: 1.6;
        min-height: 100vh;
      }

      .page-container {
        width: 100%;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
      }

      /* Header Styles - เหมือน OwnerHome */
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
        font-size: 0.95rem;
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
        font-size: 0.95rem;
      }

      .user-info i {
        color: var(--primary);
        font-size: 1.2rem;
      }

      /* ปุ่มแก้ไขข้อมูล - สีฟ้า */
      .btn-edit-profile {
        background: linear-gradient(135deg, #5ca9e9, #4a90e2);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 10px;
        font-weight: 700;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
        font-family: "Sarabun", sans-serif;
        font-size: 0.95rem;
        text-decoration: none;
        box-shadow: 0 4px 12px rgba(92, 169, 233, 0.3);
      }

      .btn-edit-profile:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(92, 169, 233, 0.4);
        background: linear-gradient(135deg, #4a90e2, #357abd);
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
        font-size: 0.95rem;
      }

      .logout-btn:hover {
        box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
        transform: translateY(-2px);
      }

      /* Main Content */
      .container {
        max-width: 1100px;
        margin: 0 auto;
        padding: 32px 24px;
        flex: 1;
      }

      .page-header {
        text-align: center;
        color: var(--primary);
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 28px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
      }

      .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 24px;
        padding: 10px 20px;
        background: var(--accent);
        border: 2px solid var(--border);
        color: var(--primary);
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s ease;
        font-weight: 600;
        font-size: 0.95rem;
      }

      .back-btn:hover {
        background: var(--primary);
        color: white;
        transform: translateX(-5px);
      }

      .current-rate-card {
        background: linear-gradient(
          135deg,
          var(--primary),
          var(--primary-dark)
        );
        color: white;
        padding: 24px;
        border-radius: 16px;
        margin-bottom: 24px;
        box-shadow: 0 4px 20px rgba(92, 169, 233, 0.3);
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
      }

      .current-rate-card h2 {
        font-size: 1.5rem;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .rate-display {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 16px;
      }

      .rate-item {
        background: rgba(255, 255, 255, 0.15);
        padding: 20px;
        border-radius: 12px;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
      }

      .rate-item i {
        font-size: 2rem;
        margin-bottom: 10px;
        display: block;
      }

      .rate-label {
        font-size: 0.85rem;
        opacity: 0.95;
        margin-bottom: 8px;
        font-weight: 500;
      }

      .rate-value {
        font-size: 1.75rem;
        font-weight: 700;
        margin-top: 4px;
        line-height: 1.2;
      }

      .current-rate-card .notes-section {
        margin-top: 20px;
        padding: 16px;
        background: rgba(255, 255, 255, 0.15);
        border-radius: 10px;
        border: 1px solid rgba(255, 255, 255, 0.2);
      }

      .current-rate-card .notes-section strong {
        font-size: 0.95rem;
        margin-right: 8px;
      }

      .form-card {
        background: white;
        border: 2px solid var(--border);
        border-radius: 16px;
        padding: 28px;
        margin-bottom: 28px;
        box-shadow: 0 2px 12px var(--shadow);
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
      }

      .form-card h3 {
        color: var(--primary);
        font-size: 1.4rem;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-group label {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 600;
        margin-bottom: 8px;
        color: var(--text);
        font-size: 0.95rem;
      }

      .form-group label i {
        color: var(--primary);
        font-size: 1rem;
      }

      .form-group input,
      .form-group textarea {
        width: 100%;
        padding: 12px 14px;
        border: 2px solid var(--border);
        border-radius: 10px;
        font-family: "Sarabun", sans-serif;
        font-size: 0.95rem;
        transition: all 0.3s ease;
      }

      .form-group input:focus,
      .form-group textarea:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(92, 169, 233, 0.1);
      }

      .form-group textarea {
        resize: vertical;
        min-height: 80px;
      }

      .btn-submit {
        background: linear-gradient(
          135deg,
          var(--primary),
          var(--primary-dark)
        );
        color: white;
        border: none;
        padding: 12px 28px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        font-family: "Sarabun", sans-serif;
        box-shadow: 0 4px 12px rgba(92, 169, 233, 0.3);
      }

      .btn-submit:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(92, 169, 233, 0.4);
      }

      .history-section {
        margin-top: 28px;
      }

      .history-section h3 {
        color: var(--primary);
        font-size: 1.3rem;
        margin-bottom: 14px;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .history-table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }

      .history-table thead {
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
        color: white;
      }

      .history-table th,
      .history-table td {
        padding: 11px 12px;
        text-align: left;
        font-size: 0.88rem;
      }

      .history-table th {
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.3px;
      }

      .history-table tbody tr {
        transition: all 0.3s ease;
      }

      .history-table tbody tr:hover {
        background: var(--accent);
      }

      .badge {
        padding: 4px 10px;
        border-radius: 16px;
        font-size: 0.8rem;
        font-weight: 600;
        white-space: nowrap;
      }

      .badge-active {
        background: rgba(76, 175, 80, 0.1);
        color: var(--success);
        border: 2px solid var(--success);
      }

      .badge-inactive {
        background: rgba(158, 158, 158, 0.1);
        color: #9e9e9e;
        border: 2px solid #9e9e9e;
      }

      .toast {
        position: fixed;
        top: 20px;
        right: 20px;
        min-width: 350px;
        padding: 18px 25px;
        border-radius: 12px;
        font-weight: 600;
        font-size: 1rem;
        z-index: 9999;
        display: none;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        border-left: 5px solid;
        backdrop-filter: blur(10px);
        animation: slideIn 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
      }

      .toast.success {
        background: linear-gradient(135deg, #81c784, #4caf50);
        color: white;
        border-left-color: #2e7d32;
      }

      .toast.error {
        background: linear-gradient(135deg, #ff6b6b, #f44336);
        color: white;
        border-left-color: #c62828;
      }

      .toast.warning {
        background: linear-gradient(135deg, #ffb74d, #ff9800);
        color: white;
        border-left-color: #ef6c00;
      }

      .toast-icon {
        display: inline-block;
        margin-right: 12px;
        font-size: 1.3rem;
        vertical-align: middle;
        animation: iconBounce 0.6s ease;
      }

      .toast-message {
        display: inline-block;
        vertical-align: middle;
        max-width: 280px;
      }

      @keyframes slideIn {
        from {
          transform: translateX(450px);
          opacity: 0;
        }
        to {
          transform: translateX(0);
          opacity: 1;
        }
      }

      @keyframes slideOut {
        from {
          transform: translateX(0) scale(1);
          opacity: 1;
        }
        to {
          transform: translateX(450px) scale(0.8);
          opacity: 0;
        }
      }

      @keyframes iconBounce {
        0%,
        100% {
          transform: scale(1);
        }
        25% {
          transform: scale(1.2);
        }
        50% {
          transform: scale(0.9);
        }
        75% {
          transform: scale(1.1);
        }
      }

      .toast.hiding {
        animation: slideOut 0.3s ease forwards;
      }

      /* Responsive Design */
      @media (max-width: 768px) {
        .header {
          flex-direction: column;
          padding: 15px 20px;
          gap: 15px;
        }

        .header h1 {
          font-size: 1.8rem;
        }

        .nav-menu {
          flex-wrap: wrap;
          gap: 10px;
          justify-content: center;
        }

        .nav-link {
          padding: 6px 12px;
          font-size: 0.85rem;
        }

        .user-section {
          flex-wrap: wrap;
          justify-content: center;
          width: 100%;
          gap: 8px;
        }

        .user-info,
        .btn-edit-profile,
        .logout-btn {
          font-size: 0.85rem;
          padding: 7px 12px;
        }

        .container {
          padding: 16px 12px;
        }

        .page-header {
          font-size: 1.5rem;
          margin-bottom: 14px;
        }

        .back-btn {
          font-size: 0.85rem;
          padding: 7px 14px;
        }

        .current-rate-card {
          padding: 16px;
        }

        .current-rate-card h2 {
          font-size: 1.2rem;
        }

        .rate-display {
          grid-template-columns: 1fr;
          gap: 10px;
        }

        .rate-item {
          padding: 12px;
        }

        .rate-value {
          font-size: 1.3rem;
        }

        .form-card {
          padding: 16px;
        }

        .form-card h3 {
          font-size: 1.1rem;
        }

        .form-group {
          margin-bottom: 14px;
        }

        .form-group label {
          font-size: 0.85rem;
        }

        .form-group input,
        .form-group textarea {
          font-size: 0.85rem;
          padding: 9px;
        }

        .btn-submit {
          font-size: 0.9rem;
          padding: 9px 18px;
        }

        .history-section {
          margin-top: 20px;
        }

        .history-section h3 {
          font-size: 1.1rem;
        }

        .history-table {
          font-size: 0.8rem;
        }

        .history-table th,
        .history-table td {
          padding: 9px 8px;
        }

        .badge {
          font-size: 0.75rem;
          padding: 3px 8px;
        }
      }
    </style>
  </head>
  <body>
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
          <a href="OViewReserve" class="nav-link">
            <i class="fas fa-list"></i> รายการเช่า
          </a>
          <a href="ListReservations" class="nav-link">
            <i class="fas fa-clipboard-list"></i> รายการจอง
          </a>
          <a href="ListReturnRoom" class="nav-link">
            <i class="fas fa-clipboard-check"></i> คำขอคืนห้อง
          </a>
          <a href="ManageUtilityRates" class="nav-link active">
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
          <a href="EditManager" class="btn-edit-profile">
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
        <div class="page-header">
          <i class="fas fa-cogs"></i>
          จัดการหน่วยค่าน้ำ-ค่าไฟ
        </div>

        <a href="OwnerHome" class="back-btn">
          <i class="fas fa-arrow-left"></i>
          กลับไปหน้าหลัก
        </a>

        <c:if test="${not empty activeRate}">
          <div class="current-rate-card">
            <h2>
              <i class="fas fa-check-circle"></i> หน่วยที่ใช้งานอยู่ปัจจุบัน
            </h2>
            <div class="rate-display">
              <div class="rate-item">
                <i class="fas fa-tint"></i>
                <div class="rate-label">ค่าน้ำ</div>
                <div class="rate-value">
                  ${activeRate.ratePerUnitWater} บาท/หน่วย
                </div>
              </div>
              <div class="rate-item">
                <i class="fas fa-bolt"></i>
                <div class="rate-label">ค่าไฟ</div>
                <div class="rate-value">
                  ${activeRate.ratePerUnitElectric} บาท/หน่วย
                </div>
              </div>
              <div class="rate-item">
                <i class="fas fa-calendar"></i>
                <div class="rate-label">วันที่เริ่มใช้</div>
                <div class="rate-value" style="font-size: 1.3rem">
                  <fmt:formatDate
                    value="${activeRate.effectiveDate}"
                    pattern="dd/MM/yyyy"
                  />
                </div>
              </div>
            </div>
            <c:if test="${not empty activeRate.notes}">
              <div class="notes-section">
                <strong><i class="fas fa-info-circle"></i> หมายเหตุ:</strong> ${activeRate.notes}
              </div>
            </c:if>
          </div>
        </c:if>

        <div class="form-card">
          <h3>
            <i class="fas fa-plus-circle"></i>
            ตั้งค่าหน่วยใหม่
          </h3>
          <form
            action="SaveUtilityRate"
            method="post"
            id="rateForm"
            onsubmit="return validateRates()"
          >
            <div class="form-group">
              <label><i class="fas fa-tint"></i> ค่าน้ำ (บาท/หน่วย):</label>
              <input
                type="number"
                name="ratePerUnitWater"
                id="ratePerUnitWater"
                step="1"
                min="0"
                required
                placeholder="เช่น 18.00"
              />
            </div>

            <div class="form-group">
              <label><i class="fas fa-bolt"></i> ค่าไฟ (บาท/หน่วย):</label>
              <input
                type="number"
                name="ratePerUnitElectric"
                id="ratePerUnitElectric"
                step="1"
                min="0"
                required
                placeholder="เช่น 8.00"
              />
            </div>

            <div class="form-group">
              <label><i class="fas fa-sticky-note"></i> หมายเหตุ (ถ้ามี):</label>
              <textarea
                name="notes"
                rows="3"
                placeholder="เช่น เพิ่มขึ้นตามประกาศการไฟฟ้า..."
              ></textarea>
            </div>

            <button type="submit" class="btn-submit">
              <i class="fas fa-save"></i>
              บันทึกหน่วยใหม่
            </button>
          </form>
        </div>

        <c:if test="${not empty allRates}">
          <div class="history-section">
            <h3><i class="fas fa-history"></i> ประวัติการเปลี่ยนแปลงหน่วย</h3>
            <table class="history-table">
              <thead>
                <tr>
                  <th>วันที่เริ่มใช้</th>
                  <th>ค่าน้ำ (บาท/หน่วย)</th>
                  <th>ค่าไฟ (บาท/หน่วย)</th>
                  <th>สถานะ</th>
                  <th>หมายเหตุ</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="rate" items="${allRates}">
                  <tr>
                    <td>
                      <fmt:formatDate
                        value="${rate.effectiveDate}"
                        pattern="dd/MM/yyyy HH:mm"
                      />
                    </td>
                    <td>${rate.ratePerUnitWater}</td>
                    <td>${rate.ratePerUnitElectric}</td>
                    <td>
                      <c:choose>
                        <c:when test="${rate.active}">
                          <span class="badge badge-active">ใช้งานอยู่</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge badge-inactive">หยุดใช้แล้ว</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>${rate.notes}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:if>
      </div>
    </div>

    <div id="toast" class="toast"></div>

    <script>
      var successMessage = '<c:out value="${message}" escapeXml="false" />';
      var errorMessage = '<c:out value="${error}" escapeXml="false" />';

      var currentWaterRate = (
        <c:out value="${not empty activeRate ? activeRate.ratePerUnitWater : -1}" />
      );
      var currentElectricRate = (
        <c:out value="${not empty activeRate ? activeRate.ratePerUnitElectric : -1}" />
      );

      function showToast(message, type) {
        const toast = document.getElementById("toast");
        let icon = "";
        if (type === "success") {
          icon = '<i class="fas fa-check-circle toast-icon"></i>';
        } else if (type === "error") {
          icon = '<i class="fas fa-exclamation-circle toast-icon"></i>';
        } else if (type === "warning") {
          icon = '<i class="fas fa-exclamation-triangle toast-icon"></i>';
        }
        toast.innerHTML =
          icon + '<span class="toast-message">' + message + "</span>";
        toast.className = `toast ${type}`;
        toast.style.display = "block";
        setTimeout(() => {
          toast.classList.add("hiding");
          setTimeout(() => {
            toast.style.display = "none";
            toast.classList.remove("hiding");
          }, 300);
        }, 3000);
      }

      function validateRates() {
        const waterRate = parseFloat(
          document.getElementById("ratePerUnitWater").value
        );
        const electricRate = parseFloat(
          document.getElementById("ratePerUnitElectric").value
        );
        if (currentWaterRate > 0 && currentElectricRate > 0) {
          if (
            waterRate === currentWaterRate &&
            electricRate === currentElectricRate
          ) {
            showToast(
              "ค่าหน่วยที่กรอกตรงกับค่าหน่วยปัจจุบันทุกประการ กรุณากรอกค่าใหม่ที่แตกต่าง",
              "warning"
            );
            return false; 
          }
        }

        return true; 
      }

      if (successMessage && successMessage.trim() !== "") {
        showToast(successMessage, "success");
      }

      if (errorMessage && errorMessage.trim() !== "") {
        showToast(errorMessage, "error");
      }
      window.addEventListener('load', function() {
        document.body.style.opacity = '0';
        document.body.style.transition = 'opacity 0.5s ease-in-out';
        setTimeout(function() {
          document.body.style.opacity = '1';
        }, 100);
      });
    </script>
  </body>
</html>
