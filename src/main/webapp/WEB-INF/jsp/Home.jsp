<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ThanaChok Place - หน้าแรก</title>
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
            font-size: 3rem;
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

        .login-register {
            text-align: center;
            margin-bottom: 30px;
            background: rgba(255, 140, 0, 0.1);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 15px;
            border: 1px solid rgba(255, 140, 0, 0.3);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .login-register a {
            color: white;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: 500;
            padding: 12px 30px;
            margin: 0 10px;
            border-radius: 25px;
            background: rgba(255, 140, 0, 0.2);
            border: 1px solid rgba(255, 140, 0, 0.5);
            transition: all 0.3s ease;
            display: inline-block;
        }

        .login-register a:hover {
            background: linear-gradient(45deg, #ff8c00, #ff6b00);
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(255, 140, 0, 0.4);
        }

        .separator {
            color: rgba(255, 140, 0, 0.5);
            margin: 0 10px;
            font-weight: 300;
        }

        .search-form {
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 30px;
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
            margin-bottom: 25px;
            color: #ff8c00;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .search-form h3 i {
            font-size: 1.8rem;
        }

        .form-group {
            display: inline-block;
            margin: 0 15px 15px 0;
            vertical-align: top;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #ff8c00;
            font-size: 1rem;
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
            padding: 12px 35px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-left: 10px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(255, 140, 0, 0.3);
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
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 140, 0, 0.5);
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
            padding: 25px;
            text-align: center;
            position: relative;
        }

        .table-header h2 {
            font-size: 1.8rem;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
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
            font-size: 1rem;
        }

        tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
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
            box-shadow: 0 3px 10px rgba(255, 140, 0, 0.3);
        }

        .view-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 140, 0, 0.5);
        }

        .view-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .view-btn:hover:before {
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

        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
            padding: 20px 25px;
            border-radius: 15px;
            border: 1px solid rgba(255, 140, 0, 0.5);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            z-index: 1001;
            display: none;
            animation: slideInRight 0.3s ease;
            color: #fff;
            min-width: 300px;
        }

        .toast.show {
            display: block;
        }

        .toast.success {
            border-left: 4px solid #00ff88;
        }

        .toast.error {
            border-left: 4px solid #ff4444;
        }

        .toast-content {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .toast-icon {
            font-size: 1.5rem;
        }

        .toast.success .toast-icon {
            color: #00ff88;
        }

        .toast.error .toast-icon {
            color: #ff4444;
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
            
            .login-register {
                padding: 15px;
            }

            .login-register a {
                display: block;
                margin: 10px 0;
            }

            .separator {
                display: none;
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
                font-size: 0.85rem;
            }
            
            tbody td {
                padding: 15px 8px;
            }

            .toast {
                right: 10px;
                left: 10px;
                min-width: auto;
            }

            .table-header h2 {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <!-- Loading Animation -->
    <div class="loading" id="loading">
        <div class="spinner"></div>
    </div>

    <!-- Toast Notification -->
    <div id="toast" class="toast">
        <div class="toast-content">
            <i class="toast-icon" id="toastIcon"></i>
            <span id="toastMessage"></span>
        </div>
    </div>

    <div class="container">
        <div class="header">
            <i class="fas fa-building"></i>
            ThanaChok Place
        </div>

        <div class="login-register">
            <a href="Login">
                <i class="fas fa-sign-in-alt"></i>
                เข้าสู่ระบบ
            </a>
            <span class="separator">|</span>
            <a href="Register">
                <i class="fas fa-user-plus"></i>
                สมัครสมาชิก
            </a>
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
                        <c:forEach var="i" begin="1" end="9">
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
                                        <a href="roomDetail?id=${room.roomID}">
                                            <button class="view-btn" onclick="return checkRoomStatus('${room.roomStatus}')">
                                                <i class="fas fa-eye"></i>
                                                ดูรายละเอียด
                                            </button>
                                        </a>
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
        // Toast Notification Function
        function showToast(message, type = 'success') {
            const toast = document.getElementById('toast');
            const toastMessage = document.getElementById('toastMessage');
            const toastIcon = document.getElementById('toastIcon');
            
            toastMessage.textContent = message;
            toast.className = `toast ${type} show`;
            
            if (type === 'success') {
                toastIcon.className = 'toast-icon fas fa-check-circle';
            } else {
                toastIcon.className = 'toast-icon fas fa-exclamation-circle';
            }
            
            setTimeout(() => {
                toast.classList.remove('show');
            }, 4000);
        }

        // Check Room Status
        function checkRoomStatus(status) {
            if (status === 'ไม่ว่าง') {
                showToast('ห้องนี้ไม่ว่าง กรุณาเข้าสู่ระบบเพื่อดูรายละเอียด', 'error');
                return confirm('ห้องนี้ไม่ว่าง คุณต้องการดูรายละเอียดหรือไม่?');
            }
            return true;
        }

        // Show loading animation on form submit
        document.getElementById('searchForm').addEventListener('submit', function() {
            document.getElementById('loading').style.display = 'flex';
        });

        // Handle message from server
        <c:if test="${not empty message}">
            window.addEventListener('load', function() {
                showToast("${message}", "success");
            });
        </c:if>

        // Smooth page load animation
        window.addEventListener('load', function() {
            document.body.style.opacity = '0';
            document.body.style.transition = 'opacity 0.5s ease-in-out';
            
            setTimeout(function() {
                document.body.style.opacity = '1';
                document.getElementById('loading').style.display = 'none';
            }, 100);
        });

        // Prevent form resubmission
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</body>
</html>