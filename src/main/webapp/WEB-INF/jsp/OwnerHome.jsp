<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ page session="true" %>
                <%@ page import="com.springmvc.model.Manager" %>
                    <%@ page import="java.util.*" %>

                        <% Manager loginManager=(Manager) session.getAttribute("loginManager"); if (loginManager==null)
                            { response.sendRedirect("Login"); return; } %>

                            <!DOCTYPE html>
                            <html lang="th">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Manager Dashboard - ThanaChok Place</title>
                                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                                    rel="stylesheet">
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

                                    .floating-shapes:nth-child(1) {
                                        top: 10%;
                                        left: 10%;
                                        animation-delay: 0s;
                                    }

                                    .floating-shapes:nth-child(2) {
                                        top: 20%;
                                        right: 10%;
                                        animation-delay: 2s;
                                    }

                                    .floating-shapes:nth-child(3) {
                                        bottom: 10%;
                                        left: 20%;
                                        animation-delay: 4s;
                                    }

                                    .floating-shapes:nth-child(4) {
                                        bottom: 20%;
                                        right: 20%;
                                        animation-delay: 1s;
                                    }

                                    @keyframes float {

                                        0%,
                                        100% {
                                            transform: translateY(0px) rotate(0deg);
                                        }

                                        50% {
                                            transform: translateY(-20px) rotate(180deg);
                                        }
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
                                        0% {
                                            opacity: 0;
                                            transform: translateY(100vh) scale(0);
                                        }

                                        10% {
                                            opacity: 1;
                                        }

                                        90% {
                                            opacity: 1;
                                        }

                                        100% {
                                            opacity: 0;
                                            transform: translateY(-100vh) scale(1);
                                        }
                                    }

                                    .container {
                                        max-width: 1400px;
                                        margin: 0 auto;
                                        padding: 20px;
                                        position: relative;
                                        z-index: 1;
                                    }

                                    /* Header */
                                    .header {
                                        background: linear-gradient(135deg, #ff8c00, #ff6b00);
                                        color: white;
                                        text-align: center;
                                        padding: 30px;
                                        border-radius: 15px;
                                        margin-bottom: 20px;
                                        font-size: 2.5rem;
                                        font-weight: bold;
                                        box-shadow: 0 8px 32px rgba(255, 140, 0, 0.3);
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        gap: 15px;
                                        animation: glow 2s ease-in-out infinite;
                                    }

                                    @keyframes glow {

                                        0%,
                                        100% {
                                            text-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
                                        }

                                        50% {
                                            text-shadow: 0 0 30px rgba(0, 0, 0, 0.5), 0 0 40px rgba(255, 255, 255, 0.3);
                                        }
                                    }

                                    /* Top Bar */
                                    .top-bar {
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
                                        padding: 20px 30px;
                                        border-radius: 15px;
                                        margin-bottom: 25px;
                                        border: 1px solid rgba(255, 140, 0, 0.3);
                                    }

                                    .welcome-message {
                                        display: flex;
                                        align-items: center;
                                        gap: 10px;
                                        font-size: 1.2rem;
                                        color: #fff;
                                    }

                                    .admin-badge {
                                        background: linear-gradient(135deg, #ff8c00, #ff6b00);
                                        color: white;
                                        padding: 5px 15px;
                                        border-radius: 20px;
                                        font-size: 0.85rem;
                                        font-weight: 600;
                                        box-shadow: 0 4px 10px rgba(255, 140, 0, 0.3);
                                    }

                                    .logout-btn {
                                        background: rgba(255, 68, 68, 0.2);
                                        color: #ff4444;
                                        border: 2px solid #ff4444;
                                        padding: 10px 25px;
                                        border-radius: 10px;
                                        cursor: pointer;
                                        font-size: 1rem;
                                        font-weight: 600;
                                        transition: all 0.3s ease;
                                        display: flex;
                                        align-items: center;
                                        gap: 8px;
                                    }

                                    .logout-btn:hover {
                                        background: linear-gradient(135deg, #ff4444, #cc0000);
                                        color: white;
                                        transform: translateY(-2px);
                                    }

                                    /* Stats Container */
                                    .stats-container {
                                        display: grid;
                                        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                                        gap: 20px;
                                        margin-bottom: 30px;
                                    }

                                    .stat-card {
                                        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
                                        padding: 25px;
                                        border-radius: 15px;
                                        text-align: center;
                                        border: 1px solid rgba(255, 140, 0, 0.3);
                                        transition: all 0.3s ease;
                                        position: relative;
                                        overflow: hidden;
                                    }

                                    .stat-card::before {
                                        content: '';
                                        position: absolute;
                                        top: 0;
                                        left: 0;
                                        right: 0;
                                        height: 4px;
                                    }

                                    .stat-card:hover {
                                        transform: translateY(-5px);
                                        box-shadow: 0 12px 40px rgba(255, 140, 0, 0.3);
                                    }

                                    .stat-icon {
                                        font-size: 2.5rem;
                                        margin-bottom: 15px;
                                    }

                                    .stat-number {
                                        font-size: 2.5rem;
                                        font-weight: bold;
                                        margin-bottom: 10px;
                                    }

                                    .stat-label {
                                        color: #999;
                                        font-size: 0.95rem;
                                    }

                                    .stat-total::before {
                                        background: linear-gradient(90deg, #ff8c00, #ff6b00);
                                    }

                                    .stat-total .stat-icon,
                                    .stat-total .stat-number {
                                        color: #ff8c00;
                                    }

                                    .stat-available::before {
                                        background: linear-gradient(90deg, #00ff88, #00cc6f);
                                    }

                                    .stat-available .stat-icon,
                                    .stat-available .stat-number {
                                        color: #00ff88;
                                    }

                                    .stat-occupied::before {
                                        background: linear-gradient(90deg, #ff4444, #cc0000);
                                    }

                                    .stat-occupied .stat-icon,
                                    .stat-occupied .stat-number {
                                        color: #ff4444;
                                    }

                                    .stat-pending::before {
                                        background: linear-gradient(90deg, #ffa726, #f57c00);
                                    }

                                    .stat-pending .stat-icon,
                                    .stat-pending .stat-number {
                                        color: #ffa726;
                                    }

                                    .stat-revenue::before {
                                        background: linear-gradient(90deg, #42a5f5, #1976d2);
                                    }

                                    .stat-revenue .stat-icon,
                                    .stat-revenue .stat-number {
                                        color: #42a5f5;
                                    }

                                    /* Navigation */
                                    .nav {
                                        background: rgba(0, 0, 0, 0.6);
                                        backdrop-filter: blur(10px);
                                        border-radius: 15px;
                                        padding: 15px;
                                        margin-bottom: 25px;
                                        display: flex;
                                        gap: 10px;
                                        border: 1px solid rgba(255, 140, 0, 0.3);
                                        flex-wrap: wrap;
                                    }

                                    .nav a {
                                        flex: 1;
                                        min-width: 150px;
                                        padding: 15px 25px;
                                        background: rgba(255, 140, 0, 0.1);
                                        border: 1px solid rgba(255, 140, 0, 0.3);
                                        color: white;
                                        text-decoration: none;
                                        border-radius: 10px;
                                        transition: all 0.3s ease;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        gap: 8px;
                                        font-weight: 500;
                                    }

                                    .nav a:hover {
                                        background: rgba(255, 140, 0, 0.2);
                                        transform: translateY(-2px);
                                    }

                                    .nav a.active {
                                        background: linear-gradient(135deg, #ff8c00, #ff6b00);
                                        border-color: transparent;
                                    }

                                    /* Search Form */
                                    .search-form {
                                        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
                                        padding: 30px;
                                        border-radius: 15px;
                                        margin-bottom: 25px;
                                        border: 1px solid rgba(255, 140, 0, 0.3);
                                    }

                                    .search-form h3 {
                                        color: #ff8c00;
                                        margin-bottom: 20px;
                                        font-size: 1.3rem;
                                        display: flex;
                                        align-items: center;
                                        gap: 10px;
                                    }

                                    .search-form form {
                                        display: flex;
                                        gap: 15px;
                                        flex-wrap: wrap;
                                        align-items: end;
                                    }

                                    .form-group {
                                        flex: 1;
                                        min-width: 150px;
                                    }

                                    .form-group label {
                                        display: block;
                                        margin-bottom: 8px;
                                        color: #ccc;
                                        font-weight: 500;
                                    }

                                    .form-group select {
                                        width: 100%;
                                        padding: 12px 15px;
                                        background: rgba(0, 0, 0, 0.4);
                                        border: 2px solid rgba(255, 140, 0, 0.3);
                                        border-radius: 10px;
                                        color: #fff;
                                        font-size: 1rem;
                                        cursor: pointer;
                                        transition: all 0.3s ease;
                                    }

                                    .form-group select:focus {
                                        outline: none;
                                        border-color: #ff8c00;
                                        box-shadow: 0 0 15px rgba(255, 140, 0, 0.3);
                                    }

                                    .search-btn,
                                    .clear-btn {
                                        padding: 12px 30px;
                                        border: none;
                                        border-radius: 10px;
                                        font-size: 1rem;
                                        font-weight: 600;
                                        cursor: pointer;
                                        transition: all 0.3s ease;
                                        display: flex;
                                        align-items: center;
                                        gap: 8px;
                                    }

                                    .search-btn {
                                        background: linear-gradient(135deg, #ff8c00, #ff6b00);
                                        color: white;
                                        box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
                                    }

                                    .search-btn:hover {
                                        transform: translateY(-2px);
                                        box-shadow: 0 6px 20px rgba(255, 140, 0, 0.5);
                                    }

                                    .clear-btn {
                                        background: rgba(255, 68, 68, 0.2);
                                        color: #ff4444;
                                        border: 2px solid #ff4444;
                                    }

                                    .clear-btn:hover {
                                        background: linear-gradient(135deg, #ff4444, #cc0000);
                                        color: white;
                                    }

                                    /* Table Container */
                                    .table-container {
                                        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
                                        border-radius: 15px;
                                        padding: 30px;
                                        border: 1px solid rgba(255, 140, 0, 0.3);
                                    }

                                    .table-header {
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        margin-bottom: 25px;
                                        flex-wrap: wrap;
                                        gap: 15px;
                                    }

                                    .table-header h2 {
                                        color: #ff8c00;
                                        font-size: 1.5rem;
                                        display: flex;
                                        align-items: center;
                                        gap: 10px;
                                    }

                                    .table-info {
                                        color: #999;
                                        font-size: 1rem;
                                    }

                                    table {
                                        width: 100%;
                                        border-collapse: collapse;
                                    }

                                    thead tr {
                                        background: linear-gradient(135deg, #ff8c00, #ff6b00);
                                    }

                                    th {
                                        padding: 18px 15px;
                                        text-align: center;
                                        font-weight: 600;
                                        color: white;
                                        text-transform: uppercase;
                                        letter-spacing: 0.5px;
                                        font-size: 0.9rem;
                                    }

                                    td {
                                        padding: 16px 15px;
                                        text-align: center;
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
                                        font-weight: 700;
                                        color: #ff8c00;
                                        font-size: 1.1rem;
                                    }

                                    .room-type {
                                        color: #fff;
                                    }

                                    .price {
                                        font-weight: 600;
                                        color: #00ff88;
                                        font-size: 1.05rem;
                                    }

                                    /* Status Badges */
                                    .status-badge {
                                        padding: 6px 16px;
                                        border-radius: 20px;
                                        font-size: 0.85rem;
                                        font-weight: 600;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 6px;
                                    }

                                    .status-available {
                                        background: linear-gradient(135deg, #00ff88, #00cc6f);
                                        color: #000;
                                        box-shadow: 0 4px 10px rgba(0, 255, 136, 0.3);
                                    }

                                    .status-occupied {
                                        background: linear-gradient(135deg, #ff4444, #cc0000);
                                        color: white;
                                        box-shadow: 0 4px 10px rgba(255, 68, 68, 0.3);
                                    }

                                    .deposit-status {
                                        font-size: 0.8rem;
                                        margin-top: 5px;
                                        display: inline-block;
                                    }

                                    .deposit-status.approved {
                                        color: #00ff88;
                                    }

                                    .deposit-status.pending {
                                        color: #ffa726;
                                    }

                                    /* Action Buttons */
                                    .action-buttons {
                                        display: flex;
                                        gap: 8px;
                                        justify-content: center;
                                        flex-wrap: wrap;
                                    }

                                    .action-btn {
                                        padding: 8px 16px;
                                        border: none;
                                        border-radius: 8px;
                                        font-size: 0.85rem;
                                        font-weight: 500;
                                        cursor: pointer;
                                        transition: all 0.3s ease;
                                        text-decoration: none;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 6px;
                                    }

                                    .btn-add {
                                        background: linear-gradient(135deg, #00ff88, #00cc6f);
                                        color: #000;
                                    }

                                    .btn-edit-invoice {
                                        background: linear-gradient(135deg, #42a5f5, #1976d2);
                                        color: white;
                                    }

                                    .btn-edit {
                                        background: linear-gradient(135deg, #ff8c00, #ff6b00);
                                        color: white;
                                    }

                                    .btn-delete {
                                        background: linear-gradient(135deg, #ff4444, #cc0000);
                                        color: white;
                                    }

                                    .btn-view {
                                        background: linear-gradient(135deg, #ffa726, #f57c00);
                                        color: white;
                                    }

                                    .btn-disabled {
                                        background: #666;
                                        color: #999;
                                        cursor: not-allowed;
                                    }

                                    .action-btn:not(.btn-disabled):hover {
                                        transform: translateY(-2px);
                                        box-shadow: 0 4px 15px rgba(255, 140, 0, 0.4);
                                    }

                                    /* Empty State */
                                    .empty-state {
                                        text-align: center;
                                        padding: 60px 20px;
                                    }

                                    .empty-icon {
                                        font-size: 4rem;
                                        color: #ff8c00;
                                        margin-bottom: 20px;
                                        opacity: 0.5;
                                    }

                                    .empty-state h3 {
                                        color: #ff8c00;
                                        font-size: 1.8rem;
                                        margin-bottom: 10px;
                                    }

                                    .empty-state p {
                                        color: #999;
                                        font-size: 1.1rem;
                                    }

                                    /* Loading & Toast */
                                    .loading {
                                        display: none;
                                        position: fixed;
                                        top: 0;
                                        left: 0;
                                        width: 100%;
                                        height: 100%;
                                        background: rgba(0, 0, 0, 0.9);
                                        z-index: 1000;
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

                                    .toast.success {
                                        border-left: 4px solid #00ff88;
                                    }

                                    .toast.error {
                                        border-left: 4px solid #ff4444;
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

                                    /* Responsive */
                                    @media (max-width: 768px) {
                                        .header {
                                            font-size: 1.8rem;
                                            padding: 20px;
                                        }

                                        .top-bar {
                                            flex-direction: column;
                                            gap: 15px;
                                            text-align: center;
                                        }

                                        .stats-container {
                                            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                                        }

                                        .nav {
                                            flex-direction: column;
                                        }

                                        .nav a {
                                            min-width: 100%;
                                        }

                                        .search-form form {
                                            flex-direction: column;
                                        }

                                        .form-group {
                                            width: 100%;
                                        }

                                        table {
                                            font-size: 0.85rem;
                                        }

                                        th,
                                        td {
                                            padding: 12px 8px;
                                        }

                                        .action-buttons {
                                            flex-direction: column;
                                        }

                                        .action-btn {
                                            width: 100%;
                                            justify-content: center;
                                        }
                                    }
                                </style>
                            </head>

                            <body>
                                <div class="bg-animation">
                                    <div class="floating-shapes"></div>
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
                                        <i class="fas fa-building"></i>
                                        ThanaChok Place
                                    </div>

                                    <div class="top-bar">
                                        <div class="welcome-message">
                                            <i class="fas fa-user-shield"></i>
                                            สวัสดี, ${loginManager.email}!
                                            <span class="admin-badge">Manager</span>
                                        </div>

                                        <form action="Logout" method="post" style="display: inline;">
                                            <button type="submit" class="logout-btn">
                                                <i class="fas fa-sign-out-alt"></i>
                                                ออกจากระบบ
                                            </button>
                                        </form>
                                    </div>

                                    <div class="stats-container">
                                        <div class="stat-card stat-total">
                                            <div class="stat-icon">
                                                <i class="fas fa-door-open"></i>
                                            </div>
                                            <div class="stat-number" id="totalRooms">
                                                <c:set var="totalRooms" value="${roomList.size()}" />
                                                ${totalRooms}
                                            </div>
                                            <div class="stat-label">ห้องทั้งหมด</div>
                                        </div>

                                        <div class="stat-card stat-available">
                                            <div class="stat-icon">
                                                <i class="fas fa-check-circle"></i>
                                            </div>
                                            <div class="stat-number" id="availableRooms">
                                                <c:set var="availableCount" value="0" />
                                                <c:forEach var="room" items="${roomList}">
                                                    <c:if test="${room.roomStatus == 'ว่าง'}">
                                                        <c:set var="availableCount" value="${availableCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${availableCount}
                                            </div>
                                            <div class="stat-label">ห้องว่าง</div>
                                        </div>

                                        <div class="stat-card stat-occupied">
                                            <div class="stat-icon">
                                                <i class="fas fa-times-circle"></i>
                                            </div>
                                            <div class="stat-number" id="occupiedRooms">
                                                <c:set var="occupiedCount" value="0" />
                                                <c:forEach var="room" items="${roomList}">
                                                    <c:if test="${room.roomStatus == 'ไม่ว่าง'}">
                                                        <c:set var="occupiedCount" value="${occupiedCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${occupiedCount}
                                            </div>
                                            <div class="stat-label">ห้องไม่ว่าง</div>
                                        </div>

                                        <div class="stat-card stat-pending">
                                            <div class="stat-icon">
                                                <i class="fas fa-clock"></i>
                                            </div>
                                            <div class="stat-number">
                                                <c:set var="pendingCount" value="0" />
                                                <c:forEach var="room" items="${roomList}">
                                                    <c:if
                                                        test="${room.roomStatus == 'ไม่ว่าง' && roomDepositStatus[room.roomID] == 'รอดำเนินการ'}">
                                                        <c:set var="pendingCount" value="${pendingCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${pendingCount}
                                            </div>
                                            <div class="stat-label">รอการอนุมัติ</div>
                                        </div>

                                        <div class="stat-card stat-revenue">
                                            <div class="stat-icon">
                                                <i class="fas fa-money-bill-wave"></i>
                                            </div>
                                            <div class="stat-number">
                                                <c:set var="totalRevenue" value="0" />
                                                <c:forEach var="room" items="${roomList}">
                                                    <c:if test="${room.roomStatus == 'ไม่ว่าง'}">
                                                        <c:set var="totalRevenue"
                                                            value="${totalRevenue + room.roomPrice}" />
                                                    </c:if>
                                                </c:forEach>
                                                ฿
                                                <fmt:formatNumber value="${totalRevenue}" groupingUsed="true" />
                                            </div>
                                            <div class="stat-label">รายได้ต่อเดือน (ประมาณ)</div>
                                        </div>
                                    </div>

                                    <div class="nav">
                                        <a href="OwnerHome" class="active">
                                            <i class="fas fa-home"></i>
                                            หน้าหลัก
                                        </a>
                                        <a href="AddRoom">
                                            <i class="fas fa-plus-circle"></i>
                                            เพิ่มห้องพัก
                                        </a>
                                        <a href="OViewReserve">
                                            <i class="fas fa-chart-bar"></i>
                                            จัดการการจอง
                                            <c:if test="${pendingCount > 0}">
                                                <span class="admin-badge"
                                                    style="margin-left: 5px; font-size: 0.7rem;">${pendingCount}</span>
                                            </c:if>
                                        </a>
                                    </div>

                                    <div class="search-form">
                                        <h3>
                                            <i class="fas fa-search"></i>
                                            ค้นหาและกรองห้องพัก
                                        </h3>
                                        <form method="get" action="OwnerHome" id="searchForm">
                                            <div class="form-group">
                                                <label for="floor">ชั้น:</label>
                                                <select name="floor" id="floor">
                                                    <option value="">ทั้งหมด</option>
                                                    <c:forEach var="i" begin="1" end="9">
                                                        <option value="${i}" ${param.floor==i ? 'selected' : '' }>ชั้น
                                                            ${i}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label for="status">สถานะ:</label>
                                                <select name="status" id="status">
                                                    <option value="">ทั้งหมด</option>
                                                    <option value="ว่าง" ${param.status=='ว่าง' ? 'selected' : '' }>ว่าง
                                                    </option>
                                                    <option value="ไม่ว่าง" ${param.status=='ไม่ว่าง' ? 'selected' : ''
                                                        }>ไม่ว่าง</option>
                                                </select>
                                            </div>

                                            <button type="submit" class="search-btn">
                                                <i class="fas fa-search"></i>
                                                ค้นหา
                                            </button>

                                            <button type="button" class="clear-btn" onclick="clearFilters()">
                                                <i class="fas fa-times"></i>
                                                ล้างตัวกรอง
                                            </button>
                                        </form>
                                    </div>

                                    <div class="table-container">
                                        <div class="table-header">
                                            <h2>
                                                <i class="fas fa-list"></i>
                                                รายการห้องพัก
                                            </h2>
                                            <div class="table-info">
                                                <c:choose>
                                                    <c:when test="${not empty param.floor || not empty param.status}">
                                                        แสดงผลการค้นหา: ${roomList.size()} ห้อง
                                                    </c:when>
                                                    <c:otherwise>
                                                        ห้องทั้งหมด: ${roomList.size()} ห้อง
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <c:choose>
                                            <c:when test="${empty roomList}">
                                                <div class="empty-state">
                                                    <div class="empty-icon">
                                                        <i class="fas fa-search"></i>
                                                    </div>
                                                    <h3>ไม่พบห้องพัก</h3>
                                                    <p>ไม่มีห้องพักที่ตรงกับเงื่อนไขการค้นหา
                                                        กรุณาลองเปลี่ยนตัวกรองหรือเพิ่มห้องใหม่</p>
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
                                                                <td class="price">฿
                                                                    <fmt:formatNumber value="${room.roomPrice}"
                                                                        groupingUsed="true" />
                                                                </td>
                                                                <td>
                                                                    <span
                                                                        class="status-badge ${room.roomStatus == 'ว่าง' ? 'status-available' : 'status-occupied'}">
                                                                        <i
                                                                            class="fas ${room.roomStatus == 'ว่าง' ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                                                        ${room.roomStatus}
                                                                    </span>
                                                                    <c:if test="${room.roomStatus == 'ไม่ว่าง'}">
                                                                        <br>
                                                                        <small
                                                                            class="deposit-status ${roomDepositStatus[room.roomID] == 'เสร็จสมบูรณ์' ? 'approved' : 'pending'}">
                                                                            <i
                                                                                class="fas ${roomDepositStatus[room.roomID] == 'เสร็จสมบูรณ์' ? 'fa-check-circle' : 'fa-clock'}"></i>
                                                                            ${roomDepositStatus[room.roomID]}
                                                                        </small>
                                                                    </c:if>
                                                                </td>
                                                                <td>
                                                                    <div class="action-buttons">
                                                                        <c:if test="${room.roomStatus == 'ไม่ว่าง'}">
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${roomApprovalStatus[room.roomID] == true}">
                                                                                    <a href="ManagerAddInvoice?roomID=${room.roomID}"
                                                                                        class="action-btn btn-add"
                                                                                        title="เพิ่มใบแจ้งหนี้สำหรับห้อง ${room.roomNumber}">
                                                                                        <i class="fas fa-plus"></i>
                                                                                        เพิ่มบิล
                                                                                    </a>
                                                                                    <a href="EditInvoice?roomID=${room.roomID}"
                                                                                        class="action-btn btn-edit-invoice"
                                                                                        title="แก้ไขใบแจ้งหนี้ห้อง ${room.roomNumber}">
                                                                                        <i
                                                                                            class="fas fa-file-invoice"></i>
                                                                                        แก้ไขบิล
                                                                                    </a>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <button
                                                                                        class="action-btn btn-disabled"
                                                                                        disabled
                                                                                        title="ต้องอนุมัติการจองก่อนจึงจะสามารถเพิ่มบิลได้">
                                                                                        <i class="fas fa-ban"></i>
                                                                                        รอการอนุมัติ
                                                                                    </button>
                                                                                    <a href="OViewReserve"
                                                                                        class="action-btn btn-view"
                                                                                        title="ไปที่หน้าจัดการการจองเพื่ออนุมัติ">
                                                                                        <i
                                                                                            class="fas fa-clipboard-check"></i>
                                                                                        อนุมัติการจอง
                                                                                    </a>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </c:if>

                                                                        <a href="editRoom?id=${room.roomID}"
                                                                            class="action-btn btn-edit"
                                                                            title="แก้ไขข้อมูลห้อง ${room.roomNumber}">
                                                                            <i class="fas fa-edit"></i>
                                                                            แก้ไขข้อมูล
                                                                        </a>

                                                                        <c:if test="${room.roomStatus == 'ว่าง'}">
                                                                            <!-- Debug: แสดง roomID -->
                                                                            <input type="hidden" value="${room.roomID}"
                                                                                id="roomID_${room.roomID}">

                                                                            <button class="action-btn btn-delete"
                                                                                onclick="confirmDelete(${room.roomID}, '${room.roomNumber}')"
                                                                                title="ลบห้อง ${room.roomNumber}">
                                                                                <i class="fas fa-trash"></i>
                                                                                ลบ
                                                                            </button>
                                                                        </c:if>
                                                                    </div>
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

                                    function showToast(message, type = 'success') {
                                        const toast = document.getElementById('toast');
                                        const toastMessage = document.getElementById('toast-message');
                                        toastMessage.textContent = message;
                                        toast.className = `toast ${type}`;
                                        toast.style.display = 'block';
                                        setTimeout(() => { toast.style.display = 'none'; }, 5000);
                                    }

                                    function confirmDelete(roomID, roomNumber) {
                                        // Debug
                                        console.log("roomID:", roomID);
                                        console.log("roomNumber:", roomNumber);
                                        console.log("Type of roomID:", typeof roomID);

                                        // ตรวจสอบความถูกต้องของ roomID
                                        if (!roomID || roomID === '' || roomID === 'undefined' || roomID === 'null') {
                                            showToast('ข้อผิดพลาด: ไม่พบรหัสห้อง', 'error');
                                            console.error('Invalid roomID:', roomID);
                                            return;
                                        }

                                        if (confirm(`⚠️ คำเตือน!\n\nคุณต้องการลบห้อง ${roomNumber} ใช่หรือไม่?\n\nการดำเนินการนี้ไม่สามารถยกเลิกได้`)) {
                                            document.getElementById('loading').style.display = 'flex';

                                            // สร้าง URL แบบชัดเจน
                                            const deleteUrl = 'deleteRoom?id=' + roomID;
                                            console.log('Navigating to:', deleteUrl);

                                            window.location.href = deleteUrl;
                                        }
                                    }

                                    function clearFilters() {
                                        document.getElementById('floor').value = '';
                                        document.getElementById('status').value = '';
                                        document.getElementById('searchForm').submit();
                                    }

                                    document.getElementById('searchForm').addEventListener('submit', function () {
                                        document.getElementById('loading').style.display = 'flex';
                                    });

                                    window.addEventListener('load', function () {
                                        createParticles();
            
            <c:if test="${not empty message}">
                setTimeout(() => showToast("${message}", "success"), 500);
            </c:if>

            <c:if test="${not empty error}">
                setTimeout(() => showToast("${error}", "error"), 500);
            </c:if>

                                        setTimeout(() => { document.getElementById('loading').style.display = 'none'; }, 1000);

                                        document.body.style.opacity = '0';
                                        document.body.style.transition = 'opacity 0.5s ease-in-out';
                                        setTimeout(function () { document.body.style.opacity = '1'; }, 100);
                                    });

                                    document.querySelectorAll('.action-btn:not(.btn-disabled)').forEach(btn => {
                                        btn.addEventListener('click', function (e) {
                                            this.style.transform = 'scale(0.95)';
                                            setTimeout(() => { this.style.transform = ''; }, 150);
                                        });
                                    });

                                    document.addEventListener('DOMContentLoaded', function () {
                                        document.querySelectorAll('tbody tr').forEach(row => {
                                            const depositStatus = row.querySelector('.deposit-status');
                                            if (depositStatus && depositStatus.textContent.includes('รอดำเนินการ')) {
                                                row.style.boxShadow = '0 0 0 2px rgba(255, 167, 38, 0.3)';
                                                row.style.backgroundColor = 'rgba(255, 167, 38, 0.05)';
                                            }
                                        });
                                    });

                                    document.addEventListener('keydown', function (e) {
                                        if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                                            e.preventDefault();
                                            document.getElementById('floor').focus();
                                        }
                                        if (e.key === 'Escape') {
                                            clearFilters();
                                        }
                                    });
                                </script>
                            </body>

                            </html>