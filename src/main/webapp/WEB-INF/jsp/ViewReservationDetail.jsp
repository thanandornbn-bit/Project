<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
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
    <title>รายละเอียดการจอง - ThanaChok Place</title>
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

       
        .success-message, .error-message {
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
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-message {
            background: rgba(0, 255, 136, 0.15);
            border: 2px solid #00ff88;
            color: #00ff88;
        }

        .error-message {
            background: rgba(255, 68, 68, 0.15);
            border: 2px solid #ff4444;
            color: #ff4444;
        }

       
        .detail-card {
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
            font-size: 2rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card-body {
            padding: 40px;
        }

        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .info-section {
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 15px;
            padding: 25px;
            transition: all 0.3s ease;
        }

        .info-section:hover {
            transform: translateY(-3px);
            border-color: rgba(255, 140, 0, 0.5);
            box-shadow: 0 8px 25px rgba(255, 140, 0, 0.2);
        }

        .info-section h3 {
            color: #ff8c00;
            font-size: 1.3rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(255, 140, 0, 0.3);
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #999;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-value {
            color: #fff;
            font-weight: 600;
            text-align: right;
        }

        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .status-approved {
            background: rgba(0, 255, 136, 0.2);
            color: #00ff88;
            border: 2px solid #00ff88;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            border: 2px solid #ffc107;
            animation: pulse-pending 2s ease-in-out infinite;
        }

        @keyframes pulse-pending {
            0%, 100% { box-shadow: 0 0 10px rgba(255, 193, 7, 0.3); }
            50% { box-shadow: 0 0 20px rgba(255, 193, 7, 0.6); }
        }

       
        .slip-section {
            grid-column: 1 / -1;
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 15px;
            padding: 25px;
        }

        .slip-section h3 {
            color: #ff8c00;
            font-size: 1.3rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(255, 140, 0, 0.3);
        }

        .slip-image-container {
            display: flex;
            justify-content: center;
            align-items: center;
            background: rgba(0, 0, 0, 0.6);
            border-radius: 12px;
            padding: 20px;
            min-height: 400px;
        }

        .slip-image {
            max-width: 100%;
            max-height: 600px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            cursor: pointer;
            transition: all 0.3s ease;
            border: 3px solid rgba(255, 140, 0, 0.3);
        }

        .slip-image:hover {
            transform: scale(1.02);
            box-shadow: 0 15px 40px rgba(255, 140, 0, 0.4);
            border-color: #ff8c00;
        }

        .no-image {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .no-image i {
            font-size: 4rem;
            color: rgba(255, 140, 0, 0.3);
            margin-bottom: 20px;
        }

        .no-image h4 {
            color: #ff8c00;
            margin-bottom: 10px;
            font-size: 1.3rem;
        }

      
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.95);
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            margin: auto;
            display: block;
            max-width: 90%;
            max-height: 90%;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border-radius: 10px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.8);
            animation: zoomIn 0.3s ease;
        }

        @keyframes zoomIn {
            from { transform: translate(-50%, -50%) scale(0.8); }
            to { transform: translate(-50%, -50%) scale(1); }
        }

        .close {
            position: absolute;
            top: 20px;
            right: 40px;
            color: #fff;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
            z-index: 1001;
            transition: all 0.3s ease;
            background: rgba(255, 68, 68, 0.8);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .close:hover {
            background: #ff4444;
            transform: rotate(90deg);
        }

    
        .action-section {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid rgba(255, 140, 0, 0.3);
        }

        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
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
            min-width: 200px;
            justify-content: center;
        }

        .btn-approve {
            background: linear-gradient(135deg, #00ff88, #00cc6f);
            color: #000;
            box-shadow: 0 5px 20px rgba(0, 255, 136, 0.3);
            animation: pulse-approve 2s ease-in-out infinite;
        }

        @keyframes pulse-approve {
            0%, 100% { box-shadow: 0 5px 20px rgba(0, 255, 136, 0.3); }
            50% { box-shadow: 0 8px 30px rgba(0, 255, 136, 0.6); }
        }

        .btn-approve:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 255, 136, 0.5);
        }

        .btn-disabled {
            background: rgba(100, 100, 100, 0.3);
            color: #999;
            border: 2px solid #666;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .btn-back {
            background: rgba(255, 68, 68, 0.2);
            color: #ff4444;
            border: 2px solid #ff4444;
        }

        .btn-back:hover {
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
            .info-grid { grid-template-columns: 1fr; }
            .button-group { flex-direction: column; align-items: center; }
            .btn { width: 100%; max-width: 300px; }
            .slip-image-container { min-height: 300px; }
            .close { top: 10px; right: 20px; width: 40px; height: 40px; font-size: 30px; }
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

    <div id="imageModal" class="modal">
        <span class="close">&times;</span>
        <img class="modal-content" id="modalImage">
    </div>

    <div class="container">
        <div class="page-header">
            <i class="fas fa-file-contract"></i>
            รายละเอียดการจอง
        </div>

        <a href="OViewReserve" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            กลับไปหน้ารายการจอง
        </a>

        <c:if test="${param.success == '1'}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                อนุมัติการจองเรียบร้อยแล้ว! ตอนนี้สามารถเพิ่มบิลให้ห้องนี้ได้แล้ว
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty rent}">
                <div class="detail-card">
                    <div class="card-header">
                        <h2>
                            <i class="fas fa-home"></i>
                            ห้อง ${rent.room.roomNumber}
                        </h2>
                    </div>
                    
                    <div class="card-body">
                        <div class="info-grid">
                            <div class="info-section">
                                <h3>
                                    <i class="fas fa-door-open"></i>
                                    ข้อมูลห้องพัก
                                </h3>
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-hashtag"></i>
                                        หมายเลขห้อง:
                                    </span>
                                    <span class="info-value">${rent.room.roomNumber}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-home"></i>
                                        ประเภทห้อง:
                                    </span>
                                    <span class="info-value">${rent.room.roomtype}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-money-bill-wave"></i>
                                        ราคาห้อง:
                                    </span>
                                    <span class="info-value">฿<fmt:formatNumber value="${rent.room.roomPrice}" groupingUsed="true" /></span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-calendar-alt"></i>
                                        วันที่จอง:
                                    </span>
                                    <span class="info-value">
                                        <fmt:formatDate value="${rent.rentDate}" pattern="dd/MM/yyyy"/>
                                    </span>
                                </div>
                            </div>

                            <div class="info-section">
                                <h3>
                                    <i class="fas fa-user"></i>
                                    ข้อมูลผู้จอง
                                </h3>
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-user-circle"></i>
                                        ชื่อ-นามสกุล:
                                    </span>
                                    <span class="info-value">${rent.member.firstName} ${rent.member.lastName}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-envelope"></i>
                                        อีเมล:
                                    </span>
                                    <span class="info-value">${rent.member.email}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-phone"></i>
                                        เบอร์โทรศัพท์:
                                    </span>
                                    <span class="info-value">${rent.member.phoneNumber}</span>
                                </div>
                            </div>

                            <c:if test="${not empty rent.rentalDeposit}">
                                <div class="info-section">
                                    <h3>
                                        <i class="fas fa-credit-card"></i>
                                        ข้อมูลการชำระเงิน
                                    </h3>
                                    <div class="info-item">
                                        <span class="info-label">
                                            <i class="fas fa-user-tag"></i>
                                            ชื่อบัญชีที่โอน:
                                        </span>
                                        <span class="info-value">${rent.rentalDeposit.transferAccountName}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">
                                            <i class="fas fa-calendar-check"></i>
                                            วันที่โอน:
                                        </span>
                                        <span class="info-value">
                                            <fmt:formatDate value="${rent.rentalDeposit.paymentDate}" pattern="dd/MM/yyyy"/>
                                        </span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">
                                            <i class="fas fa-clock"></i>
                                            วันครบกำหนด:
                                        </span>
                                        <span class="info-value">
                                            <fmt:formatDate value="${rent.rentalDeposit.deadlineDate}" pattern="dd/MM/yyyy"/>
                                        </span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">
                                            <i class="fas fa-money-bill"></i>
                                            จำนวนเงินที่ชำระ:
                                        </span>
                                        <span class="info-value">฿<fmt:formatNumber value="${rent.rentalDeposit.totalPrice}" groupingUsed="true" /></span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">
                                            <i class="fas fa-tags"></i>
                                            สถานะ:
                                        </span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${rent.rentalDeposit.status == 'เสร็จสมบูรณ์'}">
                                                    <span class="status-badge status-approved">
                                                        <i class="fas fa-check-circle"></i> เสร็จสมบูรณ์
                                                    </span>
                                                </c:when>
                                                <c:when test="${rent.rentalDeposit.status == 'รอดำเนินการ'}">
                                                    <span class="status-badge status-pending">
                                                        <i class="fas fa-clock"></i> รอการอนุมัติ
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-pending">
                                                        <i class="fas fa-question-circle"></i> ${rent.rentalDeposit.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </c:if>

                            <div class="slip-section">
                                <h3>
                                    <i class="fas fa-image"></i>
                                    สลิปการโอนเงิน
                                </h3>
                                <c:choose>
                                    <c:when test="${not empty rent.rentalDeposit.paymentSlipImage}">
                                        <div class="slip-image-container">
                                            <img src="${pageContext.request.contextPath}/${rent.rentalDeposit.paymentSlipImage}" 
                                                 class="slip-image" 
                                                 alt="สลิปการโอนเงิน"
                                                 onclick="openModal(this)"
                                                 title="คลิกเพื่อดูภาพขนาดใหญ่"/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-image">
                                            <i class="fas fa-image"></i>
                                            <h4>ไม่มีภาพสลิปการโอนเงิน</h4>
                                            <p>ผู้จองยังไม่ได้อัปโหลดสลิปการโอนเงิน</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="action-section">
                            <div class="button-group">
                                <c:choose>
                                    <c:when test="${rent.rentalDeposit.status == 'รอดำเนินการ'}">
                                        <form action="ConfirmRentalDeposit" method="post" style="display: inline;">
                                            <input type="hidden" name="depositId" value="${rent.rentalDeposit.depositID}" />
                                            <button type="submit" class="btn btn-approve" 
                                                    onclick="return confirmApproval('${rent.room.roomNumber}', '${rent.member.firstName} ${rent.member.lastName}')">
                                                <i class="fas fa-check"></i>
                                                อนุมัติการจอง
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:when test="${rent.rentalDeposit.status == 'เสร็จสมบูรณ์'}">
                                        <button class="btn btn-disabled" disabled>
                                            <i class="fas fa-check-circle"></i>
                                            อนุมัติแล้ว
                                        </button>
                                    </c:when>
                                </c:choose>
                                
                                <a href="OViewReserve" class="btn btn-back">
                                    <i class="fas fa-arrow-left"></i>
                                    กลับไปรายการจอง
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="detail-card">
                    <div class="card-body" style="text-align: center; padding: 60px 30px;">
                        <i class="fas fa-exclamation-triangle" style="font-size: 4rem; color: #ff4444; margin-bottom: 20px;"></i>
                        <h3 style="color: #ff8c00; margin-bottom: 15px;">ไม่พบข้อมูลการจอง</h3>
                        <p style="color: #999; margin-bottom: 30px;">ระบบไม่สามารถค้นหาข้อมูลการจองที่ต้องการได้</p>
                        <a href="OViewReserve" class="btn btn-back">
                            <i class="fas fa-arrow-left"></i>
                            กลับไปรายการจอง
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function openModal(img) {
            const modal = document.getElementById('imageModal');
            const modalImg = document.getElementById('modalImage');
            modal.style.display = 'block';
            modalImg.src = img.src;
        }

        document.querySelector('.close').onclick = function() {
            document.getElementById('imageModal').style.display = 'none';
        }

        window.onclick = function(event) {
            const modal = document.getElementById('imageModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        }

        function confirmApproval(roomNumber, memberName) {
            const message = `คุณต้องการอนุมัติการจองห้อง ${roomNumber}\nของ ${memberName} ใช่หรือไม่?\n\nหลังจากอนุมัติแล้ว:\n✓ สามารถเพิ่มบิลให้ห้องนี้ได้\n✓ ผู้เช่าสามารถเข้าพักได้\n✓ ไม่สามารถยกเลิกได้`;
            
            if (confirm(message)) {
                document.getElementById('loading').style.display = 'flex';
                return true;
            }
            return false;
        }

        window.addEventListener('load', function() {
            setTimeout(() => {
                document.getElementById('loading').style.display = 'none';
            }, 500);

            // Fade in animation
            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            
            setTimeout(() => {
                document.body.style.opacity = '1';
            }, 100);
        });

        // Close modal on Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                document.getElementById('imageModal').style.display = 'none';
            }
        });

        // Add animation delays to info sections
        document.addEventListener('DOMContentLoaded', function() {
            const sections = document.querySelectorAll('.info-section, .slip-section');
            sections.forEach((section, index) => {
                section.style.animationDelay = (index * 0.1) + 's';
            });
        });
    </script>
</body>
</html>