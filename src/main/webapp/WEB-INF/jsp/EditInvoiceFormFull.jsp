<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
    <title>แก้ไขข้อมูลบิล #INV-${invoice.invoiceId} - ThanaChok Place</title>
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

        .container {
            max-width: 1200px;
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

        .main-card {
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
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideInDown 0.5s ease;
        }

        @keyframes slideInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .alert-success {
            background: rgba(0, 255, 136, 0.15);
            border: 2px solid #00ff88;
            color: #00ff88;
        }

        .alert-danger {
            background: rgba(255, 68, 68, 0.15);
            border: 2px solid #ff4444;
            color: #ff4444;
        }

        .alert-warning {
            background: rgba(255, 193, 7, 0.15);
            border: 2px solid #ffc107;
            color: #ffc107;
        }

        .form-section {
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
        }

        .section-title {
            color: #ff8c00;
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 0;
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

        .form-control:disabled {
            background: rgba(100, 100, 100, 0.2);
            color: #999;
            cursor: not-allowed;
        }

        .form-control.warning {
            border-color: #ffc107;
            animation: shake 0.5s;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .utility-section {
            background: rgba(255, 140, 0, 0.05);
            border: 2px dashed rgba(255, 140, 0, 0.3);
            border-radius: 10px;
            padding: 20px;
            margin-top: 15px;
        }

        .utility-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr 1fr;
            gap: 15px;
            align-items: end;
        }

        .total-display {
            background: linear-gradient(135deg, rgba(255, 140, 0, 0.2), rgba(255, 107, 0, 0.2));
            border: 3px solid #ff8c00;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            margin-bottom: 30px;
        }

        .total-amount {
            font-size: 2rem;
            font-weight: bold;
            color: #ff8c00;
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

        @media (max-width: 768px) {
            .container { padding: 15px; }
            .page-header { font-size: 2rem; }
            .card-body { padding: 25px 20px; }
            .form-row { grid-template-columns: 1fr; }
            .utility-grid { grid-template-columns: 1fr; }
            .btn-group { flex-direction: column; align-items: center; }
            .btn { width: 100%; max-width: 300px; }
        }
    </style>
</head>

<body>
    <div class="bg-animation">
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
    </div>

    <div class="loading" id="loading">
        <div class="spinner"></div>
    </div>

    <div class="container">
        <div class="page-header">
            <i class="fas fa-edit"></i>
            แก้ไขข้อมูลบิลแบบเต็ม
        </div>

        <a href="EditInvoice?roomID=${invoice.rent.room.roomID}" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            กลับไปรายการบิล
        </a>

        <div class="main-card">
            <div class="card-header">
                <h2>
                    <i class="fas fa-file-invoice"></i>
                    แก้ไขบิล #INV-${invoice.invoiceId}
                </h2>
            </div>

            <div class="card-body">
                <!-- Alert Messages -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        ${message}
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i>
                        ${error}
                    </div>
                </c:if>

                <!-- Warning Alert for Meter -->
                <div class="alert alert-warning" id="meterWarning" style="display: none;">
                    <i class="fas fa-exclamation-circle"></i>
                    <span id="warningMessage"></span>
                </div>

                <!-- Edit Form -->
                <form action="UpdateInvoiceFull" method="post" id="editForm" onsubmit="return validateForm()">
                    <input type="hidden" name="invoiceId" value="${invoice.invoiceId}"/>
                    <input type="hidden" name="roomID" value="${invoice.rent.room.roomID}"/>
                    
                    <!-- Basic Info Section -->
                    <div class="form-section">
                        <div class="section-title">
                            <i class="fas fa-info-circle"></i>
                            ข้อมูลพื้นฐาน
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-door-open"></i>
                                    ห้องพัก
                                </label>
                                <input type="text" class="form-control" 
                                       value="${invoice.rent.room.roomNumber}" disabled>
                            </div>
                            
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-user"></i>
                                    ผู้เช่า
                                </label>
                                <input type="text" class="form-control" 
                                       value="${invoice.rent.member.firstName} ${invoice.rent.member.lastName}" disabled>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="issueDate">
                                    <i class="fas fa-calendar-plus"></i>
                                    วันที่ออกบิล
                                </label>
                                <input type="date" class="form-control" id="issueDate" 
                                       name="issueDate" value="${invoice.issueDate}" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="dueDate">
                                    <i class="fas fa-calendar-check"></i>
                                    วันครบกำหนด
                                </label>
                                <input type="date" class="form-control" id="dueDate" 
                                       name="dueDate" value="${invoice.dueDate}" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="status">
                                    <i class="fas fa-flag"></i>
                                    สถานะ
                                </label>
                                <select name="status" id="status" class="form-control" required>
                                    <option value="0" ${invoice.status == 0 ? 'selected' : ''}>
                                        ยังไม่ได้ชำระ
                                    </option>
                                    <option value="1" ${invoice.status == 1 ? 'selected' : ''}>
                                        ชำระแล้ว
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Cost Details Section -->
                    <div class="form-section">
                        <div class="section-title">
                            <i class="fas fa-money-bill-wave"></i>
                            รายละเอียดค่าใช้จ่าย
                        </div>

                        <!-- ค่าห้อง -->
                        <div class="form-group">
                            <label for="roomPrice">
                                <i class="fas fa-home"></i>
                                ค่าห้อง (บาท)
                            </label>
                            <input type="number" step="0.01" class="form-control" id="roomPrice" 
                                   name="roomPrice" value="${roomPrice}" required onchange="calculateTotal()">
                        </div>

                        <!-- ค่าอินเทอร์เน็ต -->
                        <div class="form-group">
                            <label for="internetPrice">
                                <i class="fas fa-wifi"></i>
                                ค่าอินเทอร์เน็ต (บาท)
                            </label>
                            <input type="number" step="0.01" class="form-control" id="internetPrice" 
                                   name="internetPrice" value="${internetPrice}" onchange="calculateTotal()">
                        </div>

                        <!-- ค่าน้ำ -->
                        <div class="utility-section">
                            <label style="color: #4a90e2; font-size: 1.1rem; margin-bottom: 15px; display: block;">
                                <i class="fas fa-tint"></i>
                                ค่าน้ำ
                            </label>
                            <div class="utility-grid">
                                <div class="form-group">
                                    <label>เลขครั้งก่อน</label>
                                    <input type="number" class="form-control" id="prevWater" 
                                           name="prevWater" value="${prevWater}" required readonly 
                                           style="background: rgba(100, 100, 100, 0.3);">
                                </div>
                                <div class="form-group">
                                    <label>เลขครั้งนี้</label>
                                    <input type="number" class="form-control" id="currWater" 
                                           name="currWater" value="${currWater}" required 
                                           onchange="checkMeterReading(); calculateWater();" 
                                           oninput="checkMeterReading();">
                                </div>
                                <div class="form-group">
                                    <label>อัตราต่อหน่วย (บาท)</label>
                                    <input type="number" step="0.01" class="form-control" id="waterRate" 
                                           name="waterRate" value="${waterRate}" required onchange="calculateWater()">
                                </div>
                                <div class="form-group">
                                    <label>รวม (บาท)</label>
                                    <input type="number" step="0.01" class="form-control" id="waterTotal" 
                                           disabled>
                                </div>
                            </div>
                        </div>

                        <!-- ค่าไฟฟ้า -->
                        <div class="utility-section">
                            <label style="color: #ffc107; font-size: 1.1rem; margin-bottom: 15px; display: block;">
                                <i class="fas fa-bolt"></i>
                                ค่าไฟฟ้า
                            </label>
                            <div class="utility-grid">
                                <div class="form-group">
                                    <label>เลขครั้งก่อน</label>
                                    <input type="number" class="form-control" id="prevElectric" 
                                           name="prevElectric" value="${prevElectric}" required readonly
                                           style="background: rgba(100, 100, 100, 0.3);">
                                </div>
                                <div class="form-group">
                                    <label>เลขครั้งนี้</label>
                                    <input type="number" class="form-control" id="currElectric" 
                                           name="currElectric" value="${currElectric}" required 
                                           onchange="checkMeterReading(); calculateElectric();"
                                           oninput="checkMeterReading();">
                                </div>
                                <div class="form-group">
                                    <label>อัตราต่อหน่วย (บาท)</label>
                                    <input type="number" step="0.01" class="form-control" id="electricRate" 
                                           name="electricRate" value="${electricRate}" required onchange="calculateElectric()">
                                </div>
                                <div class="form-group">
                                    <label>รวม (บาท)</label>
                                    <input type="number" step="0.01" class="form-control" id="electricTotal" 
                                           disabled>
                                </div>
                            </div>
                        </div>

                        <!-- ค่าปรับ -->
                        <div class="form-group">
                            <label for="penalty">
                                <i class="fas fa-exclamation-triangle"></i>
                                ค่าปรับ (บาท)
                            </label>
                            <input type="number" step="0.01" class="form-control" id="penalty" 
                                   name="penalty" value="${penalty}" onchange="calculateTotal()">
                        </div>
                    </div>

                    <!-- Total Section -->
                    <div class="total-display">
                        <div style="font-size: 1.2rem; color: #ccc; margin-bottom: 10px;">
                            ยอดรวมทั้งสิ้น
                        </div>
                        <div class="total-amount" id="totalDisplay">
                            ฿0.00
                        </div>
                        <input type="hidden" name="totalPrice" id="totalPrice">
                    </div>

                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            บันทึกการแก้ไข
                        </button>
                        <a href="EditInvoice?roomID=${invoice.rent.room.roomID}" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            ยกเลิก
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function checkMeterReading() {
            const prevWater = parseFloat(document.getElementById('prevWater').value) || 0;
            const currWater = parseFloat(document.getElementById('currWater').value) || 0;
            const prevElectric = parseFloat(document.getElementById('prevElectric').value) || 0;
            const currElectric = parseFloat(document.getElementById('currElectric').value) || 0;
            
            const warningDiv = document.getElementById('meterWarning');
            const warningMsg = document.getElementById('warningMessage');
            const waterInput = document.getElementById('currWater');
            const electricInput = document.getElementById('currElectric');
            
            let warnings = [];
            
            if (currWater < prevWater && currWater > 0) {
                warnings.push('เลขมิเตอร์น้ำครั้งนี้ (' + currWater + ') น้อยกว่าครั้งก่อน (' + prevWater + ')');
                waterInput.classList.add('warning');
            } else {
                waterInput.classList.remove('warning');
            }
            
            if (currElectric < prevElectric && currElectric > 0) {
                warnings.push('เลขมิเตอร์ไฟฟ้าครั้งนี้ (' + currElectric + ') น้อยกว่าครั้งก่อน (' + prevElectric + ')');
                electricInput.classList.add('warning');
            } else {
                electricInput.classList.remove('warning');
            }
            
            if (warnings.length > 0) {
                warningMsg.textContent = warnings.join(' และ ');
                warningDiv.style.display = 'flex';
            } else {
                warningDiv.style.display = 'none';
            }
        }

        function calculateWater() {
            const prev = parseFloat(document.getElementById('prevWater').value) || 0;
            const curr = parseFloat(document.getElementById('currWater').value) || 0;
            const rate = parseFloat(document.getElementById('waterRate').value) || 0;
            
            const usage = Math.max(0, curr - prev);
            const total = usage * rate;
            
            document.getElementById('waterTotal').value = total.toFixed(2);
            calculateTotal();
        }

        function calculateElectric() {
            const prev = parseFloat(document.getElementById('prevElectric').value) || 0;
            const curr = parseFloat(document.getElementById('currElectric').value) || 0;
            const rate = parseFloat(document.getElementById('electricRate').value) || 0;
            
            const usage = Math.max(0, curr - prev);
            const total = usage * rate;
            
            document.getElementById('electricTotal').value = total.toFixed(2);
            calculateTotal();
        }

        function calculateTotal() {
            const roomPrice = parseFloat(document.getElementById('roomPrice').value) || 0;
            const internetPrice = parseFloat(document.getElementById('internetPrice').value) || 0;
            const waterTotal = parseFloat(document.getElementById('waterTotal').value) || 0;
            const electricTotal = parseFloat(document.getElementById('electricTotal').value) || 0;
            const penalty = parseFloat(document.getElementById('penalty').value) || 0;
            
            const total = roomPrice + internetPrice + waterTotal + electricTotal + penalty;
            
            document.getElementById('totalDisplay').textContent = '฿' + total.toLocaleString('th-TH', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            });
            document.getElementById('totalPrice').value = total.toFixed(2);
        }

        function validateForm() {
            const prevWater = parseFloat(document.getElementById('prevWater').value) || 0;
            const currWater = parseFloat(document.getElementById('currWater').value) || 0;
            const prevElectric = parseFloat(document.getElementById('prevElectric').value) || 0;
            const currElectric = parseFloat(document.getElementById('currElectric').value) || 0;
            
            if (currWater < prevWater) {
                alert('❌ เลขมิเตอร์น้ำครั้งนี้ (' + currWater + ') ต้องมากกว่าหรือเท่ากับครั้งก่อน (' + prevWater + ')');
                document.getElementById('currWater').focus();
                return false;
            }
            
            if (currElectric < prevElectric) {
                alert('❌ เลขมิเตอร์ไฟฟ้าครั้งนี้ (' + currElectric + ') ต้องมากกว่าหรือเท่ากับครั้งก่อน (' + prevElectric + ')');
                document.getElementById('currElectric').focus();
                return false;
            }
            
            const issueDate = new Date(document.getElementById('issueDate').value);
            const dueDate = new Date(document.getElementById('dueDate').value);
            
            if (dueDate < issueDate) {
                alert('❌ วันครบกำหนดต้องเป็นวันที่มาหลังวันที่ออกบิล');
                return false;
            }
            
            if (confirm('คุณต้องการบันทึกการแก้ไขบิลนี้ใช่หรือไม่?')) {
                document.getElementById('loading').style.display = 'flex';
                return true;
            }
            return false;
        }

        // Initialize calculations on page load
        window.addEventListener('load', function() {
            calculateWater();
            calculateElectric();
            calculateTotal();
            checkMeterReading();
            
            setTimeout(() => {
                document.getElementById('loading').style.display = 'none';
            }, 500);
        });
    </script>
</body>
</html>