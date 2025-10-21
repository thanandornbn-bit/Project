<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>รายการคำขอคืนห้อง - ThanaChok Place</title>
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
        }

        .page-header {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            color: white;
            text-align: center;
            padding: 30px 20px;
            box-shadow: 0 4px 20px rgba(255, 140, 0, 0.3);
        }

        .page-header h1 {
            font-size: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .nav {
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(10px);
            padding: 15px;
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .nav a {
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 10px;
            background: rgba(255, 140, 0, 0.1);
            border: 1px solid rgba(255, 140, 0, 0.3);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav a:hover, .nav a.active {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
        }

        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .stat-card {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            border: 2px solid rgba(255, 140, 0, 0.3);
            margin-bottom: 30px;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: bold;
            color: #ff8c00;
        }

        .stat-label {
            color: #999;
            font-size: 1.1rem;
            margin-top: 10px;
        }

        .alert {
            padding: 18px 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success {
            background: linear-gradient(135deg, #00ff88, #00cc6f);
            color: #000;
        }

        .alert-danger {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
        }

        .requests-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 25px;
        }

        .request-card {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 15px;
            overflow: hidden;
            border: 2px solid rgba(255, 140, 0, 0.3);
            transition: all 0.3s ease;
        }

        .request-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(255, 140, 0, 0.3);
        }

        .request-header {
            background: linear-gradient(135deg, #ff8c00, #ff6b00);
            padding: 20px;
        }

        .room-number {
            font-size: 1.8rem;
            font-weight: bold;
        }

        .request-body {
            padding: 25px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
        }

        .info-label {
            color: #999;
        }

        .info-value {
            color: #fff;
            font-weight: 600;
        }

        .actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .btn-approve {
            background: linear-gradient(135deg, #00ff88, #00cc6f);
            color: #000;
        }

        .btn-approve:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 255, 136, 0.5);
        }

        .btn-reject {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
        }

        .btn-reject:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 68, 68, 0.5);
        }

        .no-requests {
            text-align: center;
            padding: 80px 20px;
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 15px;
            border: 1px solid rgba(255, 140, 0, 0.3);
        }

        .no-requests i {
            font-size: 5rem;
            color: #ff8c00;
            margin-bottom: 25px;
            opacity: 0.5;
        }

        .no-requests h3 {
            color: #ff8c00;
            margin-bottom: 15px;
            font-size: 1.8rem;
        }

        .no-requests p {
            color: #999;
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 1.5rem;
            }

            .nav a {
                padding: 10px 16px;
                font-size: 0.9rem;
            }

            .stat-number {
                font-size: 2.5rem;
            }

            .requests-grid {
                grid-template-columns: 1fr;
            }

            .room-number {
                font-size: 1.5rem;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="page-header">
        <h1>
            <i class="fas fa-clipboard-check"></i>
            รายการคำขอคืนห้อง
        </h1>
    </div>

    <div class="nav">
        <a href="OwnerHome"><i class="fas fa-home"></i> หน้าหลัก</a>
        <a href="OViewReserve"><i class="fas fa-list"></i> รายการจอง</a>
        <a href="ListReturnRoom" class="active"><i class="fas fa-clipboard-check"></i> คำขอคืนห้อง</a>
        <a href="AddRoom"><i class="fas fa-plus"></i> เพิ่มห้อง</a>
    </div>

    <div class="container">
        <div class="stat-card">
            <div class="stat-number">${requestCount}</div>
            <div class="stat-label">คำขอรอการอนุมัติ</div>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty returnRequests}">
                <div class="no-requests">
                    <i class="fas fa-clipboard-check"></i>
                    <h3>ไม่มีคำขอคืนห้อง</h3>
                    <p>ไม่มีคำขอคืนห้องที่รอการอนุมัติในขณะนี้</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="requests-grid">
                    <c:forEach var="request" items="${returnRequests}">
                        <div class="request-card">
                            <div class="request-header">
                                <div class="room-number">
                                    <i class="fas fa-door-open"></i>
                                    ห้อง ${request.rent.room.roomNumber}
                                </div>
                            </div>
                            <div class="request-body">
                                <div class="info-row">
                                    <span class="info-label">
                                        <i class="fas fa-user"></i> ผู้เช่า
                                    </span>
                                    <span class="info-value">
                                        ${request.rent.member.firstName} ${request.rent.member.lastName}
                                    </span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">
                                        <i class="fas fa-phone"></i> เบอร์โทร
                                    </span>
                                    <span class="info-value">
                                        ${request.rent.member.phoneNumber}
                                    </span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">
                                        <i class="fas fa-home"></i> ประเภทห้อง
                                    </span>
                                    <span class="info-value">
                                        ${request.rent.room.roomtype}
                                    </span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">
                                        <i class="fas fa-calendar"></i> วันที่เช่า
                                    </span>
                                    <span class="info-value">
                                        <fmt:formatDate value="${request.paymentDate}" pattern="dd/MM/yyyy"/>
                                    </span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">
                                        <i class="fas fa-money-bill-wave"></i> ค่ามัดจำ
                                    </span>
                                    <span class="info-value" style="color: #00ff88;">
                                        ฿<fmt:formatNumber value="${request.totalPrice}" groupingUsed="true"/>
                                    </span>
                                </div>
                                <div class="actions">
                                    <form action="ApproveReturnRoom" method="post" style="flex: 1;">
                                        <input type="hidden" name="rentId" value="${request.rent.rentID}">
                                        <input type="hidden" name="roomNumber" value="${request.rent.room.roomNumber}">
                                        <button type="submit" class="btn btn-approve" 
                                                onclick="return confirm('ยืนยันการอนุมัติคืนห้อง ${request.rent.room.roomNumber}?')">
                                            <i class="fas fa-check"></i> อนุมัติ
                                        </button>
                                    </form>
                                    <form action="RejectReturnRoom" method="post" style="flex: 1;">
                                        <input type="hidden" name="rentId" value="${request.rent.rentID}">
                                        <input type="hidden" name="roomNumber" value="${request.rent.room.roomNumber}">
                                        <button type="submit" class="btn btn-reject"
                                                onclick="return confirm('ยืนยันการปฏิเสธคำขอคืนห้อง ${request.rent.room.roomNumber}?')">
                                            <i class="fas fa-times"></i> ปฏิเสธ
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>