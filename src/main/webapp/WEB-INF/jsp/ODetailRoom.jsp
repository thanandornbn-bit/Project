<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="jakarta.tags.core"%> <%@ page
import="com.springmvc.model.*"%> <% Member loginMember = (Member)
session.getAttribute("loginMember"); boolean isLoggedIn = (loginMember != null);
%>

<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>รายละเอียดห้องพัก - ThanaChok Place</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(
          135deg,
          #1a1a1a 0%,
          #2d2d2d 50%,
          #1a1a1a 100%
        );
        min-height: 100vh;
        color: #fff;
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

      @keyframes float {
        0%,
        100% {
          transform: translateY(0px) rotate(0deg);
        }
        50% {
          transform: translateY(-20px) rotate(180deg);
        }
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
        margin-bottom: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
        animation: glow 2s ease-in-out infinite;
      }

      @keyframes glow {
        0%,
        100% {
          text-shadow: 0 0 20px rgba(255, 140, 0, 0.3);
        }
        50% {
          text-shadow: 0 0 30px rgba(255, 140, 0, 0.5),
            0 0 40px rgba(255, 255, 255, 0.3);
        }
      }

      .room-detail-card {
        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
        backdrop-filter: blur(20px);
        border-radius: 25px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        border: 1px solid rgba(255, 140, 0, 0.3);
        overflow: hidden;
        animation: slideUp 0.8s ease-out;
      }

      @keyframes slideUp {
        from {
          opacity: 0;
          transform: translateY(50px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .image-gallery-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
        padding: 20px;
        background: #000;
      }

      .gallery-item {
        position: relative;
        overflow: hidden;
        border-radius: 15px;
        aspect-ratio: 16/10;
        cursor: pointer;
        transition: all 0.3s ease;
        border: 2px solid rgba(255, 140, 0, 0.2);
      }

      .gallery-item:hover {
        transform: scale(1.02);
        border-color: rgba(255, 140, 0, 0.6);
        box-shadow: 0 10px 30px rgba(255, 140, 0, 0.3);
      }

      .gallery-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
      }

      .gallery-item:hover img {
        transform: scale(1.05);
      }

      .image-label {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        background: linear-gradient(to top, rgba(0, 0, 0, 0.8), transparent);
        padding: 15px;
        color: white;
        font-size: 0.9rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 8px;
        opacity: 0;
        transition: opacity 0.3s ease;
      }

      .gallery-item:hover .image-label {
        opacity: 1;
      }

      .zoom-icon {
        position: absolute;
        top: 15px;
        right: 15px;
        background: rgba(255, 140, 0, 0.9);
        color: white;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        transition: all 0.3s ease;
        font-size: 1.1rem;
      }

      .gallery-item:hover .zoom-icon {
        opacity: 1;
        transform: rotate(90deg);
      }

      .fullscreen-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.95);
        z-index: 9999;
        justify-content: center;
        align-items: center;
        animation: fadeIn 0.3s ease;
      }

      .fullscreen-overlay.active {
        display: flex;
      }

      @keyframes fadeIn {
        from {
          opacity: 0;
        }
        to {
          opacity: 1;
        }
      }

      .fullscreen-image {
        max-width: 90%;
        max-height: 90vh;
        object-fit: contain;
        border-radius: 10px;
        box-shadow: 0 10px 50px rgba(0, 0, 0, 0.5);
      }

      .fullscreen-close {
        position: absolute;
        top: 30px;
        right: 30px;
        background: rgba(255, 140, 0, 0.9);
        color: white;
        border: none;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        cursor: pointer;
        font-size: 1.5rem;
        transition: all 0.3s ease;
      }

      .fullscreen-close:hover {
        background: #ff8c00;
        transform: rotate(90deg) scale(1.1);
      }

      .room-info {
        padding: 40px;
      }

      .room-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        flex-wrap: wrap;
        gap: 15px;
      }

      .room-number {
        font-size: 2rem;
        font-weight: bold;
        color: #ff8c00;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .room-status {
        padding: 10px 20px;
        border-radius: 25px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .status-available {
        background: linear-gradient(135deg, #00ff88, #00cc6f);
        color: #000;
        box-shadow: 0 4px 15px rgba(0, 255, 136, 0.3);
      }

      .status-occupied {
        background: linear-gradient(135deg, #ff4444, #cc0000);
        color: white;
        box-shadow: 0 4px 15px rgba(255, 68, 68, 0.3);
      }

      .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
      }

      .info-section {
        background: rgba(0, 0, 0, 0.4);
        padding: 25px;
        border-radius: 15px;
        border: 1px solid rgba(255, 140, 0, 0.2);
        transition: all 0.3s ease;
      }

      .info-section:hover {
        border-color: rgba(255, 140, 0, 0.5);
        transform: translateY(-3px);
        box-shadow: 0 5px 20px rgba(255, 140, 0, 0.2);
      }

      .info-section h3 {
        color: #ff8c00;
        margin-bottom: 20px;
        font-size: 1.3rem;
        display: flex;
        align-items: center;
        gap: 10px;
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
        font-weight: 500;
        color: #999;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .info-value {
        font-weight: 600;
        color: #fff;
      }

      .price-highlight {
        font-size: 1.3rem;
        color: #ff8c00;
      }

      .wifi-section {
        background: linear-gradient(
          135deg,
          rgba(255, 140, 0, 0.2),
          rgba(255, 107, 0, 0.2)
        );
        border: 1px solid rgba(255, 140, 0, 0.3);
        padding: 25px;
        border-radius: 15px;
        margin-bottom: 25px;
      }

      .wifi-header {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 15px;
        font-size: 1.2rem;
        font-weight: 600;
        color: #ff8c00;
      }

      .wifi-controls {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
      }

      .wifi-select {
        padding: 12px 20px;
        border: 2px solid rgba(255, 140, 0, 0.3);
        border-radius: 10px;
        font-size: 1rem;
        background: rgba(0, 0, 0, 0.4);
        color: #fff;
        cursor: pointer;
        transition: all 0.3s ease;
        min-width: 200px;
      }

      .wifi-select:focus {
        outline: none;
        border-color: #ff8c00;
        box-shadow: 0 0 15px rgba(255, 140, 0, 0.3);
      }

      .wifi-select:disabled {
        opacity: 0.5;
        cursor: not-allowed;
      }

      .wifi-price {
        font-size: 1.2rem;
        font-weight: 600;
        padding: 10px 20px;
        background: rgba(255, 140, 0, 0.2);
        border: 1px solid rgba(255, 140, 0, 0.3);
        border-radius: 20px;
        color: #ff8c00;
      }

      .notice {
        background: linear-gradient(
          135deg,
          rgba(66, 165, 245, 0.2),
          rgba(25, 118, 210, 0.2)
        );
        border: 1px solid rgba(66, 165, 245, 0.3);
        padding: 20px;
        border-radius: 15px;
        margin-bottom: 30px;
        display: flex;
        align-items: center;
        gap: 15px;
        color: #ccc;
      }

      .notice-icon {
        font-size: 1.5rem;
        color: #42a5f5;
      }

      .alert {
        padding: 18px 25px;
        border-radius: 12px;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 12px;
        font-weight: 500;
        animation: slideDown 0.5s ease;
      }

      .alert-warning {
        background: linear-gradient(
          135deg,
          rgba(255, 167, 38, 0.2),
          rgba(245, 124, 0, 0.2)
        );
        border: 1px solid rgba(255, 167, 38, 0.5);
        color: #ffa726;
      }

      .alert-danger {
        background: linear-gradient(
          135deg,
          rgba(255, 68, 68, 0.2),
          rgba(204, 0, 0, 0.2)
        );
        border: 1px solid rgba(255, 68, 68, 0.5);
        color: #ff4444;
      }

      .alert-info {
        background: linear-gradient(
          135deg,
          rgba(66, 165, 245, 0.2),
          rgba(25, 118, 210, 0.2)
        );
        border: 1px solid rgba(66, 165, 245, 0.5);
        color: #42a5f5;
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

      .action-buttons {
        display: flex;
        gap: 20px;
        justify-content: center;
        flex-wrap: wrap;
      }

      .btn {
        padding: 18px 40px;
        border: none;
        border-radius: 12px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        text-transform: uppercase;
        letter-spacing: 1px;
        display: flex;
        align-items: center;
        gap: 10px;
        min-width: 200px;
        justify-content: center;
      }

      .btn-reserve {
        background: linear-gradient(135deg, #00ff88, #00cc6f);
        color: #000;
        box-shadow: 0 5px 20px rgba(0, 255, 136, 0.3);
      }

      .btn-back {
        background: rgba(255, 140, 0, 0.2);
        color: #ff8c00;
        border: 2px solid #ff8c00;
      }

      .btn:hover:not(:disabled) {
        transform: translateY(-3px);
        box-shadow: 0 10px 30px rgba(255, 140, 0, 0.4);
      }

      .btn-reserve:hover:not(:disabled) {
        box-shadow: 0 10px 30px rgba(0, 255, 136, 0.5);
      }

      .btn:active:not(:disabled) {
        transform: translateY(-1px);
      }

      .btn:disabled {
        opacity: 0.5;
        cursor: not-allowed;
        transform: none !important;
        box-shadow: none !important;
        background: #666 !important;
        color: #999 !important;
      }

      .loading {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.9);
        z-index: 10000;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        gap: 20px;
      }

      .loading.active {
        display: flex;
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

      .loading-text {
        color: #ff8c00;
        font-size: 1.2rem;
        font-weight: 600;
      }

      @media (max-width: 768px) {
        .container {
          padding: 15px;
        }
        .page-header {
          font-size: 1.8rem;
          margin-bottom: 25px;
        }
        .room-info {
          padding: 25px 20px;
        }
        .info-grid {
          grid-template-columns: 1fr;
          gap: 20px;
        }
        .room-header {
          flex-direction: column;
          text-align: center;
        }
        .wifi-controls {
          flex-direction: column;
          align-items: stretch;
        }
        .wifi-select {
          min-width: 100%;
        }
        .action-buttons {
          flex-direction: column;
          align-items: center;
        }
        .btn {
          width: 100%;
          max-width: 300px;
        }
        .image-gallery-grid {
          grid-template-columns: 1fr;
          gap: 10px;
          padding: 15px;
        }
        .fullscreen-close {
          top: 20px;
          right: 20px;
          width: 40px;
          height: 40px;
          font-size: 1.2rem;
        }
      }
    </style>
  </head>
  <body>
    <div class="loading" id="loading">
      <div class="spinner"></div>
      <div class="loading-text">กำลังโหลด...</div>
    </div>

    <div class="bg-animation">
      <div class="floating-shapes"></div>
      <div class="floating-shapes"></div>
      <div class="floating-shapes"></div>
    </div>

    <!-- Fullscreen Image Preview -->
    <div
      class="fullscreen-overlay"
      id="fullscreenOverlay"
      onclick="closeFullscreen()"
    >
      <button class="fullscreen-close" onclick="closeFullscreen()">
        <i class="fas fa-times"></i>
      </button>
      <img
        src=""
        alt="ดูภาพขนาดเต็ม"
        class="fullscreen-image"
        id="fullscreenImage"
      />
    </div>

    <div class="container">
      <div class="page-header">
        <i class="fas fa-door-open"></i>
        รายละเอียดห้องพัก
      </div>

      <!-- Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-warning">
          <i class="fas fa-exclamation-triangle"></i>
          ${message}
        </div>
      </c:if>

      <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
          <i class="fas fa-times-circle"></i>
          ${errorMessage}
        </div>
      </c:if>

      <div
        id="activeRentalAlert"
        class="alert alert-info"
        style="display: none"
      >
        <i class="fas fa-exclamation-circle"></i>
        <span id="activeRentalMessage"></span>
      </div>

      <div class="room-detail-card">
        <!-- Image Gallery Grid (แสดง 4 รูปพร้อมกัน) -->
        <div class="image-gallery-grid">
          <div
            class="gallery-item"
            onclick="openFullscreen('${pageContext.request.contextPath}/image/tc1.jpg')"
          >
            <img
              src="${pageContext.request.contextPath}/image/tc1.jpg"
              alt="ห้องพัก - มุมมองห้องนอนพร้อมตู้เสื้อผ้า"
              onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%23ff8c00%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2228%22 font-weight=%22bold%22 text-anchor=%22middle%22 x=%22400%22 y=%22240%22%3Eห้องพัก - มุมมอง 1%3C/text%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2216%22 text-anchor=%22middle%22 x=%22400%22 y=%22270%22%3Eห้องนอนพร้อมตู้เสื้อผ้า%3C/text%3E%3C/svg%3E';"
            />
            <div class="zoom-icon"><i class="fas fa-search-plus"></i></div>
            <div class="image-label">
              <i class="fas fa-bed"></i>
              มุมมองห้องนอนพร้อมตู้เสื้อผ้า
            </div>
          </div>

          <div
            class="gallery-item"
            onclick="openFullscreen('${pageContext.request.contextPath}/image/tc2.jpg')"
          >
            <img
              src="${pageContext.request.contextPath}/image/tc2.jpg"
              alt="ห้องพัก - ระเบียงพร้อมมุมครัว"
              onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%23ff6b00%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2228%22 font-weight=%22bold%22 text-anchor=%22middle%22 x=%22400%22 y=%22240%22%3Eห้องพัก - มุมมอง 2%3C/text%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2216%22 text-anchor=%22middle%22 x=%22400%22 y=%22270%22%3Eระเบียงพร้อมมุมครัว%3C/text%3E%3C/svg%3E';"
            />
            <div class="zoom-icon"><i class="fas fa-search-plus"></i></div>
            <div class="image-label">
              <i class="fas fa-utensils"></i>
              ระเบียงพร้อมมุมครัว
            </div>
          </div>

          <div
            class="gallery-item"
            onclick="openFullscreen('${pageContext.request.contextPath}/image/tc3.jpg')"
          >
            <img
              src="${pageContext.request.contextPath}/image/tc3.jpg"
              alt="ห้องพัก - ลิฟต์อาคาร"
              onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%2300cc6f%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2228%22 font-weight=%22bold%22 text-anchor=%22middle%22 x=%22400%22 y=%22240%22%3Eห้องพัก - มุมมอง 3%3C/text%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2216%22 text-anchor=%22middle%22 x=%22400%22 y=%22270%22%3Eลิฟต์อาคาร%3C/text%3E%3C/svg%3E';"
            />
            <div class="zoom-icon"><i class="fas fa-search-plus"></i></div>
            <div class="image-label">
              <i class="fas fa-building"></i>
              ลิฟต์อาคาร
            </div>
          </div>

          <div
            class="gallery-item"
            onclick="openFullscreen('${pageContext.request.contextPath}/image/tc4.jpg')"
          >
            <img
              src="${pageContext.request.contextPath}/image/tc4.jpg"
              alt="ห้องพัก - มุมมองห้องทั้งหมด"
              onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%2342a5f5%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2228%22 font-weight=%22bold%22 text-anchor=%22middle%22 x=%22400%22 y=%22240%22%3Eห้องพัก - มุมมอง 4%3C/text%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2216%22 text-anchor=%22middle%22 x=%22400%22 y=%22270%22%3Eมุมมองห้องทั้งหมด%3C/text%3E%3C/svg%3E';"
            />
            <div class="zoom-icon"><i class="fas fa-search-plus"></i></div>
            <div class="image-label">
              <i class="fas fa-home"></i>
              มุมมองห้องทั้งหมด
            </div>
          </div>
        </div>

        <!-- Room Info -->
        <div class="room-info">
          <div class="room-header">
            <div class="room-number">
              <i class="fas fa-home"></i>
              ห้อง ${room.roomNumber}
            </div>
            <div
              class="room-status ${room.roomStatus == 'ว่าง' ? 'status-available' : 'status-occupied'}"
            >
              <i
                class="fas ${room.roomStatus == 'ว่าง' ? 'fa-check-circle' : 'fa-times-circle'}"
              ></i>
              ${room.roomStatus}
            </div>
          </div>

          <c:if test="${room.roomStatus != 'ว่าง'}">
            <div class="alert alert-danger">
              <i class="fas fa-ban"></i>
              ห้องนี้ไม่ว่างในขณะนี้ ไม่สามารถจองได้
            </div>
          </c:if>

          <div class="info-grid">
            <div class="info-section">
              <h3>
                <i class="fas fa-info-circle"></i>
                ข้อมูลห้องพัก
              </h3>
              <div class="info-item">
                <span class="info-label">
                  <i class="fas fa-home"></i>
                  ประเภทห้อง
                </span>
                <span class="info-value">${room.roomtype}</span>
              </div>
              <div class="info-item">
                <span class="info-label">
                  <i class="fas fa-money-bill-wave"></i>
                  ค่าเช่า
                </span>
                <span class="info-value price-highlight"
                  >฿${room.roomPrice}/เดือน</span
                >
              </div>
              <div class="info-item">
                <span class="info-label">
                  <i class="fas fa-bolt"></i>
                  ค่าไฟฟ้า
                </span>
                <span class="info-value">7 บาท/หน่วย</span>
              </div>
            </div>

            <div class="info-section">
              <h3>
                <i class="fas fa-clipboard-list"></i>
                รายละเอียดห้อง
              </h3>
              <div class="info-item">
                <span
                  class="info-value"
                  style="
                    width: 100%;
                    text-align: left;
                    line-height: 1.6;
                    color: #ccc;
                  "
                >
                  ${room.description}
                </span>
              </div>
            </div>
          </div>

          <!-- WiFi Section -->
          <div class="wifi-section">
            <div class="wifi-header">
              <i class="fas fa-wifi"></i>
              อินเทอร์เน็ต Wi-Fi
            </div>
            <div class="wifi-controls">
              <div>
                <select
                  id="Routerwifi"
                  name="Routerwifi"
                  class="wifi-select"
                  onchange="updateWifiPrice()"
                >
                  <option value="เอา">ต้องการ Wi-Fi</option>
                  <option value="ไม่เอา">ไม่ต้องการ Wi-Fi</option>
                </select>
              </div>
              <div class="wifi-price" id="wifiPrice">
                <i class="fas fa-tag"></i> ฿200/เดือน
              </div>
            </div>
          </div>

          <!-- Notice -->
          <div class="notice">
            <div class="notice-icon">
              <i class="fas fa-lightbulb"></i>
            </div>
            <div>
              <strong>หมายเหตุ:</strong> ค่าบริการ Wi-Fi
              สามารถเลือกได้ตามความต้องการ และสามารถเปลี่ยนแปลงได้ในภายหลัง
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="action-buttons">
            <button
              class="btn btn-reserve"
              id="reserveBtn"
              onclick="handleReserve()"
            >
              <i class="fas fa-calendar-check"></i>
              จองห้องพัก
            </button>
            <button class="btn btn-back" onclick="history.back()">
              <i class="fas fa-arrow-left"></i>
              ย้อนกลับ
            </button>
          </div>
        </div>
      </div>
    </div>

    <input type="hidden" id="roomStatus" value="${room.roomStatus}" />
    <input type="hidden" id="isLoggedIn" value="<%=isLoggedIn%>" />

    <script>
      let userActiveRentalData = null;
      let isCheckingRental = false;

      // Fullscreen Image Functions
      function openFullscreen(imageSrc) {
        const overlay = document.getElementById("fullscreenOverlay");
        const image = document.getElementById("fullscreenImage");
        image.src = imageSrc;
        overlay.classList.add("active");
        document.body.style.overflow = "hidden";
      }

      function closeFullscreen() {
        const overlay = document.getElementById("fullscreenOverlay");
        overlay.classList.remove("active");
        document.body.style.overflow = "auto";
      }

      // Check for existing rental function
      async function checkExistingRental() {
        if (isCheckingRental) return userActiveRentalData;

        isCheckingRental = true;

        try {
          const response = await fetch("checkActiveRental");
          const data = await response.json();

          userActiveRentalData = data;
          updateRentalAlert(data);
          updateReserveButton(data);

          return data;
        } catch (error) {
          console.error("Error checking rental status:", error);
          return { hasActiveRental: false };
        } finally {
          isCheckingRental = false;
        }
      }

      // Update rental alert display
      function updateRentalAlert(data) {
        const alertDiv = document.getElementById("activeRentalAlert");
        const messageSpan = document.getElementById("activeRentalMessage");

        if (data.hasActiveRental) {
          const roomList = data.activeRooms ? data.activeRooms.join(", ") : "";
          messageSpan.innerHTML = `
                    <strong>คุณมีการจองห้องอยู่แล้ว ${data.activeRentalCount} ห้อง</strong><br>
                    ห้อง: ${roomList}<br>
                    <small><i class="fas fa-info-circle"></i> กรุณาคืนห้องเก่าก่อนจองห้องใหม่</small>
                `;
          alertDiv.style.display = "flex";
        } else {
          alertDiv.style.display = "none";
        }
      }

      // Update reserve button based on rental status
      function updateReserveButton(data) {
        const reserveBtn = document.getElementById("reserveBtn");
        const roomStatus = document.getElementById("roomStatus").value;
        const wifiSelect = document.getElementById("Routerwifi");

        if (roomStatus !== "ว่าง") {
          reserveBtn.disabled = true;
          reserveBtn.innerHTML =
            '<i class="fas fa-times-circle"></i> ห้องไม่ว่าง';
          wifiSelect.disabled = true;
          return;
        }

        if (data.hasActiveRental) {
          reserveBtn.disabled = true;
          reserveBtn.innerHTML = '<i class="fas fa-ban"></i> ไม่สามารถจองได้';
          reserveBtn.title = `คุณมีการจองห้องอยู่แล้ว: ${data.activeRooms.join(
            ", "
          )}`;
          wifiSelect.disabled = true;
        } else {
          reserveBtn.disabled = false;
          reserveBtn.innerHTML =
            '<i class="fas fa-calendar-check"></i> จองห้องพัก';
          reserveBtn.title = "คลิกเพื่อจองห้องพัก";
          wifiSelect.disabled = false;
        }
      }

      async function handleReserve() {
        const isLoggedIn =
          document.getElementById("isLoggedIn").value === "true";
        const roomStatus = document.getElementById("roomStatus").value;

        if (!isLoggedIn) {
          alert("กรุณาเข้าสู่ระบบก่อนทำการจองห้องพัก");
          window.location.href = "Login";
          return;
        }

        if (roomStatus !== "ว่าง") {
          alert("ห้องนี้ไม่ว่างแล้ว ไม่สามารถจองได้");
          return;
        }

        const loading = document.getElementById("loading");
        loading.classList.add("active");

        try {
          const rentalCheck = await checkExistingRental();

          loading.classList.remove("active");

          if (rentalCheck.hasActiveRental) {
            const roomList = rentalCheck.activeRooms
              ? rentalCheck.activeRooms.join(", ")
              : "";
            alert(
              `คุณมีการจองห้องอยู่แล้ว ${rentalCheck.activeRentalCount} ห้อง (${roomList}) กรุณาคืนห้องเก่าก่อนจองห้องใหม่`
            );
            return;
          }

          loading.classList.add("active");
          setTimeout(() => {
            window.location.href = "Payment?id=${room.roomID}";
          }, 500);
        } catch (error) {
          console.error("Error:", error);
          loading.classList.remove("active");
          alert("เกิดข้อผิดพลาดในการตรวจสอบข้อมูล กรุณาลองใหม่อีกครั้ง");
        }
      }

      function updateWifiPrice() {
        const select = document.getElementById("Routerwifi");
        const priceDisplay = document.getElementById("wifiPrice");

        if (select.value === "เอา") {
          priceDisplay.innerHTML = '<i class="fas fa-tag"></i> ฿200/เดือน';
        } else {
          priceDisplay.innerHTML = '<i class="fas fa-check-circle"></i> ฟรี';
        }
      }

      // Keyboard navigation for fullscreen
      document.addEventListener("keydown", function (e) {
        const overlay = document.getElementById("fullscreenOverlay");

        if (overlay.classList.contains("active") && e.key === "Escape") {
          closeFullscreen();
        }
      });

      // Initialize
      window.addEventListener("load", async function () {
        updateWifiPrice();

        const isLoggedIn =
          document.getElementById("isLoggedIn").value === "true";
        if (isLoggedIn) {
          await checkExistingRental();
        } else {
          const reserveBtn = document.getElementById("reserveBtn");
          const wifiSelect = document.getElementById("Routerwifi");
          const roomStatus = document.getElementById("roomStatus").value;

          if (roomStatus !== "ว่าง") {
            reserveBtn.disabled = true;
            reserveBtn.innerHTML =
              '<i class="fas fa-times-circle"></i> ห้องไม่ว่าง';
            wifiSelect.disabled = true;
          }
        }

        document.body.style.opacity = "0";
        document.body.style.transition = "opacity 0.5s ease-in-out";

        setTimeout(function () {
          document.body.style.opacity = "1";
        }, 100);
      });

      // Periodic checks (every 30 seconds)
      setInterval(() => {
        const isLoggedIn =
          document.getElementById("isLoggedIn").value === "true";
        if (isLoggedIn && !isCheckingRental) {
          checkExistingRental();
        }
      }, 30000);

      // Check when page regains focus
      document.addEventListener("visibilitychange", function () {
        const isLoggedIn =
          document.getElementById("isLoggedIn").value === "true";
        if (!document.hidden && isLoggedIn && !isCheckingRental) {
          checkExistingRental();
        }
      });
    </script>
  </body>
</html>
