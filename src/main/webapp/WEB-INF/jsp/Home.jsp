<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="th">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>ThanaChok Place - หน้าแรก</title>
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                :root {
                    --bg: #FFFFFF;
                    --muted-bg: #F0F7FF;
                    --primary: #5CA9E9;
                    --primary-dark: #4A90E2;
                    --accent: #E3F2FD;
                    --text: #1E3A5F;
                    --muted-text: #5B7A9D;
                    --card-border: #D1E8FF;
                    --hover-bg: #E8F4FF;
                }

                body {
                    font-family: 'Sarabun', system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
                    background: var(--bg);
                    color: var(--text);
                    min-height: 100vh;
                }

                .container {
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

                .login-register {
                    display: flex;
                    gap: 12px;
                }

                .login-register a {
                    font-weight: 600;
                    text-decoration: none;
                    padding: 10px 20px;
                    border-radius: 10px;
                    transition: all 0.3s ease;
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                }

                .login-register a:first-child {
                    color: var(--primary);
                    background: var(--accent);
                    border: 2px solid var(--primary);
                }

                .login-register a:first-child:hover {
                    background: var(--primary);
                    color: white;
                }

                .login-register a:last-child {
                    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                    color: white;
                    box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
                }

                .login-register a:last-child:hover {
                    box-shadow: 0 6px 16px rgba(74, 144, 226, 0.4);
                    transform: translateY(-2px);
                }

                .search-section {
                    background: linear-gradient(135deg, var(--muted-bg) 0%, #E8F4FF 100%);
                    padding: 32px 48px;
                    border-bottom: 1px solid var(--card-border);
                }

                .search-form {
                    max-width: 1200px;
                    margin: 0 auto;
                }

                .search-form h3 {
                    font-size: 1.4rem;
                    color: var(--primary);
                    margin-bottom: 20px;
                    font-weight: 700;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .search-row {
                    display: flex;
                    align-items: flex-end;
                    gap: 20px;
                    flex-wrap: wrap;
                }

                .form-group {
                    display: flex;
                    flex-direction: column;
                    gap: 6px;
                    flex: 1;
                    min-width: 180px;
                }

                .form-group label {
                    color: var(--text);
                    font-weight: 600;
                    font-size: 0.95rem;
                }

                .form-group select {
                    padding: 12px 16px;
                    border-radius: 10px;
                    border: 2px solid var(--card-border);
                    background: white;
                    color: var(--text);
                    font-weight: 600;
                    transition: all 0.3s ease;
                    cursor: pointer;
                    width: 100%;
                }

                .form-group select:focus {
                    outline: none;
                    border-color: var(--primary);
                    box-shadow: 0 0 0 3px rgba(92, 169, 233, 0.1);
                }

                .search-btn {
                    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                    color: white;
                    border: none;
                    padding: 12px 32px;
                    border-radius: 10px;
                    font-weight: 700;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    white-space: nowrap;
                    height: 48px;
                }

                .search-btn:hover {
                    box-shadow: 0 6px 16px rgba(74, 144, 226, 0.4);
                    transform: translateY(-2px);
                }

                .table-container {
                    flex: 1;
                    padding: 28px 48px;
                    background: var(--bg);
                }

                .table-header h2 {
                    color: var(--text);
                    font-size: 1.4rem;
                    margin-bottom: 10px;
                }

                .rooms-grid {
                    display: flex;
                    gap: 20px;
                    align-items: flex-start;
                    overflow-x: auto;
                    padding: 18px 8px;
                    scroll-behavior: smooth;
                }

                .rooms-grid::-webkit-scrollbar {
                    height: 10px;
                }

                .rooms-grid::-webkit-scrollbar-thumb {
                    background: var(--accent);
                    border-radius: 10px;
                }

                .room-card {
                    min-width: 340px;
                    max-width: 380px;
                    background: var(--bg);
                    border-radius: 16px;
                    border: 2px solid var(--card-border);
                    box-shadow: 0 8px 24px rgba(92, 169, 233, 0.12);
                    overflow: hidden;
                    display: flex;
                    flex-direction: column;
                    transition: all 0.3s ease;
                }

                .room-card:hover {
                    transform: translateY(-8px);
                    box-shadow: 0 12px 32px rgba(92, 169, 233, 0.2);
                    border-color: var(--primary);
                }

                .room-image-container {
                    height: 240px;
                    background: linear-gradient(135deg, var(--accent) 0%, var(--hover-bg) 100%);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    overflow: hidden;
                    position: relative;
                }

                .room-image {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform .4s ease;
                }

                .room-card:hover .room-image {
                    transform: scale(1.06);
                }

                .no-image {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    gap: 12px;
                    color: var(--primary);
                }

                .no-image i {
                    font-size: 3rem;
                    opacity: 0.5;
                }

                .no-image-text {
                    font-weight: 600;
                    color: var(--muted-text);
                }

                .room-info {
                    padding: 20px;
                    background: transparent;
                    color: var(--text);
                    display: flex;
                    flex-direction: column;
                    gap: 14px;
                }

                .room-number-badge {
                    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                    color: white;
                    padding: 10px 16px;
                    border-radius: 10px;
                    font-weight: 700;
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    font-size: 1.05rem;
                    box-shadow: 0 4px 12px rgba(74, 144, 226, 0.25);
                }

                .room-detail-row {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 8px 0;
                    border-bottom: 1px solid var(--accent);
                }

                .room-detail-row:last-of-type {
                    border-bottom: none;
                }

                .detail-label {
                    color: var(--muted-text);
                    font-size: 0.95rem;
                    font-weight: 600;
                }

                .detail-value {
                    color: var(--text);
                    font-weight: 700;
                    font-size: 1.05rem;
                }

                .status-badge {
                    padding: 8px 14px;
                    border-radius: 20px;
                    font-weight: 700;
                    font-size: 0.9rem;
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                }

                .status-available {
                    background: #D4F4DD;
                    color: #22C55E;
                    border: 2px solid #22C55E;
                }

                .status-occupied {
                    background: #FFE4E6;
                    color: #EF4444;
                    border: 2px solid #EF4444;
                }

                .view-btn {
                    display: inline-block;
                    text-align: center;
                    padding: 12px 16px;
                    border-radius: 10px;
                    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                    color: white;
                    text-decoration: none;
                    font-weight: 700;
                    transition: all 0.3s ease;
                    box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
                    margin-top: 8px;
                }

                .view-btn:hover {
                    box-shadow: 0 6px 16px rgba(74, 144, 226, 0.4);
                    transform: translateY(-2px);
                }

                .empty-state {
                    padding: 80px 20px;
                    text-align: center;
                    color: var(--muted-text);
                }

                .empty-state i {
                    font-size: 4rem;
                    color: var(--primary);
                    opacity: 0.3;
                    margin-bottom: 20px;
                }

                .empty-state h3 {
                    color: var(--text);
                    margin: 16px 0 8px;
                    font-size: 1.4rem;
                }

                .loading {
                    display: none;
                    position: fixed;
                    inset: 0;
                    align-items: center;
                    justify-content: center;
                    background: rgba(255, 255, 255, 0.9);
                    z-index: 2000;
                }

                .spinner {
                    width: 50px;
                    height: 50px;
                    border: 4px solid var(--accent);
                    border-top: 4px solid var(--primary);
                    border-radius: 50%;
                    animation: spin 1s linear infinite;
                }

                @keyframes spin {
                    0% {
                        transform: rotate(0deg);
                    }

                    100% {
                        transform: rotate(360deg);
                    }
                }

                .toast {
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    background: white;
                    padding: 16px 24px;
                    border-radius: 12px;
                    box-shadow: 0 8px 24px rgba(74, 144, 226, 0.2);
                    border: 2px solid var(--accent);
                    display: none;
                    z-index: 3000;
                }

                .toast.show {
                    display: block;
                    animation: slideIn 0.3s ease;
                }

                .toast.success {
                    border-color: #00C853;
                }

                .toast.error {
                    border-color: #FF5252;
                }

                .toast-content {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                }

                .toast-icon {
                    font-size: 1.5rem;
                }

                .toast.success .toast-icon {
                    color: #00C853;
                }

                .toast.error .toast-icon {
                    color: #FF5252;
                }

                @keyframes slideIn {
                    from {
                        transform: translateX(400px);
                        opacity: 0;
                    }

                    to {
                        transform: translateX(0);
                        opacity: 1;
                    }
                }

                @media (max-width:900px) {
                    .header {
                        padding: 12px 18px;
                    }

                    .search-section {
                        padding: 18px;
                    }

                    .table-container {
                        padding: 18px;
                    }

                    .room-card {
                        min-width: 260px;
                    }
                }

                @media (max-width:480px) {
                    .nav-menu {
                        display: none;
                    }

                    .login-register a:first-child {
                        display: none;
                    }

                    .rooms-grid {
                        gap: 14px;
                        padding-left: 12px;
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
            <c:if test="${not empty message}">
                <input type="hidden" id="serverMessage" value="${message}" />
            </c:if>

            <div class="container">
                <div class="header">
                    <h1>
                        <i class="fas fa-building"></i>
                        Thanachok Place
                    </h1>
                    <nav class="nav-menu">
                        <a href="Home" class="nav-link active">
                            <i class="fas fa-home"></i> หน้าหลัก
                        </a>
                        <a href="#" class="nav-link">
                            <i class="fas fa-door-open"></i> ห้องของฉัน
                        </a>
                        <a href="#" class="nav-link">
                            <i class="fas fa-file-invoice"></i> ใบแจ้งหนี้
                        </a>
                        <a href="#" class="nav-link">
                            <i class="fas fa-history"></i> ประวัติการจอง
                        </a>
                    </nav>
                    <div class="login-register">
                        <a href="Login">
                            <i class="fas fa-sign-in-alt"></i>
                            เข้าสู่ระบบ
                        </a>
                        <a href="Register">
                            <i class="fas fa-user-plus"></i>
                            สมัครสมาชิก
                        </a>
                    </div>
                </div>

                <div class="search-section">
                    <div class="search-form">
                        <h3>
                            <i class="fas fa-search"></i>
                            ค้นหาห้องพัก
                        </h3>
                        <form method="get" action="Home" id="searchForm">
                            <div class="search-row">
                                <div class="form-group">
                                    <label for="floor">ชั้น:</label>
                                    <select name="floor" id="floor">
                                        <option value="">ทั้งหมด</option>
                                        <c:forEach var="i" begin="1" end="5">
                                            <option value="${i}" ${param.floor==i ? 'selected' : '' }>ชั้น ${i}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="status">สถานะ:</label>
                                    <select name="status" id="status">
                                        <option value="">ทั้งหมด</option>
                                        <option value="ว่าง" ${param.status=='ว่าง' ? 'selected' : '' }>ว่าง</option>
                                        <option value="ไม่ว่าง" ${param.status=='ไม่ว่าง' ? 'selected' : '' }>ไม่ว่าง
                                        </option>
                                    </select>
                                </div>

                                <button type="submit" class="search-btn">
                                    <i class="fas fa-search"></i>
                                    ค้นหา
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="table-container">
                    <div class="table-header">
                        <h2>รายการห้องพัก</h2>
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
                            <div class="rooms-grid">
                                <c:forEach var="room" items="${roomList}">
                                    <div class="room-card">
                                        <div class="room-image-container">
                                            <c:choose>
                                                <c:when test="${not empty room.roomNumberImage}">
                                                    <img src="${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=number"
                                                        alt="ห้อง ${room.roomNumber}" class="room-image"
                                                        onerror="this.onerror=null; this.parentElement.innerHTML='<div class=no-image><i class=fas fa-image></i><div class=no-image-text>ไม่มีรูปภาพ</div></div>';">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-image">
                                                        <i class="fas fa-image"></i>
                                                        <div class="no-image-text">รูปภาพหมายเลขห้อง</div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="room-info">
                                            <div class="room-number-badge">
                                                <i class="fas fa-door-closed"></i>
                                                ห้อง ${room.roomNumber}
                                            </div>

                                            <div class="room-detail-row">
                                                <span class="detail-label">
                                                    <i class="fas fa-layer-group"></i> ประเภทห้อง
                                                </span>
                                                <span class="detail-value">${room.roomtype}</span>
                                            </div>

                                            <div class="room-detail-row">
                                                <span class="detail-label">
                                                    <i class="fas fa-money-bill-wave"></i> ราคา
                                                </span>
                                                <span class="detail-value">${room.roomPrice} บาท</span>
                                            </div>

                                            <div class="room-detail-row">
                                                <span class="detail-label">
                                                    <i class="fas fa-info-circle"></i> สถานะ
                                                </span>
                                                <span
                                                    class="status-badge ${room.roomStatus == 'ว่าง' ? 'status-available' : 'status-occupied'}">
                                                    <i
                                                        class="fas ${room.roomStatus == 'ว่าง' ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                                    ${room.roomStatus}
                                                </span>
                                            </div>

                                            <a href="roomDetail?id=${room.roomID}" class="view-btn"
                                                onclick="return checkRoomStatus('${room.roomStatus}')">
                                                <i class="fas fa-eye"></i>
                                                ดูรายละเอียด
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
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
                    toast.className = 'toast ' + type + ' show';

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
                document.getElementById('searchForm').addEventListener('submit', function () {
                    document.getElementById('loading').style.display = 'flex';
                });

                // Handle message from server (read hidden field if present)
                window.addEventListener('load', function () {
                    var serverMessageEl = document.getElementById('serverMessage');
                    if (serverMessageEl && serverMessageEl.value) {
                        showToast(serverMessageEl.value, 'success');
                    }
                });

                // Smooth page load animation
                window.addEventListener('load', function () {
                    document.body.style.opacity = '0';
                    document.body.style.transition = 'opacity 0.5s ease-in-out';

                    setTimeout(function () {
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