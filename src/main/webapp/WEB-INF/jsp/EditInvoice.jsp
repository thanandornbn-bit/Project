<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <%@ page session="true" %>
        <%@ page import="com.springmvc.model.Manager" %>
          <% Manager loginManager=(Manager) session.getAttribute("loginManager"); if (loginManager==null) {
            response.sendRedirect("Login"); return; } %>

            <!DOCTYPE html>
            <html lang="th">

            <head>
              <meta charset="UTF-8" />
              <meta name="viewport" content="width=device-width, initial-scale=1.0" />
              <title>จัดการบิลห้อง ${room.roomNumber} - ThanaChok Place</title>
              <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
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

                .container {
                  max-width: 1400px;
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
                  padding: 12px 24px;
                  background: var(--primary);
                  color: white;
                  text-decoration: none;
                  border-radius: 8px;
                  transition: all 0.3s ease;
                  font-weight: 600;
                  border: none;
                }

                .back-btn:hover {
                  background: var(--primary-dark);
                  transform: translateX(-5px);
                  box-shadow: 0 4px 12px rgba(92, 169, 233, 0.3);
                }

                .alert {
                  padding: 16px 20px;
                  border-radius: 8px;
                  margin-bottom: 24px;
                  display: flex;
                  align-items: center;
                  gap: 12px;
                  animation: slideInDown 0.5s ease;
                  font-weight: 500;
                }

                @keyframes slideInDown {
                  from {
                    opacity: 0;
                    transform: translateY(-20px);
                  }

                  to {
                    opacity: 1;
                    transform: translateY(0);
                  }
                }

                .alert-success {
                  background: #e8f5e9;
                  border: 1px solid var(--success);
                  color: var(--success);
                }

                .alert-error {
                  background: #ffebee;
                  border: 1px solid var(--danger);
                  color: var(--danger);
                }

                .room-info-card {
                  background: white;
                  border-radius: 12px;
                  padding: 28px;
                  margin-bottom: 28px;
                  border: 1px solid var(--card-border);
                  box-shadow: 0 2px 8px rgba(92, 169, 233, 0.08);
                }

                .room-info-card h3 {
                  color: var(--primary);
                  margin-bottom: 20px;
                  font-size: 1.5rem;
                  font-weight: 600;
                  display: flex;
                  align-items: center;
                  gap: 10px;
                }

                .room-info-grid {
                  display: grid;
                  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                  gap: 16px;
                }

                .room-info-item {
                  background: var(--muted-bg);
                  padding: 16px;
                  border-radius: 8px;
                  border-left: 4px solid var(--primary);
                }

                .room-info-item strong {
                  color: #7a8b99;
                  display: block;
                  font-size: 0.9rem;
                  margin-bottom: 6px;
                  font-weight: 500;
                }

                .room-info-item span {
                  color: var(--text);
                  font-size: 1.1rem;
                  font-weight: 600;
                }

                .table-container {
                  background: white;
                  border-radius: 12px;
                  box-shadow: 0 2px 8px rgba(92, 169, 233, 0.08);
                  border: 1px solid var(--card-border);
                  overflow: hidden;
                  margin-bottom: 28px;
                }

                .table-header {
                  background: linear-gradient(135deg,
                      var(--primary),
                      var(--primary-dark));
                  color: white;
                  padding: 24px 28px;
                }

                .table-header h2 {
                  font-size: 1.5rem;
                  font-weight: 600;
                  margin: 0;
                  display: flex;
                  align-items: center;
                  gap: 12px;
                }

                .invoice-table {
                  width: 100%;
                  border-collapse: collapse;
                }

                .invoice-table thead {
                  background: var(--muted-bg);
                }

                .invoice-table th {
                  padding: 16px;
                  text-align: left;
                  color: var(--primary);
                  font-weight: 600;
                  border-bottom: 2px solid var(--card-border);
                  white-space: nowrap;
                }

                .invoice-table td {
                  padding: 16px;
                  border-bottom: 1px solid #f0f0f0;
                  color: var(--text);
                }

                .invoice-table tbody tr {
                  transition: all 0.2s ease;
                }

                .invoice-table tbody tr:hover {
                  background: var(--hover-bg);
                }

                .amount {
                  color: var(--success);
                  font-weight: 600;
                  font-size: 1.05rem;
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

                .status-paid {
                  background: #e8f5e9;
                  color: var(--success);
                  border: 1px solid var(--success);
                }

                .status-unpaid {
                  background: #fff3e0;
                  color: var(--warning);
                  border: 1px solid var(--warning);
                }

                .action-buttons {
                  display: flex;
                  gap: 8px;
                  flex-wrap: wrap;
                }

                .btn {
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

                .btn-edit {
                  background: var(--primary);
                  color: white;
                  border: none;
                }

                .btn-edit:hover:not(.btn-disabled) {
                  background: var(--primary-dark);
                  transform: translateY(-2px);
                  box-shadow: 0 4px 12px rgba(92, 169, 233, 0.3);
                }

                .btn-delete {
                  background: var(--danger);
                  color: white;
                  border: none;
                }

                .btn-delete:hover:not(.btn-disabled) {
                  background: #d32f2f;
                  transform: translateY(-2px);
                  box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
                }

                .btn-disabled {
                  background: #e0e0e0 !important;
                  color: #9e9e9e !important;
                  cursor: not-allowed !important;
                  opacity: 0.6;
                  pointer-events: none;
                }

                .btn-create {
                  background: linear-gradient(135deg,
                      var(--primary),
                      var(--primary-dark));
                  color: white;
                  border: none;
                  padding: 14px 28px;
                  font-size: 1.05rem;
                  box-shadow: 0 4px 12px rgba(92, 169, 233, 0.3);
                }

                .btn-create:hover {
                  transform: translateY(-2px);
                  box-shadow: 0 6px 16px rgba(92, 169, 233, 0.4);
                }

                .no-invoice-state {
                  text-align: center;
                  padding: 80px 20px;
                  color: #7a8b99;
                }

                .no-invoice-icon {
                  font-size: 5rem;
                  color: var(--primary);
                  opacity: 0.3;
                  margin-bottom: 25px;
                }

                .no-invoice-state h3 {
                  color: var(--text);
                  margin-bottom: 15px;
                  font-size: 1.8rem;
                  font-weight: 600;
                }

                .no-invoice-state p {
                  margin-bottom: 30px;
                  font-size: 1.05rem;
                  color: #7a8b99;
                }

                .modal {
                  display: none;
                  position: fixed;
                  z-index: 1000;
                  left: 0;
                  top: 0;
                  width: 100%;
                  height: 100%;
                  background-color: rgba(0, 0, 0, 0.6);
                  animation: fadeIn 0.3s ease;
                }

                @keyframes fadeIn {
                  from {
                    opacity: 0;
                  }

                  to {
                    opacity: 1;
                  }
                }

                .modal-content {
                  background: white;
                  margin: 10% auto;
                  padding: 0;
                  border: 1px solid var(--card-border);
                  border-radius: 12px;
                  width: 90%;
                  max-width: 500px;
                  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
                  animation: slideDown 0.3s ease;
                }

                @keyframes slideDown {
                  from {
                    transform: translateY(-50px);
                    opacity: 0;
                  }

                  to {
                    transform: translateY(0);
                    opacity: 1;
                  }
                }

                .modal-header {
                  background: linear-gradient(135deg, var(--danger), #d32f2f);
                  color: white;
                  padding: 24px;
                  border-radius: 11px 11px 0 0;
                  font-size: 1.4rem;
                  font-weight: 600;
                  display: flex;
                  align-items: center;
                  gap: 12px;
                }

                .modal-body {
                  padding: 28px;
                  color: var(--text);
                }

                .modal-body p {
                  margin-bottom: 14px;
                  line-height: 1.6;
                }

                .modal-body strong {
                  color: var(--primary);
                  font-weight: 600;
                }

                .modal-buttons {
                  display: flex;
                  gap: 12px;
                  justify-content: center;
                  padding: 0 28px 28px;
                }

                .btn-confirm {
                  background: linear-gradient(135deg, var(--danger), #d32f2f);
                  color: white;
                  padding: 12px 28px;
                  border: none;
                  border-radius: 8px;
                  font-size: 1rem;
                  font-weight: 600;
                  cursor: pointer;
                  transition: all 0.3s ease;
                  font-family: "Sarabun", sans-serif;
                }

                .btn-confirm:hover {
                  transform: translateY(-2px);
                  box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
                }

                .btn-cancel {
                  background: #e0e0e0;
                  color: var(--text);
                  padding: 12px 28px;
                  border: none;
                  border-radius: 8px;
                  font-size: 1rem;
                  font-weight: 600;
                  cursor: pointer;
                  transition: all 0.3s ease;
                  font-family: "Sarabun", sans-serif;
                }

                .btn-cancel:hover {
                  background: #bdbdbd;
                  transform: translateY(-2px);
                }

                .create-invoice-section {
                  text-align: center;
                  margin-top: 28px;
                  padding: 32px;
                  background: var(--muted-bg);
                  border-radius: 12px;
                  border: 2px dashed var(--primary);
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

                /* Tooltip สำหรับปุ่ม disabled */
                .btn-wrapper {
                  position: relative;
                  display: inline-block;
                }

                .btn-wrapper .tooltip {
                  visibility: hidden;
                  background-color: var(--text);
                  color: white;
                  text-align: center;
                  border-radius: 6px;
                  padding: 8px 12px;
                  position: absolute;
                  z-index: 1;
                  bottom: 125%;
                  left: 50%;
                  transform: translateX(-50%);
                  white-space: nowrap;
                  opacity: 0;
                  transition: opacity 0.3s;
                  font-size: 0.85rem;
                }

                .btn-wrapper .tooltip::after {
                  content: "";
                  position: absolute;
                  top: 100%;
                  left: 50%;
                  margin-left: -5px;
                  border-width: 5px;
                  border-style: solid;
                  border-color: var(--text) transparent transparent transparent;
                }

                .btn-wrapper:hover .tooltip {
                  visibility: visible;
                  opacity: 1;
                }

                @media (max-width: 768px) {
                  .container {
                    padding: 15px;
                  }

                  .page-header {
                    font-size: 2rem;
                  }

                  .room-info-grid {
                    grid-template-columns: 1fr;
                  }

                  .invoice-table {
                    font-size: 0.85rem;
                  }

                  .invoice-table th,
                  .invoice-table td {
                    padding: 12px 8px;
                  }

                  .action-buttons {
                    flex-direction: column;
                  }

                  .btn {
                    width: 100%;
                    justify-content: center;
                  }

                  .modal-content {
                    width: 95%;
                    margin: 20% auto;
                  }
                }
              </style>
            </head>

            <body>
              <div class="loading" id="loading">
                <div class="spinner"></div>
              </div>

              <div class="container">
                <div class="page-header">
                  <i class="fas fa-file-invoice-dollar"></i>
                  จัดการบิลห้องพัก
                </div>

                <a href="OwnerHome" class="back-btn">
                  <i class="fas fa-arrow-left"></i>
                  กลับหน้าหลัก
                </a>

                <!-- Alert Messages -->
                <c:if test="${not empty message}">
                  <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    ${message}
                  </div>
                </c:if>

                <c:if test="${not empty error}">
                  <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                  </div>
                </c:if>

                <!-- Room Information -->
                <div class="room-info-card">
                  <h3>
                    <i class="fas fa-home"></i>
                    ข้อมูลห้องพัก
                  </h3>
                  <div class="room-info-grid">
                    <div class="room-info-item">
                      <strong><i class="fas fa-door-open"></i> หมายเลขห้อง</strong>
                      <span>${room.roomNumber}</span>
                    </div>
                    <div class="room-info-item">
                      <strong><i class="fas fa-tag"></i> ประเภทห้อง</strong>
                      <span>${room.roomtype}</span>
                    </div>
                    <div class="room-info-item">
                      <strong><i class="fas fa-money-bill-wave"></i> ราคาห้อง</strong>
                      <span>฿${room.roomPrice}/เดือน</span>
                    </div>
                    <div class="room-info-item">
                      <strong><i class="fas fa-info-circle"></i> สถานะห้อง</strong>
                      <span>${room.roomStatus}</span>
                    </div>
                  </div>
                </div>

                <!-- Invoice List or Empty State -->
                <c:choose>
                  <c:when test="${empty invoices}">
                    <div class="table-container">
                      <div class="table-header">
                        <h2>
                          <i class="fas fa-receipt"></i>
                          รายการใบแจ้งหนี้
                        </h2>
                      </div>
                      <div class="no-invoice-state">
                        <div class="no-invoice-icon">
                          <i class="fas fa-file-invoice"></i>
                        </div>
                        <h3>ยังไม่มีใบแจ้งหนี้</h3>
                        <p>ห้องนี้ยังไม่มีประวัติใบแจ้งหนี้</p>
                        <a href="ManagerAddInvoice?roomID=${room.roomID}" class="btn btn-create">
                          <i class="fas fa-plus-circle"></i>
                          สร้างใบแจ้งหนี้ใหม่
                        </a>
                      </div>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="table-container">
                      <div class="table-header">
                        <h2>
                          <i class="fas fa-receipt"></i>
                          รายการใบแจ้งหนี้ทั้งหมด
                        </h2>
                      </div>
                      <table class="invoice-table">
                        <thead>
                          <tr>
                            <th><i class="fas fa-hashtag"></i> เลขที่ใบแจ้งหนี้</th>
                            <th><i class="fas fa-calendar-plus"></i> วันที่ออกบิล</th>
                            <th><i class="fas fa-calendar-check"></i> วันครบกำหนด</th>
                            <th><i class="fas fa-dollar-sign"></i> จำนวนเงิน</th>
                            <th><i class="fas fa-flag"></i> สถานะ</th>
                            <th><i class="fas fa-cogs"></i> การจัดการ</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="invoice" items="${invoices}">
                            <tr>
                              <td>
                                <strong style="color: #ff8c00">INV-${invoice.invoiceId}</strong>
                              </td>
                              <td>
                                <c:choose>
                                  <c:when test="${not empty invoice.issueDate}">
                                    <i class="fas fa-calendar"></i> ${invoice.issueDate}
                                  </c:when>
                                  <c:otherwise>-</c:otherwise>
                                </c:choose>
                              </td>
                              <td>
                                <c:choose>
                                  <c:when test="${not empty invoice.dueDate}">
                                    <i class="fas fa-calendar"></i> ${invoice.dueDate}
                                  </c:when>
                                  <c:otherwise>-</c:otherwise>
                                </c:choose>
                              </td>
                              <td class="amount">
                                ฿
                                <fmt:formatNumber value="${invoice.totalAmount}" groupingUsed="true"
                                  minFractionDigits="2" />
                              </td>
                              <td>
                                <c:choose>
                                  <c:when test="${invoice.status == 1}">
                                    <span class="status-badge status-paid">
                                      <i class="fas fa-check-circle"></i> ชำระแล้ว
                                    </span>
                                  </c:when>
                                  <c:otherwise>
                                    <span class="status-badge status-unpaid">
                                      <i class="fas fa-clock"></i> ยังไม่ได้ชำระ
                                    </span>
                                  </c:otherwise>
                                </c:choose>
                              </td>
                              <td>
                                <div class="action-buttons">
                                  <!-- ปุ่มแก้ไขข้อมูลบิล -->
                                  <c:choose>
                                    <c:when test="${invoice.status == 1}">
                                      <div class="btn-wrapper">
                                        <span class="btn btn-edit btn-disabled"
                                          title="ไม่สามารถแก้ไขได้ เนื่องจากชำระเงินแล้ว">
                                          <i class="fas fa-ban"></i> แก้ไขไม่ได้
                                        </span>
                                        <span class="tooltip">ไม่สามารถแก้ไขได้ เนื่องจากชำระเงินแล้ว</span>
                                      </div>
                                    </c:when>
                                    <c:otherwise>
                                      <a href="EditInvoiceFormFull?invoiceId=${invoice.invoiceId}" class="btn btn-edit"
                                        title="แก้ไขข้อมูลบิล">
                                        <i class="fas fa-edit"></i> แก้ไขข้อมูล
                                      </a>
                                    </c:otherwise>
                                  </c:choose>

                                  <!-- ปุ่มลบ -->
                                  <c:choose>
                                    <c:when test="${invoice.status == 1}">
                                      <div class="btn-wrapper">
                                        <span class="btn btn-delete btn-disabled"
                                          title="ไม่สามารถลบได้ เนื่องจากชำระเงินแล้ว">
                                          <i class="fas fa-ban"></i> ลบไม่ได้
                                        </span>
                                        <span class="tooltip">ไม่สามารถลบได้ เนื่องจากชำระเงินแล้ว</span>
                                      </div>
                                    </c:when>
                                    <c:otherwise>
                                      <a href="javascript:void(0)" class="btn btn-delete" title="ลบใบแจ้งหนี้"
                                        onclick="confirmDelete(${invoice.invoiceId}, 'INV-${invoice.invoiceId}')">
                                        <i class="fas fa-trash"></i> ลบ
                                      </a>
                                    </c:otherwise>
                                  </c:choose>
                                </div>
                              </td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>

                    <!-- Create New Invoice Section -->
                    <div class="create-invoice-section">
                      <a href="ManagerAddInvoice?roomID=${room.roomID}" class="btn btn-create">
                        <i class="fas fa-plus-circle"></i>
                        สร้างใบแจ้งหนี้ใหม่
                      </a>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>

              <!-- Delete Confirmation Modal -->
              <div id="deleteModal" class="modal">
                <div class="modal-content">
                  <div class="modal-header">
                    <i class="fas fa-exclamation-triangle"></i>
                    ยืนยันการลบ
                  </div>
                  <div class="modal-body">
                    <p>
                      คุณต้องการลบใบแจ้งหนี้ <strong id="invoiceNumber"></strong> หรือไม่?
                    </p>
                    <p style="color: #ff4444; font-size: 0.95rem">
                      <i class="fas fa-info-circle"></i>
                      <strong>หมายเหตุ:</strong>
                      สามารถลบได้เฉพาะใบแจ้งหนี้ที่ยังไม่ได้ชำระเท่านั้น
                    </p>
                    <p style="color: #ff4444; font-size: 0.95rem">
                      <i class="fas fa-exclamation-circle"></i>
                      การลบนี้ไม่สามารถย้อนกลับได้
                    </p>
                  </div>
                  <div class="modal-buttons">
                    <button type="button" class="btn-confirm" onclick="deleteInvoice()">
                      <i class="fas fa-check"></i> ยืนยันลบ
                    </button>
                    <button type="button" class="btn-cancel" onclick="closeModal()">
                      <i class="fas fa-times"></i> ยกเลิก
                    </button>
                  </div>
                </div>
              </div>

              <script>
                let invoiceToDelete = null;

                function confirmDelete(invoiceId, invoiceNumber) {
                  invoiceToDelete = invoiceId;
                  document.getElementById("invoiceNumber").textContent = invoiceNumber;
                  document.getElementById("deleteModal").style.display = "block";
                }

                function closeModal() {
                  document.getElementById("deleteModal").style.display = "none";
                  invoiceToDelete = null;
                }

                function deleteInvoice() {
                  if (invoiceToDelete) {
                    const roomID = "${room.roomID}";
                    const deleteUrl =
                      "DeleteInvoice?invoiceId=" + invoiceToDelete + "&roomID=" + roomID;

                    document.getElementById("loading").style.display = "flex";
                    window.location.href = deleteUrl;
                  }
                }

                window.onclick = function (event) {
                  const modal = document.getElementById("deleteModal");
                  if (event.target === modal) {
                    closeModal();
                  }
                };

                document.addEventListener("keydown", function (event) {
                  if (event.key === "Escape") {
                    closeModal();
                  }
                });

                // Auto hide alerts after 5 seconds
                window.addEventListener("load", function () {
                  const alerts = document.querySelectorAll(".alert");
                  alerts.forEach(function (alert) {
                    setTimeout(function () {
                      alert.style.transition = "opacity 0.5s ease";
                      alert.style.opacity = "0";
                      setTimeout(() => alert.remove(), 500);
                    }, 5000);
                  });

                  // Hide loading
                  setTimeout(() => {
                    document.getElementById("loading").style.display = "none";
                  }, 500);

                  // Fade in animation
                  document.body.style.opacity = "0";
                  document.body.style.transition = "opacity 0.5s ease-in-out";
                  setTimeout(() => {
                    document.body.style.opacity = "1";
                  }, 100);
                });
              </script>
            </body>

            </html>