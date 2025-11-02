<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="com.springmvc.model.Member" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
      <% Member member=(Member) session.getAttribute("loginMember"); if (member==null) { response.sendRedirect("Login");
        return; } %>
        <!DOCTYPE html>
        <html lang="th">

        <head>
          <meta charset="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <title>ThanaChok Place - แก้ไขข้อมูลส่วนตัว</title>
          <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
          <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
            rel="stylesheet" />
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
              background: linear-gradient(135deg,
                  var(--bg-secondary) 0%,
                  var(--accent) 100%);
              min-height: 100vh;
              color: var(--text);
              padding: 20px;
            }

            .container {
              max-width: 800px;
              margin: 0 auto;
              padding: 20px;
            }

            .header {
              text-align: center;
              color: var(--primary);
              font-size: 2.5rem;
              font-weight: 700;
              margin-bottom: 25px;
              text-shadow: 0 2px 10px var(--shadow);
              position: relative;
              display: flex;
              align-items: center;
              justify-content: center;
              gap: 15px;
            }

            .header i {
              font-size: 2.3rem;
            }

            .header::after {
              content: "";
              position: absolute;
              bottom: -10px;
              left: 50%;
              transform: translateX(-50%);
              width: 120px;
              height: 4px;
              background: linear-gradient(90deg,
                  var(--primary),
                  var(--primary-light));
              border-radius: 2px;
              box-shadow: 0 2px 8px var(--shadow);
            }

            .top-bar {
              display: flex;
              justify-content: space-between;
              align-items: center;
              background: var(--bg);
              backdrop-filter: blur(10px);
              padding: 18px 30px;
              border-radius: 16px;
              border: 2px solid var(--border);
              margin-bottom: 25px;
              box-shadow: 0 4px 20px var(--shadow);
            }

            .welcome-message {
              color: var(--primary);
              font-size: 1.3rem;
              font-weight: 600;
              display: flex;
              align-items: center;
              gap: 12px;
            }

            .welcome-message i {
              font-size: 1.6rem;
            }

            .back-link {
              color: var(--primary);
              text-decoration: none;
              padding: 12px 24px;
              background: var(--bg-secondary);
              border: 2px solid var(--primary);
              border-radius: 12px;
              transition: all 0.3s ease;
              display: flex;
              align-items: center;
              gap: 10px;
              font-weight: 500;
            }

            .back-link:hover {
              background: var(--primary);
              color: var(--text-light);
              transform: translateY(-2px);
              box-shadow: 0 6px 20px var(--shadow);
            }

            .form-container {
              background: var(--bg);
              padding: 45px;
              border-radius: 24px;
              box-shadow: 0 10px 40px var(--shadow);
              border: 2px solid var(--border);
              position: relative;
              overflow: hidden;
            }

            .form-container::before {
              content: "";
              position: absolute;
              top: 0;
              left: 0;
              right: 0;
              height: 4px;
              background: linear-gradient(90deg,
                  var(--primary) 0%,
                  var(--primary-light) 50%,
                  var(--primary) 100%);
              animation: shimmer 3s ease-in-out infinite;
            }

            @keyframes shimmer {

              0%,
              100% {
                opacity: 0.6;
              }

              50% {
                opacity: 1;
              }
            }

            .form-title {
              text-align: center;
              color: var(--primary);
              font-size: 2rem;
              font-weight: 700;
              margin-bottom: 35px;
              display: flex;
              align-items: center;
              justify-content: center;
              gap: 15px;
              padding-bottom: 20px;
              border-bottom: 2px solid var(--accent);
            }

            .form-title i {
              font-size: 2.2rem;
            }

            .form-group {
              margin-bottom: 25px;
              position: relative;
            }

            .form-group label {
              display: block;
              color: var(--primary-dark);
              font-weight: 600;
              margin-bottom: 10px;
              font-size: 1.05rem;
              display: flex;
              align-items: center;
              gap: 10px;
            }

            .form-group label i {
              font-size: 1.15rem;
              color: var(--primary);
            }

            .form-group input {
              width: 100%;
              padding: 16px 20px;
              background: var(--bg-secondary);
              border: 2px solid var(--border);
              border-radius: 12px;
              color: var(--text);
              font-size: 1rem;
              font-family: "Sarabun", sans-serif;
              transition: all 0.3s ease;
              outline: none;
            }

            .form-group input:focus {
              border-color: var(--primary);
              box-shadow: 0 0 0 3px var(--accent);
              background: var(--bg);
            }

            .form-group input:read-only {
              background: var(--accent);
              border-color: var(--border);
              cursor: not-allowed;
              color: var(--muted-text);
            }

            .form-group input::placeholder {
              color: var(--muted-text);
            }

            .password-wrapper {
              position: relative;
            }

            .password-toggle {
              position: absolute;
              right: 18px;
              top: 50%;
              transform: translateY(-50%);
              color: var(--primary);
              cursor: pointer;
              font-size: 1.2rem;
              transition: all 0.3s ease;
            }

            .password-toggle:hover {
              color: var(--primary-dark);
              transform: translateY(-50%) scale(1.15);
            }

            .error-message {
              background: rgba(244, 67, 54, 0.1);
              border: 2px solid var(--danger);
              color: var(--danger);
              padding: 16px 22px;
              border-radius: 12px;
              margin-bottom: 20px;
              display: flex;
              align-items: center;
              gap: 12px;
              animation: shake 0.5s ease;
              font-weight: 500;
            }

            .error-message i {
              font-size: 1.5rem;
            }

            .error-message:empty {
              display: none;
            }

            @keyframes shake {

              0%,
              100% {
                transform: translateX(0);
              }

              25% {
                transform: translateX(-10px);
              }

              75% {
                transform: translateX(10px);
              }
            }

            .success-message {
              background: rgba(76, 175, 80, 0.1);
              border: 2px solid var(--success);
              color: var(--success);
              padding: 16px 22px;
              border-radius: 12px;
              margin-bottom: 20px;
              display: flex;
              align-items: center;
              gap: 12px;
              animation: slideDown 0.5s ease;
              font-weight: 500;
            }

            .success-message i {
              font-size: 1.5rem;
            }

            .button-group {
              display: flex;
              gap: 15px;
              margin-top: 35px;
              justify-content: center;
            }

            .submit-btn {
              background: linear-gradient(135deg,
                  var(--primary),
                  var(--primary-dark));
              color: var(--text-light);
              border: none;
              padding: 16px 45px;
              font-size: 1.1rem;
              font-weight: 600;
              font-family: "Sarabun", sans-serif;
              border-radius: 12px;
              cursor: pointer;
              transition: all 0.3s ease;
              position: relative;
              overflow: hidden;
              display: flex;
              align-items: center;
              gap: 12px;
              box-shadow: 0 6px 20px var(--shadow);
            }

            .submit-btn:before {
              content: "";
              position: absolute;
              top: 0;
              left: -100%;
              width: 100%;
              height: 100%;
              background: linear-gradient(90deg,
                  transparent,
                  rgba(255, 255, 255, 0.2),
                  transparent);
              transition: left 0.5s;
            }

            .submit-btn:hover:before {
              left: 100%;
            }

            .submit-btn:hover {
              transform: translateY(-3px);
              box-shadow: 0 8px 25px var(--shadow);
              background: linear-gradient(135deg,
                  var(--primary-dark),
                  var(--primary));
            }

            .submit-btn:active {
              transform: translateY(-1px);
            }

            .cancel-btn {
              background: var(--bg);
              color: var(--primary);
              border: 2px solid var(--primary);
              padding: 14px 45px;
              font-size: 1.1rem;
              font-weight: 600;
              font-family: "Sarabun", sans-serif;
              border-radius: 12px;
              cursor: pointer;
              transition: all 0.3s ease;
              text-decoration: none;
              display: flex;
              align-items: center;
              gap: 12px;
            }

            .cancel-btn:hover {
              background: var(--accent);
              border-color: var(--primary-dark);
              transform: translateY(-3px);
              box-shadow: 0 6px 20px var(--shadow);
            }

            .info-box {
              background: var(--accent);
              border: 2px solid var(--primary);
              border-left: 5px solid var(--primary);
              padding: 16px 22px;
              border-radius: 12px;
              margin-bottom: 28px;
              color: var(--primary-dark);
              font-weight: 500;
            }

            .info-box i {
              margin-right: 10px;
              color: var(--primary);
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
              border: 6px solid var(--accent);
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

            .valid-feedback {
              color: var(--success);
              font-size: 0.9rem;
              margin-top: 6px;
              display: none;
              font-weight: 500;
            }

            .invalid-feedback {
              color: var(--danger);
              font-size: 0.9rem;
              margin-top: 6px;
              display: none;
              font-weight: 500;
            }

            .form-group input.is-valid {
              border-color: var(--success);
              background: rgba(76, 175, 80, 0.05);
            }

            .form-group input.is-invalid {
              border-color: var(--danger);
              background: rgba(244, 67, 54, 0.05);
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
              <div class="welcome-message">
                <i class="fas fa-user-circle"></i>
                แก้ไขข้อมูลส่วนตัว
              </div>
              <a href="Homesucess" class="back-link">
                <i class="fas fa-arrow-left"></i>
                กลับหน้าหลัก
              </a>
            </div>

            <div class="form-container">
              <div class="form-title">
                <i class="fas fa-user-edit"></i>
                แก้ไขข้อมูลส่วนตัว
              </div>

              <div class="info-box">
                <i class="fas fa-info-circle"></i>
                <strong>หมายเหตุ:</strong> Email ไม่สามารถแก้ไขได้ |
                หากไม่ต้องการเปลี่ยนรหัสผ่านให้เว้นว่างไว้
              </div>

              <c:if test="${not empty edit_result}">
                <c:choose>
                  <c:when test="${edit_result == 'บันทึกข้อมูลเรียบร้อยแล้ว'}">
                    <div class="success-message">
                      <i class="fas fa-check-circle"></i>
                      ${edit_result}
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="error-message">
                      <i class="fas fa-exclamation-triangle"></i>
                      ${edit_result}
                    </div>
                  </c:otherwise>
                </c:choose>
              </c:if>

              <form name="formEditProfile" action="Editprofile" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                  <label for="email">
                    <i class="fas fa-envelope"></i>
                    อีเมล
                  </label>
                  <input type="email" id="email" name="email" value="<%= member.getEmail() %>" required readonly />
                </div>

                <div class="form-group">
                  <label for="firstName">
                    <i class="fas fa-user"></i>
                    ชื่อ
                  </label>
                  <input type="text" id="firstName" name="firstName" value="<%= member.getFirstName() %>" required />
                  <div class="invalid-feedback" id="firstNameError">
                    กรุณากรอกชื่อ
                  </div>
                </div>

                <div class="form-group">
                  <label for="lastName">
                    <i class="fas fa-user"></i>
                    นามสกุล
                  </label>
                  <input type="text" id="lastName" name="lastName" value="<%= member.getLastName() %>" required />
                  <div class="invalid-feedback" id="lastNameError">
                    กรุณากรอกนามสกุล
                  </div>
                </div>

                <div class="form-group">
                  <label for="phoneNumber">
                    <i class="fas fa-phone"></i>
                    เบอร์โทรศัพท์
                  </label>
                  <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= member.getPhoneNumber() %>" required
                    pattern="^0[0-9]{9}$" maxlength="10" placeholder="0812345678" />
                  <div class="invalid-feedback" id="phoneError">
                    กรุณากรอกเบอร์โทรศัพท์ 10 หลัก (ขึ้นต้นด้วย 0)
                  </div>
                  <div class="valid-feedback" id="phoneValid">
                    เบอร์โทรศัพท์ถูกต้อง
                  </div>
                </div>

                <div class="form-group">
                  <label for="password">
                    <i class="fas fa-lock"></i>
                    รหัสผ่านใหม่ (ถ้าต้องการเปลี่ยน)
                  </label>
                  <div class="password-wrapper">
                    <input type="password" id="password" name="password"
                      placeholder="กรอกรหัสผ่านใหม่ถ้าต้องการเปลี่ยน" />
                    <i class="fas fa-eye password-toggle" id="togglePassword"></i>
                  </div>
                  <div class="invalid-feedback" id="passwordError">
                    รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร
                  </div>
                </div>

                <div class="form-group">
                  <label for="confirmPassword">
                    <i class="fas fa-lock"></i>
                    ยืนยันรหัสผ่านใหม่
                  </label>
                  <div class="password-wrapper">
                    <input type="password" id="confirmPassword" name="confirmPassword"
                      placeholder="ยืนยันรหัสผ่านใหม่" />
                    <i class="fas fa-eye password-toggle" id="toggleConfirmPassword"></i>
                  </div>
                  <div class="invalid-feedback" id="confirmPasswordError">
                    รหัสผ่านไม่ตรงกัน
                  </div>
                  <div class="valid-feedback" id="confirmPasswordValid">
                    รหัสผ่านตรงกัน
                  </div>
                </div>

                <div class="button-group">
                  <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i>
                    บันทึกการแก้ไข
                  </button>
                  <a href="Homesucess" class="cancel-btn">
                    <i class="fas fa-times"></i>
                    ยกเลิก
                  </a>
                </div>
              </form>
            </div>
          </div>

          <script>
            // Toggle Password Visibility
            function togglePasswordVisibility(inputId, toggleId) {
              const input = document.getElementById(inputId);
              const toggle = document.getElementById(toggleId);

              toggle.addEventListener("click", function () {
                if (input.type === "password") {
                  input.type = "text";
                  toggle.classList.remove("fa-eye");
                  toggle.classList.add("fa-eye-slash");
                } else {
                  input.type = "password";
                  toggle.classList.remove("fa-eye-slash");
                  toggle.classList.add("fa-eye");
                }
              });
            }

            togglePasswordVisibility("password", "togglePassword");
            togglePasswordVisibility("confirmPassword", "toggleConfirmPassword");

            // Phone Number Validation
            const phoneInput = document.getElementById("phoneNumber");
            const phoneError = document.getElementById("phoneError");
            const phoneValid = document.getElementById("phoneValid");

            phoneInput.addEventListener("input", function () {
              const phonePattern = /^0[0-9]{9}$/;

              if (this.value.length === 10 && phonePattern.test(this.value)) {
                this.classList.add("is-valid");
                this.classList.remove("is-invalid");
                phoneError.style.display = "none";
                phoneValid.style.display = "block";
              } else if (this.value.length > 0) {
                this.classList.add("is-invalid");
                this.classList.remove("is-valid");
                phoneError.style.display = "block";
                phoneValid.style.display = "none";
              } else {
                this.classList.remove("is-valid", "is-invalid");
                phoneError.style.display = "none";
                phoneValid.style.display = "none";
              }
            });

            // Password Match Validation
            const password = document.getElementById("password");
            const confirmPassword = document.getElementById("confirmPassword");
            const confirmPasswordError = document.getElementById(
              "confirmPasswordError"
            );
            const confirmPasswordValid = document.getElementById(
              "confirmPasswordValid"
            );

            function checkPasswordMatch() {
              if (password.value.length > 0 || confirmPassword.value.length > 0) {
                if (
                  password.value === confirmPassword.value &&
                  password.value.length >= 6
                ) {
                  confirmPassword.classList.add("is-valid");
                  confirmPassword.classList.remove("is-invalid");
                  confirmPasswordError.style.display = "none";
                  confirmPasswordValid.style.display = "block";
                  return true;
                } else {
                  confirmPassword.classList.add("is-invalid");
                  confirmPassword.classList.remove("is-valid");
                  confirmPasswordError.style.display = "block";
                  confirmPasswordValid.style.display = "none";
                  return false;
                }
              }
              return true;
            }

            password.addEventListener("input", checkPasswordMatch);
            confirmPassword.addEventListener("input", checkPasswordMatch);

            // Form Validation
            function validateForm() {
              let isValid = true;

              // Validate First Name
              const firstName = document.getElementById("firstName");
              const firstNameError = document.getElementById("firstNameError");
              if (firstName.value.trim() === "") {
                firstName.classList.add("is-invalid");
                firstNameError.style.display = "block";
                isValid = false;
              } else {
                firstName.classList.remove("is-invalid");
                firstNameError.style.display = "none";
              }

              // Validate Last Name
              const lastName = document.getElementById("lastName");
              const lastNameError = document.getElementById("lastNameError");
              if (lastName.value.trim() === "") {
                lastName.classList.add("is-invalid");
                lastNameError.style.display = "block";
                isValid = false;
              } else {
                lastName.classList.remove("is-invalid");
                lastNameError.style.display = "none";
              }

              // Validate Phone Number
              const phonePattern = /^0[0-9]{9}$/;
              if (!phonePattern.test(phoneInput.value)) {
                phoneInput.classList.add("is-invalid");
                phoneError.style.display = "block";
                isValid = false;
              }

              // Validate Password Match (if password is entered)
              if (password.value.length > 0) {
                if (password.value.length < 6) {
                  password.classList.add("is-invalid");
                  document.getElementById("passwordError").style.display = "block";
                  isValid = false;
                }

                if (!checkPasswordMatch()) {
                  isValid = false;
                }
              }

              if (isValid) {
                document.getElementById("loading").style.display = "flex";
              }

              return isValid;
            }

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
          </script>
        </body>

        </html>