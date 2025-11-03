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
        --primary: #5ca9e9;
        --primary-dark: #4a90e2;
        --text: #1e3a5f;
        --muted-text: #5b7a9d;
        --accent: #e3f2fd;
        --border: #d1e8ff;
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
      }

      .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 30px 20px;
      }

      .page-header {
        text-align: center;
        color: var(--primary);
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
      }

      .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 25px;
        padding: 12px 25px;
        background: var(--accent);
        border: 2px solid var(--border);
        color: var(--primary);
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s ease;
        font-weight: 600;
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
        padding: 30px;
        border-radius: 15px;
        margin-bottom: 30px;
        box-shadow: 0 4px 20px rgba(92, 169, 233, 0.3);
      }

      .current-rate-card h2 {
        font-size: 1.8rem;
        margin-bottom: 20px;
      }

      .rate-display {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
      }

      .rate-item {
        background: rgba(255, 255, 255, 0.1);
        padding: 20px;
        border-radius: 10px;
        backdrop-filter: blur(10px);
      }

      .rate-item i {
        font-size: 2rem;
        margin-bottom: 10px;
      }

      .rate-label {
        font-size: 0.9rem;
        opacity: 0.9;
      }

      .rate-value {
        font-size: 2rem;
        font-weight: 700;
        margin-top: 5px;
      }

      .form-card {
        background: white;
        border: 2px solid var(--border);
        border-radius: 15px;
        padding: 30px;
        margin-bottom: 30px;
      }

      .form-card h3 {
        color: var(--primary);
        font-size: 1.5rem;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-group label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        color: var(--text);
      }

      .form-group input,
      .form-group textarea {
        width: 100%;
        padding: 12px;
        border: 2px solid var(--border);
        border-radius: 10px;
        font-family: "Sarabun", sans-serif;
        font-size: 1rem;
      }

      .form-group input:focus,
      .form-group textarea:focus {
        outline: none;
        border-color: var(--primary);
      }

      .btn-submit {
        background: linear-gradient(
          135deg,
          var(--primary),
          var(--primary-dark)
        );
        color: white;
        border: none;
        padding: 14px 30px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 1.1rem;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 10px;
      }

      .btn-submit:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(92, 169, 233, 0.4);
      }

      .history-section {
        margin-top: 40px;
      }

      .history-section h3 {
        color: var(--primary);
        font-size: 1.5rem;
        margin-bottom: 20px;
      }

      .history-table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }

      .history-table thead {
        background: var(--accent);
        color: var(--primary);
      }

      .history-table th,
      .history-table td {
        padding: 15px;
        text-align: left;
      }

      .history-table tbody tr:hover {
        background: var(--accent);
      }

      .badge {
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 600;
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
    </style>
  </head>
  <body>
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
            <div
              style="
                margin-top: 15px;
                padding: 15px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 10px;
              "
            >
              <strong>หมายเหตุ:</strong> ${activeRate.notes}
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
              step="0.01"
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
              step="0.01"
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

    <div id="toast" class="toast"></div>

    <script>
      var successMessage = '<c:out value="${message}" escapeXml="false" />';
      var errorMessage = '<c:out value="${error}" escapeXml="false" />';

      // ค่าหน่วยปัจจุบัน
      var currentWaterRate = (
        <c:out value="${not empty activeRate ? activeRate.ratePerUnitWater : -1}" />
      );
      var currentElectricRate = (
        <c:out value="${not empty activeRate ? activeRate.ratePerUnitElectric : -1}" />
      );

      function showToast(message, type) {
        const toast = document.getElementById("toast");

        // เลือกไอคอนตามประเภท
        let icon = "";
        if (type === "success") {
          icon = '<i class="fas fa-check-circle toast-icon"></i>';
        } else if (type === "error") {
          icon = '<i class="fas fa-exclamation-circle toast-icon"></i>';
        } else if (type === "warning") {
          icon = '<i class="fas fa-exclamation-triangle toast-icon"></i>';
        }

        // แสดงข้อความพร้อมไอคอน
        toast.innerHTML =
          icon + '<span class="toast-message">' + message + "</span>";
        toast.className = `toast ${type}`;
        toast.style.display = "block";

        // ซ่อนด้วย animation
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

        // ตรวจสอบว่าค่าที่กรอกตรงกับค่าปัจจุบันหรือไม่
        if (currentWaterRate > 0 && currentElectricRate > 0) {
          if (
            waterRate === currentWaterRate &&
            electricRate === currentElectricRate
          ) {
            showToast(
              "ค่าหน่วยที่กรอกตรงกับค่าหน่วยปัจจุบันทุกประการ กรุณากรอกค่าใหม่ที่แตกต่าง",
              "warning"
            );
            return false; // ไม่ให้ submit form
          }
        }

        return true; // อนุญาตให้ submit form
      }

      if (successMessage && successMessage.trim() !== "") {
        showToast(successMessage, "success");
      }

      if (errorMessage && errorMessage.trim() !== "") {
        showToast(errorMessage, "error");
      }
    </script>
  </body>
</html>
