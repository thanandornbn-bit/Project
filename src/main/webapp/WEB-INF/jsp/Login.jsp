<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.util.*" %>
    <%@ page import="com.springmvc.model.*" %>
      <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="th">

        <head>
          <meta charset="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <title>ThanaChok Place - เข้าสู่ระบบ</title>
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
              font-family: "Sarabun", "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
              background: linear-gradient(135deg,
                  #e3f2fd 0%,
                  #ffffff 50%,
                  #f0f8ff 100%);
              min-height: 100vh;
              display: flex;
              align-items: center;
              justify-content: center;
              position: relative;
              overflow: hidden;
            }

            .bg-animation {
              position: absolute;
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
              background: rgba(74, 144, 226, 0.1);
              border-radius: 50%;
              animation: float 6s ease-in-out infinite;
              box-shadow: 0 0 30px rgba(74, 144, 226, 0.2);
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

            @keyframes float {

              0%,
              100% {
                transform: translateY(0px) rotate(0deg);
              }

              50% {
                transform: translateY(-20px) rotate(180deg);
              }
            }

            .login-container {
              background: rgba(255, 255, 255, 0.95);
              backdrop-filter: blur(20px);
              border-radius: 25px;
              box-shadow: 0 20px 60px rgba(74, 144, 226, 0.15),
                0 0 0 1px rgba(74, 144, 226, 0.1);
              border: 1px solid rgba(74, 144, 226, 0.2);
              overflow: hidden;
              width: 100%;
              max-width: 480px;
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

            .login-header {
              background: linear-gradient(135deg, #4a90e2, #64b5f6);
              color: white;
              text-align: center;
              padding: 40px 20px;
              position: relative;
            }

            .login-header::before {
              content: "";
              position: absolute;
              top: 0;
              left: -100%;
              width: 100%;
              height: 2px;
              background: linear-gradient(90deg,
                  transparent,
                  rgba(255, 255, 255, 0.5),
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
              font-weight: bold;
              margin-bottom: 10px;
              text-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
              animation: glow 2s ease-in-out infinite;
            }

            @keyframes glow {

              0%,
              100% {
                text-shadow: 0 0 20px rgba(0, 0, 0, 0.3),
                  0 0 30px rgba(255, 255, 255, 0.2);
              }

              50% {
                text-shadow: 0 0 30px rgba(0, 0, 0, 0.5),
                  0 0 40px rgba(255, 255, 255, 0.3);
              }
            }

            .app-subtitle {
              font-size: 1rem;
              opacity: 0.9;
            }

            .role-selection {
              padding: 40px;
              text-align: center;
              transition: all 0.5s ease;
            }

            .role-selection.hidden {
              opacity: 0;
              transform: translateX(-100%);
              pointer-events: none;
              position: absolute;
              width: 100%;
            }

            .role-title {
              font-size: 1.5rem;
              color: #2c3e50;
              margin-bottom: 30px;
              font-weight: 600;
            }

            .role-buttons {
              display: flex;
              gap: 20px;
              justify-content: center;
            }

            .role-btn {
              flex: 1;
              padding: 20px;
              border: 2px solid rgba(74, 144, 226, 0.3);
              border-radius: 15px;
              font-size: 1.1rem;
              font-weight: 600;
              cursor: pointer;
              transition: all 0.3s ease;
              position: relative;
              overflow: hidden;
              text-transform: uppercase;
              letter-spacing: 1px;
              background: #ffffff;
              color: #2c3e50;
            }

            .role-btn.member {
              border-color: #4a90e2;
            }

            .role-btn.member:hover {
              background: linear-gradient(135deg, #4a90e2, #64b5f6);
              color: white;
              border-color: #4a90e2;
            }

            .role-btn.manager {
              border-color: #5c6bc0;
            }

            .role-btn.manager:hover {
              background: linear-gradient(135deg, #5c6bc0, #7986cb);
              color: white;
              border-color: #5c6bc0;
            }

            .role-btn:hover {
              transform: translateY(-3px);
              box-shadow: 0 10px 25px rgba(74, 144, 226, 0.3);
            }

            .role-btn:before {
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

            .role-btn:hover:before {
              left: 100%;
            }

            .login-form-container {
              padding: 40px;
              opacity: 0;
              transform: translateX(100%);
              transition: all 0.5s ease;
              position: absolute;
              width: 100%;
              top: 0;
              background: rgba(255, 255, 255, 0.95);
              border-radius: 0 0 25px 25px;
            }

            .login-form-container.active {
              opacity: 1;
              transform: translateX(0);
              position: relative;
            }

            .form-header {
              text-align: center;
              margin-bottom: 30px;
            }

            .form-title {
              font-size: 1.8rem;
              color: #2c3e50;
              margin-bottom: 10px;
              font-weight: 600;
            }

            .back-btn {
              background: rgba(74, 144, 226, 0.1);
              border: 1px solid rgba(74, 144, 226, 0.3);
              color: #4a90e2;
              font-size: 1rem;
              cursor: pointer;
              display: flex;
              align-items: center;
              gap: 5px;
              margin-bottom: 20px;
              transition: all 0.3s ease;
              padding: 10px 15px;
              border-radius: 10px;
              font-weight: 500;
            }

            .back-btn:hover {
              background: rgba(74, 144, 226, 0.2);
              transform: translateX(-5px);
            }

            .form-group {
              margin-bottom: 25px;
              position: relative;
            }

            .form-group label {
              display: block;
              margin-bottom: 8px;
              color: #2c3e50;
              font-weight: 500;
              font-size: 0.95rem;
            }

            .input-container {
              position: relative;
            }

            .form-group input {
              width: 100%;
              padding: 15px 20px 15px 50px;
              background: #f8fafb;
              border: 2px solid rgba(74, 144, 226, 0.2);
              border-radius: 12px;
              font-size: 1rem;
              transition: all 0.3s ease;
              color: #2c3e50;
            }

            .form-group input::placeholder {
              color: #999;
            }

            .form-group input:focus {
              outline: none;
              border-color: #4a90e2;
              box-shadow: 0 0 20px rgba(74, 144, 226, 0.2);
              background: #ffffff;
            }

            .input-icon {
              position: absolute;
              left: 18px;
              top: 50%;
              transform: translateY(-50%);
              color: #999;
              font-size: 1.1rem;
              transition: all 0.3s ease;
            }

            .form-group input:focus+.input-icon {
              color: #4a90e2;
            }

            .submit-btn {
              width: 100%;
              padding: 15px;
              background: linear-gradient(135deg, #4a90e2, #64b5f6);
              color: white;
              border: none;
              border-radius: 12px;
              font-size: 1.1rem;
              font-weight: 600;
              cursor: pointer;
              transition: all 0.3s ease;
              position: relative;
              overflow: hidden;
              margin-top: 10px;
              box-shadow: 0 5px 20px rgba(74, 144, 226, 0.3);
            }

            .submit-btn:hover {
              transform: translateY(-2px);
              box-shadow: 0 10px 25px rgba(74, 144, 226, 0.4);
            }

            .submit-btn:active {
              transform: translateY(0);
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

            .message {
              padding: 12px 20px;
              border-radius: 10px;
              margin-bottom: 20px;
              font-weight: 500;
              animation: slideIn 0.5s ease-out;
              display: flex;
              align-items: center;
              gap: 10px;
            }

            .error-message {
              background: linear-gradient(135deg, #ef4444, #dc2626);
              color: white;
              border: 1px solid rgba(239, 68, 68, 0.3);
            }

            .success-message {
              background: linear-gradient(135deg, #22c55e, #16a34a);
              color: white;
              border: 1px solid rgba(34, 197, 94, 0.3);
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

            .loading {
              display: none;
              position: absolute;
              top: 50%;
              left: 50%;
              transform: translate(-50%, -50%);
            }

            .spinner {
              width: 30px;
              height: 30px;
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

            .password-toggle {
              position: absolute;
              right: 15px;
              top: 50%;
              transform: translateY(-50%);
              background: none;
              border: none;
              color: #999;
              cursor: pointer;
              font-size: 1.1rem;
              transition: all 0.3s ease;
            }

            .password-toggle:hover {
              color: #4a90e2;
            }

            .register-section {
              margin-top: 30px;
              text-align: center;
              padding-top: 25px;
              border-top: 2px solid rgba(74, 144, 226, 0.1);
            }

            .register-text {
              color: #666;
              font-size: 0.95rem;
              margin-bottom: 15px;
              font-weight: 400;
            }

            .register-btn {
              display: inline-flex;
              align-items: center;
              gap: 8px;
              padding: 12px 30px;
              background: linear-gradient(135deg, #f0f8ff, #e3f2fd);
              border: 2px solid #4a90e2;
              border-radius: 12px;
              color: #4a90e2;
              text-decoration: none;
              font-weight: 600;
              font-size: 1rem;
              transition: all 0.3s ease;
              position: relative;
              overflow: hidden;
            }

            .register-btn:hover {
              background: linear-gradient(135deg, #4a90e2, #64b5f6);
              color: white;
              transform: translateY(-2px);
              box-shadow: 0 8px 20px rgba(74, 144, 226, 0.3);
            }

            .register-btn:before {
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

            .register-btn:hover:before {
              left: 100%;
            }

            @media (max-width: 480px) {
              .login-container {
                margin: 20px;
                max-width: none;
              }

              .role-buttons {
                flex-direction: column;
              }

              .role-btn {
                padding: 18px;
              }

              .login-header {
                padding: 30px 20px;
              }

              .app-logo {
                font-size: 2rem;
              }
            }

            .particles {
              position: absolute;
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
              background: rgba(74, 144, 226, 0.5);
              border-radius: 50%;
              animation: particleFloat 8s linear infinite;
              box-shadow: 0 0 10px rgba(74, 144, 226, 0.5);
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
            <div class="particles" id="particles"></div>
          </div>

          <div class="login-container">
            <!-- Header -->
            <div class="login-header">
              <div class="app-logo">
                <i class="fas fa-building"></i>
                ThanaChok Place
              </div>
              <div class="app-subtitle">ระบบจัดการหอพัก</div>
            </div>

            <!-- Role Selection -->
            <div class="role-selection" id="roleSelection">
              <button class="back-btn" onclick="window.location.href='./'">
                <i class="fas fa-arrow-left"></i>
              </button>
              <h2 class="role-title">เลือกประเภทผู้ใช้งาน</h2>
              <div class="role-buttons">
                <button class="role-btn member" onclick="showLogin('Member')">
                  <i class="fas fa-user"></i><br />
                  สมาชิก
                </button>
                <button class="role-btn manager" onclick="showLogin('Manager')">
                  <i class="fas fa-user-tie"></i><br />
                  ผู้จัดการ
                </button>
              </div>
            </div>

            <!-- Login Form -->
            <div class="login-form-container" id="loginForm">
              <button class="back-btn" onclick="hideLogin()">
                <i class="fas fa-arrow-left"></i>
                กลับ
              </button>

              <div class="form-header">
                <h3 class="form-title" id="loginTitle">เข้าสู่ระบบ</h3>
              </div>

              <!-- Messages -->
              <c:if test="${not empty error_message}">
                <div class="message error-message">
                  <i class="fas fa-exclamation-circle"></i>
                  ${error_message}
                </div>
              </c:if>

              <c:if test="${not empty success_message}">
                <div class="message success-message">
                  <i class="fas fa-check-circle"></i>
                  ${success_message}
                </div>
              </c:if>

              <!-- Form -->
              <form action="Login" method="post" id="loginFormElement">
                <input type="hidden" id="roleInput" name="role" value="" />

                <div class="form-group">
                  <label for="email">อีเมล</label>
                  <div class="input-container">
                    <input type="email" id="email" name="email" required placeholder="กรุณากรอกอีเมล" />
                    <i class="fas fa-envelope input-icon"></i>
                  </div>
                </div>

                <div class="form-group">
                  <label for="password">รหัสผ่าน</label>
                  <div class="input-container">
                    <input type="password" id="password" name="password" required placeholder="กรุณากรอกรหัสผ่าน" />
                    <i class="fas fa-lock input-icon"></i>
                    <button type="button" class="password-toggle" onclick="togglePassword()">
                      <i class="fas fa-eye" id="toggleIcon"></i>
                    </button>
                  </div>
                </div>

                <button type="submit" class="submit-btn">
                  <span id="btnText">เข้าสู่ระบบ</span>
                  <div class="loading" id="loading">
                    <div class="spinner"></div>
                  </div>
                </button>
              </form>

              <!-- Register Link -->
              <div class="register-section">
                <p class="register-text">ยังไม่มีบัญชี?</p>
                <a href="Register" class="register-btn">
                  <i class="fas fa-user-plus"></i>
                  สมัครสมาชิก
                </a>
              </div>
            </div>
          </div>

          <script>
            // Show login form
            function showLogin(role) {
              const roleSelection = document.getElementById("roleSelection");
              const loginForm = document.getElementById("loginForm");
              const roleInput = document.getElementById("roleInput");
              const loginTitle = document.getElementById("loginTitle");

              roleSelection.classList.add("hidden");
              setTimeout(() => {
                loginForm.classList.add("active");
              }, 300);

              roleInput.value = role;
              loginTitle.innerText =
                "เข้าสู่ระบบ " + (role === "Manager" ? "ผู้จัดการ" : "สมาชิก");
            }

            // Hide login form
            function hideLogin() {
              const roleSelection = document.getElementById("roleSelection");
              const loginForm = document.getElementById("loginForm");

              loginForm.classList.remove("active");
              setTimeout(() => {
                roleSelection.classList.remove("hidden");
              }, 300);
            }

            // Toggle password visibility
            function togglePassword() {
              const passwordInput = document.getElementById("password");
              const toggleIcon = document.getElementById("toggleIcon");

              if (passwordInput.type === "password") {
                passwordInput.type = "text";
                toggleIcon.className = "fas fa-eye-slash";
              } else {
                passwordInput.type = "password";
                toggleIcon.className = "fas fa-eye";
              }
            }

            // Form submission with loading
            document
              .getElementById("loginFormElement")
              .addEventListener("submit", function () {
                const btnText = document.getElementById("btnText");
                const loading = document.getElementById("loading");
                const submitBtn = document.querySelector(".submit-btn");

                btnText.style.opacity = "0";
                loading.style.display = "block";
                submitBtn.style.pointerEvents = "none";
              });

            // Create particle effect
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

            // Initialize particles on load
            window.addEventListener("load", createParticles);

            // Input animations
            document
              .querySelectorAll('input[type="email"], input[type="password"]')
              .forEach((input) => {
                input.addEventListener("focus", function () {
                  this.parentElement.parentElement.style.transform =
                    "translateY(-2px)";
                });

                input.addEventListener("blur", function () {
                  this.parentElement.parentElement.style.transform = "translateY(0)";
                });
              });

            // Page load animation
            window.addEventListener("load", function () {
              document.body.style.opacity = "0";
              document.body.style.transition = "opacity 0.5s ease-in-out";

              setTimeout(function () {
                document.body.style.opacity = "1";
              }, 100);
            });
          </script>
        </body>

        </html>