<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ page session="true"%>
<%@ page import="com.springmvc.model.Manager"%>
<%@ page import="java.util.*"%>

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
    <title>จัดการการจอง - ThanaChok Place</title>
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
            max-width: 1400px;
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

        .top-bar {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 25px;
            border: 1px solid rgba(255, 140, 0, 0.3);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .welcome-message {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.2rem;
            color: #ff8c00;
            font-weight: 600;
        }

        .admin-badge {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            color: white;
            box-shadow: 0 3px 10px rgba(255, 140, 0, 0.3);
        }

        .nav {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .nav a {
            padding: 12px 25px;
            background: rgba(255, 140, 0, 0.1);
            border: 1px solid rgba(255, 140, 0, 0.3);
            color: #ff8c00;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .nav a:hover, .nav a.active {
            background: rgba(255, 140, 0, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 140, 0, 0.2);
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

        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 25px;
            border-radius: 15px;
            border: 2px solid;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
        }

        .stat-total { border-color: #ff8c00; }
        .stat-pending { border-color: #ffc107; }
        .stat-approved { border-color: #00ff88; }
        .stat-returned { border-color: #4a90e2; }

        .stat-icon {
            font-size: 2.5rem;
            opacity: 0.8;
        }

        .stat-total .stat-icon { color: #ff8c00; }
        .stat-pending .stat-icon { color: #ffc107; }
        .stat-approved .stat-icon { color: #00ff88; }
        .stat-returned .stat-icon { color: #4a90e2; }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
        }

        .stat-total .stat-number { color: #ff8c00; }
        .stat-pending .stat-number { color: #ffc107; }
        .stat-approved .stat-number { color: #00ff88; }
        .stat-returned .stat-number { color: #4a90e2; }

        .stat-label {
            font-size: 1rem;
            color: #999;
            font-weight: 500;
        }

      
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

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: rgba(255, 140, 0, 0.2);
        }

        th {
            padding: 18px 15px;
            text-align: left;
            color: #ff8c00;
            font-weight: 600;
            border-bottom: 2px solid rgba(255, 140, 0, 0.5);
            white-space: nowrap;
        }

        td {
            padding: 18px 15px;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
            color: #ccc;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: rgba(255, 140, 0, 0.1);
            transform: scale(1.01);
        }

        .room-number {
            font-weight: bold;
            color: #ff8c00;
            font-size: 1.1rem;
        }

        .member-name {
            color: #fff;
            font-weight: 500;
        }

        .price {
            color: #00ff88;
            font-weight: 600;
            font-size: 1.05rem;
        }

       
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

        .status-approved {
            background: rgba(0, 255, 136, 0.2);
            color: #00ff88;
            border: 2px solid #00ff88;
        }

        .status-returned {
            background: rgba(74, 144, 226, 0.2);
            color: #4a90e2;
            border: 2px solid #4a90e2;
        }

        .status-waiting {
            background: rgba(150, 150, 150, 0.2);
            color: #999;
            border: 2px solid #666;
        }

      
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 10px 18px;
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

        .btn-view {
            background: rgba(74, 144, 226, 0.2);
            color: #4a90e2;
            border: 2px solid #4a90e2;
        }

        .btn-view:hover {
            background: #4a90e2;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(74, 144, 226, 0.3);
        }

        .btn-approve {
            background: rgba(0, 255, 136, 0.2);
            color: #00ff88;
            border: 2px solid #00ff88;
            animation: pulse-approve 2s ease-in-out infinite;
        }

        @keyframes pulse-approve {
            0%, 100% { box-shadow: 0 0 10px rgba(0, 255, 136, 0.3); }
            50% { box-shadow: 0 0 20px rgba(0, 255, 136, 0.6); }
        }

        .btn-approve:hover {
            background: #00ff88;
            color: #000;
            transform: translateY(-2px);
        }

        .btn-add-invoice {
            background: rgba(255, 140, 0, 0.2);
            color: #ff8c00;
            border: 2px solid #ff8c00;
        }

        .btn-add-invoice:hover {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 140, 0, 0.3);
        }

        .btn-disabled {
            background: rgba(100, 100, 100, 0.2);
            color: #666;
            border: 2px solid #444;
            cursor: not-allowed;
            opacity: 0.6;
        }

       
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-icon {
            font-size: 4rem;
            color: rgba(255, 140, 0, 0.3);
            margin-bottom: 20px;
        }

        .empty-state h3 {
            color: #ff8c00;
            margin-bottom: 10px;
            font-size: 1.5rem;
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
            padding: 20px 25px;
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

        
        .section-divider {
            background: linear-gradient(90deg, transparent, rgba(255, 140, 0, 0.5), transparent);
            height: 2px;
            margin: 30px 0;
        }

        .section-label {
            background: rgba(255, 140, 0, 0.1);
            padding: 12px 20px;
            border-left: 4px solid;
            font-weight: 600;
            font-size: 1.1rem;
            margin-top: 20px;
        }

        .label-pending {
            border-left-color: #ffc107;
            color: #ffc107;
        }

        .label-approved {
            border-left-color: #00ff88;
            color: #00ff88;
        }

        .label-returned {
            border-left-color: #4a90e2;
            color: #4a90e2;
        }

        
        @media (max-width: 768px) {
            .container { padding: 15px; }
            .header { font-size: 2rem; }
            .stats-container { grid-template-columns: 1fr; }
            table { font-size: 0.9rem; }
            th, td { padding: 12px 8px; }
            .action-buttons { flex-direction: column; }
            .action-btn { width: 100%; justify-content: center; }
        }
    </style>
</head>

<body>
    <div class="bg-animation">
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
        <div class="floating-shapes"></div>
    </div>

    <!-- Loading Animation -->
    <div class="loading" id="loading">
        <div class="spinner"></div>
    </div>

    <!-- Toast Notification -->
    <div id="toast" class="toast">
        <div id="toast-message"></div>
    </div>

    <div class="container">
        <div class="header">
            <i class="fas fa-building"></i>
            ThanaChok Place - จัดการการจอง
        </div>

        <div class="top-bar">
            <div class="welcome-message">
                <i class="fas fa-user-shield"></i>
                Manager Dashboard
                <span class="admin-badge">Admin</span>
            </div>
        </div>

        <div class="nav">
            <a href="OwnerHome">
                <i class="fas fa-home"></i>
                หน้าหลัก
            </a>
            <a href="AddRoom">
                <i class="fas fa-plus-circle"></i>
                เพิ่มห้องพัก
            </a>
            <a href="OViewReserve" class="active">
                <i class="fas fa-chart-bar"></i>
                ดูรายการจอง
            </a>
        </div>

        <a href="OwnerHome" class="back-btn">
            <i class="fas fa-arrow-left"></i> 
            กลับหน้าหลัก
        </a>

        <!-- สถิติการจอง -->
        <div class="stats-container">
            <div class="stat-card stat-total">
                <div class="stat-icon">
                    <i class="fas fa-clipboard-list"></i>
                </div>
                <div class="stat-number">
                    <c:set var="totalReservations" value="${rentList.size()}" />
                    ${totalReservations}
                </div>
                <div class="stat-label">การจองทั้งหมด</div>
            </div>

            <div class="stat-card stat-pending">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-number">
                    <c:set var="pendingCount" value="0" />
                    <c:forEach var="rent" items="${rentList}">
                        <c:if test="${rent.rentalDeposit.status == 'รอดำเนินการ'}">
                            <c:set var="pendingCount" value="${pendingCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${pendingCount}
                </div>
                <div class="stat-label">รอการอนุมัติ</div>
            </div>

            <div class="stat-card stat-approved">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-number">
                    <c:set var="approvedCount" value="0" />
                    <c:forEach var="rent" items="${rentList}">
                        <c:if test="${rent.rentalDeposit.status == 'เสร็จสมบูรณ์'}">
                            <c:set var="approvedCount" value="${approvedCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${approvedCount}
                </div>
                <div class="stat-label">อนุมัติแล้ว</div>
            </div>

            <div class="stat-card stat-returned">
                <div class="stat-icon">
                    <i class="fas fa-home"></i>
                </div>
                <div class="stat-number">
                    <c:set var="returnedCount" value="0" />
                    <c:forEach var="rent" items="${rentList}">
                        <c:if test="${rent.rentalDeposit.status == 'คืนห้องแล้ว'}">
                            <c:set var="returnedCount" value="${returnedCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${returnedCount}
                </div>
                <div class="stat-label">คืนห้องแล้ว</div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-header">
                <h2>
                    <i class="fas fa-list-alt"></i> 
                    รายการการจองทั้งหมด
                </h2>
            </div>
            
            <c:choose>
                <c:when test="${empty rentList}">
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                        <h3>ไม่มีรายการจอง</h3>
                        <p>ยังไม่มีการจองห้องพักในระบบ</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-door-open"></i> เลขห้อง</th>
                                <th><i class="fas fa-user"></i> ชื่อผู้จอง</th>
                                <th><i class="fas fa-money-bill-wave"></i> ราคาห้อง</th>
                                <th><i class="fas fa-calendar"></i> วันที่จอง</th>
                                <th><i class="fas fa-tags"></i> สถานะค่ามัดจำ</th>
                                <th><i class="fas fa-cogs"></i> การจัดการ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- แยกข้อมูลออกเป็น 3 กลุ่ม -->
                            <c:set var="hasPending" value="false" />
                            <c:set var="hasApproved" value="false" />
                            <c:set var="hasReturned" value="false" />
                            
                            <!-- ตรวจสอบว่ามีข้อมูลในแต่ละกลุ่มหรือไม่ -->
                            <c:forEach var="rent" items="${rentList}">
                                <c:if test="${rent.rentalDeposit.status == 'รอดำเนินการ'}">
                                    <c:set var="hasPending" value="true" />
                                </c:if>
                                <c:if test="${rent.rentalDeposit.status == 'เสร็จสมบูรณ์'}">
                                    <c:set var="hasApproved" value="true" />
                                </c:if>
                                <c:if test="${rent.rentalDeposit.status == 'คืนห้องแล้ว'}">
                                    <c:set var="hasReturned" value="true" />
                                </c:if>
                            </c:forEach>

                            <!-- กลุ่ม 1: รอการอนุมัติ (ด้านบน) -->
                            <c:if test="${hasPending}">
                                <tr>
                                    <td colspan="6" class="section-label label-pending">
                                        <i class="fas fa-clock"></i> 
                                        รอการอนุมัติ (${pendingCount} รายการ)
                                    </td>
                                </tr>
                                <c:forEach var="rent" items="${rentList}">
                                    <c:if test="${rent.rentalDeposit.status == 'รอดำเนินการ'}">
                                        <tr>
                                            <td class="room-number">${rent.room.roomNumber}</td>
                                            <td class="member-name">${rent.member.firstName} ${rent.member.lastName}</td>
                                            <td class="price">฿${rent.room.roomPrice}</td>
                                            <td>
                                                <i class="fas fa-calendar-alt"></i>
                                                <fmt:formatDate value="${rent.rentDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <span class="status-badge status-pending">
                                                    <i class="fas fa-clock"></i> รอการอนุมัติ
                                                </span>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <form action="ViewReservationDetail" method="get" style="display: inline;">
                                                        <input type="hidden" name="rentId" value="${rent.rentID}" />
                                                        <button type="submit" class="action-btn btn-view">
                                                            <i class="fas fa-eye"></i>
                                                            ดูรายละเอียด
                                                        </button>
                                                    </form>
                                                    <form action="ConfirmRentalDeposit" method="post" style="display: inline;">
                                                        <input type="hidden" name="depositId" value="${rent.rentalDeposit.depositID}" />
                                                        <button type="submit" class="action-btn btn-approve" 
                                                                onclick="return confirmApproval('${rent.room.roomNumber}', '${rent.member.firstName} ${rent.member.lastName}')">
                                                            <i class="fas fa-check"></i>
                                                            อนุมัติ
                                                        </button>
                                                    </form>
                                                    <form action="ManagerReturnRoom" method="post" style="display: inline;">
            <input type="hidden" name="rentId" value="${rent.rentID}" />
            <input type="hidden" name="roomNumber" value="${rent.room.roomNumber}" />
            <input type="hidden" name="status" value="รอดำเนินการ" />
            <button type="submit" class="action-btn btn-return" 
                    onclick="return confirmReturn('${rent.room.roomNumber}', '${rent.member.firstName} ${rent.member.lastName}', 'รอดำเนินการ')">
                <i class="fas fa-times-circle"></i>
                ยกเลิกการจอง
            </button>
        </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:if>

                            <!-- กลุ่ม 2: อนุมัติแล้ว (ตรงกลาง) -->
                            <c:if test="${hasApproved}">
                                <tr>
                                    <td colspan="6" class="section-label label-approved">
                                        <i class="fas fa-check-circle"></i> 
                                        อนุมัติแล้ว (${approvedCount} รายการ)
                                    </td>
                                </tr>
                                <c:forEach var="rent" items="${rentList}">
                                    <c:if test="${rent.rentalDeposit.status == 'เสร็จสมบูรณ์'}">
                                        <tr>
                                            <td class="room-number">${rent.room.roomNumber}</td>
                                            <td class="member-name">${rent.member.firstName} ${rent.member.lastName}</td>
                                            <td class="price">฿${rent.room.roomPrice}</td>
                                            <td>
                                                <i class="fas fa-calendar-alt"></i>
                                                <fmt:formatDate value="${rent.rentDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <span class="status-badge status-approved">
                                                    <i class="fas fa-check-circle"></i> เสร็จสมบูรณ์
                                                </span>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <form action="ViewReservationDetail" method="get" style="display: inline;">
                                                        <input type="hidden" name="rentId" value="${rent.rentID}" />
                                                        <button type="submit" class="action-btn btn-view">
                                                            <i class="fas fa-eye"></i>
                                                            ดูรายละเอียด
                                                        </button>
                                                    </form>
                                                    <c:if test="${rent.room.roomStatus == 'ไม่ว่าง'}">
                                                        <a href="ManagerAddInvoice?roomID=${rent.room.roomID}" class="action-btn btn-add-invoice">
                                                            <i class="fas fa-plus-circle"></i>
                                                            เพิ่มบิล
                                                        </a>
                                                    </c:if>
                                                    <form action="ManagerReturnRoom" method="post" style="display: inline;">
            <input type="hidden" name="rentId" value="${rent.rentID}" />
            <input type="hidden" name="roomNumber" value="${rent.room.roomNumber}" />
            <input type="hidden" name="status" value="เสร็จสมบูรณ์" />
            <button type="submit" class="action-btn btn-return" 
                    onclick="return confirmReturn('${rent.room.roomNumber}', '${rent.member.firstName} ${rent.member.lastName}', 'เสร็จสมบูรณ์')">
                <i class="fas fa-door-open"></i>
                คืนห้อง
            </button>
        </form>
                                                </div>
                                             </form>   
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:if>

                            <!-- กลุ่ม 3: คืนห้องแล้ว (ด้านล่าง) -->
                            <c:if test="${hasReturned}">
                                <tr>
                                    <td colspan="6" class="section-label label-returned">
                                        <i class="fas fa-home"></i> 
                                        คืนห้องแล้ว (${returnedCount} รายการ)
                                    </td>
                                </tr>
                                <c:forEach var="rent" items="${rentList}">
                                    <c:if test="${rent.rentalDeposit.status == 'คืนห้องแล้ว'}">
                                        <tr>
                                            <td class="room-number">${rent.room.roomNumber}</td>
                                            <td class="member-name">${rent.member.firstName} ${rent.member.lastName}</td>
                                            <td class="price">฿${rent.room.roomPrice}</td>
                                            <td>
                                                <i class="fas fa-calendar-alt"></i>
                                                <fmt:formatDate value="${rent.rentDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <span class="status-badge status-returned">
                                                    <i class="fas fa-home"></i> คืนห้องแล้ว
                                                </span>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <form action="ViewReservationDetail" method="get" style="display: inline;">
                                                        <input type="hidden" name="rentId" value="${rent.rentID}" />
                                                        <button type="submit" class="action-btn btn-view">
                                                            <i class="fas fa-eye"></i>
                                                            ดูรายละเอียด
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Toast notification function
        function showToast(message, type = 'success') {
            const toast = document.getElementById('toast');
            const toastMessage = document.getElementById('toast-message');
            
            toastMessage.textContent = message;
            toast.className = `toast ${type}`;
            toast.style.display = 'block';
            
            setTimeout(() => {
                toast.style.display = 'none';
            }, 5000);
        }

        // Confirmation for approval
        function confirmApproval(roomNumber, memberName) {
            const message = `คุณต้องการอนุมัติการจองห้อง ${roomNumber}\nของคุณ ${memberName} ใช่หรือไม่?\n\nหลังจากอนุมัติแล้ว:\n✓ สามารถเพิ่มบิลให้ห้องนี้ได้\n✓ ผู้เช่าสามารถเข้าพักได้\n✓ ไม่สามารถยกเลิกได้`;
            
            return confirm(message);
        }

        // Loading animation
        function showLoading() {
            document.getElementById('loading').style.display = 'flex';
        }

        // Add loading to forms
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function() {
                showLoading();
            });
        });

        // Page load animations
        window.addEventListener('load', function() {
            // Hide loading after page loads
            setTimeout(() => {
                document.getElementById('loading').style.display = 'none';
            }, 1000);

            // Fade in animation
            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            
            setTimeout(function() {
                document.body.style.opacity = '1';
            }, 100);
        });

        // Set active navigation
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.nav a');
        
        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === 'OViewReserve' && 
                currentPath.includes('OViewReserve')) {
                link.classList.add('active');
            }
        });

        // Add hover effects to table rows
        document.querySelectorAll('tbody tr').forEach(row => {
            // Skip section label rows
            if (!row.querySelector('.section-label')) {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.02)';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1)';
                });
            }
        });

        // Auto refresh every 2 minutes to check for new reservations
        setInterval(() => {
            if (document.visibilityState === 'visible') {
                window.location.reload();
            }
        }, 120000);

        // Network status monitoring
        window.addEventListener('online', function() {
            showToast('เชื่อมต่อ อินเทอร์เน็ตแล้ว', 'success');
        });

        window.addEventListener('offline', function() {
            showToast('ไม่มีการเชื่อมต่ออินเทอร์เน็ต', 'error');
        });

        // Show success/error messages
        <c:if test="${not empty message}">
            setTimeout(() => {
                showToast("${message}", "success");
            }, 500);
        </c:if>

        <c:if test="${not empty error}">
            setTimeout(() => {
                showToast("${error}", "error");
            }, 500);
        </c:if>

        // Confirmation for returning room - Manager สามารถคืนห้องได้เลยโดยไม่มีเงื่อนไข
function confirmReturn(roomNumber, memberName, status) {
    let message = '';
    
    if (status === 'รอดำเนินการ') {
        message = `⚠️ คุณต้องการยกเลิกการจองห้อง ${roomNumber}\n` +
                  `ของคุณ ${memberName} ใช่หรือไม่?\n\n` +
                  `หลังจากยกเลิกแล้ว:\n` +
                  `✓ ห้องจะกลับเป็นสถานะ "ว่าง"\n` +
                  `✓ สามารถให้ผู้อื่นจองได้ใหม่\n` +
                  `✓ ไม่สามารถเรียกคืนได้`;
    } else {
        message = `⚠️ คุณต้องการคืนห้อง ${roomNumber}\n` +
                  `ของคุณ ${memberName} ใช่หรือไม่?\n\n` +
                  `หลังจากคืนห้องแล้ว:\n` +
                  `✓ ห้องจะกลับเป็นสถานะ "ว่าง"\n` +
                  `✓ สามารถให้ผู้อื่นจองได้ใหม่\n` +
                  `✓ ไม่สามารถเรียกคืนได้\n\n` +
                  `📝 หมายเหตุ: Manager สามารถคืนห้องได้ทันที\n` +
                  `    แม้จะยังมีบิลค้างชำระ`;
    }
    
    return confirm(message);
}
    </script>
</body>
</html>