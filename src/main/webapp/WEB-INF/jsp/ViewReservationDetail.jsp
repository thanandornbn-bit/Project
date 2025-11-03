<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
              <title>รายละเอียดการเช่า - ThanaChok Place</title>
              <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
              <link rel="preconnect" href="https://fonts.googleapis.com" />
              <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
              <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
              <style>
                :root {
                  --bg: #FFFFFF;
                  --text: #2C3E50;
                  --primary: #5CA9E9;
                  --primary-dark: #4A8AC7;
                  --muted-bg: #F0F7FF;
                  --success: #4CAF50;
                  --warning: #FFC107;
                  --danger: #F44336;
                  --card-border: #D1E8FF;
                  --hover-bg: #E8F4FF;
                }

                * {
                  margin: 0;
                  padding: 0;
                  box-sizing: border-box;
                }

                body {
                  font-family: 'Sarabun', sans-serif;
                  background: var(--bg);
                  min-height: 100vh;
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
                  background: var(--muted-bg);
                  border: 2px solid var(--card-border);
                  color: var(--primary);
                  text-decoration: none;
                  border-radius: 10px;
                  transition: all 0.3s ease;
                  font-weight: 600;
                }

                .back-btn:hover {
                  background: var(--hover-bg);
                  border-color: var(--primary);
                  transform: translateX(-5px);
                }

                .success-message,
                .error-message {
                  padding: 20px 25px;
                  border-radius: 12px;
                  margin-bottom: 25px;
                  display: flex;
                  align-items: center;
                  gap: 12px;
                  font-weight: 500;
                }

                .success-message {
                  background: rgba(76, 175, 80, 0.1);
                  border: 2px solid var(--success);
                  color: var(--success);
                }

                .error-message {
                  background: rgba(244, 67, 54, 0.1);
                  border: 2px solid var(--danger);
                  color: var(--danger);
                }

                .detail-card {
                  background: var(--bg);
                  border-radius: 20px;
                  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                  border: 2px solid var(--card-border);
                  overflow: hidden;
                }

                .card-header {
                  background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                  color: white;
                  padding: 30px;
                  position: relative;
                }

                .card-header h2 {
                  font-size: 2rem;
                  font-weight: 700;
                  margin: 0;
                  display: flex;
                  align-items: center;
                  gap: 12px;
                }

                .card-body {
                  padding: 40px;
                }

                .info-grid {
                  display: grid;
                  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
                  gap: 25px;
                  margin-bottom: 30px;
                }

                .info-section {
                  background: var(--muted-bg);
                  border: 2px solid var(--card-border);
                  border-radius: 15px;
                  padding: 25px;
                  transition: all 0.3s ease;
                }

                .info-section:hover {
                  transform: translateY(-3px);
                  border-color: var(--primary);
                  box-shadow: 0 8px 25px rgba(92, 169, 233, 0.15);
                }

                .info-section h3 {
                  color: var(--primary);
                  font-size: 1.3rem;
                  font-weight: 600;
                  margin-bottom: 20px;
                  display: flex;
                  align-items: center;
                  gap: 10px;
                  padding-bottom: 15px;
                  border-bottom: 2px solid var(--card-border);
                }

                .info-item {
                  display: flex;
                  justify-content: space-between;
                  align-items: center;
                  padding: 12px 0;
                  border-bottom: 1px solid var(--card-border);
                }

                .info-item:last-child {
                  border-bottom: none;
                }

                .info-label {
                  color: #7D8A95;
                  font-weight: 500;
                  display: flex;
                  align-items: center;
                  gap: 8px;
                }

                .info-value {
                  color: var(--text);
                  font-weight: 600;
                  text-align: right;
                }

                .status-badge {
                  display: inline-flex;
                  align-items: center;
                  gap: 8px;
                  padding: 8px 16px;
                  border-radius: 20px;
                  font-weight: 600;
                  font-size: 0.95rem;
                }

                .status-approved {
                  background: rgba(76, 175, 80, 0.1);
                  color: var(--success);
                  border: 2px solid var(--success);
                }

                .status-pending {
                  background: rgba(255, 193, 7, 0.1);
                  color: var(--warning);
                  border: 2px solid var(--warning);
                }

                .slip-section {
                  grid-column: 1 / -1;
                  background: var(--muted-bg);
                  border: 2px solid var(--card-border);
                  border-radius: 15px;
                  padding: 25px;
                }

                .slip-section h3 {
                  color: var(--primary);
                  font-size: 1.3rem;
                  font-weight: 600;
                  margin-bottom: 20px;
                  display: flex;
                  align-items: center;
                  gap: 10px;
                  padding-bottom: 15px;
                  border-bottom: 2px solid var(--card-border);
                }

                .slip-image-container {
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  background: var(--bg);
                  border-radius: 12px;
                  padding: 20px;
                  min-height: 400px;
                }

                .slip-image {
                  max-width: 100%;
                  max-height: 600px;
                  border-radius: 10px;
                  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                  cursor: pointer;
                  transition: all 0.3s ease;
                  border: 3px solid var(--card-border);
                }

                .slip-image:hover {
                  transform: scale(1.02);
                  box-shadow: 0 8px 30px rgba(92, 169, 233, 0.3);
                  border-color: var(--primary);
                }

                .no-image {
                  text-align: center;
                  padding: 60px 20px;
                  color: #7D8A95;
                }

                .no-image i {
                  font-size: 4rem;
                  color: var(--card-border);
                  margin-bottom: 20px;
                }

                .no-image h4 {
                  color: var(--primary);
                  margin-bottom: 10px;
                  font-size: 1.3rem;
                  font-weight: 600;
                }

                .modal {
                  display: none;
                  position: fixed;
                  z-index: 1000;
                  left: 0;
                  top: 0;
                  width: 100%;
                  height: 100%;
                  background-color: rgba(0, 0, 0, 0.9);
                }

                .modal-content {
                  margin: auto;
                  display: block;
                  max-width: 90%;
                  max-height: 90%;
                  position: absolute;
                  top: 50%;
                  left: 50%;
                  transform: translate(-50%, -50%);
                  border-radius: 10px;
                  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
                }

                .close {
                  position: absolute;
                  top: 20px;
                  right: 40px;
                  color: #fff;
                  font-size: 40px;
                  font-weight: bold;
                  cursor: pointer;
                  z-index: 1001;
                  transition: all 0.3s ease;
                  background: var(--danger);
                  width: 50px;
                  height: 50px;
                  border-radius: 50%;
                  display: flex;
                  align-items: center;
                  justify-content: center;
                }

                .close:hover {
                  background: #D32F2F;
                  transform: rotate(90deg);
                }

                .action-section {
                  margin-top: 30px;
                  padding-top: 30px;
                  border-top: 2px solid var(--card-border);
                }

                .button-group {
                  display: flex;
                  gap: 15px;
                  justify-content: center;
                  flex-wrap: wrap;
                }

                .btn {
                  padding: 18px 40px;
                  border: none;
                  border-radius: 12px;
                  cursor: pointer;
                  font-size: 1.1rem;
                  font-weight: 600;
                  font-family: 'Sarabun', sans-serif;
                  transition: all 0.3s ease;
                  text-decoration: none;
                  display: inline-flex;
                  align-items: center;
                  gap: 10px;
                  min-width: 200px;
                  justify-content: center;
                }

                .btn-approve {
                  background: var(--success);
                  color: white;
                  box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
                }

                .btn-approve:hover {
                  background: #45A049;
                  transform: translateY(-2px);
                  box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
                }

                .btn-disabled {
                  background: #E0E0E0;
                  color: #9E9E9E;
                  border: 2px solid #BDBDBD;
                  cursor: not-allowed;
                  opacity: 0.6;
                }

                .btn-back {
                  background: var(--muted-bg);
                  color: var(--primary);
                  border: 2px solid var(--primary);
                }

                .btn-back:hover {
                  background: var(--primary);
                  color: white;
                  transform: translateY(-2px);
                }

                .btn-reject {
                  background: rgba(244, 67, 54, 0.1);
                  color: var(--danger);
                  border: 2px solid var(--danger);
                }

                .btn-reject:hover {
                  background: var(--danger);
                  color: white;
                  transform: translateY(-2px);
                  box-shadow: 0 6px 20px rgba(244, 67, 54, 0.3);
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
                  border: 6px solid var(--card-border);
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

                @media (max-width: 768px) {
                  .container {
                    padding: 15px;
                  }

                  .page-header {
                    font-size: 2rem;
                  }

                  .card-body {
                    padding: 25px 20px;
                  }

                  .info-grid {
                    grid-template-columns: 1fr;
                  }

                  .button-group {
                    flex-direction: column;
                    align-items: center;
                  }

                  .btn {
                    width: 100%;
                    max-width: 300px;
                  }

                  .slip-image-container {
                    min-height: 300px;
                  }

                  .close {
                    top: 10px;
                    right: 20px;
                    width: 40px;
                    height: 40px;
                    font-size: 30px;
                  }
                }
              </style>
            </head>

            <body>
              <div class="loading" id="loading">
                <div class="spinner"></div>
              </div>

              <div id="imageModal" class="modal">
                <span class="close">&times;</span>
                <img class="modal-content" id="modalImage" />
              </div>

              <div class="container">
                <div class="page-header">
                  <i class="fas fa-file-contract"></i>
                  รายละเอียดการเช่า
                </div>

                <a href="OViewReserve" class="back-btn">
                  <i class="fas fa-arrow-left"></i>
                  กลับไปหน้ารายการจอง
                </a>

                <c:if test="${not empty error}">
                  <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                  </div>
                </c:if>

                <c:choose>
                  <c:when test="${not empty rent}">
                    <div class="detail-card">
                      <div class="card-header">
                        <h2>
                          <i class="fas fa-home"></i>
                          ห้อง ${rent.room.roomNumber}
                        </h2>
                      </div>

                      <div class="card-body">
                        <div class="info-grid">
                          <div class="info-section">
                            <h3>
                              <i class="fas fa-door-open"></i>
                              ข้อมูลห้องพัก
                            </h3>
                            <div class="info-item">
                              <span class="info-label">
                                <i class="fas fa-hashtag"></i>
                                หมายเลขห้อง:
                              </span>
                              <span class="info-value">${rent.room.roomNumber}</span>
                            </div>
                            <div class="info-item">
                              <span class="info-label">
                                <i class="fas fa-home"></i>
                                ประเภทห้อง:
                              </span>
                              <span class="info-value">${rent.room.roomtype}</span>
                            </div>
                            <div class="info-item">
                              <span class="info-label">
                                <i class="fas fa-money-bill-wave"></i>
                                ราคาห้อง:
                              </span>
                              <span class="info-value">฿
                                <fmt:formatNumber value="${rent.room.roomPrice}" groupingUsed="true" />
                              </span>
                            </div>
                            <div class="info-item">
                              <span class="info-label">
                                <i class="fas fa-calendar-alt"></i>
                                วันที่เช่า:
                              </span>
                              <span class="info-value">
                                <fmt:formatDate value="${rent.rentDate}" pattern="dd/MM/yyyy" />
                              </span>
                            </div>
                            <c:if test="${not empty rent.returnDate}">
                              <div class="info-item">
                                <span class="info-label">
                                  <i class="fas fa-calendar-times"></i>
                                  วันที่คืนห้อง:
                                </span>
                                <span class="info-value">
                                  <fmt:formatDate value="${rent.returnDate}" pattern="dd/MM/yyyy" />
                                </span>
                              </div>
                            </c:if>
                          </div>

                          <div class="info-section">
                            <h3>
                              <i class="fas fa-user"></i>
                              ข้อมูลผู้เช่า
                            </h3>
                            <div class="info-item">
                              <span class="info-label">
                                <i class="fas fa-user-circle"></i>
                                ชื่อ-นามสกุล:
                              </span>
                              <span class="info-value">${rent.member.firstName} ${rent.member.lastName}</span>
                            </div>
                            <div class="info-item">
                              <span class="info-label">
                                <i class="fas fa-envelope"></i>
                                อีเมล:
                              </span>
                              <span class="info-value">${rent.member.email}</span>
                            </div>
                            <div class="info-item">
                              <span class="info-label">
                                <i class="fas fa-phone"></i>
                                เบอร์โทรศัพท์:
                              </span>
                              <span class="info-value">${rent.member.phoneNumber}</span>
                            </div>
                          </div>

                          <div class="info-section">
                            <h3>
                              <i class="fas fa-credit-card"></i>
                              ข้อมูลการชำระเงิน
                            </h3>
                            <c:if test="${not empty rent.transferAccountName}">
                              <div class="info-item">
                                <span class="info-label">
                                  <i class="fas fa-user-tag"></i>
                                  ชื่อบัญชีที่โอน:
                                </span>
                                <span class="info-value">${rent.transferAccountName}</span>
                              </div>
                            </c:if>
                            <c:if test="${not empty rent.deadline}">
                              <div class="info-item">
                                <span class="info-label">
                                  <i class="fas fa-clock"></i>
                                  วันครบกำหนด:
                                </span>
                                <span class="info-value">
                                  <fmt:formatDate value="${rent.deadline}" pattern="dd/MM/yyyy" />
                                </span>
                              </div>
                            </c:if>
                            <c:if test="${not empty rent.totalPrice}">
                              <div class="info-item">
                                <span class="info-label">
                                  <i class="fas fa-money-bill"></i>
                                  จำนวนเงินที่ชำระ:
                                </span>
                                <span class="info-value">฿
                                  <fmt:formatNumber value="${rent.totalPrice}" groupingUsed="true" />
                                </span>
                              </div>
                            </c:if>
                            <div class="info-item">
                              <span class="info-label">
                                <i class="fas fa-tags"></i>
                                สถานะ:
                              </span>
                              <span class="info-value">
                                <c:choose>
                                  <c:when test="${rent.status == 'ชำระแล้ว'}">
                                    <span class="status-badge status-pending">
                                      <i class="fas fa-check-circle"></i> ชำระแล้ว
                                    </span>
                                  </c:when>
                                  <c:when test="${rent.status == 'เสร็จสมบูรณ์'}">
                                    <span class="status-badge status-approved">
                                      <i class="fas fa-home"></i> กำลังเช่าอยู่
                                    </span>
                                  </c:when>
                                  <c:when test="${rent.status == 'รอคืนห้อง'}">
                                    <span class="status-badge status-pending">
                                      <i class="fas fa-hourglass-half"></i> รอคืนห้อง
                                    </span>
                                  </c:when>
                                  <c:when test="${rent.status == 'คืนห้องแล้ว'}">
                                    <span class="status-badge status-approved">
                                      <i class="fas fa-door-closed"></i> คืนห้องแล้ว
                                    </span>
                                  </c:when>
                                  <c:otherwise>
                                    <span class="status-badge status-pending">
                                      <i class="fas fa-question-circle"></i>
                                      ${rent.status}
                                    </span>
                                  </c:otherwise>
                                </c:choose>
                              </span>
                            </div>
                          </div>

                          <div class="slip-section">
                            <h3>
                              <i class="fas fa-image"></i>
                              สลิปการโอนเงิน
                            </h3>
                            <c:choose>
                              <c:when test="${not empty rent.paymentSlipImage}">
                                <div class="slip-image-container">
                                  <img src="${pageContext.request.contextPath}/${rent.paymentSlipImage}"
                                    class="slip-image" alt="สลิปการโอนเงิน" onclick="openModal(this)"
                                    title="คลิกเพื่อดูภาพขนาดใหญ่" />
                                </div>
                              </c:when>
                              <c:otherwise>
                                <div class="no-image">
                                  <i class="fas fa-image"></i>
                                  <h4>ไม่มีภาพสลิปการโอนเงิน</h4>
                                  <p>ยังไม่มีสลิปการโอนเงิน</p>
                                </div>
                              </c:otherwise>
                            </c:choose>
                          </div>
                        </div>

                        <div class="action-section">
                          <div class="button-group">
                            <!-- แสดงปุ่มอนุมัติ/ปฏิเสธ เฉพาะเมื่อสถานะเป็น "รออนุมัติ" -->
                            <c:if test="${rent.status == 'รออนุมัติ'}">
                              <form action="approveDeposit" method="post" style="display: inline"
                                onsubmit="return confirmApproval()">
                                <input type="hidden" name="depositID" value="${rent.rentID}" />
                                <button type="submit" class="btn btn-approve">
                                  <i class="fas fa-check-circle"></i>
                                  อนุมัติค่ามัดจำ
                                </button>
                              </form>

                              <form action="rejectDeposit" method="post" style="display: inline"
                                onsubmit="return confirmReject()">
                                <input type="hidden" name="depositID" value="${rent.rentID}" />
                                <button type="submit" class="btn btn-reject">
                                  <i class="fas fa-times-circle"></i>
                                  ปฏิเสธ
                                </button>
                              </form>
                            </c:if>

                            <!-- ปุ่มกลับแสดงเสมอ -->
                            <a href="OViewReserve" class="btn btn-back">
                              <i class="fas fa-arrow-left"></i>
                              กลับไปรายการจอง
                            </a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="detail-card">
                      <div class="card-body" style="text-align: center; padding: 60px 30px">
                        <i class="fas fa-exclamation-triangle"
                          style="font-size: 4rem; color: #ff4444; margin-bottom: 20px"></i>
                        <h3 style="color: #ff8c00; margin-bottom: 15px">
                          ไม่พบข้อมูลการเช่า
                        </h3>
                        <p style="color: #999; margin-bottom: 30px">
                          ระบบไม่สามารถค้นหาข้อมูลการเช่าที่ต้องการได้
                        </p>
                        <a href="OViewReserve" class="btn btn-back">
                          <i class="fas fa-arrow-left"></i>
                          กลับไปรายการจอง
                        </a>
                      </div>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>

              <script>
                function openModal(img) {
                  const modal = document.getElementById("imageModal");
                  const modalImg = document.getElementById("modalImage");
                  modal.style.display = "block";
                  modalImg.src = img.src;
                }

                document.querySelector(".close").onclick = function () {
                  document.getElementById("imageModal").style.display = "none";
                };

                window.onclick = function (event) {
                  const modal = document.getElementById("imageModal");
                  if (event.target === modal) {
                    modal.style.display = "none";
                  }
                };

                window.addEventListener("load", function () {
                  document.getElementById("loading").style.display = "none";
                });

                // Close modal on Escape key
                document.addEventListener("keydown", function (e) {
                  if (e.key === "Escape") {
                    document.getElementById("imageModal").style.display = "none";
                  }
                });

                // Confirmation functions
                function confirmApproval() {
                  return confirm(
                    "ยืนยันการอนุมัติค่ามัดจำใช่หรือไม่?"
                  );
                }

                function confirmReject() {
                  return confirm(
                    "ยืนยันการปฏิเสธค่ามัดจำใช่หรือไม่?"
                  );
                }
              </script>
            </body>

            </html>