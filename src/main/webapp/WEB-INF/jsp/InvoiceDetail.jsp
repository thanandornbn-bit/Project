<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
taglib prefix="fmt" uri="jakarta.tags.fmt" %> <%@ page session="true" %> <%@
page import="com.springmvc.model.Member" %> <% Member loginMember=(Member)
session.getAttribute("loginMember"); if (loginMember==null) {
response.sendRedirect("Login"); return; } %>

<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>รายละเอียดใบแจ้งหนี้ - ThanaChok Place</title>

    <!-- ป้องกัน browser cache เพื่อแสดงข้อมูลล่าสุด -->
    <meta
      http-equiv="Cache-Control"
      content="no-cache, no-store, must-revalidate"
    />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

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
        --primary: #5ca9e9;
        --primary-dark: #4a90e2;
        --primary-light: #7bc4ff;
        --accent: #e3f2fd;
        --text: #1e3a5f;
        --text-light: #ffffff;
        --muted-text: #5b7a9d;
        --bg: #ffffff;
        --bg-secondary: #f8fcff;
        --border: #d1e8ff;
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
        background: linear-gradient(
          135deg,
          var(--bg-secondary) 0%,
          var(--accent) 100%
        );
        min-height: 100vh;
        color: var(--text);
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
        pointer-events: none;
      }

      .floating-shapes {
        position: absolute;
        width: 120px;
        height: 120px;
        background: radial-gradient(
          circle,
          rgba(92, 169, 233, 0.15),
          transparent
        );
        border-radius: 50%;
        animation: float 8s ease-in-out infinite;
        box-shadow: 0 0 40px rgba(92, 169, 233, 0.2);
      }

      .floating-shapes:nth-child(1) {
        top: 10%;
        left: 10%;
        animation-delay: 0s;
        width: 150px;
        height: 150px;
      }

      .floating-shapes:nth-child(2) {
        top: 20%;
        right: 10%;
        animation-delay: 2s;
        width: 100px;
        height: 100px;
      }

      .floating-shapes:nth-child(3) {
        bottom: 10%;
        left: 20%;
        animation-delay: 4s;
        width: 130px;
        height: 130px;
      }

      @keyframes float {
        0%,
        100% {
          transform: translateY(0px) translateX(0px) rotate(0deg);
        }

        33% {
          transform: translateY(-30px) translateX(20px) rotate(120deg);
        }

        66% {
          transform: translateY(-15px) translateX(-20px) rotate(240deg);
        }
      }

      .page-header {
        background: linear-gradient(
          135deg,
          var(--primary),
          var(--primary-dark)
        );
        color: var(--text-light);
        text-align: center;
        padding: 35px 20px;
        position: relative;
        z-index: 10;
        box-shadow: 0 4px 20px var(--shadow);
      }

      .page-header::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(
          90deg,
          transparent 0%,
          var(--primary-light) 50%,
          transparent 100%
        );
        animation: shimmer 3s ease-in-out infinite;
      }

      @keyframes shimmer {
        0%,
        100% {
          opacity: 0.5;
        }

        50% {
          opacity: 1;
        }
      }

      .page-header h1 {
        font-size: 2.2rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      .page-header h1 i {
        font-size: 2rem;
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
        gap: 10px;
        margin-bottom: 25px;
        padding: 12px 28px;
        background: var(--bg);
        border: 2px solid var(--primary);
        color: var(--primary);
        text-decoration: none;
        border-radius: 12px;
        transition: all 0.3s ease;
        font-weight: 500;
        box-shadow: 0 2px 8px var(--shadow);
      }

      .back-btn:hover {
        background: var(--primary);
        color: var(--text-light);
        transform: translateX(-5px);
        box-shadow: 0 4px 12px var(--shadow);
      }

      .print-btn {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        margin-left: 10px;
        padding: 12px 28px;
        background: linear-gradient(
          135deg,
          var(--primary),
          var(--primary-dark)
        );
        border: none;
        color: var(--text-light);
        text-decoration: none;
        border-radius: 12px;
        transition: all 0.3s ease;
        font-weight: 500;
        cursor: pointer;
        box-shadow: 0 4px 12px var(--shadow);
      }

      .print-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px var(--shadow);
        background: linear-gradient(
          135deg,
          var(--primary-dark),
          var(--primary)
        );
      }

      .error-message {
        background: linear-gradient(135deg, var(--danger), #d32f2f);
        color: var(--text-light);
        padding: 16px 24px;
        border-radius: 12px;
        margin-bottom: 20px;
        text-align: center;
        animation: slideIn 0.5s ease-out;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        border: 2px solid rgba(244, 67, 54, 0.3);
        box-shadow: 0 4px 12px rgba(244, 67, 54, 0.2);
        font-weight: 500;
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
        background: var(--bg);
        backdrop-filter: blur(20px);
        padding: 35px;
        border-radius: 20px;
        margin-bottom: 30px;
        box-shadow: 0 8px 32px var(--shadow);
        border: 2px solid var(--border);
        animation: slideIn 0.6s ease-out;
      }

      .invoice-number {
        font-size: 2.2rem;
        font-weight: 700;
        color: var(--primary);
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 12px;
        padding-bottom: 20px;
        border-bottom: 3px solid var(--accent);
      }

      .invoice-info-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
      }

      .info-card {
        padding: 24px;
        background: var(--bg-secondary);
        border-radius: 16px;
        border: 2px solid var(--border);
        transition: all 0.3s ease;
      }

      .info-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 24px var(--shadow);
        border-color: var(--primary);
        background: var(--bg);
      }

      .info-card h4 {
        color: var(--primary);
        margin-bottom: 18px;
        padding-bottom: 12px;
        border-bottom: 2px solid var(--border);
        font-size: 1.2rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .info-card p {
        color: var(--text);
        margin: 12px 0;
        line-height: 1.8;
        font-size: 1rem;
      }

      .info-card strong {
        color: var(--primary-dark);
        font-weight: 600;
      }

      .status-paid {
        background: linear-gradient(135deg, var(--success), #45a049);
        color: var(--text-light);
        padding: 8px 18px;
        border-radius: 25px;
        font-size: 0.95rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
      }

      .status-unpaid {
        background: linear-gradient(135deg, var(--warning), #f57c00);
        color: var(--text-light);
        padding: 8px 18px;
        border-radius: 25px;
        font-size: 0.95rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        box-shadow: 0 4px 12px rgba(255, 152, 0, 0.3);
      }

      .table-container {
        background: var(--bg);
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 8px 32px var(--shadow);
        border: 2px solid var(--border);
        margin-bottom: 30px;
        animation: slideIn 0.8s ease-out;
      }

      .detail-table {
        width: 100%;
        border-collapse: collapse;
      }

      .detail-table th {
        background: linear-gradient(
          135deg,
          var(--primary),
          var(--primary-dark)
        );
        color: var(--text-light);
        padding: 20px 24px;
        text-align: left;
        font-weight: 600;
        font-size: 1rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .detail-table th:nth-child(2),
      .detail-table th:nth-child(3),
      .detail-table th:nth-child(4) {
        text-align: right;
      }

      .detail-table td {
        padding: 18px 24px;
        border-bottom: 1px solid var(--border);
        color: var(--text);
        font-size: 1rem;
      }

      .detail-table tbody tr {
        transition: all 0.3s ease;
        background: var(--bg);
      }

      .detail-table tbody tr:hover {
        background: var(--accent);
        transform: scale(1.01);
      }

      .detail-table tbody tr:last-child td {
        border-bottom: none;
      }

      .item-name {
        color: var(--text);
        font-weight: 600;
      }

      .amount-cell {
        text-align: right;
        font-weight: 600;
        color: var(--primary);
      }

      .total-section {
        background: linear-gradient(135deg, var(--bg), var(--bg-secondary));
        padding: 35px;
        border-radius: 20px;
        box-shadow: 0 8px 32px var(--shadow);
        border: 2px solid var(--border);
        text-align: right;
        animation: slideIn 1s ease-out;
      }

      .total-label {
        color: var(--muted-text);
        font-size: 1.2rem;
        margin-bottom: 12px;
        font-weight: 500;
      }

      .total-amount {
        font-size: 2.8rem;
        font-weight: 700;
        color: var(--primary);
        padding-top: 20px;
        border-top: 3px solid var(--primary);
        display: flex;
        align-items: center;
        justify-content: flex-end;
        gap: 12px;
        text-shadow: 0 2px 4px var(--shadow);
      }

      .total-amount i {
        font-size: 2.5rem;
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
        pointer-events: none;
      }

      .particle {
        position: absolute;
        width: 6px;
        height: 6px;
        background: var(--primary);
        border-radius: 50%;
        animation: particleFloat 10s linear infinite;
        box-shadow: 0 0 10px var(--primary);
        opacity: 0.6;
      }

      @keyframes particleFloat {
        0% {
          opacity: 0;
          transform: translateY(100vh) scale(0) rotate(0deg);
        }

        10% {
          opacity: 0.6;
        }

        90% {
          opacity: 0.6;
        }

        100% {
          opacity: 0;
          transform: translateY(-100vh) scale(1) rotate(360deg);
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
          background: var(--primary);
          print-color-adjust: exact;
          -webkit-print-color-adjust: exact;
        }

        .invoice-header-card,
        .table-container,
        .total-section,
        .info-card {
          border: 2px solid var(--border);
          box-shadow: none;
          page-break-inside: avoid;
        }

        .detail-table th {
          background: var(--primary);
          print-color-adjust: exact;
          -webkit-print-color-adjust: exact;
        }
      }
    </style>
  </head>

  <body>
    <div class="bg-animation">
      <div class="floating-shapes"></div>
      <div class="floating-shapes"></div>
      <div class="floating-shapes"></div>
      <div class="particles" id="particles"></div>
    </div>

    <div class="page-header">
      <h1>
        <i class="fas fa-file-invoice-dollar"></i>
        รายละเอียดใบแจ้งหนี้
      </h1>
    </div>
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

      <c:if test="${not empty error}">
        <div class="error-message">
          <i class="fas fa-exclamation-circle"></i>
          ${error}
        </div>
      </c:if>

      <c:if test="${not empty invoice}">
        <div class="invoice-header-card">
          <div class="invoice-number">
            <i class="fas fa-receipt"></i>
            ใบแจ้งหนี้ #INV-${invoice.invoiceId}
          </div>

          <div class="invoice-info-grid">
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
                  <td class="item-name">
                    ${detail.type.typeName}
                    <c:if test="${detail.type.typeName == 'ค่าปรับ'}">
                      <c:choose>
                        <c:when test="${not empty detail.remark}">
                          <div
                            style="
                              font-size: 0.9rem;
                              color: #f44336;
                              margin-top: 8px;
                              padding: 10px 15px;
                              background: #fff3f3;
                              border-left: 4px solid #f44336;
                              border-radius: 6px;
                              line-height: 1.6;
                            "
                          >
                            <i
                              class="fas fa-sticky-note"
                              style="margin-right: 8px; color: #f44336"
                            ></i>
                            <strong style="color: #d32f2f">หมายเหตุ:</strong>
                            <span
                              style="
                                color: #424242;
                                margin-left: 5px;
                                word-wrap: break-word;
                                word-break: break-word;
                                white-space: pre-wrap;
                                display: block;
                                max-width: 100%;
                              "
                            >
                              <c:out value="${detail.remark}" />
                            </span>
                          </div>
                        </c:when>
                        <c:otherwise>
                          <div
                            style="
                              font-size: 0.85rem;
                              color: #999;
                              margin-top: 6px;
                              font-style: italic;
                            "
                          >
                            <i
                              class="fas fa-info-circle"
                              style="margin-right: 5px"
                            ></i>
                            (ไม่มีหมายเหตุ)
                          </div>
                        </c:otherwise>
                      </c:choose>
                    </c:if>
                  </td>
                  <td style="text-align: right; color: #161616">
                    <c:choose>
                      <c:when test="${detail.quantity > 1}">
                        ${detail.quantity} หน่วย
                      </c:when>
                      <c:otherwise> 1 </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="amount-cell">
                    ฿
                    <fmt:formatNumber
                      value="${detail.price}"
                      groupingUsed="true"
                      minFractionDigits="2"
                    />
                  </td>
                  <td class="amount-cell">
                    ฿
                    <fmt:formatNumber
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

        <div class="total-section">
          <div class="total-label">ยอดรวมทั้งสิ้น</div>
          <div class="total-amount">
            <i class="fas fa-money-bill-wave"></i>
            ฿
            <fmt:formatNumber
              value="${invoice.totalAmount}"
              groupingUsed="true"
              minFractionDigits="2"
            />
          </div>
        </div>
      </c:if>
    </div>

    <script>
      <c:if test="${not empty message}">alert("${message}");</c:if>;

      function printInvoice() {
        window.print();
      }

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

      window.addEventListener("load", function () {
        createParticles();

        document.body.style.opacity = "0";
        document.body.style.transition = "opacity 0.5s ease-in-out";

        setTimeout(function () {
          document.body.style.opacity = "1";
        }, 100);
      });

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
