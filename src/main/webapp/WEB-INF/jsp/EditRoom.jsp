<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="c"
uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ThanaChok Place - แก้ไขห้องพัก</title>
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
        padding: 20px;
      }

      .container {
        max-width: 900px;
        margin: 0 auto;
        padding: 20px;
      }

      .header {
        text-align: center;
        color: #ff8c00;
        font-size: 2.5rem;
        font-weight: bold;
        margin-bottom: 20px;
        text-shadow: 0 0 20px rgba(255, 140, 0, 0.5);
        position: relative;
        animation: glow 2s ease-in-out infinite;
      }

      @keyframes glow {
        0%,
        100% {
          text-shadow: 0 0 20px rgba(255, 140, 0, 0.5),
            0 0 30px rgba(255, 140, 0, 0.3);
        }
        50% {
          text-shadow: 0 0 30px rgba(255, 140, 0, 0.8),
            0 0 40px rgba(255, 140, 0, 0.5);
        }
      }

      .header::after {
        content: "";
        position: absolute;
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 100px;
        height: 4px;
        background: linear-gradient(45deg, #ff8c00, #ff6b00);
        border-radius: 2px;
        box-shadow: 0 0 10px rgba(255, 140, 0, 0.5);
      }

      .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: rgba(255, 140, 0, 0.1);
        backdrop-filter: blur(10px);
        padding: 15px 25px;
        border-radius: 15px;
        border: 1px solid rgba(255, 140, 0, 0.3);
        margin-bottom: 20px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
      }

      .page-title {
        color: #ff8c00;
        font-size: 1.2rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .page-title i {
        font-size: 1.5rem;
      }

      .back-link {
        color: #fff;
        text-decoration: none;
        padding: 10px 20px;
        background: rgba(255, 140, 0, 0.2);
        border: 1px solid rgba(255, 140, 0, 0.5);
        border-radius: 10px;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 500;
      }

      .back-link:hover {
        background: rgba(255, 140, 0, 0.3);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 140, 0, 0.3);
      }

      .form-container {
        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5),
          inset 0 1px 0 rgba(255, 140, 0, 0.1);
        border: 1px solid rgba(255, 140, 0, 0.2);
        position: relative;
        overflow: hidden;
      }

      .form-container::before {
        content: "";
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 2px;
        background: linear-gradient(90deg, transparent, #ff8c00, transparent);
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

      .form-title {
        text-align: center;
        color: #ff8c00;
        font-size: 2rem;
        margin-bottom: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
      }

      .form-title i {
        font-size: 2.5rem;
      }

      .form-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 25px;
        margin-bottom: 25px;
      }

      .form-group {
        position: relative;
      }

      .form-group.full-width {
        grid-column: 1 / -1;
      }

      .form-group label {
        display: block;
        color: #ff8c00;
        font-weight: 600;
        margin-bottom: 8px;
        font-size: 1rem;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .form-group label i {
        font-size: 1.1rem;
      }

      .form-group label .required {
        color: #ff4444;
        margin-left: 4px;
      }

      .form-group input,
      .form-group select,
      .form-group textarea {
        width: 100%;
        padding: 15px 20px;
        background: rgba(0, 0, 0, 0.4);
        border: 2px solid rgba(255, 140, 0, 0.3);
        border-radius: 10px;
        color: #fff;
        font-size: 1rem;
        transition: all 0.3s ease;
        outline: none;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }

      .form-group input:focus,
      .form-group select:focus,
      .form-group textarea:focus {
        border-color: #ff8c00;
        box-shadow: 0 0 20px rgba(255, 140, 0, 0.3);
        background: rgba(0, 0, 0, 0.6);
      }

      .form-group input::placeholder,
      .form-group textarea::placeholder {
        color: #666;
      }

      .form-group select {
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23ff8c00' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 15px center;
        padding-right: 45px;
      }

      .form-group select option {
        background: #2d2d2d;
        color: #fff;
        padding: 10px;
      }

      .form-group textarea {
        min-height: 120px;
        resize: vertical;
      }

      .info-box {
        background: rgba(255, 140, 0, 0.1);
        border: 1px solid rgba(255, 140, 0, 0.3);
        border-left: 4px solid #ff8c00;
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 25px;
        color: #ffa500;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .info-box i {
        font-size: 1.5rem;
        flex-shrink: 0;
      }

      .room-info {
        background: rgba(255, 140, 0, 0.05);
        border: 1px solid rgba(255, 140, 0, 0.2);
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 25px;
      }

      .room-info-item {
        display: flex;
        justify-content: space-between;
        padding: 10px 0;
        border-bottom: 1px solid rgba(255, 140, 0, 0.1);
      }

      .room-info-item:last-child {
        border-bottom: none;
      }

      .room-info-label {
        color: #ff8c00;
        font-weight: 600;
      }

      .room-info-value {
        color: #fff;
      }

      .button-group {
        display: flex;
        gap: 15px;
        margin-top: 30px;
        justify-content: center;
      }

      .submit-btn {
        background: linear-gradient(45deg, #ff8c00, #ff6b00);
        color: white;
        border: none;
        padding: 15px 40px;
        font-size: 1.1rem;
        font-weight: 600;
        border-radius: 25px;
        cursor: pointer;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        display: flex;
        align-items: center;
        gap: 10px;
        box-shadow: 0 5px 20px rgba(255, 140, 0, 0.3);
      }

      .submit-btn:before {
        content: "";
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(
          90deg,
          transparent,
          rgba(255, 255, 255, 0.3),
          transparent
        );
        transition: left 0.5s;
      }

      .submit-btn:hover:before {
        left: 100%;
      }

      .submit-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(255, 140, 0, 0.5);
      }

      .submit-btn:active {
        transform: translateY(-1px);
      }

      .cancel-btn {
        background: rgba(255, 255, 255, 0.1);
        color: white;
        border: 2px solid rgba(255, 140, 0, 0.5);
        padding: 13px 40px;
        font-size: 1.1rem;
        font-weight: 600;
        border-radius: 25px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .cancel-btn:hover {
        background: rgba(255, 140, 0, 0.2);
        border-color: #ff8c00;
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(255, 140, 0, 0.2);
      }

      .valid-feedback {
        color: #00ff88;
        font-size: 0.9rem;
        margin-top: 5px;
        display: none;
      }

      .invalid-feedback {
        color: #ff4444;
        font-size: 0.9rem;
        margin-top: 5px;
        display: none;
      }

      .form-group input.is-valid,
      .form-group select.is-valid,
      .form-group textarea.is-valid {
        border-color: #00ff88;
      }

      .form-group input.is-invalid,
      .form-group select.is-invalid,
      .form-group textarea.is-invalid {
        border-color: #ff4444;
      }

      .loading {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.9);
        z-index: 2000;
        justify-content: center;
        align-items: center;
      }

      .spinner {
        width: 60px;
        height: 60px;
        border: 6px solid rgba(255, 140, 0, 0.2);
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

      .price-input-wrapper {
        position: relative;
      }

      .price-input-wrapper::before {
        content: "฿";
        position: absolute;
        left: 20px;
        top: 50%;
        transform: translateY(-50%);
        color: #ff8c00;
        font-size: 1.2rem;
        font-weight: 600;
      }

      .price-input-wrapper input {
        padding-left: 45px;
      }

      @media (max-width: 768px) {
        .container {
          padding: 10px;
        }

        .header {
          font-size: 2rem;
        }

        .form-container {
          padding: 25px;
        }

        .form-title {
          font-size: 1.5rem;
        }

        .form-grid {
          grid-template-columns: 1fr;
        }

        .top-bar {
          flex-direction: column;
          gap: 15px;
          text-align: center;
        }

        .button-group {
          flex-direction: column;
        }

        .submit-btn,
        .cancel-btn {
          width: 100%;
          justify-content: center;
        }
      }

      @keyframes slideDown {
        from {
          opacity: 0;
          transform: translateY(-20px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
    </style>
  </head>
  <body>
    <!-- Loading Animation -->
    <div class="loading" id="loading">
      <div class="spinner"></div>
    </div>

    <div class="container">
      <div class="header">
        <i class="fas fa-building"></i>
        ThanaChok Place
      </div>

      <div class="top-bar">
        <div class="page-title">
          <i class="fas fa-edit"></i>
          แก้ไขข้อมูลห้องพัก
        </div>
        <a href="OwnerHome" class="back-link">
          <i class="fas fa-arrow-left"></i>
          กลับหน้าหลัก
        </a>
      </div>

      <div class="form-container">
        <div class="form-title">
          <i class="fas fa-door-open"></i>
          แก้ไขห้องพัก
        </div>

        <div class="info-box">
          <i class="fas fa-info-circle"></i>
          <span
            >กรุณากรอกข้อมูลให้ครบถ้วนและถูกต้อง ข้อมูลที่มีเครื่องหมาย
            <span style="color: #ff4444">*</span> จำเป็นต้องกรอก</span
          >
        </div>

        <form
          action="UpdateRoom"
          method="post"
          enctype="multipart/form-data"
          onsubmit="return validateForm()"
        >
          <input type="hidden" name="roomID" value="${room.roomID}" />

          <div class="form-grid">
            <div class="form-group">
              <label for="roomNumber">
                <i class="fas fa-door-closed"></i>
                เลขห้อง
              </label>
              <input
                type="text"
                id="roomNumber"
                name="roomNumber"
                value="${room.roomNumber}"
                placeholder="เช่น 101, 202"
                readonly
                style="background: rgba(0, 0, 0, 0.6); cursor: not-allowed"
                required
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
                value="${room.roomtype}"
                readonly
                style="background: rgba(0, 0, 0, 0.6); cursor: not-allowed"
                required
              />
            </div>

            <div class="form-group">
              <label for="roomPrice">
                <i class="fas fa-money-bill-wave"></i>
                ราคาห้อง (บาท/เดือน)
                <span class="required">*</span>
              </label>
              <div class="price-input-wrapper">
                <input
                  type="number"
                  id="roomPrice"
                  name="roomPrice"
                  value="${room.roomPrice}"
                  placeholder="3000"
                  min="0"
                  step="0.01"
                  required
                />
              </div>
              <div class="invalid-feedback" id="priceError">
                กรุณากรอกราคาห้องที่ถูกต้อง
              </div>
            </div>

            <div class="form-group">
              <label for="roomDeposit">
                <i class="fas fa-hand-holding-usd"></i>
                เงินมัดจำ (บาท)
                <span class="required">*</span>
              </label>
              <div class="price-input-wrapper">
                <input
                  type="number"
                  id="roomDeposit"
                  name="roomDeposit"
                  value="${room.roomDeposit}"
                  placeholder="3000"
                  min="0"
                  step="0.01"
                  required
                />
              </div>
              <div class="invalid-feedback" id="depositError">
                กรุณากรอกเงินมัดจำที่ถูกต้อง
              </div>
            </div>

            <div class="form-group full-width">
              <label for="description">
                <i class="fas fa-align-left"></i>
                คำอธิบายห้อง
                <span class="required">*</span>
              </label>
              <textarea
                id="description"
                name="description"
                placeholder="อธิบายรายละเอียดห้อง เช่น ขนาดห้อง อุปกรณ์ภายในห้อง ฯลฯ"
                required
              >
${room.description}</textarea
              >
              <div class="invalid-feedback" id="descriptionError">
                กรุณากรอกคำอธิบาย
              </div>
            </div>
          </div>

          <div class="button-group">
            <button type="submit" class="submit-btn">
              <i class="fas fa-save"></i>
              อัปเดตข้อมูลห้อง
            </button>
            <button
              type="button"
              class="cancel-btn"
              onclick="window.location.href='OwnerHome';"
            >
              <i class="fas fa-times"></i>
              ยกเลิก
            </button>
          </div>
        </form>
      </div>
    </div>

    <script>
      // Form Validation
      function validateForm() {
        let isValid = true;

        // Validate Room Price
        const roomPrice = document.getElementById("roomPrice");
        const priceError = document.getElementById("priceError");
        if (roomPrice.value <= 0 || roomPrice.value.trim() === "") {
          roomPrice.classList.add("is-invalid");
          priceError.style.display = "block";
          isValid = false;
        } else {
          roomPrice.classList.remove("is-invalid");
          roomPrice.classList.add("is-valid");
          priceError.style.display = "none";
        }

        // Validate Room Deposit
        const roomDeposit = document.getElementById("roomDeposit");
        const depositError = document.getElementById("depositError");
        if (roomDeposit.value <= 0 || roomDeposit.value.trim() === "") {
          roomDeposit.classList.add("is-invalid");
          depositError.style.display = "block";
          isValid = false;
        } else {
          roomDeposit.classList.remove("is-invalid");
          roomDeposit.classList.add("is-valid");
          depositError.style.display = "none";
        }

        // Validate Description
        const description = document.getElementById("description");
        const descriptionError = document.getElementById("descriptionError");
        if (description.value.trim() === "") {
          description.classList.add("is-invalid");
          descriptionError.style.display = "block";
          isValid = false;
        } else {
          description.classList.remove("is-invalid");
          description.classList.add("is-valid");
          descriptionError.style.display = "none";
        }

        if (isValid) {
          document.getElementById("loading").style.display = "flex";
        }

        return isValid;
      }

      // Real-time validation
      document
        .getElementById("roomPrice")
        .addEventListener("input", function () {
          if (this.value > 0) {
            this.classList.remove("is-invalid");
            this.classList.add("is-valid");
            document.getElementById("priceError").style.display = "none";
          }
        });

      document
        .getElementById("roomDeposit")
        .addEventListener("input", function () {
          if (this.value > 0) {
            this.classList.remove("is-invalid");
            this.classList.add("is-valid");
            document.getElementById("depositError").style.display = "none";
          }
        });

      document
        .getElementById("description")
        .addEventListener("input", function () {
          if (this.value.trim() !== "") {
            this.classList.remove("is-invalid");
            this.classList.add("is-valid");
            document.getElementById("descriptionError").style.display = "none";
          }
        });

      // Smooth Page Load
      window.addEventListener("load", function () {
        document.body.style.opacity = "0";
        document.body.style.transition = "opacity 0.5s ease-in-out";

        setTimeout(function () {
          document.body.style.opacity = "1";
          document.getElementById("loading").style.display = "none";
        }, 100);
      });

      // Prevent form resubmission
      if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
      }

      // Confirm before leaving with unsaved changes
      let formChanged = false;
      const formInputs = document.querySelectorAll("input, select, textarea");

      formInputs.forEach((input) => {
        input.addEventListener("change", function () {
          formChanged = true;
        });
      });

      window.addEventListener("beforeunload", function (e) {
        if (formChanged) {
          e.preventDefault();
          e.returnValue = "";
        }
      });

      // Reset formChanged flag on form submit
      document.querySelector("form").addEventListener("submit", function () {
        formChanged = false;
      });
    </script>
  </body>
</html>
