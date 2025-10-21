<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ThanaChok Place - เพิ่มห้องพัก</title>
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

      .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 30px 20px;
        position: relative;
        z-index: 1;
      }

      .page-header {
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

      .alert {
        padding: 20px 25px;
        border-radius: 12px;
        margin-bottom: 25px;
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
        background: rgba(0, 255, 136, 0.15);
        border: 2px solid #00ff88;
        color: #00ff88;
      }

      .alert-error {
        background: rgba(255, 68, 68, 0.15);
        border: 2px solid #ff4444;
        color: #ff4444;
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
        position: relative;
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

      textarea.form-control {
        resize: vertical;
        min-height: 120px;
        font-family: inherit;
      }

      select.form-control {
        cursor: pointer;
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

      .loading-overlay {
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

      .loading-overlay .spinner {
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
        .form-grid {
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
      }
    </style>
  </head>

  <body>
    <div class="bg-animation">
      <div class="floating-shapes"></div>
      <div class="floating-shapes"></div>
      <div class="floating-shapes"></div>
    </div>

    <div class="loading-overlay" id="loadingOverlay">
      <div class="spinner"></div>
    </div>

    <div class="container">
      <div class="page-header">
        <i class="fas fa-plus-circle"></i>
        เพิ่มห้องพักใหม่
      </div>

      <a href="OwnerHome" class="back-btn">
        <i class="fas fa-arrow-left"></i>
        กลับหน้าหลัก
      </a>

      <div class="form-card">
        <div class="card-header">
          <h2>
            <i class="fas fa-door-open"></i>
            ข้อมูลห้องพัก
          </h2>
        </div>

        <div class="card-body">
          <!-- Success Message -->
          <c:if test="${not empty message}">
            <div class="alert alert-success">
              <i class="fas fa-check-circle"></i>
              ${message}
            </div>
          </c:if>

          <!-- Error Message -->
          <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
              <i class="fas fa-exclamation-circle"></i>
              ${errorMessage}
            </div>
          </c:if>

          <!-- Add Room Form -->
          <form action="AddRoom" method="post" id="addRoomForm">
            <!-- Room Info -->
            <div class="form-section">
              <div class="section-title">
                <i class="fas fa-info-circle"></i>
                ข้อมูลพื้นฐาน
              </div>
              <div class="form-grid">
                <div class="form-group">
                  <label for="roomNumber">
                    <i class="fas fa-hashtag"></i>
                    หมายเลขห้อง
                  </label>
                  <input
                    type="text"
                    id="roomNumber"
                    name="roomNumber"
                    class="form-control"
                    required
                    placeholder="เช่น 101, 102, 103"
                    pattern="[0-9]{3,4}"
                    maxlength="3"
                  />
                </div>

                <div class="form-group">
                  <label for="roomtype">
                    <i class="fas fa-home"></i>
                    ประเภทห้อง
                  </label>
                  <input
                    type="text"
                    id="roomtype"
                    name="roomtype"
                    class="form-control"
                    value="ห้องแอร์"
                    readonly
                    style="background: rgba(0, 0, 0, 0.6)"
                  />
                </div>
              </div>
            </div>

            <!-- Room Details -->
            <div class="form-section">
              <div class="section-title">
                <i class="fas fa-align-left"></i>
                รายละเอียดห้อง
              </div>
              <div class="form-group">
                <label for="description">
                  <i class="fas fa-edit"></i>
                  คำอธิบาย
                </label>
                <textarea
                  id="description"
                  name="description"
                  class="form-control"
                  required
                  placeholder="รายละเอียดห้อง เช่น ขนาดห้อง, สิ่งอำนวยความสะดวก, เฟอร์นิเจอร์"
                ></textarea>
              </div>
            </div>

            <!-- Price and Status -->
            <div class="form-section">
              <div class="section-title">
                <i class="fas fa-dollar-sign"></i>
                ราคาและสถานะ
              </div>
              <div class="form-grid">
                <div class="form-group">
                  <label for="roomPrice">
                    <i class="fas fa-money-bill-wave"></i>
                    ราคาห้อง (บาท/เดือน)
                  </label>
                  <input
                    type="number"
                    id="roomPrice"
                    name="roomPrice"
                    class="form-control"
                    required
                    placeholder="3000"
                    min="1000"
                    max="50000"
                    step="100"
                  />
                </div>

                <div class="form-group">
                  <label for="roomStatus">
                    <i class="fas fa-flag"></i>
                    สถานะห้อง
                  </label>
                  <input
                    type="text"
                    id="roomStatus"
                    name="roomStatus"
                    class="form-control"
                    value="ว่าง"
                    readonly
                    style="background: rgba(0, 0, 0, 0.6)"
                  />
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="roomDeposit">
                <i class="fas fa-money-bill-wave"></i>
                ราคามัดจำห้อง (บาท)
              </label>
              <input
                type="number"
                id="roomDeposit"
                name="roomDeposit"
                class="form-control"
                required
                placeholder="กรุณากรอกค่ามัดจำห้อง"
                min="500"
                value="500"
              />
            </div>

            <!-- Buttons -->
            <div class="btn-group">
              <button type="submit" class="btn btn-primary" id="submitBtn">
                <i class="fas fa-save"></i>
                บันทึกห้องพัก
              </button>

              <a href="OwnerHome" class="btn btn-secondary">
                <i class="fas fa-times"></i>
                ยกเลิก
              </a>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script>
      // Form validation and submission
      document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("addRoomForm");
        const submitBtn = document.getElementById("submitBtn");

        form.addEventListener("submit", function (e) {
          const roomNumber = document.getElementById("roomNumber").value;
          const description = document.getElementById("description").value;
          const roomPrice = parseInt(
            document.getElementById("roomPrice").value
          );
          const roomDeposit = parseInt(
            document.getElementById("roomDeposit").value
          );

          if (!roomNumber || roomNumber.length < 3) {
            e.preventDefault();
            alert("กรุณากรอกหมายเลขห้อง (3-4 หลัก)");
            return;
          }

          if (!description || description.length < 10) {
            e.preventDefault();
            alert("กรุณากรอกรายละเอียดห้องอย่างน้อย 10 ตัวอักษร");
            return;
          }

          if (!roomPrice || roomPrice < 1000 || roomPrice > 50000) {
            e.preventDefault();
            alert("กรุณากรอกราคาห้อง (1,000 - 50,000 บาท)");
            return;
          }

          if (!roomDeposit || roomDeposit < 500) {
            e.preventDefault();
            alert("กรุณากรอกค่ามัดจำอย่างน้อย 500 บาท");
            return;
          }

          submitBtn.disabled = true;
          document.getElementById("loadingOverlay").style.display = "flex";
        });

        // Focus first input
        document.getElementById("roomNumber").focus();
      });

      document
        .getElementById("roomNumber")
        .addEventListener("input", function (e) {
          let value = e.target.value.replace(/\D/g, "");
          if (value.length > 4) {
            value = value.slice(0, 4);
          }
          e.target.value = value;
        });

      document
        .getElementById("roomPrice")
        .addEventListener("input", function (e) {
          let value = parseInt(e.target.value);
          if (value < 1000) {
            e.target.style.borderColor = "#ff6b6b";
          } else if (value > 50000) {
            e.target.style.borderColor = "#ff6b6b";
          } else {
            e.target.style.borderColor = "#4ecdc4";
          }
        });

      document
        .getElementById("roomDeposit")
        .addEventListener("input", function (e) {
          let value = parseInt(e.target.value);
          if (value < 500) {
            e.target.style.borderColor = "#ff6b6b";
          } else {
            e.target.style.borderColor = "#4ecdc4";
          }
        });

      // Input formatting - room number (only numbers, max 4 digits)
      document
        .getElementById("roomNumber")
        .addEventListener("input", function (e) {
          let value = e.target.value.replace(/\D/g, "");
          if (value.length > 4) value = value.slice(0, 4);
          e.target.value = value;
        });

      // Page load animation
      window.addEventListener("load", function () {
        document.body.style.opacity = "0";
        document.body.style.transition = "opacity 0.5s ease-in-out";
        setTimeout(() => {
          document.body.style.opacity = "1";
        }, 100);
      });
    </script>
  </body>
</html>
