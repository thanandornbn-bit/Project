<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.util.*" %>
    <%@ page import="com.springmvc.model.*" %>
      <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="th">

        <head>
          <meta charset="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <title>ThanaChok Place - สมัครสมาชิก</title>
          <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
          <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
            rel="stylesheet" />
          <style>
            * {
              margin: 0;
              padding: 0;
              box-sizing: border-box;
            }

            body {
              font-family: "Sarabun", sans-serif;
              background: linear-gradient(135deg,
                  #e3f2fd 0%,
                  #ffffff 50%,
                  #e8f4fd 100%);
              min-height: 100vh;
              display: flex;
              align-items: center;
              justify-content: center;
              position: relative;
              overflow-x: hidden;
              padding: 20px 0;
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
              background: linear-gradient(135deg,
                  rgba(74, 144, 226, 0.1),
                  rgba(92, 169, 233, 0.05));
              border-radius: 50%;
              animation: float 8s ease-in-out infinite;
              box-shadow: 0 8px 32px rgba(74, 144, 226, 0.1);
            }

            .floating-shapes:nth-child(1) {
              top: 10%;
              left: 10%;
              animation-delay: 0s;
              transform: scale(0.8);
            }

            .floating-shapes:nth-child(2) {
              top: 20%;
              right: 10%;
              animation-delay: 2s;
              transform: scale(1.2);
            }

            .floating-shapes:nth-child(3) {
              bottom: 10%;
              left: 20%;
              animation-delay: 4s;
              transform: scale(0.9);
            }

            .floating-shapes:nth-child(4) {
              bottom: 20%;
              right: 20%;
              animation-delay: 1s;
              transform: scale(1.1);
            }

            .floating-shapes:nth-child(5) {
              top: 50%;
              left: 5%;
              animation-delay: 3s;
              transform: scale(0.7);
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

            .register-container {
              background: rgba(255, 255, 255, 0.95);
              backdrop-filter: blur(20px);
              border-radius: 24px;
              box-shadow: 0 20px 60px rgba(74, 144, 226, 0.15),
                0 0 0 1px rgba(74, 144, 226, 0.1);
              border: 1px solid rgba(74, 144, 226, 0.2);
              overflow: hidden;
              width: 100%;
              max-width: 550px;
              position: relative;
              z-index: 1;
              transform: translateY(20px);
              opacity: 0;
              animation: slideUp 0.8s ease-out forwards;
            }

            @keyframes slideUp {
              to {
                transform: translateY(0);
                opacity: 1;
              }
            }

            .register-header {
              background: linear-gradient(135deg, #4a90e2, #5ca9e9);
              color: white;
              text-align: center;
              padding: 45px 30px;
              position: relative;
              box-shadow: 0 4px 20px rgba(74, 144, 226, 0.2);
            }

            .register-header::before {
              content: "";
              position: absolute;
              top: 0;
              left: -100%;
              width: 100%;
              height: 3px;
              background: linear-gradient(90deg,
                  transparent,
                  rgba(255, 255, 255, 0.6),
                  transparent);
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

            .app-logo {
              font-size: 2.5rem;
              font-weight: 700;
              margin-bottom: 12px;
              text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
              letter-spacing: -0.5px;
            }

            @keyframes glow {

              0%,
              100% {
                text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
              }

              50% {
                text-shadow: 0 4px 20px rgba(255, 255, 255, 0.3);
              }
            }

            .app-subtitle {
              font-size: 1.15rem;
              opacity: 0.95;
              margin-bottom: 8px;
              font-weight: 400;
            }

            .register-title {
              font-size: 1.4rem;
              font-weight: 600;
              opacity: 1;
            }

            .form-container {
              padding: 40px;
            }

            .back-link {
              display: inline-flex;
              align-items: center;
              gap: 10px;
              background: rgba(74, 144, 226, 0.08);
              border: 1px solid rgba(74, 144, 226, 0.2);
              color: #4a90e2;
              text-decoration: none;
              font-weight: 500;
              margin-bottom: 28px;
              transition: all 0.3s ease;
              padding: 12px 18px;
              border-radius: 12px;
              font-size: 1rem;
            }

            .back-link:hover {
              background: rgba(74, 144, 226, 0.15);
              transform: translateX(-5px);
              text-decoration: none;
              box-shadow: 0 4px 12px rgba(74, 144, 226, 0.15);
            }

            .form-grid {
              display: grid;
              gap: 20px;
            }

            .form-row {
              display: grid;
              grid-template-columns: 1fr 1fr;
              gap: 15px;
            }

            .form-group {
              position: relative;
            }

            .form-group.full-width {
              grid-column: 1 / -1;
            }

            .form-group label {
              display: block;
              margin-bottom: 10px;
              color: #2c3e50;
              font-weight: 600;
              font-size: 1rem;
            }

            .input-container {
              position: relative;
            }

            .form-group input {
              width: 100%;
              padding: 16px 20px 16px 50px;
              background: #f8fbff;
              border: 2px solid #e0e8f0;
              border-radius: 12px;
              font-size: 1rem;
              transition: all 0.3s ease;
              color: #2c3e50;
              font-family: "Sarabun", sans-serif;
            }

            .form-group input::placeholder {
              color: #a0aec0;
            }

            .form-group input:focus {
              outline: none;
              border-color: #4a90e2;
              box-shadow: 0 0 0 4px rgba(74, 144, 226, 0.1);
              background: #ffffff;
            }

            .input-icon {
              position: absolute;
              left: 18px;
              top: 50%;
              transform: translateY(-50%);
              color: #a0aec0;
              font-size: 1.1rem;
              transition: all 0.3s ease;
            }

            .form-group input:focus+.input-icon {
              color: #4a90e2;
            }

            .password-toggle {
              position: absolute;
              right: 15px;
              top: 50%;
              transform: translateY(-50%);
              background: none;
              border: none;
              color: #a0aec0;
              cursor: pointer;
              font-size: 1.1rem;
              transition: all 0.3s ease;
              padding: 8px;
              border-radius: 6px;
            }

            .password-toggle:hover {
              color: #4a90e2;
              background: rgba(74, 144, 226, 0.08);
            }

            .password-strength {
              margin-top: 8px;
              height: 4px;
              background: rgba(0, 0, 0, 0.4);
              border-radius: 2px;
              overflow: hidden;
              opacity: 0;
              transition: opacity 0.3s ease;
            }

            .password-strength.show {
              opacity: 1;
            }

            .password-strength-bar {
              height: 100%;
              width: 0%;
              transition: all 0.3s ease;
              border-radius: 2px;
            }

            .strength-weak {
              background: #ef4444;
              width: 25%;
            }

            .strength-fair {
              background: #f59e0b;
              width: 50%;
            }

            .strength-good {
              background: #4a90e2;
              width: 75%;
            }

            .strength-strong {
              background: #22c55e;
              width: 100%;
            }

            .password-hint {
              font-size: 0.85rem;
              color: #64748b;
              margin-top: 6px;
              opacity: 0;
              transition: opacity 0.3s ease;
            }

            .password-hint.show {
              opacity: 1;
            }

            .submit-btn {
              width: 100%;
              padding: 18px;
              background: linear-gradient(135deg, #4a90e2, #5ca9e9);
              color: white;
              border: none;
              border-radius: 12px;
              font-size: 1.15rem;
              font-weight: 600;
              cursor: pointer;
              transition: all 0.3s ease;
              position: relative;
              overflow: hidden;
              margin-top: 12px;
              box-shadow: 0 4px 16px rgba(74, 144, 226, 0.3);
              font-family: "Sarabun", sans-serif;
            }

            .submit-btn:hover {
              transform: translateY(-2px);
              box-shadow: 0 8px 24px rgba(74, 144, 226, 0.4);
            }

            .submit-btn:active {
              transform: translateY(0);
            }

            .submit-btn:disabled {
              opacity: 0.7;
              cursor: not-allowed;
              transform: none;
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
                  rgba(255, 255, 255, 0.3),
                  transparent);
              transition: left 0.5s;
            }

            .submit-btn:hover:before {
              left: 100%;
            }

            .loading {
              display: none;
              position: absolute;
              top: 50%;
              left: 50%;
              transform: translate(-50%, -50%);
            }

            .spinner {
              width: 25px;
              height: 25px;
              border: 3px solid rgba(255, 255, 255, 0.3);
              border-top: 3px solid white;
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

            .error-message {
              background: linear-gradient(135deg, #fee2e2, #fecaca);
              color: #dc2626;
              padding: 16px 20px;
              border-radius: 12px;
              margin-bottom: 24px;
              font-weight: 500;
              animation: slideIn 0.5s ease-out;
              display: flex;
              align-items: center;
              gap: 12px;
              border: 1px solid #fca5a5;
              box-shadow: 0 2px 8px rgba(220, 38, 38, 0.1);
            }

            .error-message:empty {
              display: none;
            }

            @keyframes slideIn {
              from {
                opacity: 0;
                transform: translateY(-10px);
              }

              to {
                opacity: 1;
                transform: translateY(0);
              }
            }

            .form-footer {
              text-align: center;
              margin-top: 28px;
              padding-top: 24px;
              border-top: 1px solid #e0e8f0;
            }

            .login-text {
              color: #64748b;
              font-size: 1rem;
              margin-bottom: 14px;
            }

            .login-link {
              display: inline-flex;
              align-items: center;
              gap: 10px;
              color: #4a90e2;
              text-decoration: none;
              font-weight: 600;
              padding: 12px 24px;
              border-radius: 12px;
              background: rgba(74, 144, 226, 0.08);
              border: 1px solid rgba(74, 144, 226, 0.2);
              transition: all 0.3s ease;
            }

            .login-link:hover {
              background: rgba(74, 144, 226, 0.15);
              transform: translateY(-2px);
              text-decoration: none;
              box-shadow: 0 4px 12px rgba(74, 144, 226, 0.15);
            }

            .form-group input.valid {
              border-color: #22c55e;
              background: #f0fdf4;
            }

            .form-group input.invalid {
              border-color: #ef4444;
              background: #fef2f2;
            }

            .validation-icon {
              position: absolute;
              right: 50px;
              top: 50%;
              transform: translateY(-50%);
              font-size: 1.1rem;
              opacity: 0;
              transition: all 0.3s ease;
            }

            .validation-icon.show {
              opacity: 1;
            }

            .validation-icon.valid {
              color: #22c55e;
            }

            .validation-icon.invalid {
              color: #ef4444;
            }

            @media (max-width: 600px) {
              .register-container {
                margin: 10px;
                max-width: none;
              }

              .form-container {
                padding: 30px 25px;
              }

              .form-row {
                grid-template-columns: 1fr;
                gap: 20px;
              }

              .register-header {
                padding: 30px 20px;
              }

              .app-logo {
                font-size: 1.8rem;
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
              width: 5px;
              height: 5px;
              background: rgba(74, 144, 226, 0.4);
              border-radius: 50%;
              animation: particleFloat 10s linear infinite;
              box-shadow: 0 0 12px rgba(74, 144, 226, 0.3);
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
          </style>
        </head>

        <body>
          <!-- Animated Background -->
          <div class="bg-animation">
            <div class="floating-shapes"></div>
            <div class="floating-shapes"></div>
            <div class="floating-shapes"></div>
            <div class="floating-shapes"></div>
            <div class="floating-shapes"></div>
            <div class="particles" id="particles"></div>
          </div>

          <div class="register-container">
            <!-- Header -->
            <div class="register-header">
              <div class="app-logo">
                <i class="fas fa-building"></i>
                ThanaChok Place
              </div>
              <div class="app-subtitle">ระบบจัดการหอพัก</div>
              <div class="register-title">สมัครสมาชิกใหม่</div>
            </div>

            <!-- Form Container -->
            <div class="form-container">
              <a href="Login" class="back-link">
                <i class="fas fa-arrow-left"></i>
                กลับไปหน้าเข้าสู่ระบบ
              </a>

              <!-- Error Message -->
              <div class="error-message" id="errorMessage">
                <c:if test="${not empty add_result}">
                  <i class="fas fa-exclamation-circle"></i>
                  ${add_result}
                </c:if>
              </div>

              <!-- Registration Form -->
              <form name="formregister" action="Register" method="post" id="registerForm">
                <div class="form-grid">
                  <!-- Name Row -->
                  <div class="form-row">
                    <div class="form-group">
                      <label for="firstName">ชื่อ</label>
                      <div class="input-container">
                        <input type="text" id="firstName" name="firstName" required placeholder="กรุณากรอกชื่อ" />
                        <i class="fas fa-user input-icon"></i>
                        <i class="fas fa-check validation-icon valid" id="firstNameValid"></i>
                        <i class="fas fa-times validation-icon invalid" id="firstNameInvalid"></i>
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="lastName">นามสกุล</label>
                      <div class="input-container">
                        <input type="text" id="lastName" name="lastName" required placeholder="กรุณากรอกนามสกุล" />
                        <i class="fas fa-user input-icon"></i>
                        <i class="fas fa-check validation-icon valid" id="lastNameValid"></i>
                        <i class="fas fa-times validation-icon invalid" id="lastNameInvalid"></i>
                      </div>
                    </div>
                  </div>

                  <!-- Email -->
                  <div class="form-group full-width">
                    <label for="email">อีเมล</label>
                    <div class="input-container">
                      <input type="email" id="email" name="email" required placeholder="example@gmail.com" />
                      <i class="fas fa-envelope input-icon"></i>
                      <i class="fas fa-check validation-icon valid" id="emailValid"></i>
                      <i class="fas fa-times validation-icon invalid" id="emailInvalid"></i>
                    </div>
                  </div>

                  <!-- Phone Number -->
                  <div class="form-group full-width">
                    <label for="phoneNumber">หมายเลขโทรศัพท์</label>
                    <div class="input-container">
                      <input type="tel" id="phoneNumber" name="phoneNumber" required pattern="^0[0-9]{9}$"
                        maxlength="10" placeholder="0xxxxxxxxx" />
                      <i class="fas fa-phone input-icon"></i>
                      <i class="fas fa-check validation-icon valid" id="phoneValid"></i>
                      <i class="fas fa-times validation-icon invalid" id="phoneInvalid"></i>
                    </div>
                  </div>

                  <!-- Password -->
                  <div class="form-group full-width">
                    <label for="password">รหัสผ่าน</label>
                    <div class="input-container">
                      <input type="password" id="password" name="password" required placeholder="กรุณากรอกรหัสผ่าน" />
                      <i class="fas fa-lock input-icon"></i>
                      <button type="button" class="password-toggle" onclick="togglePassword('password', 'toggleIcon1')">
                        <i class="fas fa-eye" id="toggleIcon1"></i>
                      </button>
                      <i class="fas fa-check validation-icon valid" id="passwordValid"></i>
                      <i class="fas fa-times validation-icon invalid" id="passwordInvalid"></i>
                    </div>
                    <div class="password-strength" id="passwordStrength">
                      <div class="password-strength-bar" id="strengthBar"></div>
                    </div>
                    <div class="password-hint" id="passwordHint">
                      รหัสผ่านควรมีอย่างน้อย 6 ตัวอักษร
                    </div>
                  </div>

                  <!-- Confirm Password -->
                  <div class="form-group full-width">
                    <label for="confirmPassword">ยืนยันรหัสผ่าน</label>
                    <div class="input-container">
                      <input type="password" id="confirmPassword" name="confirmPassword" required
                        placeholder="กรุณายืนยันรหัสผ่าน" />
                      <i class="fas fa-lock input-icon"></i>
                      <button type="button" class="password-toggle"
                        onclick="togglePassword('confirmPassword', 'toggleIcon2')">
                        <i class="fas fa-eye" id="toggleIcon2"></i>
                      </button>
                      <i class="fas fa-check validation-icon valid" id="confirmValid"></i>
                      <i class="fas fa-times validation-icon invalid" id="confirmInvalid"></i>
                    </div>
                  </div>
                </div>

                <button type="submit" class="submit-btn" id="submitBtn">
                  <span id="btnText">สมัครสมาชิก</span>
                  <div class="loading" id="loading">
                    <div class="spinner"></div>
                  </div>
                </button>
              </form>

              <div class="form-footer">
                <p class="login-text">มีบัญชีผู้ใช้แล้ว?</p>
                <a href="Login" class="login-link">
                  <i class="fas fa-sign-in-alt"></i>
                  เข้าสู่ระบบ
                </a>
              </div>
            </div>
          </div>

          <script>
            // Toggle password visibility
            function togglePassword(inputId, iconId) {
              const passwordInput = document.getElementById(inputId);
              const toggleIcon = document.getElementById(iconId);

              if (passwordInput.type === "password") {
                passwordInput.type = "text";
                toggleIcon.className = "fas fa-eye-slash";
              } else {
                passwordInput.type = "password";
                toggleIcon.className = "fas fa-eye";
              }
            }

            // Password strength checker
            function checkPasswordStrength(password) {
              const strengthBar = document.getElementById("strengthBar");
              const strengthIndicator = document.getElementById("passwordStrength");

              if (password.length === 0) {
                strengthIndicator.classList.remove("show");
                return;
              }

              strengthIndicator.classList.add("show");

              let strength = 0;
              if (password.length >= 6) strength++;
              if (/[a-z]/.test(password)) strength++;
              if (/[A-Z]/.test(password)) strength++;
              if (/[0-9]/.test(password)) strength++;
              if (/[^A-Za-z0-9]/.test(password)) strength++;

              strengthBar.className = "password-strength-bar";

              if (strength <= 2) {
                strengthBar.classList.add("strength-weak");
              } else if (strength === 3) {
                strengthBar.classList.add("strength-fair");
              } else if (strength === 4) {
                strengthBar.classList.add("strength-good");
              } else {
                strengthBar.classList.add("strength-strong");
              }

              return strength;
            }

            // Form validation
            function validateField(field, validationFunc) {
              const value = field.value.trim();
              const isValid = validationFunc(value);
              const validIcon = document.getElementById(field.id + "Valid");
              const invalidIcon = document.getElementById(field.id + "Invalid");

              if (value === "") {
                field.classList.remove("valid", "invalid");
                validIcon.classList.remove("show");
                invalidIcon.classList.remove("show");
                return null;
              }

              if (isValid) {
                field.classList.add("valid");
                field.classList.remove("invalid");
                validIcon.classList.add("show");
                invalidIcon.classList.remove("show");
              } else {
                field.classList.add("invalid");
                field.classList.remove("valid");
                invalidIcon.classList.add("show");
                validIcon.classList.remove("show");
              }

              return isValid;
            }

            // Validation functions
            const validators = {
              firstName: (value) => value.length >= 2,
              lastName: (value) => value.length >= 2,
              email: (value) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value),
              phoneNumber: (value) => /^0[0-9]{9}$/.test(value),
              password: (value) => value.length >= 6,
              confirmPassword: (value) =>
                value === document.getElementById("password").value,
            };

            // Add event listeners
            document.addEventListener("DOMContentLoaded", function () {
              // Field validation
              Object.keys(validators).forEach((fieldId) => {
                const field = document.getElementById(fieldId);
                if (field) {
                  field.addEventListener("input", function () {
                    validateField(this, validators[fieldId]);

                    if (fieldId === "password") {
                      checkPasswordStrength(this.value);
                      // Revalidate confirm password when password changes
                      const confirmField = document.getElementById("confirmPassword");
                      if (confirmField.value) {
                        validateField(confirmField, validators.confirmPassword);
                      }
                    }
                  });

                  field.addEventListener("focus", function () {
                    if (fieldId === "password") {
                      document.getElementById("passwordHint").classList.add("show");
                    }
                  });

                  field.addEventListener("blur", function () {
                    if (fieldId === "password") {
                      document
                        .getElementById("passwordHint")
                        .classList.remove("show");
                    }
                  });
                }
              });

              // Form submission
              document
                .getElementById("registerForm")
                .addEventListener("submit", function (e) {
                  const btnText = document.getElementById("btnText");
                  const loading = document.getElementById("loading");
                  const submitBtn = document.getElementById("submitBtn");

                  btnText.style.opacity = "0";
                  loading.style.display = "block";
                  submitBtn.disabled = true;
                });
            });

            // Create particles
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

            // Initialize
            window.addEventListener("load", function () {
              createParticles();

              // Page load animation
              document.body.style.opacity = "0";
              document.body.style.transition = "opacity 0.5s ease-in-out";

              setTimeout(function () {
                document.body.style.opacity = "1";
              }, 100);
            });

            // Input animations
            document
              .querySelectorAll(
                'input[type="email"], input[type="password"], input[type="text"], input[type="tel"]'
              )
              .forEach((input) => {
                input.addEventListener("focus", function () {
                  this.parentElement.parentElement.style.transform =
                    "translateY(-2px)";
                });

                input.addEventListener("blur", function () {
                  this.parentElement.parentElement.style.transform = "translateY(0)";
                });
              });
          </script>
        </body>

        </html>