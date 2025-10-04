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
    <title>จัดการบิลห้อง ${room.roomNumber} - ThanaChok Place</title>
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

        /* Background Animation */
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
            max-width: 1400px;
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

        /* Alert Messages */
        .alert {
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

        .alert-success {
            background: rgba(0, 255, 136, 0.15);
            border: 2px solid #00ff88;
            color: #00ff88;
        }

        .alert-error {
            background: rgba(255, 68, 68, 0.15);
            border: 2px solid #ff4444;
            color: #ff4444;
        }

        /* Room Info Card */
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

        /* Invoice Table Container */
        .table-container {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 140, 0, 0.3);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .table-header {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            padding: 25px 30px;
        }

        .table-header h2 {
            font-size: 1.5rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
        }

        .invoice-table thead {
            background: rgba(255, 140, 0, 0.2);
        }

        .invoice-table th {
            padding: 18px 15px;
            text-align: left;
            color: #ff8c00;
            font-weight: 600;
            border-bottom: 2px solid rgba(255, 140, 0, 0.5);
            white-space: nowrap;
        }

        .invoice-table td {
            padding: 18px 15px;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
            color: #ccc;
        }

        .invoice-table tbody tr {
            transition: all 0.3s ease;
        }

        .invoice-table tbody tr:hover {
            background: rgba(255, 140, 0, 0.1);
            transform: scale(1.01);
        }

        .amount {
            color: #00ff88;
            font-weight: 600;
            font-size: 1.05rem;
        }

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            white-space: nowrap;
        }

        .status-paid {
            background: rgba(0, 255, 136, 0.2);
            color: #00ff88;
            border: 2px solid #00ff88;
        }

        .status-unpaid {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            border: 2px solid #ffc107;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
        }

        .btn-edit {
            background: rgba(74, 144, 226, 0.2);
            color: #4a90e2;
            border: 2px solid #4a90e2;
        }

        .btn-edit:hover {
            background: #4a90e2;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(74, 144, 226, 0.3);
        }

        .btn-delete {
            background: rgba(255, 68, 68, 0.2);
            color: #ff4444;
            border: 2px solid #ff4444;
        }

        .btn-delete:hover:not(.btn-disabled) {
            background: #ff4444;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 68, 68, 0.3);
        }

        .btn-disabled {
            background: rgba(100, 100, 100, 0.2) !important;
            color: #666 !important;
            border: 2px solid #444 !important;
            cursor: not-allowed !important;
            opacity: 0.6;
        }

        .btn-create {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            border: none;
            padding: 15px 30px;
            font-size: 1.1rem;
            box-shadow: 0 5px 20px rgba(255, 140, 0, 0.3);
        }

        .btn-create:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 140, 0, 0.5);
        }

        /* No Invoice State */
        .no-invoice-state {
            text-align: center;
            padding: 80px 20px;
            color: #999;
        }

        .no-invoice-icon {
            font-size: 5rem;
            color: rgba(255, 140, 0, 0.3);
            margin-bottom: 25px;
        }

        .no-invoice-state h3 {
            color: #ff8c00;
            margin-bottom: 15px;
            font-size: 1.8rem;
        }

        .no-invoice-state p {
            margin-bottom: 30px;
            font-size: 1.1rem;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.9);
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            margin: 10% auto;
            padding: 0;
            border: 2px solid rgba(255, 140, 0, 0.5);
            border-radius: 15px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.8);
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .modal-header {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            padding: 25px;
            border-radius: 13px 13px 0 0;
            font-size: 1.4rem;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .modal-body {
            padding: 30px;
            color: #fff;
        }

        .modal-body p {
            margin-bottom: 15px;
            line-height: 1.6;
        }

        .modal-body strong {
            color: #ff8c00;
        }

        .modal-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            padding: 0 30px 30px;
        }

        .btn-confirm {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-confirm:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 68, 68, 0.5);
        }

        .btn-cancel {
            background: rgba(100, 100, 100, 0.3);
            color: #ccc;
            padding: 12px 30px;
            border: 2px solid #666;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            background: rgba(100, 100, 100, 0.5);
            transform: translateY(-2px);
        }

        /* Create Invoice Section */
        .create-invoice-section {
            text-align: center;
            margin-top: 30px;
            padding: 30px;
            background: rgba(255, 140, 0, 0.05);
            border-radius: 15px;
            border: 2px dashed rgba(255, 140, 0, 0.3);
        }

        /* Loading */
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

        /* Responsive */
        @media (max-width: 768px) {
            .container { padding: 15px; }
            .page-header { font-size: 2rem; }
            .room-info-grid { grid-template-columns: 1fr; }
            .invoice-table { font-size: 0.85rem; }
            .invoice-table th, .invoice-table td { padding: 12px 8px; }
            .action-buttons { flex-direction: column; }
            .btn { width: 100%; justify-content: center; }
            .modal-content { width: 95%; margin: 20% auto; }
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
            <i class="fas fa-file-invoice-dollar"></i>
            จัดการบิลห้องพัก
        </div>

        <a href="OwnerHome" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            กลับหน้าหลัก
        </a>

        <!-- Alert Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${message}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>

        <!-- Room Information -->
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
                    <span>฿${room.roomPrice}/เดือน</span>
                </div>
                <div class="room-info-item">
                    <strong><i class="fas fa-info-circle"></i> สถานะห้อง</strong>
                    <span>${room.roomStatus}</span>
                </div>
            </div>
        </div>

        <!-- Invoice List or Empty State -->
        <c:choose>
            <c:when test="${empty invoices}">
                <div class="table-container">
                    <div class="table-header">
                        <h2>
                            <i class="fas fa-receipt"></i>
                            รายการใบแจ้งหนี้
                        </h2>
                    </div>
                    <div class="no-invoice-state">
                        <div class="no-invoice-icon">
                            <i class="fas fa-file-invoice"></i>
                        </div>
                        <h3>ยังไม่มีใบแจ้งหนี้</h3>
                        <p>ห้องนี้ยังไม่มีประวัติใบแจ้งหนี้</p>
                        <a href="ManagerAddInvoice?roomID=${room.roomID}" class="btn btn-create">
                            <i class="fas fa-plus-circle"></i>
                            สร้างใบแจ้งหนี้ใหม่
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                    <div class="table-header">
                        <h2>
                            <i class="fas fa-receipt"></i>
                            รายการใบแจ้งหนี้ทั้งหมด
                        </h2>
                    </div>
                    <table class="invoice-table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag"></i> เลขที่ใบแจ้งหนี้</th>
                                <th><i class="fas fa-calendar-plus"></i> วันที่ออกบิล</th>
                                <th><i class="fas fa-calendar-check"></i> วันครบกำหนด</th>
                                <th><i class="fas fa-dollar-sign"></i> จำนวนเงิน</th>
                                <th><i class="fas fa-flag"></i> สถานะ</th>
                                <th><i class="fas fa-cogs"></i> การจัดการ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="invoice" items="${invoices}">
                                <tr>
                                    <td>
                                        <strong style="color: #ff8c00;">INV-${invoice.invoiceId}</strong>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty invoice.issueDate}">
                                                <i class="fas fa-calendar"></i> ${invoice.issueDate}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty invoice.dueDate}">
                                                <i class="fas fa-calendar"></i> ${invoice.dueDate}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="amount">
                                        ฿<fmt:formatNumber value="${invoice.totalAmount}" 
                                                         groupingUsed="true" minFractionDigits="2"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${invoice.status == 1}">
                                                <span class="status-badge status-paid">
                                                    <i class="fas fa-check-circle"></i> ชำระแล้ว
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-unpaid">
                                                    <i class="fas fa-clock"></i> ยังไม่ได้ชำระ
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="EditInvoiceForm?invoiceId=${invoice.invoiceId}" 
                                               class="btn btn-edit" 
                                               title="แก้ไขใบแจ้งหนี้">
                                                <i class="fas fa-edit"></i> แก้ไข
                                            </a>
                                            <c:choose>
                                                <c:when test="${invoice.status == 1}">
                                                    <span class="btn btn-delete btn-disabled" 
                                                          title="ไม่สามารถลบได้ เนื่องจากชำระเงินแล้ว">
                                                        <i class="fas fa-ban"></i> ลบไม่ได้
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="javascript:void(0)" 
                                                       class="btn btn-delete" 
                                                       title="ลบใบแจ้งหนี้"
                                                       onclick="confirmDelete(${invoice.invoiceId}, 'INV-${invoice.invoiceId}')">
                                                        <i class="fas fa-trash"></i> ลบ
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Create New Invoice Section -->
                <div class="create-invoice-section">
                    <a href="ManagerAddInvoice?roomID=${room.roomID}" class="btn btn-create">
                        <i class="fas fa-plus-circle"></i>
                        สร้างใบแจ้งหนี้ใหม่
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <i class="fas fa-exclamation-triangle"></i>
                ยืนยันการลบ
            </div>
            <div class="modal-body">
                <p>คุณต้องการลบใบแจ้งหนี้ <strong id="invoiceNumber"></strong> หรือไม่?</p>
                <p style="color: #ff4444; font-size: 0.95rem;">
                    <i class="fas fa-info-circle"></i>
                    <strong>หมายเหตุ:</strong> สามารถลบได้เฉพาะใบแจ้งหนี้ที่ยังไม่ได้ชำระเท่านั้น
                </p>
                <p style="color: #ff4444; font-size: 0.95rem;">
                    <i class="fas fa-exclamation-circle"></i>
                    การลบนี้ไม่สามารถย้อนกลับได้
                </p>
            </div>
            <div class="modal-buttons">
                <button type="button" class="btn-confirm" onclick="deleteInvoice()">
                    <i class="fas fa-check"></i> ยืนยันลบ
                </button>
                <button type="button" class="btn-cancel" onclick="closeModal()">
                    <i class="fas fa-times"></i> ยกเลิก
                </button>
            </div>
        </div>
    </div>

    <script>
        let invoiceToDelete = null;
        
        function confirmDelete(invoiceId, invoiceNumber) {
            invoiceToDelete = invoiceId;
            document.getElementById('invoiceNumber').textContent = invoiceNumber;
            document.getElementById('deleteModal').style.display = 'block';
        }
        
        function closeModal() {
            document.getElementById('deleteModal').style.display = 'none';
            invoiceToDelete = null;
        }
        
        function deleteInvoice() {
            if (invoiceToDelete) {
                const roomID = '${room.roomID}';
                const deleteUrl = 'DeleteInvoice?invoiceId=' + invoiceToDelete + '&roomID=' + roomID;
                
                document.getElementById('loading').style.display = 'flex';
                window.location.href = deleteUrl;
            }
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target === modal) {
                closeModal();
            }
        }
        
        // Close modal with ESC key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeModal();
            }
        });
        
        // Auto hide alerts after 5 seconds
        window.addEventListener('load', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    alert.style.transition = 'opacity 0.5s ease';
                    alert.style.opacity = '0';
                    setTimeout(() => alert.remove(), 500);
                }, 5000);
            });

            // Hide loading
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
    </script>
</body>
</html>