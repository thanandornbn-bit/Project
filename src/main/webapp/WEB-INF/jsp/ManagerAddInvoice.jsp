<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ page session="true"%>
<%@ page import="com.springmvc.model.Manager"%>

<%
Manager loginManager = (Manager) session.getAttribute("loginManager");
if (loginManager == null) {
    response.sendRedirect("Login");
    return;
}
%>

<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>เพิ่มบิลใหม่ - ThanaChok Place</title>
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

        .floating-shapes:nth-child(1) { top: 10%; left: 10%; animation-delay: 0s; }
        .floating-shapes:nth-child(2) { top: 20%; right: 10%; animation-delay: 2s; }
        .floating-shapes:nth-child(3) { bottom: 10%; left: 20%; animation-delay: 4s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
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
            0% { opacity: 0; transform: translateY(100vh) scale(0); }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { opacity: 0; transform: translateY(-100vh) scale(1); }
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
            0%, 100% { text-shadow: 0 0 20px rgba(255, 140, 0, 0.3); }
            50% { text-shadow: 0 0 30px rgba(255, 140, 0, 0.5), 0 0 40px rgba(255, 255, 255, 0.3); }
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
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
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
            background: linear-gradient(135deg, rgba(255, 140, 0, 0.2), rgba(255, 107, 0, 0.2));
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
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
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
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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

        .toast.success { border-left: 4px solid #00ff88; }
        .toast.error { border-left: 4px solid #ff4444; }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
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
            .container { padding: 15px; }
            .header { font-size: 2rem; }
            .card-body { padding: 25px 20px; }
            .form-grid, .utility-section { grid-template-columns: 1fr; }
            .room-info-grid { grid-template-columns: 1fr; }
            .btn-group { flex-direction: column; align-items: center; }
            .btn { width: 100%; max-width: 300px; }
            .total-amount { font-size: 2rem; }
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
                                    <span>฿<fmt:formatNumber value="${room.roomPrice}" groupingUsed="true"/>/เดือน</span>
                                </div>
                                <div class="room-info-item">
                                    <strong><i class="fas fa-info-circle"></i> สถานะห้อง</strong>
                                    <span>${room.roomStatus}</span>
                                </div>
                            </div>
                        </div>

                        <form action="SaveInvoice" method="post" id="invoiceForm">
                            <input type="hidden" name="rentId" value="${rent.rentID}" />
                            <input type="hidden" id="roomPrice" name="roomPrice" value="${room.roomPrice}" />

                            <!-- Date Section -->
                            <div class="form-section">
                                <div class="section-title">
                                    <i class="fas fa-calendar-alt"></i>
                                    ข้อมูลวันที่
                                </div>
                                <div class="form-grid">
                                    <div class="form-group">
                                        <label for="issueDate">วันที่ออกบิล:</label>
                                        <input type="date" name="issueDate" id="issueDate" class="form-control" value="${today}" readonly/>
                                    </div>
                                    <div class="form-group">
                                        <label for="dueDate">วันครบกำหนด:</label>
                                        <input type="date" name="dueDate" id="dueDate" class="form-control" value="${dueDate}" readonly/>
                                    </div>
                                </div>
                            </div>

                            <!-- Utilities Section -->
                            <div class="form-section">
                                <div class="section-title">
                                    <i class="fas fa-tools"></i>
                                    ค่าสาธารณูปโภค
                                </div>
                                <div class="utility-section">
                                    <!-- Internet -->
                                    <div class="utility-card">
                                        <div class="utility-title">
                                            <i class="fas fa-wifi"></i>
                                            ค่าอินเทอร์เน็ต
                                        </div>
                                        <div class="form-group">
                                            <input type="number" id="internetPrice" name="internetPrice" 
                                                   class="form-control" value="200" min="0"/>
                                        </div>
                                    </div>

                                    <!-- Water -->
                                    <div class="utility-card">
                                        <div class="utility-title">
                                            <i class="fas fa-tint"></i>
                                            ค่าน้ำ
                                        </div>
                                        <div class="form-group">
                                            <label>หน่วยปัจจุบัน:</label>
                                            <input type="number" id="currWater" name="currWater" 
                                                   class="form-control" value="0" min="0"/>
                                        </div>
                                        <div class="form-group">
                                            <label>หน่วยเดือนก่อน:</label>
                                            <input type="number" id="prevWater" name="prevWater" 
                                                   class="form-control" value="0" min="0"/>
                                        </div>
                                        <div class="form-group">
                                            <label>ราคาต่อหน่วย:</label>
                                            <input type="number" id="waterRate" name="waterRate" 
                                                   class="form-control" value="20" step="0.01" min="0"/>
                                        </div>
                                        <div class="calculation-display">
                                            <div>รวมค่าน้ำ</div>
                                            <div class="amount" id="waterTotalDisplay">฿0.00</div>
                                        </div>
                                    </div>

                                    <!-- Electricity -->
                                    <div class="utility-card">
                                        <div class="utility-title">
                                            <i class="fas fa-bolt"></i>
                                            ค่าไฟฟ้า
                                        </div>
                                        <div class="form-group">
                                            <label>หน่วยปัจจุบัน:</label>
                                            <input type="number" id="currElectric" name="currElectric" 
                                                   class="form-control" value="0" min="0"/>
                                        </div>
                                        <div class="form-group">
                                            <label>หน่วยเดือนก่อน:</label>
                                            <input type="number" id="prevElectric" name="prevElectric" 
                                                   class="form-control" value="0" min="0"/>
                                        </div>
                                        <div class="form-group">
                                            <label>ราคาต่อหน่วย:</label>
                                            <input type="number" id="electricRate" name="electricRate" 
                                                   class="form-control" value="7" step="0.01" min="0"/>
                                        </div>
                                        <div class="calculation-display">
                                            <div>รวมค่าไฟฟ้า</div>
                                            <div class="amount" id="electricityTotalDisplay">฿0.00</div>
                                        </div>
                                    </div>

                                    <!-- Penalty -->
                                    <div class="utility-card">
                                        <div class="utility-title">
                                            <i class="fas fa-exclamation-triangle"></i>
                                            ค่าปรับ (ถ้ามี)
                                        </div>
                                        <div class="form-group">
                                            <input type="number" id="penalty" name="penalty" 
                                                   class="form-control" value="0" min="0"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Total Section -->
                            <div class="total-section">
                                <div class="total-label">ยอดรวมทั้งสิ้น</div>
                                <div class="total-amount" id="totalDisplay">฿0.00</div>
                                <input type="hidden" id="totalPrice" name="totalPrice"/>

                                <div class="status-section">
                                    <div class="form-group">
                                        <label for="statusSelect">สถานะการชำระ:</label>
                                        <select name="statusId" id="statusSelect" class="form-control">
                                            <option value="0">ยังไม่ได้ชำระ</option>
                                            <option value="1">ชำระแล้ว</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="btn-group">
                                <button type="submit" class="btn btn-primary" onclick="return validateForm()">
                                    <i class="fas fa-save"></i>
                                    บันทึกบิล
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
                                    <c:when test="${not empty error}">
                                        ${error}
                                    </c:when>
                                    <c:otherwise>
                                        ไม่พบข้อมูลห้องพักหรือข้อมูลการจอง กรุณาเลือกห้องจากหน้าจัดการห้องก่อน
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
        function createParticles() {
            const particles = document.getElementById('particles');
            const particleCount = 30;
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.animationDelay = Math.random() * 8 + 's';
                particle.style.animationDuration = (Math.random() * 3 + 5) + 's';
                particles.appendChild(particle);
            }
        }

        function showToast(message, type = 'success') {
            const toast = document.getElementById('toast');
            const toastMessage = document.getElementById('toast-message');
            toastMessage.textContent = message;
            toast.className = `toast ${type}`;
            toast.style.display = 'block';
            setTimeout(() => { toast.style.display = 'none'; }, 5000);
        }

        function calculateTotal() {
            try {
                let roomPrice = parseFloat(document.getElementById("roomPrice").value) || 0;
                let internetPrice = parseFloat(document.getElementById("internetPrice").value) || 0;
                let penalty = parseFloat(document.getElementById("penalty").value) || 0;

                let prevWater = parseFloat(document.getElementById("prevWater").value) || 0;
                let currWater = parseFloat(document.getElementById("currWater").value) || 0;
                let waterRate = parseFloat(document.getElementById("waterRate").value) || 0;
                let waterUsage = Math.max(0, currWater - prevWater);
                let waterTotal = waterUsage * waterRate;
                
                const waterDisplayElement = document.getElementById("waterTotalDisplay");
                if (waterDisplayElement) {
                    waterDisplayElement.textContent = '฿' + waterTotal.toFixed(2);
                }

                let prevElectric = parseFloat(document.getElementById("prevElectric").value) || 0;
                let currElectric = parseFloat(document.getElementById("currElectric").value) || 0;
                let electricRate = parseFloat(document.getElementById("electricRate").value) || 0;
                let electricUsage = Math.max(0, currElectric - prevElectric);
                let electricityTotal = electricUsage * electricRate;
                
                const electricDisplayElement = document.getElementById("electricityTotalDisplay");
                if (electricDisplayElement) {
                    electricDisplayElement.textContent = '฿' + electricityTotal.toFixed(2);
                }

                let total = roomPrice + internetPrice + waterTotal + electricityTotal + penalty;
                
                const totalPriceElement = document.getElementById("totalPrice");
                const totalDisplayElement = document.getElementById("totalDisplay");
                
                if (totalPriceElement) totalPriceElement.value = total.toFixed(2);
                if (totalDisplayElement) {
                    totalDisplayElement.textContent = '฿' + total.toLocaleString('th-TH', {
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    });
                }
            } catch (error) {
                console.error('Error calculating total:',error);
                showToast('เกิดข้อผิดพลาดในการคำนวณ: ' + error.message, 'error');
            }
        }

        function validateForm() {
            const totalPrice = parseFloat(document.getElementById('totalPrice').value) || 0;

            if (totalPrice < 0) {
                showToast('ยอดรวมไม่สามารถติดลบได้', 'error');
                return false;
            }

            const prevWater = parseFloat(document.getElementById("prevWater").value) || 0;
            const currWater = parseFloat(document.getElementById("currWater").value) || 0;
            const prevElectric = parseFloat(document.getElementById("prevElectric").value) || 0;
            const currElectric = parseFloat(document.getElementById("currElectric").value) || 0;

            if (currWater < prevWater) {
                showToast('หน่วยน้ำปัจจุบันต้องมากกว่าหรือเท่ากับหน่วยเดือนก่อน', 'error');
                return false;
            }

            if (currElectric < prevElectric) {
                showToast('หน่วยไฟปัจจุบันต้องมากกว่าหรือเท่ากับหน่วยเดือนก่อน', 'error');
                return false;
            }

            document.getElementById('loading').style.display = 'flex';
            return true;
        }

        window.addEventListener('load', function() {
            createParticles();
            
            const inputs = [
                'roomPrice', 'internetPrice', 'penalty',
                'prevWater', 'currWater', 'waterRate',
                'prevElectric', 'currElectric', 'electricRate'
            ];
            
            inputs.forEach(id => {
                const element = document.getElementById(id);
                if (element) {
                    element.addEventListener('input', calculateTotal);
                    element.addEventListener('change', calculateTotal);
                    element.addEventListener('keyup', calculateTotal);
                }
            });
            
            calculateTotal();
            
            <c:if test="${not empty error}">
                setTimeout(() => showToast("${error}", "error"), 500);
            </c:if>
            
            setTimeout(() => {
                document.getElementById('loading').style.display = 'none';
            }, 500);

            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            setTimeout(() => { document.body.style.opacity = '1'; }, 100);
        });

        document.addEventListener('DOMContentLoaded', function() {
            const sections = document.querySelectorAll('.form-section, .total-section, .room-info-card');
            sections.forEach((section, index) => {
                section.style.animationDelay = (index * 0.1) + 's';
            });
        });

        document.querySelectorAll('input[type="number"]').forEach(input => {
            input.addEventListener('input', function() {
                if (this.value < 0) {
                    this.value = 0;
                }
            });
        });

        window.addEventListener('load', function() {
            const firstInput = document.getElementById('internetPrice');
            if (firstInput) {
                setTimeout(() => firstInput.focus(), 600);
            }
        });

        document.addEventListener('keydown', function(e) {
            if ((e.ctrlKey || e.metaKey) && e.key === 's') {
                e.preventDefault();
                if (validateForm()) {
                    document.getElementById('invoiceForm').submit();
                }
            }
            if (e.key === 'Escape') {
                if (confirm('คุณต้องการยกเลิกการสร้างบิลหรือไม่?')) {
                    window.location.href = 'OwnerHome';
                }
            }
        });

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</body>
</html>