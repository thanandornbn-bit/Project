<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ page import="com.springmvc.model.*" %>
      <%@ page import="java.util.*,
java.text.SimpleDateFormat" %>
        <% Member loginMember=(Member) session.getAttribute("loginMember"); Room reservedRoom=(Room)
          request.getAttribute("room"); Date today=new Date(); SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy",
          new Locale("th", "TH" )); String todayStr=sdf.format(today); %>
          <!DOCTYPE html>
          <html lang="th">

          <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>ชำระเงินมัดจำ - ThanaChok Place</title>
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
                font-size: 2rem;
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

              .page-title {
                background: linear-gradient(135deg, var(--muted-bg) 0%, #e8f4ff 100%);
                padding: 30px 20px;
                text-align: center;
                border-bottom: 2px solid var(--card-border);
                margin-bottom: 30px;
              }

              .page-title h2 {
                font-size: 2rem;
                font-weight: 700;
                color: var(--primary);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 15px;
              }

              .page-title p {
                color: var(--muted-text);
                margin-top: 10px;
                font-size: 1rem;
                font-weight: 500;
              }

              .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 0 20px;
                position: relative;
                z-index: 1;
              }

              .payment-card {
                background: white;
                border-radius: 20px;
                padding: 40px;
                box-shadow: 0 8px 24px rgba(92, 169, 233, 0.12);
                border: 2px solid var(--card-border);
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

              .room-details {
                background: var(--muted-bg);
                padding: 25px;
                border-radius: 15px;
                margin-bottom: 25px;
                border: 2px solid var(--card-border);
              }

              .room-details h3 {
                color: var(--primary);
                margin-bottom: 20px;
                font-size: 1.3rem;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 10px;
              }

              .detail-row {
                display: flex;
                justify-content: space-between;
                padding: 12px 0;
                border-bottom: 1px solid var(--accent);
              }

              .detail-row:last-child {
                border-bottom: none;
              }

              .detail-label {
                color: var(--muted-text);
                font-weight: 600;
              }

              .detail-value {
                color: var(--text);
                font-weight: 700;
              }

              .deposit-amount {
                color: var(--primary);
                font-size: 1.5rem;
                font-weight: 700;
              }

              .warning-note {
                background: #ffe4e6;
                color: var(--error);
                padding: 20px;
                border-radius: 12px;
                margin-bottom: 25px;
                display: flex;
                align-items: flex-start;
                gap: 15px;
                border: 2px solid var(--error);
                animation: pulse 2s ease-in-out infinite;
                font-weight: 600;
              }

              @keyframes pulse {

                0%,
                100% {
                  box-shadow: 0 4px 15px rgba(239, 68, 68, 0.2);
                }

                50% {
                  box-shadow: 0 6px 20px rgba(239, 68, 68, 0.3);
                }
              }

              .warning-note i {
                font-size: 1.5rem;
                margin-top: 2px;
              }

              .qr-section {
                background: var(--muted-bg);
                padding: 30px;
                border-radius: 15px;
                text-align: center;
                margin-bottom: 25px;
                border: 2px solid var(--card-border);
              }

              .qr-section h3 {
                color: var(--primary);
                margin-bottom: 20px;
                font-size: 1.2rem;
                font-weight: 700;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
              }

              .qr-code-container {
                background: white;
                padding: 15px;
                border-radius: 12px;
                display: inline-block;
                margin: 20px 0;
                box-shadow: 0 4px 15px rgba(92, 169, 233, 0.2);
                border: 2px solid var(--card-border);
              }

              .qr-code-container img {
                width: 200px;
                height: 200px;
                display: block;
              }

              .qr-info {
                color: var(--muted-text);
                margin-top: 15px;
                line-height: 1.8;
                font-weight: 500;
              }

              .qr-info strong {
                color: var(--primary);
                font-weight: 700;
              }

              .form-section {
                margin-top: 30px;
              }

              .form-section h3 {
                color: var(--primary);
                margin-bottom: 20px;
                font-size: 1.3rem;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 10px;
              }

              .form-group {
                margin-bottom: 25px;
              }

              .form-group label {
                display: block;
                margin-bottom: 10px;
                color: var(--primary);
                font-weight: 700;
                font-size: 0.95rem;
              }

              .form-group input[type="text"],
              .form-group input[type="file"] {
                width: 100%;
                padding: 15px 20px;
                background: white;
                border: 2px solid var(--card-border);
                border-radius: 12px;
                font-size: 1rem;
                color: var(--text);
                transition: all 0.3s ease;
                font-family: "Sarabun", sans-serif;
                font-weight: 600;
              }

              .form-group input[type="text"]:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 20px rgba(92, 169, 233, 0.2);
                background: white;
              }

              .form-group input[type="file"] {
                padding: 15px;
                cursor: pointer;
              }

              .form-group input[type="file"]::file-selector-button {
                padding: 10px 20px;
                background: linear-gradient(135deg,
                    var(--primary) 0%,
                    var(--primary-dark) 100%);
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 700;
                margin-right: 15px;
                transition: all 0.3s ease;
                font-family: "Sarabun", sans-serif;
              }

              .form-group input[type="file"]::file-selector-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(92, 169, 233, 0.4);
              }

              .form-group input[readonly] {
                background: #f5f5f5;
                cursor: not-allowed;
                color: var(--muted-text);
              }

              .button-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
              }

              .btn {
                flex: 1;
                padding: 16px;
                border: none;
                border-radius: 12px;
                font-size: 1.1rem;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
              }

              .btn-submit {
                background: linear-gradient(135deg,
                    var(--primary) 0%,
                    var(--primary-dark) 100%);
                color: white;
                box-shadow: 0 5px 20px rgba(74, 144, 226, 0.3);
              }

              .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(74, 144, 226, 0.4);
              }

              .btn-cancel {
                background: white;
                color: var(--error);
                border: 2px solid var(--error);
              }

              .btn-cancel:hover {
                background: var(--error);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 5px 20px rgba(239, 68, 68, 0.3);
              }

              .info-box {
                background: var(--accent);
                border-left: 4px solid var(--primary);
                padding: 15px 20px;
                border-radius: 8px;
                margin-top: 20px;
                color: var(--muted-text);
                font-size: 0.9rem;
                line-height: 1.8;
                font-weight: 500;
              }

              .info-box i {
                color: var(--primary);
                margin-right: 10px;
              }

              @media (max-width: 768px) {
                .header {
                  padding: 15px 20px;
                  flex-direction: column;
                  gap: 15px;
                }

                .header h1 {
                  font-size: 1.5rem;
                }

                .nav-menu {
                  flex-wrap: wrap;
                  justify-content: center;
                  gap: 10px;
                }

                .user-section {
                  flex-direction: column;
                  width: 100%;
                }

                .page-title h2 {
                  font-size: 1.5rem;
                }

                .payment-card {
                  padding: 25px 20px;
                }

                .qr-code-container img {
                  width: 180px;
                  height: 180px;
                }

                .button-group {
                  flex-direction: column;
                }

                .room-details,
                .qr-section,
                .warning-note {
                  padding: 20px;
                }

                .container {
                  padding: 0 15px;
                }
              }
            </style>
            <script>
              function calculateDeadline() {
                var paymentDate = document.getElementsByName("paymentDate")[0].value;
                var paymentDateParts = paymentDate.split("/");
                var paymentDateObj = new Date(
                  paymentDateParts[2],
                  paymentDateParts[1] - 1,
                  paymentDateParts[0]
                );

                paymentDateObj.setDate(paymentDateObj.getDate() + 7);

                var deadline = paymentDateObj.getDate();
                var deadlineMonth = paymentDateObj.getMonth() + 1;
                var deadlineYear = paymentDateObj.getFullYear();

                if (deadline < 10) deadline = "0" + deadline;
                if (deadlineMonth < 10) deadlineMonth = "0" + deadlineMonth;

                var formattedDeadline =
                  deadline + "/" + deadlineMonth + "/" + deadlineYear;
                document.getElementsByName("deadline")[0].value = formattedDeadline;
                document.getElementsByName("calculatedDeadline")[0].value =
                  formattedDeadline;
              }

              function validateForm() {
                const accountName = document.getElementsByName("transferAccountName")[0]
                  .value;
                const fileInput = document.getElementsByName("paymentSlip")[0];

                if (!accountName.trim()) {
                  alert("กรุณากรอกชื่อบัญชีที่โอน");
                  return false;
                }

                if (!fileInput.files.length) {
                  alert("กรุณาอัปโหลดสลิปโอนเงิน");
                  return false;
                }

                const file = fileInput.files[0];
                const validTypes = ["image/jpeg", "image/jpg", "image/png"];

                if (!validTypes.includes(file.type)) {
                  alert("กรุณาอัปโหลดไฟล์รูปภาพเท่านั้น (JPG, JPEG, PNG)");
                  return false;
                }

                if (file.size > 5 * 1024 * 1024) {
                  alert("ขนาดไฟล์ต้องไม่เกิน 5 MB");
                  return false;
                }

                return confirm("คุณต้องการยืนยันการชำระเงินใช่หรือไม่?");
              }

              function cancelPayment() {
                if (confirm("คุณต้องการยกเลิกการชำระเงินใช่หรือไม่?")) {
                  window.history.back();
                }
              }

              document.addEventListener("DOMContentLoaded", function () {
                calculateDeadline();

                document
                  .getElementsByName("paymentDate")[0]
                  .addEventListener("change", calculateDeadline);

                // Page load animation
                document.body.style.opacity = "0";
                document.body.style.transition = "opacity 0.5s ease-in-out";

                setTimeout(function () {
                  document.body.style.opacity = "1";
                }, 100);
              });
            </script>
          </head>

          <body>
            <!-- Header Navigation -->
            <div class="header">
              <h1>
                <i class="fas fa-building"></i>
                ThanaChok Place
              </h1>
              <div class="nav-menu">
                <a href="Homesucess" class="nav-link">
                  <i class="fas fa-home"></i> หน้าหลัก
                </a>
                <a href="YourRoom" class="nav-link">
                  <i class="fas fa-door-open"></i> ห้องของฉัน
                </a>
                <a href="ListInvoice" class="nav-link">
                  <i class="fas fa-file-invoice"></i> ใบแจ้งหนี้
                </a>
                <a href="Record" class="nav-link">
                  <i class="fas fa-history"></i> ประวัติการจอง
                </a>
              </div>
              <div class="user-section">
                <div class="user-info">
                  <i class="fas fa-user-circle"></i>
                  <span>
                    <%=loginMember !=null ? loginMember.getFirstName() + " " + loginMember.getLastName() : "" %>
                  </span>
                </div>
              </div>
            </div>

            <!-- Page Title Section -->
            <div class="page-title">
              <h2>
                <i class="fas fa-credit-card"></i>
                ชำระเงินมัดจำห้องพัก
              </h2>
              <p>กรุณาชำระเงินมัดจำและอัปโหลดสลิปเพื่อยืนยันการจองห้องพัก</p>
            </div>

            <!-- Container -->
            <div class="container">
              <form action="confirmPayment" method="post" enctype="multipart/form-data"
                onsubmit="return validateForm()">
                <div class="payment-card">
                  <!-- Room Details -->
                  <div class="room-details">
                    <h3>
                      <i class="fas fa-door-open"></i>
                      รายละเอียดห้องพัก
                    </h3>
                    <div class="detail-row">
                      <span class="detail-label">หมายเลขห้อง:</span>
                      <span class="detail-value">${room.roomNumber}</span>
                    </div>
                    <div class="detail-row">
                      <span class="detail-label">ประเภทห้อง:</span>
                      <span class="detail-value">${room.roomtype}</span>
                    </div>
                    <div class="detail-row">
                      <span class="detail-label">ค่ามัดจำ:</span>
                      <span class="deposit-amount">
                        <i class="fas fa-coins"></i> ${room.roomDeposit} บาท
                      </span>
                    </div>
                  </div>

                  <!-- Warning Note -->
                  <div class="warning-note">
                    <i class="fas fa-exclamation-triangle"></i>
                    <div>
                      <strong>หมายเหตุสำคัญ:</strong><br />
                      หากไม่มาติดต่อที่หอพักภายในระยะเวลาที่กำหนด (7 วัน)
                      การจองจะถือว่าเป็นโมฆะและไม่สามารถขอคืนเงินมัดจำได้
                    </div>
                  </div>

                  <!-- QR Code Section -->
                  <div class="qr-section">
                    <h3>
                      <i class="fas fa-qrcode"></i>
                      ชำระเงินผ่าน QR Code (PromptPay)
                    </h3>
                    <div class="qr-code-container">
                      <img src="https://promptpay.io/0635803516/${room.roomDeposit}.png" alt="QR Code PromptPay" />
                    </div>
                    <div class="qr-info">
                      <p><strong>หมายเลข PromptPay:</strong> 063-580-3516</p>
                      <p><strong>ชื่อบัญชี:</strong> ThanaChok Place</p>
                      <p><strong>จำนวนเงิน:</strong> ${room.roomDeposit} บาท</p>
                    </div>
                  </div>

                  <!-- Form Section -->
                  <div class="form-section">
                    <h3>
                      <i class="fas fa-file-upload"></i>
                      กรอกข้อมูลการชำระเงิน
                    </h3>

                    <input type="hidden" name="roomID" value="${room.roomID}" />
                    <input type="hidden" name="depositAmount" value="${room.roomDeposit}" />
                    <input type="hidden" name="price" value="${room.roomDeposit}" />
                    <input type="hidden" name="deadline" />

                    <div class="form-group">
                      <label> <i class="fas fa-user"></i> ชื่อบัญชีที่โอน: </label>
                      <input type="text" name="transferAccountName" placeholder="กรอกชื่อบัญชีที่ใช้โอนเงิน" required />
                    </div>

                    <div class="form-group">
                      <label> <i class="fas fa-calendar-day"></i> วันที่ชำระ: </label>
                      <input type="text" name="paymentDate" value="<%=todayStr%>" readonly />
                    </div>

                    <div class="form-group">
                      <label>
                        <i class="fas fa-calendar-check"></i> วันที่ต้องมาติดต่อ (ภายใน
                        7 วัน):
                      </label>
                      <input type="text" name="calculatedDeadline" readonly />
                    </div>

                    <div class="form-group">
                      <label>
                        <i class="fas fa-receipt"></i> อัปโหลดสลิปโอนเงิน:
                      </label>
                      <input type="file" name="paymentSlip" accept="image/*" required />
                    </div>

                    <div class="info-box">
                      <i class="fas fa-info-circle"></i>
                      <strong>คำแนะนำ:</strong>
                      กรุณาตรวจสอบข้อมูลให้ถูกต้องก่อนยืนยันการชำระเงิน
                      และเก็บสลิปโอนเงินไว้เป็นหลักฐาน
                    </div>

                    <div class="button-group">
                      <button type="submit" class="btn btn-submit">
                        <i class="fas fa-check-circle"></i>
                        ยืนยันการชำระเงิน
                      </button>
                      <button type="button" class="btn btn-cancel" onclick="cancelPayment()">
                        <i class="fas fa-times-circle"></i>
                        ยกเลิก
                      </button>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </body>

          </html>