<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
taglib prefix="fmt" uri="jakarta.tags.fmt" %> <%@ page session="true" %> <%@
page import="com.springmvc.model.Member" %> <% Member loginMember = (Member)
session.getAttribute("loginMember"); if (loginMember == null) {
response.sendRedirect("Login"); return; } %>

<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>รายละเอียดใบแจ้งหนี้ - ThanaChok Place</title>
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
        background: rgba(255, 140, 0, 0.1);
        border-radius: 50%;
        animation: float 6s ease-in-out infinite;
        box-shadow: 0 0 30px rgba(255, 140, 0, 0.2);
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

      @keyframes float {
        0%,
        100% {
          transform: translateY(0px) rotate(0deg);
        }
        50% {
          transform: translateY(-20px) rotate(180deg);
        }
      }

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
        content: "";
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 2px;
        background: linear-gradient(
          90deg,
          transparent,
          rgba(255, 255, 255, 0.5),
          transparent
        );
        animation: scan 3s linear infinite;
      }

      @keyframes scan {
        0% {
          left: -100%;
        }
        100% {
          left: 100%;
        }
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
        0%,
        100% {
          text-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
        }
        50% {
          text-shadow: 0 0 30px rgba(0, 0, 0, 0.5),
            0 0 40px rgba(255, 255, 255, 0.3);
        }
      }

      .container {
        max-width: 900px;
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

      .print-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        margin-left: 10px;
        padding: 12px 24px;
        background: linear-gradient(135deg, #ff8c00, #ff6b00);
        border: none;
        color: white;
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s ease;
        font-weight: 500;
        cursor: pointer;
        box-shadow: 0 4px 10px rgba(255, 140, 0, 0.3);
      }

      .print-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(255, 140, 0, 0.5);
      }

      .error-message {
        background: linear-gradient(135deg, #ff4444, #cc0000);
        color: white;
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 20px;
        text-align: center;
        animation: slideIn 0.5s ease-out;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        border: 1px solid rgba(255, 68, 68, 0.5);
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

      .invoice-header-card {
        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
        backdrop-filter: blur(20px);
        padding: 30px;
        border-radius: 15px;
        margin-bottom: 25px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 140, 0, 0.3);
        animation: slideIn 0.6s ease-out;
      }

      .invoice-number {
        font-size: 2rem;
        font-weight: bold;
        color: #ff8c00;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .invoice-info-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
      }

      .info-card {
        padding: 20px;
        background: rgba(0, 0, 0, 0.4);
        border-radius: 12px;
        border: 1px solid rgba(255, 140, 0, 0.2);
        transition: all 0.3s ease;
      }

      .info-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(255, 140, 0, 0.2);
        border-color: rgba(255, 140, 0, 0.4);
      }

      .info-card h4 {
        color: #ff8c00;
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 2px solid rgba(255, 140, 0, 0.3);
        font-size: 1.1rem;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .info-card p {
        color: #ccc;
        margin: 10px 0;
        line-height: 1.6;
      }

      .info-card strong {
        color: #ff8c00;
        font-weight: 600;
      }

      .status-paid {
        background: linear-gradient(135deg, #00ff88, #00cc6f);
        color: #000;
        padding: 6px 16px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        box-shadow: 0 4px 10px rgba(0, 255, 136, 0.3);
      }

      .status-unpaid {
        background: linear-gradient(135deg, #ff4444, #cc0000);
        color: white;
        padding: 6px 16px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        box-shadow: 0 4px 10px rgba(255, 68, 68, 0.3);
      }

      .table-container {
        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 140, 0, 0.3);
        margin-bottom: 25px;
        animation: slideIn 0.8s ease-out;
      }

      .detail-table {
        width: 100%;
        border-collapse: collapse;
      }

      .detail-table th {
        background: linear-gradient(135deg, #ff8c00, #ff6b00);
        color: white;
        padding: 18px 20px;
        text-align: left;
        font-weight: 600;
        font-size: 0.95rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .detail-table th:nth-child(2),
      .detail-table th:nth-child(3),
      .detail-table th:nth-child(4) {
        text-align: right;
      }

      .detail-table td {
        padding: 16px 20px;
        border-bottom: 1px solid rgba(255, 140, 0, 0.1);
        color: #ccc;
      }

      .detail-table tbody tr {
        transition: all 0.3s ease;
      }

      .detail-table tbody tr:hover {
        background: rgba(255, 140, 0, 0.1);
      }

      .detail-table tbody tr:last-child td {
        border-bottom: none;
      }

      .item-name {
        color: #fff;
        font-weight: 500;
      }

      .amount-cell {
        text-align: right;
        font-weight: 600;
        color: #ff8c00;
      }

      .total-section {
        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 140, 0, 0.3);
        text-align: right;
        animation: slideIn 1s ease-out;
      }

      .total-label {
        color: #ccc;
        font-size: 1.1rem;
        margin-bottom: 10px;
      }

      .total-amount {
        font-size: 2.5rem;
        font-weight: bold;
        color: #ff8c00;
        padding-top: 15px;
        border-top: 2px solid rgba(255, 140, 0, 0.3);
        display: flex;
        align-items: center;
        justify-content: flex-end;
        gap: 10px;
        animation: pulse 2s ease-in-out infinite;
      }

      @keyframes pulse {
        0%,
        100% {
          transform: scale(1);
        }
        50% {
          transform: scale(1.02);
        }
      }

      @media (max-width: 768px) {
        .page-header h1 {
          font-size: 1.5rem;
        }

        .container {
          padding: 0 15px;
        }

        .invoice-info-grid {
          grid-template-columns: 1fr;
        }

        .invoice-number {
          font-size: 1.5rem;
        }

        .detail-table {
          font-size: 0.85rem;
        }

        .detail-table th,
        .detail-table td {
          padding: 12px 10px;
        }

        .total-amount {
          font-size: 1.8rem;
        }

        .print-btn {
          display: block;
          margin: 10px 0 0 0;
          text-align: center;
          justify-content: center;
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

      @media print {
        body {
          background: white;
          color: black;
        }

        .bg-animation,
        .back-btn,
        .print-btn,
        .particles {
          display: none !important;
        }

        .page-header {
          background: #ff8c00;
          print-color-adjust: exact;
          -webkit-print-color-adjust: exact;
        }

        .invoice-header-card,
        .table-container,
        .total-section {
          border: 1px solid #ddd;
          box-shadow: none;
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
      <div class="particles" id="particles"></div>
    </div>

    <!-- Header -->
    <div class="page-header">
      <h1>
        <i class="fas fa-file-invoice-dollar"></i>
        รายละเอียดใบแจ้งหนี้
      </h1>
    </div>

    <!-- Container -->
    <div class="container">
      <div>
        <a href="Listinvoice" class="back-btn">
          <i class="fas fa-arrow-left"></i>
          กลับรายการใบแจ้งหนี้
        </a>
        <button onclick="printInvoice()" class="print-btn">
          <i class="fas fa-print"></i>
          พิมพ์ใบแจ้งหนี้
        </button>
      </div>

      <!-- Error Message -->
      <c:if test="${not empty error}">
        <div class="error-message">
          <i class="fas fa-exclamation-circle"></i>
          ${error}
        </div>
      </c:if>

      <!-- Invoice Content -->
      <c:if test="${not empty invoice}">
        <!-- Invoice Header -->
        <div class="invoice-header-card">
          <div class="invoice-number">
            <i class="fas fa-receipt"></i>
            ใบแจ้งหนี้ #INV-${invoice.invoiceId}
          </div>

          <div class="invoice-info-grid">
            <!-- Rental Information -->
            <div class="info-card">
              <h4>
                <i class="fas fa-door-open"></i>
                ข้อมูลการเช่า
              </h4>
              <p><strong>ห้องที่:</strong> ${invoice.rent.room.roomNumber}</p>
              <p>
                <strong>ผู้เช่า:</strong> ${invoice.rent.member.firstName}
                ${invoice.rent.member.lastName}
              </p>
              <p><strong>ประเภทห้อง:</strong> ${invoice.rent.room.roomtype}</p>
            </div>

            <!-- Invoice Information -->
            <div class="info-card">
              <h4>
                <i class="fas fa-info-circle"></i>
                ข้อมูลใบแจ้งหนี้
              </h4>
              <p><strong>วันที่ออก:</strong> ${invoice.issueDate}</p>
              <p><strong>วันครบกำหนด:</strong> ${invoice.dueDate}</p>
              <p>
                <strong>สถานะ:</strong>
                <c:choose>
                  <c:when test="${invoice.status == 1}">
                    <span class="status-paid">
                      <i class="fas fa-check-circle"></i>
                      ชำระแล้ว
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="status-unpaid">
                      <i class="fas fa-exclamation-circle"></i>
                      ยังไม่ได้ชำระ
                    </span>
                  </c:otherwise>
                </c:choose>
              </p>
            </div>
          </div>
        </div>

        <!-- Details Table -->
        <div class="table-container">
          <table class="detail-table">
            <thead>
              <tr>
                <th><i class="fas fa-list"></i> รายการ</th>
                <th><i class="fas fa-hashtag"></i> จำนวน</th>
                <th><i class="fas fa-tags"></i> ราคาต่อหน่วย</th>
                <th><i class="fas fa-calculator"></i> รวม</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="detail" items="${invoiceDetails}">
                <tr>
                  <td class="item-name">${detail.type.typeName}</td>
                  <td style="text-align: right; color: #ccc">
                    <c:choose>
                      <c:when test="${detail.quantity > 1}">
                        ${detail.quantity} หน่วย
                      </c:when>
                      <c:otherwise> 1 </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="amount-cell">
                    ฿<fmt:formatNumber
                      value="${detail.price}"
                      groupingUsed="true"
                      minFractionDigits="2"
                    />
                  </td>
                  <td class="amount-cell">
                    ฿<fmt:formatNumber
                      value="${detail.amount}"
                      groupingUsed="true"
                      minFractionDigits="2"
                    />
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- Total Section -->
        <div class="total-section">
          <div class="total-label">ยอดรวมทั้งสิ้น</div>
          <div class="total-amount">
            <i class="fas fa-money-bill-wave"></i>
            ฿<fmt:formatNumber
              value="${invoice.totalAmount}"
              groupingUsed="true"
              minFractionDigits="2"
            />
          </div>
        </div>
      </c:if>
    </div>

    <script>
      // Alert message
      <c:if test="${not empty message}">alert("${message}");</c:if>;

      // Print invoice function
      function printInvoice() {
        window.print();
      }

      // Create particles
      function createParticles() {
        const particles = document.getElementById("particles");
        const particleCount = 50;

        for (let i = 0; i < particleCount; i++) {
          const particle = document.createElement("div");
          particle.className = "particle";
          particle.style.left = Math.random() * 100 + "%";
          particle.style.animationDelay = Math.random() * 8 + "s";
          particle.style.animationDuration = Math.random() * 3 + 5 + "s";
          particles.appendChild(particle);
        }
      }

      // Initialize on load
      window.addEventListener("load", function () {
        createParticles();

        // Page load animation
        document.body.style.opacity = "0";
        document.body.style.transition = "opacity 0.5s ease-in-out";

        setTimeout(function () {
          document.body.style.opacity = "1";
        }, 100);
      });

      // Add hover effects to info cards
      document.querySelectorAll(".info-card").forEach((card) => {
        card.addEventListener("mouseenter", function () {
          this.style.borderColor = "rgba(255, 140, 0, 0.6)";
        });

        card.addEventListener("mouseleave", function () {
          this.style.borderColor = "rgba(255, 140, 0, 0.2)";
        });
      });
    </script>
  </body>
</html>
