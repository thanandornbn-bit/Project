<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page session="true" %>
<%@ page import="com.springmvc.model.Member" %>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>

<% 
    Member loginMember = (Member) session.getAttribute("loginMember"); 
    if (loginMember == null) {
        response.sendRedirect("Login"); 
        return; 
    }
%>

<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ThanaChok Place - หน้าหลักสมาชิก</title>
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

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }


        .header {
            text-align: center;
            color: #ff8c00;
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            text-shadow: 0 0 20px rgba(255, 140, 0, 0.5);
            position: relative;
            animation: glow 2s ease-in-out infinite;
        }

        @keyframes glow {
            0%, 100% {
                text-shadow: 0 0 20px rgba(255, 140, 0, 0.5),
                             0 0 30px rgba(255, 140, 0, 0.3);
            }
            50% {
                text-shadow: 0 0 30px rgba(255, 140, 0, 0.8),
                             0 0 40px rgba(255, 140, 0, 0.5);
            }
        }

        .header::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(45deg, #ff8c00, #ff6b00);
            border-radius: 2px;
            box-shadow: 0 0 10px rgba(255, 140, 0, 0.5);
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255, 140, 0, 0.1);
            backdrop-filter: blur(10px);
            padding: 15px 25px;
            border-radius: 15px;
            border: 1px solid rgba(255, 140, 0, 0.3);
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .welcome-message {
            color: #fff;
            font-size: 1.2rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-message i {
            font-size: 1.5rem;
            color: #ff8c00;
        }

        .rental-alert {
            background: linear-gradient(45deg, rgba(255, 140, 0, 0.2), rgba(255, 107, 0, 0.2));
            border: 2px solid rgba(255, 140, 0, 0.6);
            color: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            text-align: center;
            display: none;
            backdrop-filter: blur(10px);
            animation: slideDown 0.5s ease;
            box-shadow: 0 5px 20px rgba(255, 140, 0, 0.3);
        }

        .rental-alert.show {
            display: block;
        }

        .rental-alert .alert-icon {
            font-size: 2rem;
            margin-bottom: 15px;
            color: #ff8c00;
        }

        .rental-alert .alert-content {
            font-size: 1.1rem;
            line-height: 1.5;
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

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropbtn {
            background: rgba(255, 140, 0, 0.2);
            color: white;
            padding: 12px 16px;
            font-size: 1rem;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 140, 0, 0.5);
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .dropbtn:hover {
            background: rgba(255, 140, 0, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 140, 0, 0.3);
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            min-width: 200px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.5);
            z-index: 1000;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid rgba(255, 140, 0, 0.3);
        }

        .dropdown-content a {
            color: #fff;
            padding: 15px 20px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .dropdown-content a:hover {
            background: rgba(255, 140, 0, 0.2);
            color: #ff8c00;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .nav {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .nav a {
            color: white;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: 500;
            padding: 12px 25px;
            border-radius: 25px;
            background: rgba(255, 140, 0, 0.15);
            border: 1px solid rgba(255, 140, 0, 0.3);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav a:hover {
            background: rgba(255, 140, 0, 0.25);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 140, 0, 0.3);
        }

        .nav a.active {
            background: linear-gradient(45deg, #ff8c00, #ff6b00);
            box-shadow: 0 5px 15px rgba(255, 140, 0, 0.4);
        }

        .logout-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .logout-btn {
            background: linear-gradient(45deg, #ff4444, #cc0000);
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 1rem;
            font-weight: 500;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 5px 15px rgba(255, 68, 68, 0.3);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 68, 68, 0.5);
        }

        .search-form {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5),
                        inset 0 1px 0 rgba(255, 140, 0, 0.1);
            border: 1px solid rgba(255, 140, 0, 0.2);
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .search-form::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, transparent, #ff8c00, transparent);
            animation: scan 3s linear infinite;
        }

        @keyframes scan {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .search-form h3 {
            margin-bottom: 20px;
            color: #ff8c00;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .form-group {
            display: inline-block;
            margin: 0 15px 15px 0;
            vertical-align: top;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #ff8c00;
        }

        .form-group select {
            padding: 12px 20px;
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 10px;
            color: #fff;
            font-size: 1rem;
            min-width: 150px;
            transition: all 0.3s ease;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23ff8c00' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            padding-right: 45px;
        }

        .form-group select option {
            background: #2d2d2d;
            color: #fff;
            padding: 10px;
        }

        .form-group select:focus {
            outline: none;
            border-color: #ff8c00;
            box-shadow: 0 0 20px rgba(255, 140, 0, 0.3);
            background-color: rgba(0, 0, 0, 0.6);
        }

        .search-btn {
            background: linear-gradient(45deg, #ff8c00, #ff6b00);
            color: white;
            border: none;
            padding: 12px 30px;
            font-size: 1rem;
            font-weight: 500;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-left: 10px;
            position: relative;
            overflow: hidden;
        }

        .search-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .search-btn:hover:before {
            left: 100%;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 140, 0, 0.4);
        }

        .table-container {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 140, 0, 0.2);
            margin-top: 20px;
        }

        .table-header {
            background: linear-gradient(45deg, #ff8c00, #ff6b00);
            color: white;
            padding: 20px;
            text-align: center;
        }

        .table-header h2 {
            font-size: 1.5rem;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead th {
            background: rgba(255, 140, 0, 0.1);
            color: #ff8c00;
            font-weight: 600;
            padding: 20px 15px;
            text-align: center;
            border-bottom: 2px solid rgba(255, 140, 0, 0.3);
            position: sticky;
            top: 0;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:nth-child(even) {
            background-color: rgba(255, 140, 0, 0.05);
        }

        tbody tr:hover {
            background-color: rgba(255, 140, 0, 0.15);
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        tbody td {
            padding: 20px 15px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
            font-size: 1rem;
            color: #fff;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-available {
            background: linear-gradient(45deg, #00ff88, #00cc6f);
            color: #000;
        }

        .status-occupied {
            background: linear-gradient(45deg, #ff4444, #cc0000);
            color: white;
        }

        .view-btn {
            background: linear-gradient(45deg, #ff8c00, #ff6b00);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .view-btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 140, 0, 0.4);
        }

        .view-btn:disabled {
            background: #555 !important;
            cursor: not-allowed !important;
            transform: none !important;
            box-shadow: none !important;
            opacity: 0.6;
        }

        .view-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .view-btn:hover:not(:disabled):before {
            left: 100%;
        }

   
        .price {
            font-weight: 600;
            color: #ff8c00;
            font-size: 1.1rem;
        }


        .room-number {
            font-weight: 600;
            font-size: 1.1rem;
            color: #ff8c00;
        }


        .room-type {
            color: #ccc;
            font-weight: 500;
        }


        .loading {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.9);
            z-index: 2000;
            justify-content: center;
            align-items: center;
        }

        .spinner {
            width: 60px;
            height: 60px;
            border: 6px solid rgba(255, 140, 0, 0.2);
            border-top: 6px solid #ff8c00;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }


        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: rgba(255, 140, 0, 0.3);
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #ff8c00;
        }

        .empty-state p {
            font-size: 1.1rem;
            color: #999;
        }

        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.5);
            border: 1px solid rgba(255, 140, 0, 0.5);
            z-index: 1001;
            display: none;
            animation: slideInRight 0.3s ease;
            color: #fff;
        }

        .toast.success {
            border-left: 4px solid #00ff88;
        }

        .toast.error {
            border-left: 4px solid #ff4444;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
        }

        .modal-content {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            margin: 15% auto;
            padding: 30px;
            border: 2px solid #ff4444;
            border-radius: 15px;
            width: 80%;
            max-width: 500px;
            position: relative;
            box-shadow: 0 0 30px rgba(255, 68, 68, 0.3);
            text-align: center;
            animation: modalSlideDown 0.5s ease-out;
        }

        @keyframes modalSlideDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            margin-bottom: 20px;
        }

        .modal-header i {
            font-size: 3rem;
            color: #ff4444;
            margin-bottom: 15px;
        }

        .modal-body {
            color: #fff;
            font-size: 1.2rem;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .modal-footer .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            background: linear-gradient(45deg, #ff4444, #cc0000);
            color: white;
        }

        .modal-footer .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 68, 68, 0.4);
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }


        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .header {
                font-size: 2rem;
            }
            
            .top-bar {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .nav {
                flex-direction: column;
                gap: 10px;
                align-items: center;
            }
            
            .nav a {
                width: 100%;
                max-width: 250px;
                justify-content: center;
            }
            
            .form-group {
                display: block;
                margin: 15px 0;
            }
            
            .form-group select {
                width: 100%;
                min-width: auto;
            }
            
            .search-btn {
                width: 100%;
                margin: 10px 0 0 0;
            }
            
            table {
                font-size: 0.9rem;
            }
            
            tbody td {
                padding: 15px 8px;
            }
            
            .dropdown {
                position: static;
            }
            
            .dropdown-content {
                position: static;
                display: block;
                box-shadow: none;
                background: rgba(255, 140, 0, 0.1);
                border: 1px solid rgba(255, 140, 0, 0.2);
                margin-top: 10px;
            }

            .rental-alert {
                padding: 15px;
            }

            .rental-alert .alert-content {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Loading Animation -->
    <div class="loading" id="loading">
        <div class="spinner"></div>
    </div>

    <!-- Modal Alert -->
    <div id="alertModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <i class="fas fa-exclamation-triangle"></i>
                <h2 style="color: #ff4444;">แจ้งเตือน</h2>
            </div>
            <div class="modal-body">
                <p id="modalMessage"></p>
            </div>
            <div class="modal-footer">
                <button class="btn" onclick="closeModal()">
                    <i class="fas fa-times"></i>
                    ปิด
                </button>
            </div>
        </div>
    </div>

    <!-- Toast Notification -->
    <div id="toast" class="toast">
        <div id="toast-message"></div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="header">
            <i class="fas fa-building"></i>
            ThanaChok Place
        </div>

        <!-- Active Rental Alert -->
        <div id="activeRentalAlert" class="rental-alert">
            <div class="alert-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <div id="activeRentalMessage" class="alert-content">
                กำลังตรวจสอบสถานะการจองของคุณ...
            </div>
        </div>

        <div class="top-bar">
            <div class="welcome-message">
                <i class="fas fa-user-circle"></i>
                สวัสดี, ${loginMember.firstName} ${loginMember.lastName}!
            </div>

            <div class="dropdown">
                <button class="dropbtn">
                    <i class="fas fa-user-cog"></i>
                    จัดการบัญชี
                    <i class="fas fa-chevron-down"></i>
                </button>
                <div class="dropdown-content">
                    <a href="Editprofile">
                        <i class="fas fa-edit"></i>
                        แก้ไขข้อมูลส่วนตัว
                    </a>
                </div>
            </div>
        </div>

        <div class="nav">
    <a href="Homesucess" class="active">
        <i class="fas fa-home"></i>
        หน้าหลัก
    </a>
    <a href="YourRoom">
        <i class="fas fa-door-open"></i>
        ห้องของฉัน
    </a>
    <a href="Listinvoice">
        <i class="fas fa-file-invoice-dollar"></i>
        บิลค่าใช้จ่าย
    </a>
    <a href="Record">
        <i class="fas fa-history"></i>
        ประวัติการจอง
    </a>
</div>

        <div class="logout-container">
            <form action="Logout" method="post" style="display: inline;">
                <button type="submit" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    ออกจากระบบ
                </button>
            </form>
        </div>

        <div class="search-form">
            <h3>
                <i class="fas fa-search"></i> 
                ค้นหาห้องพัก
            </h3>
            <form method="get" action="Homesucess" id="searchForm">
                <div class="form-group">
                    <label for="floor">ชั้น:</label>
                    <select name="floor" id="floor">
                        <option value="">ทั้งหมด</option>
                        <c:forEach var="i" begin="1" end="5">
                            <option value="${i}" ${param.floor == i ? 'selected' : ''}>ชั้น ${i}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="status">สถานะ:</label>
                    <select name="status" id="status">
                        <option value="">ทั้งหมด</option>
                        <option value="ว่าง" ${param.status == 'ว่าง' ? 'selected' : ''}>ว่าง</option>
                        <option value="ไม่ว่าง" ${param.status == 'ไม่ว่าง' ? 'selected' : ''}>ไม่ว่าง</option>
                    </select>
                </div>

                <button type="submit" class="search-btn">
                    <i class="fas fa-search"></i>
                    ค้นหา
                </button>
            </form>
        </div>

        <div class="table-container">
            <div class="table-header">
                <h2>
                    <i class="fas fa-list"></i> 
                    รายการห้องพัก
                </h2>
            </div>
            
            <c:choose>
                <c:when test="${empty roomList}">
                    <div class="empty-state">
                        <i class="fas fa-search"></i>
                        <h3>ไม่พบห้องพัก</h3>
                        <p>ลองเปลี่ยนเงื่อนไขการค้นหาหรือรีเฟรชหน้าใหม่</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-door-open"></i> หมายเลขห้อง</th>
                                <th><i class="fas fa-home"></i> ประเภทห้อง</th>
                                <th><i class="fas fa-money-bill-wave"></i> ราคา</th>
                                <th><i class="fas fa-info-circle"></i> สถานะ</th>
                                <th><i class="fas fa-cogs"></i> จัดการ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Hidden fields for authentication -->
                            <input type="hidden" id="isLoggedIn" value="${not empty loginMember}">
                            
                            <c:forEach var="room" items="${roomList}">
                                <tr>
                                    <td class="room-number">${room.roomNumber}</td>
                                    <td class="room-type">${room.roomtype}</td>
                                    <td class="price">฿${room.roomPrice}</td>
                                    <td>
                                        <span class="status-badge ${room.roomStatus == 'ว่าง' ? 'status-available' : 'status-occupied'}">
                                            <i class="fas ${room.roomStatus == 'ว่าง' ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                            ${room.roomStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <button 
                                            class="view-btn" 
                                            data-room-id="${room.roomID}"
                                            data-room-status="${room.roomStatus}"
                                            data-room-number="${room.roomNumber}"
                                            onclick="handleViewRoom(this)"
                                        >
                                            <i class="fas fa-eye"></i>
                                            ดูรายละเอียด
                                        </button>
                                        <button 
                                            class="view-btn" 
                                            style="margin-left: 10px; background: linear-gradient(45deg, #00ff88, #00cc6f);"
                                            data-room-id="${room.roomID}"
                                            data-room-status="${room.roomStatus}"
                                            data-room-number="${room.roomNumber}"
                                            onclick="handleViewRoom(this)"
                                        >
                                            <i class="fas fa-calendar-check"></i>
                                            จองห้องพัก
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
    let userActiveRentalData = null;
    let isCheckingRental = false;
    
    // ข้อมูลเริ่มต้นจาก server
    const serverActiveRentalCount = ${not empty activeRentalCount ? activeRentalCount : 0};

    async function handleReserve(button) {
        // ดึงข้อมูลจาก data attributes ของปุ่ม
        const roomID = button.getAttribute('data-room-id');
        const roomStatus = button.getAttribute('data-room-status');
        const roomNumber = button.getAttribute('data-room-number');
        
        // ตรวจสอบการล็อกอิน
        const isLoggedIn = document.getElementById('isLoggedIn').value === 'true';
        if (!isLoggedIn) {
            showToast("กรุณาเข้าสู่ระบบก่อนทำการจองห้องพัก", "error");
            window.location.href = "Login";
            return;
        }

        // ตรวจสอบสถานะห้อง
        if (roomStatus !== "ว่าง") {
            showToast(`ห้อง ${roomNumber} ไม่ว่าง ไม่สามารถจองได้`, "error");
            return;
        }

        const loading = document.getElementById("loading");
        loading.classList.add("active");

        try {
            // ตรวจสอบการจองที่มีอยู่
            const response = await fetch('checkActiveRental');
            const rentalData = await response.json();
            
            if (rentalData.hasActiveRental) {
                const roomList = rentalData.activeRooms ? 
                    rentalData.activeRooms.join(', ') : 'ห้องที่คุณจองไว้';
                showToast(`คุณมีการจองห้อง ${roomList} อยู่แล้ว กรุณาคืนห้องเก่าก่อนจองห้องใหม่`, "error");
                loading.classList.remove("active");
                return;
            }

            // ไปยังหน้า Payment พร้อมส่ง room ID
            window.location.href = `Payment?id=${roomID}`;
        } catch (error) {
            console.error("Error:", error);
            showToast("เกิดข้อผิดพลาดในการจองห้อง", "error");
            loading.classList.remove("active");
        }
    }
    
    // ฟังก์ชันแสดง Toast
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

    // Modal functions
    function showModal(message) {
        document.getElementById('modalMessage').innerHTML = message;
        document.getElementById('alertModal').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    function closeModal() {
        document.getElementById('alertModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    }

    // ตรวจสอบการจองที่ active ของผู้ใช้
    function checkUserActiveRentals() {
        if (isCheckingRental) return;
        
        isCheckingRental = true;
        
        fetch('checkActiveRental')
            .then(response => response.json())
            .then(data => {
                userActiveRentalData = data;
                updateRentalAlert(data);
                updateAllBookingButtons(data);
            })
            .catch(error => {
                console.error('Error checking active rentals:', error);
                if (serverActiveRentalCount > 0) {
                    userActiveRentalData = {
                        hasActiveRental: true,
                        activeRentalCount: serverActiveRentalCount
                    };
                    updateAllBookingButtons(userActiveRentalData);
                }
            })
            .finally(() => {
                isCheckingRental = false;
            });
    }

    // อัปเดต Alert สำหรับการจองที่ active
    function updateRentalAlert(data) {
        const alertDiv = document.getElementById('activeRentalAlert');
        const messageDiv = document.getElementById('activeRentalMessage');
        
        if (data.hasActiveRental && data.activeRentalCount > 0) {
            const roomList = data.activeRooms ? data.activeRooms.join(', ') : '';
            messageDiv.innerHTML = `
                <strong>⚠️ คุณมีการจองห้องอยู่แล้ว ${data.activeRentalCount} ห้อง</strong><br>
                ห้อง: <strong>${roomList}</strong><br>
                <small><i class="fas fa-info-circle"></i> กรุณาคืนห้องเก่าในหน้า "ประวัติการจอง" ก่อนจองห้องใหม่</small>
            `;
            alertDiv.classList.add('show');
        } else {
            alertDiv.classList.remove('show');
        }
    }

    // อัปเดตปุ่มจองทั้งหมดตามสถานะการจอง
    function updateAllBookingButtons(data) {
        const viewButtons = document.querySelectorAll('.view-btn');
        const hasActiveRental = data.hasActiveRental && data.activeRentalCount > 0;
        
        viewButtons.forEach(button => {
            const roomStatus = button.getAttribute('data-room-status');
            const isBookButton = button.innerHTML.includes('จองห้องพัก');
            
            if (roomStatus !== 'ว่าง') {
                if (isBookButton) {
                    button.style.display = 'none'; // ซ่อนปุ่มจองถ้าห้องไม่ว่าง
                } else {
                    button.innerHTML = '<i class="fas fa-times-circle"></i> ห้องไม่ว่าง';
                    button.title = 'ห้องนี้ไม่ว่างแล้ว';
                    button.style.background = '#555';
                }
                return;
            }
            
            // สำหรับห้องที่ว่าง ให้แสดงปุ่มปกติ
            if (isBookButton) {
                button.innerHTML = '<i class="fas fa-calendar-check"></i> จองห้องพัก';
                button.style.background = 'linear-gradient(45deg, #00ff88, #00cc6f)';
            } else {
                button.innerHTML = '<i class="fas fa-eye"></i> ดูรายละเอียด';
                button.style.background = 'linear-gradient(45deg, #ff8c00, #ff6b00)';
            }
            button.title = 'คลิกเพื่อดูรายละเอียดและจองห้อง';
        });
    }

    // ฟังก์ชันจัดการคลิกปุ่มดูห้อง
    function handleViewRoom(button) {
        const roomID = button.getAttribute('data-room-id');
        const roomStatus = button.getAttribute('data-room-status');
        const roomNumber = button.getAttribute('data-room-number');
        const isBookButton = button.innerHTML.includes('จองห้องพัก');

        // ตรวจสอบสถานะห้อง
        if (roomStatus !== "ว่าง") {
            showToast(`❌ ห้อง ${roomNumber} ไม่ว่างแล้ว`, "error");
            return false;
        }

        // ตรวจสอบการจองที่ active
        if (userActiveRentalData && userActiveRentalData.hasActiveRental) {
            const roomList = userActiveRentalData.activeRooms ? 
                userActiveRentalData.activeRooms.join(', ') : 'ห้องที่คุณจองไว้';
            
            let modalMessage = '';
            if (isBookButton) {
                modalMessage = `
                    <div style="text-align: center;">
                        <i class="fas fa-exclamation-circle" style="font-size: 3rem; color: #ff4444; margin-bottom: 20px;"></i>
                        <h3 style="color: #ff8c00; margin-bottom: 15px;">ไม่สามารถจองห้องได้</h3>
                        <div style="margin: 15px 0; padding: 10px; background: rgba(255, 68, 68, 0.1); border-radius: 8px;">
                            <p>คุณมีการจองห้อง <strong style="color: #ff8c00;">${rent.roomNumber}</strong> อยู่แล้ว</p>
                        </div>
                        <p style="margin-top: 15px; color: #ff4444;">
                            กรุณาคืนห้องเก่าในหน้า <a href="YourRoom" style="color: #ff8c00; text-decoration: none; font-weight: bold;">"ห้องของฉัน"</a> ก่อนจองห้องใหม่
                        </p>
                    </div>
                `;
            } else {
                modalMessage = `
                    <div style="text-align: center;">
                        <i class="fas fa-info-circle" style="font-size: 3rem; color: #ff8c00; margin-bottom: 20px;"></i>
                        <h3 style="color: #ff8c00; margin-bottom: 15px;">ไม่สามารถดูรายละเอียดห้องได้</h3>
                        <div style="margin: 15px 0; padding: 10px; background: rgba(255, 140, 0, 0.1); border-radius: 8px;">
                            <p>เนื่องจากคุณมีการจองห้อง <strong style="color: #ff8c00;">${rent.roomNumber}</strong> อยู่แล้ว</p>
                        </div>
                        <p style="margin-top: 15px;">
                            กรุณาจัดการห้องที่จองไว้ในหน้า <a href="YourRoom" style="color: #ff8c00; text-decoration: none; font-weight: bold;">"ห้องของฉัน"</a> ก่อน
                        </p>
                    </div>
                `;
            }
            showModal(modalMessage);
            return false;
        }

        // ถ้าไม่มีการจองอยู่ นำทางไปยังหน้าที่เหมาะสม
        if (isBookButton) {
            window.location.href = 'Payment?id=' + roomID;
        } else {
            document.getElementById('loading').style.display = 'flex';
            window.location.href = 'roomDetail?id=' + roomID;
        }
        return false;
    }

    // ตรวจสอบสถานะเริ่มต้นของปุ่มเมื่อโหลดหน้า
    function initializeButtons() {
        if (serverActiveRentalCount > 0) {
            userActiveRentalData = {
                hasActiveRental: true,
                activeRentalCount: serverActiveRentalCount
            };
            
            const alertDiv = document.getElementById('activeRentalAlert');
            const messageDiv = document.getElementById('activeRentalMessage');
            messageDiv.innerHTML = `
                <strong>⚠️ คุณมีการจองห้องอยู่แล้ว ${serverActiveRentalCount} ห้อง</strong><br>
                
            `;
            alertDiv.classList.add('show');
        }
        
        const viewButtons = document.querySelectorAll('.view-btn');
        
        viewButtons.forEach(button => {
            const roomStatus = button.getAttribute('data-room-status');
            const isBookButton = button.innerHTML.includes('จองห้องพัก');
            
            if (roomStatus !== 'ว่าง') {
                if (isBookButton) {
                    button.style.display = 'none'; // ซ่อนปุ่มจองถ้าห้องไม่ว่าง
                } else {
                    button.innerHTML = '<i class="fas fa-times-circle"></i> ห้องไม่ว่าง';
                    button.title = 'ห้องนี้ไม่ว่างแล้ว';
                    button.style.background = '#555';
                }
            } else {
                // สำหรับห้องที่ว่าง ให้แสดงปุ่มปกติ
                if (isBookButton) {
                    button.innerHTML = '<i class="fas fa-calendar-check"></i> จองห้องพัก';
                    button.style.background = 'linear-gradient(45deg, #00ff88, #00cc6f)';
                } else {
                    button.innerHTML = '<i class="fas fa-eye"></i> ดูรายละเอียด';
                    button.style.background = 'linear-gradient(45deg, #ff8c00, #ff6b00)';
                }
                button.title = 'คลิกเพื่อดูรายละเอียดและจองห้อง';
            }
        });
    }

    // เมื่อโหลดหน้า
    window.addEventListener('load', function() {
        initializeButtons();
        
        setTimeout(() => {
            checkUserActiveRentals();
        }, 500);
        
        <c:if test="${not empty message}">
            showToast("${message}", "success");
        </c:if>

        <c:if test="${not empty errorMessage}">
            showToast("${errorMessage}", "error");
        </c:if>
        
        document.body.style.opacity = '0';
        document.body.style.transition = 'opacity 0.5s ease-in-out';
        
        setTimeout(function() {
            document.body.style.opacity = '1';
            document.getElementById('loading').style.display = 'none';
        }, 100);
    });

    // แสดง loading เมื่อส่งฟอร์ม
    document.getElementById('searchForm').addEventListener('submit', function() {
        document.getElementById('loading').style.display = 'flex';
    });

    // รีเฟรชข้อมูลการจองทุก 30 วินาที
    setInterval(() => {
        if (!isCheckingRental) {
            checkUserActiveRentals();
        }
    }, 30000);

    // ตรวจสอบเมื่อหน้าโฟกัสกลับมา
    document.addEventListener('visibilitychange', function() {
        if (!document.hidden && !isCheckingRental) {
            checkUserActiveRentals();
        }
    });
</script>
</body>
</html>