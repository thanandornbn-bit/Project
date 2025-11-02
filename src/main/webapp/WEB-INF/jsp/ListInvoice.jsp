<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <%@ page session="true" %>
        <%@ page import="com.springmvc.model.Member" %>
          <% Member loginMember=(Member) session.getAttribute("loginMember"); if (loginMember==null) {
            response.sendRedirect("Login"); return; } %>

            <!DOCTYPE html>
            <html lang="th">

            <head>
              <meta charset="UTF-8" />
              <meta name="viewport" content="width=device-width, initial-scale=1.0" />
              <title>รายการใบแจ้งหนี้ - ThanaChok Place</title>
              <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
              <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
              <style>
                * {
                  margin: 0;
                  padding: 0;
                  box-sizing: border-box;
                }

                :root {
                  --bg: #ffffff;
                  --muted-bg: #f0f7ff;
                  --primary: #5ca9e9;
                  --primary-dark: #4a90e2;
                  --accent: #e3f2fd;
                  --text: #1e3a5f;
                  --muted-text: #5b7a9d;
                  --card-border: #d1e8ff;
                  --hover-bg: #e8f4ff;
                  --success: #22c55e;
                  --warning: #ffa500;
                  --error: #ef4444;
                }

                body {
                  font-family: "Sarabun", system-ui, -apple-system, "Segoe UI", Roboto,
                    "Helvetica Neue", Arial;
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
                  background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
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

                .welcome-message {
                  background: linear-gradient(135deg, var(--muted-bg) 0%, #e8f4ff 100%);
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

                .welcome-message h3 {
                  color: var(--primary);
                  margin-bottom: 10px;
                  font-size: 1.5rem;
                  display: flex;
                  align-items: center;
                  gap: 10px;
                  font-weight: 700;
                }

                .welcome-message p {
                  color: var(--muted-text);
                  font-size: 1rem;
                  font-weight: 500;
                }

                .error-message {
                  background: #ffe4e6;
                  color: var(--error);
                  padding: 18px 25px;
                  border-radius: 12px;
                  margin-bottom: 20px;
                  text-align: center;
                  animation: slideIn 0.5s ease-out;
                  display: flex;
                  align-items: center;
                  justify-content: center;
                  gap: 10px;
                  border: 2px solid var(--error);
                  font-weight: 600;
                  box-shadow: 0 4px 12px rgba(239, 68, 68, 0.15);
                }

                .table-container {
                  background: white;
                  border-radius: 16px;
                  overflow: hidden;
                  box-shadow: 0 8px 24px rgba(92, 169, 233, 0.12);
                  border: 2px solid var(--card-border);
                  animation: slideIn 0.8s ease-out;
                }

                .invoice-table {
                  width: 100%;
                  border-collapse: collapse;
                }

                .invoice-table th {
                  background: linear-gradient(135deg,
                      var(--primary) 0%,
                      var(--primary-dark) 100%);
                  color: white;
                  padding: 18px 15px;
                  text-align: center;
                  font-weight: 700;
                  font-size: 0.95rem;
                  text-transform: uppercase;
                  letter-spacing: 0.5px;
                }

                .invoice-table td {
                  padding: 16px 15px;
                  text-align: center;
                  border-bottom: 1px solid var(--accent);
                  color: var(--text);
                  font-weight: 600;
                }

                .invoice-table tr {
                  transition: all 0.3s ease;
                }

                .invoice-table tbody tr:hover {
                  background: var(--hover-bg);
                  transform: scale(1.01);
                }

                .status-paid {
                  background: #d4f4dd;
                  color: var(--success);
                  border: 2px solid var(--success);
                  padding: 6px 16px;
                  border-radius: 20px;
                  font-size: 0.85rem;
                  font-weight: 700;
                  display: inline-flex;
                  align-items: center;
                  gap: 6px;
                  box-shadow: 0 4px 10px rgba(34, 197, 94, 0.2);
                }

                .status-unpaid {
                  background: #ffe4e6;
                  color: var(--error);
                  border: 2px solid var(--error);
                  padding: 6px 16px;
                  border-radius: 20px;
                  font-size: 0.85rem;
                  font-weight: 700;
                  display: inline-flex;
                  align-items: center;
                  gap: 6px;
                  box-shadow: 0 4px 10px rgba(239, 68, 68, 0.2);
                }

                .btn {
                  padding: 10px 20px;
                  border: none;
                  border-radius: 10px;
                  cursor: pointer;
                  text-decoration: none;
                  display: inline-flex;
                  align-items: center;
                  gap: 8px;
                  font-size: 0.9rem;
                  font-weight: 700;
                  transition: all 0.3s ease;
                }

                .btn-detail {
                  background: linear-gradient(135deg,
                      var(--primary) 0%,
                      var(--primary-dark) 100%);
                  color: white;
                  box-shadow: 0 4px 10px rgba(74, 144, 226, 0.3);
                }

                .btn-detail:hover {
                  transform: translateY(-2px);
                  box-shadow: 0 8px 20px rgba(74, 144, 226, 0.4);
                }

                .no-invoice {
                  text-align: center;
                  padding: 80px 20px;
                  color: var(--muted-text);
                }

                .no-invoice i {
                  font-size: 5rem;
                  color: var(--primary);
                  margin-bottom: 20px;
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

                .no-invoice h3 {
                  color: var(--primary);
                  font-size: 1.8rem;
                  margin-bottom: 10px;
                  font-weight: 700;
                }

                .no-invoice p {
                  font-size: 1.1rem;
                  font-weight: 500;
                }

                .amount {
                  font-weight: 700;
                  color: var(--primary);
                  font-size: 1.05rem;
                }

                .invoice-id {
                  color: var(--primary);
                  font-weight: 700;
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

                  .container {
                    padding: 0 15px;
                  }

                  .table-container {
                    overflow-x: auto;
                  }

                  .invoice-table {
                    font-size: 0.85rem;
                  }

                  .invoice-table th,
                  .invoice-table td {
                    padding: 12px 8px;
                  }

                  .welcome-message h3 {
                    font-size: 1.2rem;
                  }

                  .no-invoice i {
                    font-size: 3rem;
                  }

                  .no-invoice h3 {
                    font-size: 1.5rem;
                  }
                }
              </style>
            </head>

            <body>
              <!-- Header -->
              <div class="header">
                <h1>
                  <i class="fas fa-building"></i>
                  ThanaChok Place
                </h1>

                <div class="nav-menu">
                  <a href="Homesucess" class="nav-link"><i class="fas fa-home"></i> หน้าหลัก</a>
                  <a href="YourRoom" class="nav-link"><i class="fas fa-door-open"></i> ห้องของฉัน</a>
                  <a href="Listinvoice" class="nav-link active"><i class="fas fa-file-invoice"></i> บิลค่าใช้จ่าย</a>
                  <a href="Record" class="nav-link"><i class="fas fa-history"></i> ประวัติการจอง</a>
                </div>

                <div class="user-section">
                  <div class="user-info">
                    <i class="fas fa-user-circle"></i>
                    <span>${loginMember.firstName} ${loginMember.lastName}</span>
                  </div>
                  <form action="Logout" method="post" style="margin: 0">
                    <button type="submit" class="logout-btn">
                      <i class="fas fa-sign-out-alt"></i>
                      ออกจากระบบ
                    </button>
                  </form>
                </div>
              </div>

              <!-- Container -->
              <div class="container">
                <!-- Welcome Message -->
                <div class="welcome-message">
                  <h3>
                    <i class="fas fa-file-invoice"></i>
                    รายการใบแจ้งหนี้
                  </h3>
                  <p>ใบแจ้งหนี้ค่าเช่าห้องพักและค่าใช้จ่ายต่างๆ ของคุณ</p>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                  <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                  </div>
                </c:if>

                <!-- Invoice List -->
                <c:choose>
                  <c:when test="${empty invoices}">
                    <div class="table-container">
                      <div class="no-invoice">
                        <i class="fas fa-inbox"></i>
                        <h3>ไม่มีใบแจ้งหนี้</h3>
                        <p>ขณะนี้ยังไม่มีใบแจ้งหนี้สำหรับคุณ</p>
                      </div>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="table-container">
                      <table class="invoice-table">
                        <thead>
                          <tr>
                            <th><i class="fas fa-hashtag"></i> เลขบิล</th>
                            <th><i class="fas fa-calendar-alt"></i> เดือน</th>
                            <th><i class="fas fa-money-bill-wave"></i> จำนวนเงิน</th>
                            <th><i class="fas fa-info-circle"></i> สถานะ</th>
                            <th><i class="fas fa-cog"></i> การดำเนินการ</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="invoice" items="${invoices}" varStatus="status">
                            <tr>
                              <td class="invoice-id">${status.count}</td>
                              <td>
                                <fmt:formatDate value="${invoice.issueDate}" pattern="MMMM yyyy" var="monthYear" />
                                ${monthYear}
                              </td>
                              <td class="amount">
                                ฿
                                <fmt:formatNumber value="${invoice.totalAmount}" groupingUsed="true"
                                  minFractionDigits="2" />
                              </td>
                              <td>
                                <c:choose>
                                  <c:when test="${invoice.status == 1}">
                                    <span class="status-paid">
                                      <i class="fas fa-check-circle"></i> ชำระแล้ว
                                    </span>
                                  </c:when>
                                  <c:otherwise>
                                    <span class="status-unpaid">
                                      <i class="fas fa-exclamation-circle"></i>
                                      ค้างชำระ
                                    </span>
                                  </c:otherwise>
                                </c:choose>
                              </td>
                              <td>
                                <a href="InvoiceDetail?invoiceId=${invoice.invoiceId}" class="btn btn-detail">
                                  <i class="fas fa-eye"></i> ดูรายละเอียด
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

              <script>
                // Alert message
                <c:if test="${not empty message}">alert("${message}");</c:if>;

                // Initialize on load
                window.addEventListener("load", function () {
                  // Page load animation
                  document.body.style.opacity = "0";
                  document.body.style.transition = "opacity 0.5s ease-in-out";

                  setTimeout(function () {
                    document.body.style.opacity = "1";
                  }, 100);
                });

                // Add hover effect to table rows
                document.querySelectorAll(".invoice-table tbody tr").forEach((row) => {
                  row.addEventListener("mouseenter", function () {
                    this.style.boxShadow = "0 4px 20px rgba(92, 169, 233, 0.15)";
                  });

                  row.addEventListener("mouseleave", function () {
                    this.style.boxShadow = "none";
                  });
                });
              </script>
            </body>

            </html>