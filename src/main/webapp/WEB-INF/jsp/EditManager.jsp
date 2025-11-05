<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page session="true" %>
<%@ page import="com.springmvc.model.Manager" %>
<%
    Manager manager = (Manager) session.getAttribute("loginManager");
    if (manager == null) {
        response.sendRedirect("Login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>แก้ไขข้อมูลผู้จัดการ - ThanaChok Place</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #FFFFFF;
            --muted-bg: #F0F7FF;
            --primary: #5CA9E9;
            --primary-dark: #4A90E2;
            --primary-light: #7BC4FF;
            --accent: #E3F2FD;
            --text: #1E3A5F;
            --text-light: #FFFFFF;
            --muted-text: #5B7A9D;
            --bg-secondary: #F8FCFF;
            --border: #D1E8FF;
            --card-border: #D1E8FF;
            --hover-bg: #E8F4FF;
            --shadow: rgba(92, 169, 233, 0.15);
            --success: #4CAF50;
            --warning: #FF9800;
            --danger: #F44336;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Sarabun', system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
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

        .logout-btn {
            background: linear-gradient(135deg, #EF4444 0%, #DC2626 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: 700;
            font-family: 'Sarabun', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .logout-btn:hover {
            box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
            transform: translateY(-2px);
        }

        .main-content {
            flex: 1;
            padding: 40px 48px;
            background: linear-gradient(135deg, var(--muted-bg) 0%, #E8F4FF 100%);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .edit-container {
            max-width: 700px;
            width: 100%;
            background: var(--bg);
            border-radius: 20px;
            box-shadow: 0 8px 32px var(--shadow);
            padding: 40px;
            border: 2px solid var(--card-border);
        }

        .page-title {
            color: var(--primary);
            text-align: center;
            margin-bottom: 35px;
            font-size: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .page-title i {
            font-size: 2.2rem;
        }

        .message-box {
            margin-bottom: 25px;
            padding: 16px 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 600;
            animation: slideDown 0.4s ease;
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

        .message-box.success {
            background: linear-gradient(135deg, #D4F4DD, #A8E6B8);
            color: #22C55E;
            border: 2px solid #22C55E;
            box-shadow: 0 4px 12px rgba(34, 197, 94, 0.2);
        }

        .message-box.error {
            background: linear-gradient(135deg, #FEE2E2, #FECACA);
            color: #DC2626;
            border: 2px solid #DC2626;
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.2);
        }

        .message-box i {
            font-size: 1.5rem;
        }

        .back-btn {
            display: inline-block;
            margin-top: 12px;
            padding: 12px 28px;
            background: linear-gradient(135deg, var(--success), #66BB6A);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 700;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
            width: 100%;
        }

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(76, 175, 80, 0.4);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            font-weight: 700;
            color: var(--text);
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 10px;
            font-size: 1.05rem;
        }

        .form-group label i {
            color: var(--primary);
            font-size: 1.1rem;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 14px 16px;
            border-radius: 10px;
            border: 2px solid var(--card-border);
            font-size: 1rem;
            font-family: 'Sarabun', sans-serif;
            transition: all 0.3s ease;
            background: var(--bg);
            color: var(--text);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(92, 169, 233, 0.1);
        }

        .form-group input::placeholder {
            color: var(--muted-text);
            opacity: 0.7;
        }

        .input-hint {
            display: block;
            margin-top: 6px;
            font-size: 0.9rem;
            color: var(--muted-text);
            font-style: italic;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border: none;
            padding: 14px 32px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 1.05rem;
            font-family: 'Sarabun', sans-serif;
            cursor: pointer;
            margin-top: 20px;
            width: 100%;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-submit:hover {
            box-shadow: 0 6px 16px rgba(74, 144, 226, 0.4);
            transform: translateY(-2px);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .loading {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.9);
            z-index: 1000;
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
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                padding: 15px 20px;
                gap: 15px;
            }

            .header h1 {
                font-size: 1.8rem;
            }

            .nav-menu {
                flex-wrap: wrap;
                gap: 10px;
                justify-content: center;
            }

            .user-section {
                flex-direction: column;
                width: 100%;
            }

            .user-info,
            .logout-btn {
                width: 100%;
                justify-content: center;
            }

            .main-content {
                padding: 20px;
            }

            .edit-container {
                padding: 25px;
            }

            .page-title {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .header h1 {
                font-size: 1.5rem;
            }

            .nav-menu {
                flex-direction: column;
                width: 100%;
            }

            .nav-link {
                width: 100%;
                text-align: center;
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .edit-container {
            animation: fadeInUp 0.6s ease;
        }
    </style>
</head>
<body>
    <div class="loading" id="loading">
        <div class="spinner"></div>
    </div>

    <div class="page-container">
        <div class="header">
            <h1>
                <i class="fas fa-building"></i>
                ThanaChok Place
            </h1>
            <div class="nav-menu">
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
                <a href="AddRoom" class="nav-link">
                    <i class="fas fa-plus"></i> เพิ่มห้อง
                </a>
            </div>
            <div class="user-section">
                <div class="user-info">
                    <i class="fas fa-user-circle"></i>
                    <span>${loginManager.email}</span>
                </div>
                <form action="Logout" method="post" style="display: inline">
                    <button type="submit" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        ออกจากระบบ
                    </button>
                </form>
            </div>
        </div>

        <div class="main-content">
            <div class="edit-container">
                <h2 class="page-title">
                    <i class="fas fa-user-edit"></i>
                    แก้ไขข้อมูลผู้จัดการ
                </h2>

                <c:if test="${not empty message}">
                    <div class="message-box success">
                        <i class="fas fa-check-circle"></i>
                        <span>${message}</span>
                    </div>
                    <a href="OwnerHome" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        กลับไปหน้าหลัก
                    </a>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="message-box error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>

                <c:if test="${empty message}">
                    <form action="EditManager" method="post" id="editForm">
                        <div class="form-group">
                            <label for="email">
                                <i class="fas fa-envelope"></i>
                                อีเมล
                            </label>
                            <input
                                type="email"
                                id="email"
                                name="email"
                                value="${manager.email}"
                                required
                                placeholder="example@email.com"
                            />
                        </div>

                        <div class="form-group">
                            <label for="password">
                                <i class="fas fa-lock"></i>
                                รหัสผ่าน
                            </label>
                            <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="กรอกรหัสผ่านใหม่ถ้าต้องการเปลี่ยน"
                            />
                            <small class="input-hint">
                                <i class="fas fa-info-circle"></i>
                                หากไม่ต้องการเปลี่ยนรหัสผ่าน ให้เว้นว่างไว้
                            </small>
                        </div>

                        <div class="form-group">
                            <label for="promptPayNumber">
                                <i class="fas fa-mobile-alt"></i>
                                หมายเลข PromptPay
                            </label>
                            <input
                                type="text"
                                id="promptPayNumber"
                                name="promptPayNumber"
                                value="${manager.promptPayNumber}"
                                placeholder="0xx-xxx-xxxx"
                                maxlength="15"
                            />
                        </div>

                        <div class="form-group">
                            <label for="accountName">
                                <i class="fas fa-user"></i>
                                ชื่อบัญชี
                            </label>
                            <input
                                type="text"
                                id="accountName"
                                name="accountName"
                                value="${manager.accountName}"
                                placeholder="ชื่อ-นามสกุล"
                            />
                        </div>

                        <button type="submit" class="btn-submit">
                            <i class="fas fa-save"></i>
                            บันทึกข้อมูล
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('editForm')?.addEventListener('submit', function() {
            document.getElementById('loading').style.display = 'flex';
        });

        const promptPayInput = document.getElementById('promptPayNumber');
        if (promptPayInput) {
            promptPayInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/[^0-9]/g, '');
                if (value.length > 10) value = value.substring(0, 10);
                
                if (value.length > 6) {
                    value = value.substring(0, 3) + '-' + value.substring(3, 6) + '-' + value.substring(6);
                } else if (value.length > 3) {
                    value = value.substring(0, 3) + '-' + value.substring(3);
                }
                
                e.target.value = value;
            });
        }

        document.getElementById('editForm')?.addEventListener('submit', function(e) {
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            
            if (!email) {
                e.preventDefault();
                alert('กรุณากรอกอีเมล');
                return false;
            }
            
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('รูปแบบอีเมลไม่ถูกต้อง');
                return false;
            }
            
            if (password && password.length < 6) {
                e.preventDefault();
                alert('รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร');
                return false;
            }
        });

        window.addEventListener('load', function() {
            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            setTimeout(function() {
                document.body.style.opacity = '1';
            }, 100);
            setTimeout(function() {
                document.getElementById('loading').style.display = 'none';
            }, 500);
        });

        document.querySelectorAll('.btn-submit, .back-btn, .logout-btn').forEach(button => {
            button.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                ripple.classList.add('ripple');
                
                this.appendChild(ripple);
                
                setTimeout(() => ripple.remove(), 600);
            });
        });
    </script>
</body>
</html>
