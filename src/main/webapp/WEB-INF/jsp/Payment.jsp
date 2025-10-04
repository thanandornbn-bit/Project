<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.springmvc.model.*"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat"%>
<%
Member loginMember = (Member) session.getAttribute("loginMember");
Room reservedRoom = (Room) request.getAttribute("room");
Date today = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy", new Locale("th", "TH"));
String todayStr = sdf.format(today);
%>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ชำระเงินมัดจำ - ThanaChok Place</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 50%, #1a1a1a 100%);
            min-height: 100vh;
            color: #fff;
            position: relative;
            overflow-x: hidden;
            padding: 20px 0;
        }

        /* Animated Background */
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

        .floating-shapes:nth-child(1) { top: 10%; left: 10%; animation-delay: 0s; }
        .floating-shapes:nth-child(2) { top: 20%; right: 10%; animation-delay: 2s; }
        .floating-shapes:nth-child(3) { bottom: 10%; left: 20%; animation-delay: 4s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* Header */
        .page-header {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            text-align: center;
            padding: 30px 20px;
            position: relative;
            z-index: 10;
            box-shadow: 0 4px 20px rgba(255, 140, 0, 0.3);
            margin-bottom: 30px;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.5), transparent);
            animation: scan 3s linear infinite;
        }

        @keyframes scan {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .page-header h1 {
            font-size: 2rem;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        /* Container */
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
            position: relative;
            z-index: 1;
        }

        /* Payment Card */
        .payment-card {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 140, 0, 0.3);
            animation: slideIn 0.6s ease-out;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Room Details */
        .room-details {
            background: rgba(0, 0, 0, 0.4);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 1px solid rgba(255, 140, 0, 0.2);
        }

        .room-details h3 {
            color: #ff8c00;
            margin-bottom: 20px;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: #999;
            font-weight: 500;
        }

        .detail-value {
            color: #fff;
            font-weight: 600;
        }

        .deposit-amount {
            color: #ff8c00;
            font-size: 1.5rem;
            font-weight: bold;
        }

        /* Warning Note */
        .warning-note {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: flex;
            align-items: flex-start;
            gap: 15px;
            border: 1px solid rgba(255, 68, 68, 0.5);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { box-shadow: 0 4px 15px rgba(255, 68, 68, 0.3); }
            50% { box-shadow: 0 6px 20px rgba(255, 68, 68, 0.5); }
        }

        .warning-note i {
            font-size: 1.5rem;
            margin-top: 2px;
        }

        /* QR Code Section */
        .qr-section {
            background: rgba(0, 0, 0, 0.4);
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 25px;
            border: 1px solid rgba(255, 140, 0, 0.2);
        }

        .qr-section h3 {
            color: #ff8c00;
            margin-bottom: 20px;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .qr-code-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            display: inline-block;
            margin: 20px 0;
            box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
        }

        .qr-code-container img {
            width: 250px;
            height: 250px;
            display: block;
        }

        .qr-info {
            color: #ccc;
            margin-top: 15px;
            line-height: 1.6;
        }

        .qr-info strong {
            color: #ff8c00;
        }

        /* Form Section */
        .form-section {
            margin-top: 30px;
        }

        .form-section h3 {
            color: #ff8c00;
            margin-bottom: 20px;
            font-size: 1.3rem;
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
            color: #ff8c00;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .form-group input[type="text"],
        .form-group input[type="file"] {
            width: 100%;
            padding: 15px 20px;
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 12px;
            font-size: 1rem;
            color: #fff;
            transition: all 0.3s ease;
        }

        .form-group input[type="text"]:focus {
            outline: none;
            border-color: #ff8c00;
            box-shadow: 0 0 20px rgba(255, 140, 0, 0.3);
            background: rgba(0, 0, 0, 0.6);
        }

        .form-group input[type="file"] {
            padding: 15px;
            cursor: pointer;
        }

        .form-group input[type="file"]::file-selector-button {
            padding: 10px 20px;
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            margin-right: 15px;
            transition: all 0.3s ease;
        }

        .form-group input[type="file"]::file-selector-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(255, 140, 0, 0.4);
        }

        .form-group input[readonly] {
            background: rgba(0, 0, 0, 0.6);
            cursor: not-allowed;
            color: #999;
        }

        /* Buttons */
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 18px;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-submit {
            background: linear-gradient(135deg, #00ff88, #00cc6f);
            color: #000;
            box-shadow: 0 5px 20px rgba(0, 255, 136, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 255, 136, 0.5);
        }

        .btn-cancel {
            background: rgba(255, 68, 68, 0.2);
            color: #ff4444;
            border: 2px solid #ff4444;
        }

        .btn-cancel:hover {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            transform: translateY(-2px);
        }

        /* Info Box */
        .info-box {
            background: rgba(66, 165, 245, 0.1);
            border-left: 4px solid #42a5f5;
            padding: 15px 20px;
            border-radius: 8px;
            margin-top: 20px;
            color: #ccc;
            font-size: 0.9rem;
            line-height: 1.6;
        }

        .info-box i {
            color: #42a5f5;
            margin-right: 10px;
        }

        /* Particles */
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
            0% { opacity: 0; transform: translateY(100vh) scale(0); }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { opacity: 0; transform: translateY(-100vh) scale(1); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 1.5rem;
            }

            .payment-card {
                padding: 25px 20px;
            }

            .qr-code-container img {
                width: 200px;
                height: 200px;
            }

            .button-group {
                flex-direction: column;
            }

            .room-details,
            .qr-section,
            .warning-note {
                padding: 20px;
            }
        }
    </style>
    <script>
        function calculateDeadline() {
            var paymentDate = document.getElementsByName("paymentDate")[0].value;
            var paymentDateParts = paymentDate.split("/");
            var paymentDateObj = new Date(paymentDateParts[2], paymentDateParts[1] - 1, paymentDateParts[0]);

            paymentDateObj.setDate(paymentDateObj.getDate() + 7);

            var deadline = paymentDateObj.getDate();
            var deadlineMonth = paymentDateObj.getMonth() + 1;
            var deadlineYear = paymentDateObj.getFullYear();
            
            if (deadline < 10) deadline = "0" + deadline;
            if (deadlineMonth < 10) deadlineMonth = "0" + deadlineMonth;

            var formattedDeadline = deadline + "/" + deadlineMonth + "/" + deadlineYear;
            document.getElementsByName("deadline")[0].value = formattedDeadline;
            document.getElementsByName("calculatedDeadline")[0].value = formattedDeadline;
        }

        function validateForm() {
            const accountName = document.getElementsByName("transferAccountName")[0].value;
            const fileInput = document.getElementsByName("paymentSlip")[0];
            
            if (!accountName.trim()) {
                alert('กรุณากรอกชื่อบัญชีที่โอน');
                return false;
            }
            
            if (!fileInput.files.length) {
                alert('กรุณาอัปโหลดสลิปโอนเงิน');
                return false;
            }
            
            const file = fileInput.files[0];
            const validTypes = ['image/jpeg', 'image/jpg', 'image/png'];
            
            if (!validTypes.includes(file.type)) {
                alert('กรุณาอัปโหลดไฟล์รูปภาพเท่านั้น (JPG, JPEG, PNG)');
                return false;
            }
            
            if (file.size > 5 * 1024 * 1024) {
                alert('ขนาดไฟล์ต้องไม่เกิน 5 MB');
                return false;
            }
            
            return confirm('คุณต้องการยืนยันการชำระเงินใช่หรือไม่?');
        }

        function cancelPayment() {
            if (confirm('คุณต้องการยกเลิกการชำระเงินใช่หรือไม่?')) {
                window.history.back();
            }
        }

        function createParticles() {
            const particles = document.getElementById('particles');
            const particleCount = 50;

            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.animationDelay = Math.random() * 8 + 's';
                particle.style.animationDuration = (Math.random() * 3 + 5) + 's';
                particles.appendChild(particle);
            }
        }

        document.addEventListener("DOMContentLoaded", function() {
            calculateDeadline();
            createParticles();
            
            document.getElementsByName("paymentDate")[0].addEventListener("change", calculateDeadline);
            
            // Page load animation
            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            
            setTimeout(function() {
                document.body.style.opacity = '1';
            }, 100);
        });
    </script>
</head>
<body>
    <!-- Animated Background -->
    <div class="bg-animation">
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
        <div class="particles" id="particles"></div>
    </div>

    <!-- Header -->
    <div class="page-header">
        <h1>
            <i class="fas fa-credit-card"></i>
            ชำระเงินมัดจำห้องพัก
        </h1>
    </div>

    <!-- Container -->
    <div class="container">
        <form action="confirmPayment" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
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
                            <i class="fas fa-coins"></i> 500 บาท
                        </span>
                    </div>
                </div>

                <!-- Warning Note -->
                <div class="warning-note">
                    <i class="fas fa-exclamation-triangle"></i>
                    <div>
                        <strong>หมายเหตุสำคัญ:</strong><br>
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
                        <img src="https://promptpay.io/0635803516/1.png" alt="QR Code PromptPay" />
                    </div>
                    <div class="qr-info">
                        <p><strong>หมายเลข PromptPay:</strong> 063-580-3516</p>
                        <p><strong>ชื่อบัญชี:</strong> ThanaChok Place</p>
                        <p><strong>จำนวนเงิน:</strong> 500 บาท</p>
                    </div>
                </div>

                <!-- Form Section -->
                <div class="form-section">
                    <h3>
                        <i class="fas fa-file-upload"></i>
                        กรอกข้อมูลการชำระเงิน
                    </h3>

                    <input type="hidden" name="roomID" value="${room.roomID}" />
                    <input type="hidden" name="depositAmount" value="500" />
                    <input type="hidden" name="price" value="500" />
                    <input type="hidden" name="deadline" />

                    <div class="form-group">
                        <label>
                            <i class="fas fa-user"></i> ชื่อบัญชีที่โอน:
                        </label>
                        <input type="text" name="transferAccountName" 
                               placeholder="กรอกชื่อบัญชีที่ใช้โอนเงิน" required />
                    </div>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-calendar-day"></i> วันที่ชำระ:
                        </label>
                        <input type="text" name="paymentDate" value="<%=todayStr%>" readonly />
                    </div>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-calendar-check"></i> วันที่ต้องมาติดต่อ (ภายใน 7 วัน):
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
                        <strong>คำแนะนำ:</strong> กรุณาตรวจสอบข้อมูลให้ถูกต้องก่อนยืนยันการชำระเงิน 
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