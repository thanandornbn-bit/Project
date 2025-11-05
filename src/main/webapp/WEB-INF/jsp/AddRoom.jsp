<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
    <link
      href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <style>
      :root {
        --bg: #ffffff;
        --muted-bg: #f0f7ff;
        --primary: #5ca9e9;
        --primary-dark: #4a90e2;
        --primary-light: #7bc4ff;
        --accent: #e3f2fd;
        --text: #1e3a5f;
        --text-light: #ffffff;
        --muted-text: #5b7a9d;
        --bg-secondary: #f8fcff;
        --border: #d1e8ff;
        --card-border: #d1e8ff;
        --hover-bg: #e8f4ff;
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
        font-family: "Sarabun", system-ui, -apple-system, "Segoe UI", Roboto,
          "Helvetica Neue", Arial;
        background: var(--bg);
        color: var(--text);
        min-height: 100vh;
      }

      .page-container {
        width: 100%;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
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

      .btn-edit-profile {
    background: linear-gradient(135deg, #5CA9E9, #4A90E2);
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 10px;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
    font-family: "Sarabun", sans-serif;
    font-size: 0.95rem;
    text-decoration: none;
    box-shadow: 0 2px 8px rgba(92, 169, 233, 0.3);
}

.btn-edit-profile:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(92, 169, 233, 0.4);
    background: linear-gradient(135deg, #4A90E2, #357ABD);
}


      .logout-btn {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 10px;
        font-weight: 700;
        font-family: "Sarabun", sans-serif;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
      }

      .logout-btn:hover {
        box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
        transform: translateY(-2px);
      }

      .container {
        width: 100%;
        max-width: 1400px;
        margin: 0 auto;
        padding: 40px 48px;
        flex: 1;
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
        border: 2px solid var(--card-border);
        color: var(--primary);
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s ease;
        font-weight: 600;
      }

      .back-btn:hover {
        background: var(--hover-bg);
        transform: translateX(-5px);
        box-shadow: 0 4px 12px var(--shadow);
      }

      .form-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 8px 24px var(--shadow);
        border: 2px solid var(--card-border);
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
        background: linear-gradient(
          135deg,
          var(--primary) 0%,
          var(--primary-dark) 100%
        );
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
        background: white;
      }

      .alert {
        padding: 18px 25px;
        border-radius: 12px;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 12px;
        font-weight: 600;
        animation: slideInDown 0.5s ease;
        box-shadow: 0 4px 12px var(--shadow);
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

      .alert i {
        font-size: 1.3rem;
      }

      .alert-success {
        background: #d4f4dd;
        color: var(--success);
        border: 2px solid var(--success);
      }

      .alert-error {
        background: #ffe4e6;
        color: var(--danger);
        border: 2px solid var(--danger);
      }

      .form-section {
        margin-bottom: 30px;
        padding: 25px;
        background: var(--muted-bg);
        border-radius: 15px;
        border: 2px solid var(--card-border);
      }

      .section-title {
        color: var(--primary);
        font-size: 1.3rem;
        font-weight: 700;
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
        color: var(--primary);
        margin-bottom: 10px;
        font-size: 1rem;
      }

      .form-control {
        width: 100%;
        padding: 15px;
        background: white;
        border: 2px solid var(--border);
        border-radius: 10px;
        font-size: 1rem;
        color: var(--text);
        font-family: "Sarabun", sans-serif;
        transition: all 0.3s ease;
      }

      .form-control:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 15px var(--shadow);
        background: var(--bg-secondary);
      }

      textarea.form-control {
        resize: vertical;
        min-height: 120px;
        font-family: "Sarabun", sans-serif;
      }

      select.form-control {
        cursor: pointer;
      }

      input[type="file"].form-control {
        padding: 10px;
        cursor: pointer;
      }

      .form-control[readonly] {
        background: var(--muted-bg);
        cursor: not-allowed;
        opacity: 0.8;
      }

      .image-preview {
        margin-top: 15px;
        min-height: 200px;
        border: 2px dashed var(--border);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: var(--muted-bg);
        overflow: hidden;
      }

      .image-preview img {
        max-width: 100%;
        max-height: 200px;
        border-radius: 8px;
        object-fit: contain;
      }

      .image-preview.empty {
        color: var(--muted-text);
        font-size: 0.9rem;
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
        font-weight: 700;
        font-family: "Sarabun", sans-serif;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        min-width: 180px;
        justify-content: center;
      }

      .btn-primary {
        background: linear-gradient(135deg, var(--success) 0%, #43a047 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
      }

      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(76, 175, 80, 0.5);
      }

      .btn-secondary {
        background: white;
        color: var(--danger);
        border: 2px solid var(--danger);
        box-shadow: 0 4px 15px rgba(244, 67, 54, 0.2);
      }

      .btn-secondary:hover {
        background: linear-gradient(135deg, var(--danger) 0%, #e53935 100%);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(244, 67, 54, 0.4);
      }

      .loading-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        backdrop-filter: blur(4px);
        z-index: 999;
        justify-content: center;
        align-items: center;
      }

      .loading-overlay .spinner {
        width: 60px;
        height: 60px;
        border: 6px solid rgba(92, 169, 233, 0.2);
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
        .header {
          padding: 15px 20px;
          flex-direction: column;
          gap: 15px;
        }

        .header h1 {
          font-size: 1.8rem;
        }

        .nav-menu {
          width: 100%;
          justify-content: center;
          flex-wrap: wrap;
        }

        .user-section {
          width: 100%;
          justify-content: center;
        }

        .container {
          padding: 20px;
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
    <div class="loading-overlay" id="loadingOverlay">
      <div class="spinner"></div>
    </div>

    <div class="page-container">
      <!-- Header -->
      <div class="header">
        <h1>
          <i class="fas fa-building"></i>
          ThanaChok Place
        </h1>
        <nav class="nav-menu">
          <a href="OwnerHome" class="nav-link">
            <i class="fas fa-home"></i> หน้าหลัก
          </a>
          <a href="OViewReserve" class="nav-link">
            <i class="fas fa-list"></i> รายการเช่า
          </a>
          <a href="ListReservations" class="nav-link">
            <i class="fas fa-clipboard-list"></i> รายการจอง
          </a>
          <a href="ListReturnRoom" class="nav-link">
            <i class="fas fa-clipboard-check"></i> คำขอคืนห้อง
          </a>
          <a href="ManageUtilityRates" class="nav-link">
                                                <i class="fas fa-cogs"></i> ตั้งค่าหน่วย
                                            </a>
          <a href="AddRoom" class="nav-link active">
            <i class="fas fa-plus"></i> เพิ่มห้อง
          </a>
        </nav>
        <div class="user-section">
          <div class="user-info">
            <i class="fas fa-user-circle"></i>
            <span>${loginManager.email}</span>
          </div>
          <a href="EditManager" class="btn-edit-profile" style="margin-left:10px;">
            <i class="fas fa-user-edit"></i> แก้ไขข้อมูล
          </a>
          <form action="Logout" method="post" style="display: inline">
            <button type="submit" class="logout-btn">
              <i class="fas fa-sign-out-alt"></i> ออกจากระบบ
            </button>
          </form>
        </div>
      </div>

      <div class="container">
        <div class="page-header">
          <i class="fas fa-plus-circle"></i>
          เพิ่มห้องพักใหม่
        </div>

        <div class="form-card">
          <div class="card-header">
            <h2>
              <i class="fas fa-door-open"></i>
              ข้อมูลห้องพัก
            </h2>
          </div>

          <div class="card-body">
            <c:if test="${not empty message}">
              <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${message}
              </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
              <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${errorMessage}
              </div>
            </c:if>

            <form
              action="AddRoom"
              method="post"
              id="addRoomForm"
              enctype="multipart/form-data"
            >
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
                      pattern="[0-9]{3}"
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

              <div class="form-section">
                <div class="section-title">
                  <i class="fas fa-images"></i>
                  รูปภาพห้องพัก
                </div>

                <div class="form-group">
                  <label for="roomNumberImage">
                    <i class="fas fa-hashtag"></i>
                    รูปเลขห้อง
                  </label>
                  <input
                    type="file"
                    id="roomNumberImage"
                    name="roomNumberImage"
                    class="form-control"
                    accept="image/*"
                    onchange="previewImage(this, 'preview0')"
                  />
                  <div class="image-preview" id="preview0"></div>
                </div>

                <div class="form-grid">
                  <div class="form-group">
                    <label for="roomImage1">
                      <i class="fas fa-image"></i>
                      รูปภายในห้อง 1
                    </label>
                    <input
                      type="file"
                      id="roomImage1"
                      name="roomImage1"
                      class="form-control"
                      accept="image/*"
                      onchange="previewImage(this, 'preview1')"
                    />
                    <div class="image-preview" id="preview1"></div>
                  </div>

                  <div class="form-group">
                    <label for="roomImage2">
                      <i class="fas fa-image"></i>
                      รูปภายในห้อง 2
                    </label>
                    <input
                      type="file"
                      id="roomImage2"
                      name="roomImage2"
                      class="form-control"
                      accept="image/*"
                      onchange="previewImage(this, 'preview2')"
                    />
                    <div class="image-preview" id="preview2"></div>
                  </div>
                </div>

                <div class="form-grid">
                  <div class="form-group">
                    <label for="roomImage3">
                      <i class="fas fa-image"></i>
                      รูปภายในห้อง 3
                    </label>
                    <input
                      type="file"
                      id="roomImage3"
                      name="roomImage3"
                      class="form-control"
                      accept="image/*"
                      onchange="previewImage(this, 'preview3')"
                    />
                    <div class="image-preview" id="preview3"></div>
                  </div>

                  <div class="form-group">
                    <label for="roomImage4">
                      <i class="fas fa-image"></i>
                      รูปภายในห้อง 4
                    </label>
                    <input
                      type="file"
                      id="roomImage4"
                      name="roomImage4"
                      class="form-control"
                      accept="image/*"
                      onchange="previewImage(this, 'preview4')"
                    />
                    <div class="image-preview" id="preview4"></div>
                  </div>
                </div>
              </div>

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
    </div>

    <script>
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

        document.getElementById("roomNumber").focus();

        document
          .getElementById("roomNumber")
          .addEventListener("input", function (e) {
            let value = e.target.value.replace(/\D/g, "");
            if (value.length > 3) value = value.slice(0, 3);
            e.target.value = value;
          });
      });

      function previewImage(input, previewId) {
        const preview = document.getElementById(previewId);
        preview.innerHTML = "";

        if (input.files && input.files[0]) {
          const file = input.files[0];

          // ตรวจสอบขนาดไฟล์ (ไม่เกิน 5MB)
          if (file.size > 5 * 1024 * 1024) {
            alert("ขนาดไฟล์เกิน 5MB กรุณาเลือกไฟล์ที่มีขนาดเล็กกว่า");
            input.value = "";
            return;
          }

          // ตรวจสอบประเภทไฟล์
          if (!file.type.match("image.*")) {
            alert("กรุณาเลือกไฟล์รูปภาพเท่านั้น");
            input.value = "";
            return;
          }

          const reader = new FileReader();
          reader.onload = function (e) {
            const img = document.createElement("img");
            img.src = e.target.result;
            preview.appendChild(img);
          };
          reader.readAsDataURL(file);
        }
      }

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
