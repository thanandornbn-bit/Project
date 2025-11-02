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
              <title>เพิ่มบิลใหม่ - ThanaChok Place</title>
              <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
              <style>
                * {
                  margin: 0;
                  padding: 0;
                  box-sizing: border-box;
                }

                body {
                  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                  background: linear-gradient(135deg,
                      #1a1a1a 0%,
                      #2d2d2d 50%,
                      #1a1a1a 100%);
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

                .container {
                  max-width: 1000px;
                  margin: 0 auto;
                  padding: 30px 20px;
                  position: relative;
                  z-index: 1;
                }

                .header {
                  text-align: center;
                  color: white;
                  font-size: 2.5rem;
                  font-weight: bold;
                  margin-bottom: 30px;
                  display: flex;
                  align-items: center;
                  justify-content: center;
                  gap: 15px;
                  animation: glow 2s ease-in-out infinite;
                }

                @keyframes glow {

                  0%,
                  100% {
                    text-shadow: 0 0 20px rgba(255, 140, 0, 0.3);
                  }

                  50% {
                    text-shadow: 0 0 30px rgba(255, 140, 0, 0.5),
                      0 0 40px rgba(255, 255, 255, 0.3);
                  }
                }

                .back-btn {
                  display: inline-flex;
                  align-items: center;
                  gap: 8px;
                  margin-bottom: 25px;
                  padding: 12px 25px;
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

                .form-card {
                  background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
                  border-radius: 20px;
                  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
                  border: 1px solid rgba(255, 140, 0, 0.3);
                  overflow: hidden;
                  animation: slideUp 0.6s ease-out;
                }

                @keyframes slideUp {
                  from {
                    opacity: 0;
                    transform: translateY(30px);
                  }

                  to {
                    opacity: 1;
                    transform: translateY(0);
                  }
                }

                .card-header {
                  background: linear-gradient(135deg, #ff8c00, #ff6b00);
                  color: white;
                  padding: 30px;
                  position: relative;
                }

                .card-header h2 {
                  font-size: 1.8rem;
                  margin: 0;
                  display: flex;
                  align-items: center;
                  gap: 12px;
                }

                .card-body {
                  padding: 40px;
                }

                .room-info-card {
                  background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
                  border-radius: 15px;
                  padding: 25px;
                  margin-bottom: 30px;
                  border: 2px solid rgba(255, 140, 0, 0.3);
                  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
                }

                .room-info-card h3 {
                  color: #ff8c00;
                  margin-bottom: 20px;
                  font-size: 1.4rem;
                  display: flex;
                  align-items: center;
                  gap: 10px;
                }

                .room-info-grid {
                  display: grid;
                  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                  gap: 15px;
                }

                .room-info-item {
                  background: rgba(0, 0, 0, 0.3);
                  padding: 12px 15px;
                  border-radius: 8px;
                  border-left: 4px solid #ff8c00;
                }

                .room-info-item strong {
                  color: #999;
                  display: block;
                  font-size: 0.9rem;
                  margin-bottom: 5px;
                }

                .room-info-item span {
                  color: #fff;
                  font-size: 1.1rem;
                  font-weight: 600;
                }

                .form-section {
                  margin-bottom: 30px;
                  padding: 25px;
                  background: rgba(0, 0, 0, 0.4);
                  border-radius: 15px;
                  border: 1px solid rgba(255, 140, 0, 0.2);
                }

                .section-title {
                  color: #ff8c00;
                  font-size: 1.3rem;
                  font-weight: 600;
                  margin-bottom: 20px;
                  display: flex;
                  align-items: center;
                  gap: 10px;
                }

                .form-grid {
                  display: grid;
                  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                  gap: 20px;
                }

                .form-group {
                  margin-bottom: 20px;
                }

                .form-group label {
                  display: block;
                  font-weight: 600;
                  color: #ff8c00;
                  margin-bottom: 10px;
                  font-size: 1rem;
                }

                .form-control {
                  width: 100%;
                  padding: 15px;
                  background: rgba(0, 0, 0, 0.4);
                  border: 2px solid rgba(255, 140, 0, 0.3);
                  border-radius: 10px;
                  font-size: 1rem;
                  color: #fff;
                  transition: all 0.3s ease;
                }

                .form-control:focus {
                  outline: none;
                  border-color: #ff8c00;
                  box-shadow: 0 0 15px rgba(255, 140, 0, 0.3);
                }

                .form-control:read-only {
                  background: rgba(0, 0, 0, 0.6);
                  color: #999;
                  cursor: not-allowed;
                }

                select.form-control {
                  cursor: pointer;
                  appearance: none;
                  -webkit-appearance: none;
                  -moz-appearance: none;
                  background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%23ff8c00' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
                  background-repeat: no-repeat;
                  background-position: right 15px center;
                  background-size: 20px;
                  padding-right: 45px;
                }

                select.form-control option {
                  background: #2d2d2d;
                  color: #fff;
                  padding: 10px;
                }

                select.form-control:hover {
                  border-color: #ff8c00;
                }

                .utility-section {
                  display: grid;
                  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                  gap: 20px;
                }

                .utility-card {
                  background: rgba(0, 0, 0, 0.6);
                  border: 2px solid rgba(255, 140, 0, 0.2);
                  border-radius: 15px;
                  padding: 20px;
                  transition: all 0.3s ease;
                }

                .utility-card:hover {
                  transform: translateY(-3px);
                  border-color: rgba(255, 140, 0, 0.5);
                  box-shadow: 0 8px 25px rgba(255, 140, 0, 0.2);
                }

                .utility-title {
                  font-weight: 600;
                  color: #ff8c00;
                  margin-bottom: 15px;
                  display: flex;
                  align-items: center;
                  gap: 8px;
                  font-size: 1.1rem;
                }

                .calculation-display {
                  background: rgba(0, 255, 136, 0.1);
                  border: 2px solid #00ff88;
                  border-radius: 10px;
                  padding: 15px;
                  text-align: center;
                  margin-top: 15px;
                }

                .calculation-display .amount {
                  font-size: 1.3rem;
                  font-weight: bold;
                  color: #00ff88;
                }

                .total-section {
                  background: linear-gradient(135deg,
                      rgba(255, 140, 0, 0.2),
                      rgba(255, 107, 0, 0.2));
                  border: 3px solid #ff8c00;
                  border-radius: 15px;
                  padding: 30px;
                  text-align: center;
                  margin-top: 30px;
                }

                .total-label {
                  font-size: 1.3rem;
                  font-weight: 600;
                  color: #ccc;
                  margin-bottom: 10px;
                }

                .total-amount {
                  font-size: 2.5rem;
                  font-weight: bold;
                  color: #ff8c00;
                  margin-bottom: 20px;
                  animation: pulse 2s ease-in-out infinite;
                }

                @keyframes pulse {

                  0%,
                  100% {
                    transform: scale(1);
                  }

                  50% {
                    transform: scale(1.05);
                  }
                }

                .status-section {
                  margin-top: 20px;
                }

                .btn-group {
                  display: flex;
                  gap: 15px;
                  justify-content: center;
                  margin-top: 30px;
                  flex-wrap: wrap;
                }

                .btn {
                  padding: 18px 40px;
                  border: none;
                  border-radius: 12px;
                  cursor: pointer;
                  font-size: 1.1rem;
                  font-weight: 600;
                  transition: all 0.3s ease;
                  text-decoration: none;
                  display: inline-flex;
                  align-items: center;
                  gap: 10px;
                  min-width: 180px;
                  justify-content: center;
                }

                .btn-primary {
                  background: linear-gradient(135deg, #00ff88, #00cc6f);
                  color: #000;
                  box-shadow: 0 5px 20px rgba(0, 255, 136, 0.3);
                }

                .btn-primary:hover {
                  transform: translateY(-2px);
                  box-shadow: 0 8px 25px rgba(0, 255, 136, 0.5);
                }

                .btn-secondary {
                  background: rgba(255, 68, 68, 0.2);
                  color: #ff4444;
                  border: 2px solid #ff4444;
                }

                .btn-secondary:hover {
                  background: linear-gradient(135deg, #ff4444, #cc0000);
                  color: white;
                  transform: translateY(-2px);
                }

                .loading {
                  display: none;
                  position: fixed;
                  top: 0;
                  left: 0;
                  width: 100%;
                  height: 100%;
                  background: rgba(0, 0, 0, 0.9);
                  z-index: 999;
                  justify-content: center;
                  align-items: center;
                }

                .spinner {
                  width: 60px;
                  height: 60px;
                  border: 6px solid rgba(255, 140, 0, 0.3);
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
                  border: 1px solid rgba(255, 140, 0, 0.3);
                  color: white;
                  max-width: 400px;
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

                .error-container {
                  background: rgba(255, 68, 68, 0.15);
                  border: 2px solid #ff4444;
                  border-radius: 15px;
                  padding: 30px;
                  text-align: center;
                  color: #ff4444;
                  margin-top: 20px;
                }

                .error-container i {
                  font-size: 3rem;
                  margin-bottom: 15px;
                }

                .error-container h3 {
                  margin-bottom: 10px;
                  font-size: 1.5rem;
                }

                .error-container p {
                  margin-bottom: 20px;
                  color: #ccc;
                }

                @media (max-width: 768px) {
                  .container {
                    padding: 15px;
                  }

                  .header {
                    font-size: 2rem;
                  }

                  .card-body {
                    padding: 25px 20px;
                  }

                  .form-grid,
                  .utility-section {
                    grid-template-columns: 1fr;
                  }

                  .room-info-grid {
                    grid-template-columns: 1fr;
                  }

                  .btn-group {
                    flex-direction: column;
                    align-items: center;
                  }

                  .btn {
                    width: 100%;
                    max-width: 300px;
                  }

                  .total-amount {
                    font-size: 2rem;
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

              <div class="loading" id="loading">
                <div class="spinner"></div>
              </div>

              <div id="toast" class="toast">
                <div id="toast-message"></div>
              </div>

              <div class="container">
                <div class="header">
                  <i class="fas fa-file-invoice-dollar"></i>
                  เพิ่มบิลใหม่
                </div>

                <a href="OwnerHome" class="back-btn">
                  <i class="fas fa-arrow-left"></i>
                  กลับหน้าจัดการห้อง
                </a>

                <div class="form-card">
                  <div class="card-header">
                    <h2>
                      <i class="fas fa-plus-circle"></i>
                      สร้างใบแจ้งหนี้ใหม่
                    </h2>
                  </div>

                  <div class="card-body">
                    <c:choose>
                      <c:when test="${not empty rent && not empty room}">
                        <!-- Room Information Card -->
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
                              <span>฿
                                <fmt:formatNumber value="${room.roomPrice}" groupingUsed="true" />/เดือน
                              </span>
                            </div>
                            <div class="room-info-item">
                              <strong><i class="fas fa-info-circle"></i> สถานะห้อง</strong>
                              <span>${room.roomStatus}</span>
                            </div>
                          </div>
                        </div>
                        <div class="alert alert-warning" id="meterWarning" style="
                  display: none;
                  background: rgba(255, 193, 7, 0.15);
                  border: 2px solid #ffc107;
                  color: #ffc107;
                  padding: 15px 20px;
                  border-radius: 10px;
                  margin-bottom: 25px;
                  display: flex;
                  align-items: center;
                  gap: 12px;
                  animation: slideInDown 0.5s ease;
                ">
                          <i class="fas fa-exclamation-circle"></i>
                          <span id="warningMessage"></span>
                        </div>

                        <form action="SaveInvoice" method="post" id="invoiceForm">
                          <input type="hidden" name="rentId" value="${rent.rentID}" />
                          <input type="hidden" name="issueDate" value="${today}" />
                          <input type="hidden" name="dueDate" value="${dueDate}" />

                          <!-- ค่าห้อง -->
                          <input type="hidden" id="roomPrice" value="${room.roomPrice}" />

                          <!-- พื้นที่แสดง Cards ของบิลทั้งหมด -->
                          <div id="billsCardsContainer" style="position: relative">
                            <!-- Cards จะแสดงที่นี่ -->
                          </div>

                          <!-- Hidden inputs สำหรับส่งข้อมูล -->
                          <div id="hiddenInputsContainer" style="display: none"></div>

                          <!-- Total Section -->
                          <div class="total-section">
                            <div class="total-label">ยอดรวมทั้งสิ้น</div>
                            <div class="total-amount" id="totalDisplay">
                              ฿
                              <fmt:formatNumber value="${room.roomPrice}" groupingUsed="true" pattern="#,##0.00" />
                            </div>
                            <input type="hidden" id="totalPrice" name="totalPrice" value="${room.roomPrice}" />

                            <div class="status-section">
                              <div class="form-group">
                                <label for="statusSelect">สถานะการชำระ:</label>
                                <select name="statusId" id="statusSelect" class="form-control" disabled style="
                          background: rgba(0, 0, 0, 0.6);
                          cursor: not-allowed;
                        ">
                                  <option value="0" selected>ยังไม่ได้ชำระ</option>
                                </select>
                                <input type="hidden" name="statusId" value="0" />
                              </div>
                            </div>
                          </div>

                          <div class="btn-group">
                            <button type="button" onclick="saveAllBills()" class="btn btn-primary" id="saveAllBtn"
                              style="display: none">
                              <i class="fas fa-save"></i>
                              บันทึกทั้งหมด (<span id="totalBillsCount">0</span> บิล)
                            </button>
                            <a href="OwnerHome" class="btn btn-secondary">
                              <i class="fas fa-times"></i>
                              ยกเลิก
                            </a>
                          </div>
                        </form>
                      </c:when>
                      <c:otherwise>
                        <div class="error-container">
                          <i class="fas fa-exclamation-triangle"></i>
                          <h3>ไม่พบข้อมูลห้องพัก</h3>
                          <p>
                            <c:choose>
                              <c:when test="${not empty error}"> ${error} </c:when>
                              <c:otherwise>
                                ไม่พบข้อมูลห้องพักหรือข้อมูลการจอง
                                กรุณาเลือกห้องจากหน้าจัดการห้องก่อน
                              </c:otherwise>
                            </c:choose>
                          </p>
                          <a href="OwnerHome" class="btn btn-primary">
                            <i class="fas fa-arrow-left"></i>
                            กลับหน้าจัดการห้อง
                          </a>
                        </div>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>

              <script>
                // ข้อมูลบิลทั้งหมด
                let bills = [];
                let billCounter = 1;
                let currentCardId = 1;
                const roomPrice = ${ room.roomPrice };

                // ข้อมูลมิเตอร์เริ่มต้น
                let currentPrevWater = ${ prevWater };
                let currentPrevElectric = ${ prevElectric };
                const initialWaterRate = ${ waterRate };
                const initialElectricRate = ${ electricRate };

                // รายการที่เลือกไปแล้ว (เพื่อซ่อนใน dropdown)
                let usedTypes = [];

                function createParticles() {
                  const particles = document.getElementById("particles");
                  const particleCount = 30;
                  for (let i = 0; i < particleCount; i++) {
                    const particle = document.createElement("div");
                    particle.className = "particle";
                    particle.style.left = Math.random() * 100 + "%";
                    particle.style.animationDelay = Math.random() * 8 + "s";
                    particle.style.animationDuration = Math.random() * 3 + 5 + "s";
                    particles.appendChild(particle);
                  }
                }

                function showToast(message, type) {
                  if (type === void 0) { type = "success"; }
                  const toast = document.getElementById("toast");
                  const toastMessage = document.getElementById("toast-message");
                  toastMessage.textContent = message;
                  toast.className = "toast " + type;
                  toast.style.display = "block";
                  setTimeout(function () {
                    toast.style.display = "none";
                  }, 5000);
                }

                // เมื่อโหลดหน้าเว็บเสร็จ สร้าง Card แรก
                document.addEventListener('DOMContentLoaded', function () {
                  createParticles();
                  createNewCard();
                  // ตั้งค่ายอดรวมเริ่มต้น
                  calculateAllBillsTotal();
                });

                // สร้าง Card ใหม่
                function createNewCard() {
                  const container = document.getElementById('billsCardsContainer');
                  const cardId = 'card_' + currentCardId++;

                  const card = document.createElement('div');
                  card.id = cardId;
                  card.className = 'form-section';
                  card.style.cssText = 'margin-bottom: 15px; animation: slideUp 0.5s ease;';

                  card.innerHTML = '<div class="section-title" style="display: flex; justify-content: space-between; align-items: center;">' +
                    '<div>' +
                    '<i class="fas fa-file-invoice-dollar"></i> ' +
                    'บิลที่ ' + (bills.length + 1) +
                    '</div>' +
                    '<div style="color: #999; font-size: 0.9rem;">กรอกข้อมูลและกดเพิ่มบิล</div>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label><i class="fas fa-list"></i> เลือกประเภท</label>' +
                    '<select class="form-control billType" onchange="handleTypeChange(\'' + cardId + '\')">' +
                    '<option value="">-- เลือกประเภท --</option>' +
                    '<option value="water" ' + (usedTypes.includes('water') ? 'disabled style="display:none"' : '') + '>ค่าน้ำ</option>' +
                    '<option value="electricity" ' + (usedTypes.includes('electricity') ? 'disabled style="display:none"' : '') + '>ค่าไฟฟ้า</option>' +
                    '<option value="internet" ' + (usedTypes.includes('internet') ? 'disabled style="display:none"' : '') + '>ค่าอินเทอร์เน็ต</option>' +
                    '<option value="penalty" ' + (usedTypes.includes('penalty') ? 'disabled style="display:none"' : '') + '>ค่าปรับ</option>' +
                    '<option value="other">อื่นๆ</option>' +
                    '</select>' +
                    '</div>' +
                    '<div class="form-inputs-container"></div>' +
                    '<div class="btn-group" style="justify-content: center; margin-top: 20px;">' +
                    '<button type="button" onclick="addBill(\'' + cardId + '\')" class="btn btn-success" style="padding: 12px 35px;">' +
                    '<i class="fas fa-plus-circle"></i> เพิ่มบิล' +
                    '</button>' +
                    '<button type="button" onclick="removeCard(\'' + cardId + '\')" class="btn-secondary" style="padding: 12px 25px; display: none;" id="removeBtn_' + cardId + '">' +
                    '<i class="fas fa-trash"></i> ลบ' +
                    '</button>' +
                    '</div>';

                  container.appendChild(card);
                }

                // จัดการเมื่อเปลี่ยนประเภทใน dropdown
                function handleTypeChange(cardId) {
                  const card = document.getElementById(cardId);
                  const typeSelect = card.querySelector('.billType');
                  const type = typeSelect.value;
                  const inputsContainer = card.querySelector('.form-inputs-container');

                  if (!type) {
                    inputsContainer.innerHTML = '';
                    return;
                  }

                  let html = '';

                  if (type === 'water' || type === 'electricity') {
                    const prevMeter = type === 'water' ? currentPrevWater : currentPrevElectric;
                    const rate = type === 'water' ? initialWaterRate : initialElectricRate;

                    html = '<div class="form-group">' +
                      '<label>หน่วยเดือนก่อน</label>' +
                      '<input type="number" class="form-control prevMeter" value="' + prevMeter + '" readonly />' +
                      '</div>' +
                      '<div class="form-group">' +
                      '<label>หน่วยปัจจุบัน</label>' +
                      '<input type="number" class="form-control currMeter" placeholder="กรอกมิเตอร์ปัจจุบัน" oninput="calculateMeter(\'' + cardId + '\')" />' +
                      '</div>' +
                      '<div class="form-group">' +
                      '<label>อัตราต่อหน่วย (฿)</label>' +
                      '<input type="number" class="form-control rate" value="' + rate + '" step="0.01" oninput="calculateMeter(\'' + cardId + '\')" />' +
                      '</div>' +
                      '<div class="form-group">' +
                      '<label>จำนวนเงิน</label>' +
                      '<input type="number" class="form-control amount" readonly style="background: rgba(0,0,0,0.6); color: #00ff88; font-weight: bold;" />' +
                      '</div>';
                  } else if (type === 'other') {
                    html = '<div class="form-group">' +
                      '<label>ชื่อรายการ</label>' +
                      '<input type="text" class="form-control itemName" placeholder="ระบุชื่อรายการ" />' +
                      '</div>' +
                      '<div class="form-group">' +
                      '<label>จำนวนเงิน (฿)</label>' +
                      '<input type="number" class="form-control amount" placeholder="ระบุจำนวนเงิน" step="0.01" />' +
                      '</div>';
                  } else {
                    html = '<div class="form-group">' +
                      '<label>จำนวนเงิน (฿)</label>' +
                      '<input type="number" class="form-control amount" placeholder="ระบุจำนวนเงิน" step="0.01" />' +
                      '</div>';
                  }

                  inputsContainer.innerHTML = html;

                  // เพิ่ม event listeners สำหรับ input ใหม่
                  setupCardEventListeners(cardId);
                }

                // คำนวณค่ามิเตอร์
                function calculateMeter(cardId) {
                  const card = document.getElementById(cardId);
                  const prevMeter = parseFloat(card.querySelector('.prevMeter').value) || 0;
                  const currMeter = parseFloat(card.querySelector('.currMeter').value) || 0;
                  const rate = parseFloat(card.querySelector('.rate').value) || 0;

                  if (currMeter >= prevMeter) {
                    const usage = currMeter - prevMeter;
                    const total = usage * rate;
                    card.querySelector('.amount').value = total.toFixed(2);
                  }

                  // อัพเดตยอดรวม
                  if (bills.find(b => b.cardId === cardId)) {
                    calculateAllBillsTotal();
                  }
                }

                // เพิ่มบิลเข้าลิสต์
                function addBill(cardId) {
                  const card = document.getElementById(cardId);
                  const type = card.querySelector('.billType').value;

                  if (!type) {
                    showToast('กรุณาเลือกประเภท', 'error');
                    return;
                  }

                  // ตรวจสอบข้อมูลก่อนเพิ่ม
                  if (type === 'water' || type === 'electricity') {
                    const prevMeter = parseFloat(card.querySelector('.prevMeter').value) || 0;
                    const currMeter = parseFloat(card.querySelector('.currMeter').value) || 0;
                    const amount = parseFloat(card.querySelector('.amount').value) || 0;

                    if (!currMeter) {
                      showToast('กรุณาระบุมิเตอร์ปัจจุบัน', 'error');
                      return;
                    }

                    if (currMeter < prevMeter) {
                      showToast('มิเตอร์ปัจจุบันต้องมากกว่าหรือเท่ากับมิเตอร์เดือนก่อน', 'error');
                      return;
                    }

                    if (amount <= 0) {
                      showToast('กรุณาคำนวณจำนวนเงิน', 'error');
                      return;
                    }
                  } else if (type === 'other') {
                    const itemName = card.querySelector('.itemName').value.trim();
                    const amount = parseFloat(card.querySelector('.amount').value) || 0;

                    if (!itemName) {
                      showToast('กรุณาระบุชื่อรายการ', 'error');
                      return;
                    }

                    if (amount <= 0) {
                      showToast('กรุณาระบุจำนวนเงิน', 'error');
                      return;
                    }
                  } else {
                    const amount = parseFloat(card.querySelector('.amount').value) || 0;

                    if (amount <= 0) {
                      showToast('กรุณาระบุจำนวนเงิน', 'error');
                      return;
                    }
                  }

                  // เพิ่ม type เข้า usedTypes (เว้นแต่ type "other")
                  if (type !== 'other') {
                    usedTypes.push(type);
                  }

                  // เก็บ cardId กับข้อมูล
                  bills.push({
                    id: billCounter++,
                    cardId: cardId,
                    type: type
                  });

                  // ซ่อนปุ่มเพิ่มบิล และแสดงปุ่มลบของ card นี้
                  card.querySelector('button[onclick*="addBill"]').style.display = 'none';
                  document.getElementById('removeBtn_' + cardId).style.display = 'inline-flex';

                  // เปลี่ยนสี header เป็นสีเขียวเพื่อบ่งบอกว่าเพิ่มแล้ว
                  const sectionTitle = card.querySelector('.section-title');
                  if (sectionTitle) {
                    sectionTitle.style.borderBottom = '2px solid #00ff88';
                    sectionTitle.innerHTML = '<div style="color: #00ff88; font-weight: 600;">' +
                      '<i class="fas fa-check-circle"></i> บิลที่ ' + bills.length + ' (แก้ไขได้)' +
                      '</div>';
                  }

                  // อัพเดตมิเตอร์สำหรับบิลถัดไป
                  if (type === 'water') {
                    const currMeter = parseFloat(card.querySelector('.currMeter').value) || 0;
                    currentPrevWater = currMeter;
                  } else if (type === 'electricity') {
                    const currMeter = parseFloat(card.querySelector('.currMeter').value) || 0;
                    currentPrevElectric = currMeter;
                  }

                  // สร้าง Card ใหม่
                  createNewCard();

                  // อัพเดตยอดรวมและแสดงปุ่มบันทึก
                  calculateAllBillsTotal();
                  document.getElementById('saveAllBtn').style.display = 'inline-flex';

                  showToast('เพิ่มบิลเรียบร้อย', 'success');
                }

                // คำนวณยอดรวมจากทุก Card (รวมทั้งที่ยังไม่ได้กดเพิ่มบิล)
                function calculateAllBillsTotal() {
                  let total = roomPrice; // เริ่มจากค่าห้อง
                  let billCount = 0;

                  // หาทุก Card ที่มีข้อมูล amount
                  const container = document.getElementById('billsCardsContainer');
                  if (container) {
                    const allCards = container.querySelectorAll('.form-section');
                    allCards.forEach(card => {
                      const amountInput = card.querySelector('.amount');
                      if (amountInput && amountInput.value) {
                        const amount = parseFloat(amountInput.value) || 0;
                        if (amount > 0) {
                          total += amount;
                          billCount++;
                        }
                      }
                    });
                  }

                  // อัพเดตการแสดงผล
                  const totalDisplay = document.getElementById('totalDisplay');
                  if (totalDisplay) {
                    totalDisplay.textContent = '฿' + total.toLocaleString('th-TH', {
                      minimumFractionDigits: 2,
                      maximumFractionDigits: 2
                    });
                  }

                  const totalBillsCount = document.getElementById('totalBillsCount');
                  if (totalBillsCount) {
                    totalBillsCount.textContent = billCount;
                  }

                  // อัพเดต hidden input สำหรับส่งค่า
                  const totalPriceInput = document.getElementById('totalPrice');
                  if (totalPriceInput) {
                    totalPriceInput.value = total.toFixed(2);
                  }
                }

                function getBillIcon(type) {
                  const icons = {
                    water: '<i class="fas fa-tint"></i>',
                    electricity: '<i class="fas fa-bolt"></i>',
                    internet: '<i class="fas fa-wifi"></i>',
                    penalty: '<i class="fas fa-exclamation-triangle"></i>',
                    other: '<i class="fas fa-file-invoice"></i>'
                  };
                  return icons[type] || '<i class="fas fa-file"></i>';
                }

                // ลบบิล
                function removeBill(billId) {
                  if (confirm('ต้องการลบบิลนี้หรือไม่?')) {
                    const bill = bills.find(b => b.id === billId);

                    if (bill) {
                      // ลบ Card
                      const card = document.getElementById(bill.cardId);
                      if (card) {
                        card.remove();
                      }

                      // ลบประเภทออกจาก usedTypes (เว้นแต่ type "other")
                      if (bill.type !== 'other') {
                        usedTypes = usedTypes.filter(t => t !== bill.type);
                      }

                      // รีเซ็ตมิเตอร์ถ้าเป็นน้ำหรือไฟ (ต้องหาค่าจาก card ที่เหลือ)
                      if (bill.type === 'water') {
                        // หาค่ามิเตอร์ล่าสุดจาก card ที่เหลือ
                        let lastWaterMeter = ${ prevWater };
                        bills.forEach(b => {
                          if (b.type === 'water' && b.id !== billId) {
                            const c = document.getElementById(b.cardId);
                            if (c) {
                              const curr = parseFloat(c.querySelector('.currMeter').value) || 0;
                              if (curr > lastWaterMeter) lastWaterMeter = curr;
                            }
                          }
                        });
                        currentPrevWater = lastWaterMeter;
                      } else if (bill.type === 'electricity') {
                        let lastElectricMeter = ${ prevElectric };
                        bills.forEach(b => {
                          if (b.type === 'electricity' && b.id !== billId) {
                            const c = document.getElementById(b.cardId);
                            if (c) {
                              const curr = parseFloat(c.querySelector('.currMeter').value) || 0;
                              if (curr > lastElectricMeter) lastElectricMeter = curr;
                            }
                          }
                        });
                        currentPrevElectric = lastElectricMeter;
                      }
                    }

                    bills = bills.filter(b => b.id !== billId);

                    // อัพเดตยอดรวม
                    calculateAllBillsTotal();

                    if (bills.length === 0) {
                      document.getElementById('saveAllBtn').style.display = 'none';
                    }

                    showToast('ลบบิลเรียบร้อย', 'success');
                  }
                }

                // เพิ่ม event listener สำหรับ input ที่เปลี่ยนแปลง
                function setupCardEventListeners(cardId) {
                  const card = document.getElementById(cardId);
                  if (!card) return;

                  const inputs = card.querySelectorAll('input[type="number"], input[type="text"]');
                  inputs.forEach(input => {
                    input.addEventListener('input', function () {
                      // คำนวณยอดรวมทันทีเมื่อมีการกรอกข้อมูล
                      calculateAllBillsTotal();
                    });
                  });
                }

                // ลบ Card (ใช้สำหรับ Card ที่เพิ่มแล้ว)
                function removeCard(cardId) {
                  const bill = bills.find(b => b.cardId === cardId);
                  if (!bill) return;

                  removeBill(bill.id);
                }

                // บันทึกบิลทั้งหมด
                function saveAllBills() {
                  // สร้าง hidden inputs
                  const container = document.getElementById('hiddenInputsContainer');
                  container.innerHTML = '';

                  let grandTotal = roomPrice;
                  let validBills = [];

                  // สแกนทุก Card เพื่อหาข้อมูลที่สมบูรณ์
                  const billsContainer = document.getElementById('billsCardsContainer');
                  if (billsContainer) {
                    const allCards = billsContainer.querySelectorAll('.form-section');

                    allCards.forEach(card => {
                      const typeSelect = card.querySelector('.billType');
                      if (!typeSelect || !typeSelect.value) return; // ข้าม Card ที่ยังไม่เลือกประเภท

                      const type = typeSelect.value;
                      let name = '';
                      let detail = '';
                      let amount = 0;
                      let meterData = null;
                      let isValid = false;

                      if (type === 'water' || type === 'electricity') {
                        const prevMeterInput = card.querySelector('.prevMeter');
                        const currMeterInput = card.querySelector('.currMeter');
                        const rateInput = card.querySelector('.rate');
                        const amountInput = card.querySelector('.amount');

                        if (prevMeterInput && currMeterInput && rateInput && amountInput) {
                          const prevMeter = parseFloat(prevMeterInput.value) || 0;
                          const currMeter = parseFloat(currMeterInput.value) || 0;
                          const rate = parseFloat(rateInput.value) || 0;
                          amount = parseFloat(amountInput.value) || 0;

                          if (currMeter >= prevMeter && amount > 0) {
                            const usage = currMeter - prevMeter;
                            name = type === 'water' ? 'ค่าน้ำ' : 'ค่าไฟฟ้า';
                            detail = usage + ' หน่วย (' + prevMeter + ' → ' + currMeter + ') @ ฿' + rate.toFixed(2);
                            meterData = { prev: prevMeter, curr: currMeter, rate: rate, usage: usage };
                            isValid = true;
                          }
                        }
                      } else if (type === 'other') {
                        const itemNameInput = card.querySelector('.itemName');
                        const amountInput = card.querySelector('.amount');

                        if (itemNameInput && amountInput) {
                          name = itemNameInput.value.trim();
                          amount = parseFloat(amountInput.value) || 0;
                          detail = '-';
                          if (name && amount > 0) {
                            isValid = true;
                          }
                        }
                      } else {
                        const amountInput = card.querySelector('.amount');
                        if (amountInput) {
                          const typeNames = {
                            internet: 'ค่าอินเทอร์เน็ต',
                            penalty: 'ค่าปรับ'
                          };
                          name = typeNames[type] || type;
                          amount = parseFloat(amountInput.value) || 0;
                          detail = '-';
                          if (amount > 0) {
                            isValid = true;
                          }
                        }
                      }

                      if (isValid) {
                        validBills.push({ type, name, detail, amount, meterData });
                      }
                    });
                  }

                  // เช็คว่ามีบิลที่ถูกต้องหรือไม่
                  if (validBills.length === 0) {
                    showToast('กรุณากรอกข้อมูลบิลอย่างน้อย 1 รายการให้สมบูรณ์', 'error');
                    return;
                  }

                  // item_0 = ค่าห้อง
                  container.innerHTML += '<input type="hidden" name="item_0_type" value="room" />' +
                    '<input type="hidden" name="item_0_name" value="ค่าเช่าห้อง" />' +
                    '<input type="hidden" name="item_0_detail" value="-" />' +
                    '<input type="hidden" name="item_0_amount" value="' + roomPrice + '" />';

                  validBills.forEach((bill, index) => {
                    const i = index + 1;

                    grandTotal += bill.amount;

                    container.innerHTML += '<input type="hidden" name="item_' + i + '_type" value="' + bill.type + '" />' +
                      '<input type="hidden" name="item_' + i + '_name" value="' + bill.name + '" />' +
                      '<input type="hidden" name="item_' + i + '_detail" value="' + bill.detail + '" />' +
                      '<input type="hidden" name="item_' + i + '_amount" value="' + bill.amount + '" />';

                    if (bill.meterData) {
                      container.innerHTML += '<input type="hidden" name="item_' + i + '_prevMeter" value="' + bill.meterData.prev + '" />' +
                        '<input type="hidden" name="item_' + i + '_currMeter" value="' + bill.meterData.curr + '" />' +
                        '<input type="hidden" name="item_' + i + '_rate" value="' + bill.meterData.rate + '" />' +
                        '<input type="hidden" name="item_' + i + '_usage" value="' + bill.meterData.usage + '" />';
                    }
                  });

                  container.innerHTML += '<input type="hidden" name="itemCount" value="' + (validBills.length + 1) + '" />' +
                    '<input type="hidden" name="totalPrice" value="' + grandTotal.toFixed(2) + '" />';

                  document.getElementById('loading').style.display = 'flex';
                  document.querySelector('form').submit();
                }



                window.addEventListener("load", function () {
                  <c:if test="${not empty error}">
                    setTimeout(function() {
                      showToast('<c:out value="${error}" />', "error");
          }, 500);
                  </c:if>

                  setTimeout(() => {
                    document.getElementById("loading").style.display = "none";
                  }, 500);

                  document.body.style.opacity = "0";
                  document.body.style.transition = "opacity 0.5s ease-in-out";
                  setTimeout(() => {
                    document.body.style.opacity = "1";
                  }, 100);
                });

                document.addEventListener("DOMContentLoaded", function () {
                  const sections = document.querySelectorAll(
                    ".form-section, .total-section, .room-info-card"
                  );
                  sections.forEach((section, index) => {
                    section.style.animationDelay = index * 0.1 + "s";
                  });
                });

                document.querySelectorAll('input[type="number"]').forEach((input) => {
                  input.addEventListener("input", function () {
                    if (this.value < 0) {
                      this.value = 0;
                    }
                  });
                });

                document.addEventListener("keydown", function (e) {
                  if ((e.ctrlKey || e.metaKey) && e.key === "s") {
                    e.preventDefault();
                    saveAllBills();
                  }
                  if (e.key === "Escape") {
                    if (confirm("คุณต้องการยกเลิกการสร้างบิลหรือไม่?")) {
                      window.location.href = "OwnerHome";
                    }
                  }
                });

                if (window.history.replaceState) {
                  window.history.replaceState(null, null, window.location.href);
                }
              </script>
            </body>

            </html>