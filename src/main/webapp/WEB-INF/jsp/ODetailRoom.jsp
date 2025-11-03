<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
page import="com.springmvc.model.*" %> <% Member loginMember=(Member)
session.getAttribute("loginMember"); boolean isLoggedIn=(loginMember !=null); %>

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
    <link
      href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      :root {
        --bg: #ffffff;
        --muted-bg: #f0f7ff;
        --primary: #5ca9e9;
        --primary-dark: #4a90e2;
        --accent: #e3f2fd;
        --text: #1e3a5f;
        --muted-text: #5b7a9d;
        --card-border: #d1e8ff;
        --hover-bg: #e8f4ff;
        --success: #22c55e;
        --warning: #ffa500;
        --error: #ef4444;
      }

      body {
        font-family: "Sarabun", system-ui, -apple-system, "Segoe UI", Roboto,
          "Helvetica Neue", Arial;
        background: var(--bg);
        min-height: 100vh;
        color: var(--text);
        overflow-x: hidden;
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
        color: var(--primary);
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
      }

      .room-detail-card {
        background: white;
        border-radius: 20px;
        box-shadow: 0 8px 24px rgba(92, 169, 233, 0.12);
        border: 2px solid var(--card-border);
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

      /* Image Gallery Styles */
      .image-gallery-container {
        position: relative;
        width: 100%;
        background: #000;
        padding: 0;
        overflow: hidden;
      }

      .image-gallery-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 0;
        width: 100%;
        height: 600px;
      }

      .gallery-item {
        position: relative;
        width: 100%;
        height: 100%;
        overflow: hidden;
        cursor: pointer;
        transition: all 0.3s ease;
      }

      .gallery-item:hover {
        transform: scale(1.02);
        z-index: 2;
      }

      .gallery-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
        transition: all 0.3s ease;
      }

      .gallery-item:hover img {
        filter: brightness(1.1);
      }

      .image-label {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        background: linear-gradient(to top, rgba(0, 0, 0, 0.8), transparent);
        padding: 20px;
        color: white;
        font-size: 1rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 10px;
        opacity: 0;
        transition: opacity 0.3s ease;
      }

      .gallery-item:hover .image-label {
        opacity: 1;
      }

      .zoom-icon {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: rgba(92, 169, 233, 0.9);
        color: white;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        opacity: 0;
        transition: all 0.3s ease;
        pointer-events: none;
      }

      .gallery-item:hover .zoom-icon {
        opacity: 1;
        transform: translate(-50%, -50%) scale(1.1);
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
        background: var(--primary);
        color: white;
        border: none;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        cursor: pointer;
        font-size: 1.5rem;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(74, 144, 226, 0.4);
      }

      .fullscreen-close:hover {
        background: var(--primary-dark);
        transform: rotate(90deg) scale(1.1);
        box-shadow: 0 6px 16px rgba(74, 144, 226, 0.5);
      }

      .room-info {
        padding: 35px 40px;
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
        font-weight: 700;
        color: var(--primary);
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .room-status {
        padding: 10px 20px;
        border-radius: 25px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .status-available {
        background: #d4f4dd;
        color: var(--success);
        border: 2px solid var(--success);
        box-shadow: 0 4px 15px rgba(34, 197, 94, 0.2);
      }

      .status-occupied {
        background: #ffe4e6;
        color: var(--error);
        border: 2px solid var(--error);
        box-shadow: 0 4px 15px rgba(239, 68, 68, 0.2);
      }

      .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
      }

      .info-section {
        background: var(--muted-bg);
        padding: 25px;
        border-radius: 15px;
        border: 2px solid var(--card-border);
        transition: all 0.3s ease;
      }

      .info-section:hover {
        border-color: var(--primary);
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(92, 169, 233, 0.15);
      }

      .info-section h3 {
        color: var(--primary);
        margin-bottom: 20px;
        font-size: 1.3rem;
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 700;
      }

      .info-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 0;
        border-bottom: 1px solid var(--accent);
      }

      .info-item:last-child {
        border-bottom: none;
      }

      .info-label {
        font-weight: 600;
        color: var(--muted-text);
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .info-value {
        font-weight: 700;
        color: var(--text);
      }

      .price-highlight {
        font-size: 1.3rem;
        color: var(--primary);
        font-weight: 700;
      }

      .wifi-section {
        background: var(--accent);
        border: 2px solid var(--card-border);
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
        font-weight: 700;
        color: var(--primary);
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
        border: 2px solid var(--card-border);
        border-radius: 10px;
        font-size: 1rem;
        background: white;
        color: var(--text);
        cursor: pointer;
        transition: all 0.3s ease;
        min-width: 200px;
        font-weight: 600;
        font-family: "Sarabun", sans-serif;
      }

      .wifi-select:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 15px rgba(92, 169, 233, 0.2);
      }

      .wifi-select:disabled {
        opacity: 0.5;
        cursor: not-allowed;
        background: #f5f5f5;
      }

      .wifi-price {
        font-size: 1.2rem;
        font-weight: 700;
        padding: 10px 20px;
        background: white;
        border: 2px solid var(--primary);
        border-radius: 20px;
        color: var(--primary);
      }

      .notice {
        background: var(--accent);
        border: 2px solid var(--card-border);
        padding: 20px;
        border-radius: 15px;
        margin-bottom: 30px;
        display: flex;
        align-items: center;
        gap: 15px;
        color: var(--muted-text);
        font-weight: 500;
      }

      .notice-icon {
        font-size: 1.5rem;
        color: var(--primary);
      }

      .alert {
        padding: 18px 25px;
        border-radius: 12px;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 12px;
        font-weight: 600;
        animation: slideDown 0.5s ease;
        box-shadow: 0 4px 12px rgba(74, 144, 226, 0.1);
      }

      .alert-warning {
        background: #fff3cd;
        border: 2px solid var(--warning);
        color: #856404;
      }

      .alert-danger {
        background: #ffe4e6;
        border: 2px solid var(--error);
        color: var(--error);
      }

      .alert-info {
        background: var(--accent);
        border: 2px solid var(--primary);
        color: var(--primary-dark);
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
        margin-top: 30px;
      }

      .btn {
        padding: 16px 40px;
        border: none;
        border-radius: 12px;
        font-size: 1.1rem;
        font-weight: 700;
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
        background: linear-gradient(
          135deg,
          var(--primary) 0%,
          var(--primary-dark) 100%
        );
        color: white;
        box-shadow: 0 5px 20px rgba(74, 144, 226, 0.3);
      }

      .btn-back {
        background: white;
        color: var(--primary);
        border: 2px solid var(--primary);
      }

      .btn:hover:not(:disabled) {
        transform: translateY(-3px);
        box-shadow: 0 10px 30px rgba(74, 144, 226, 0.4);
      }

      .btn-reserve:hover:not(:disabled) {
        box-shadow: 0 10px 30px rgba(74, 144, 226, 0.5);
      }

      .btn-back:hover:not(:disabled) {
        background: var(--hover-bg);
      }

      .btn:active:not(:disabled) {
        transform: translateY(-1px);
      }

      .btn:disabled {
        opacity: 0.6;
        cursor: not-allowed;
        transform: none !important;
        box-shadow: none !important;
        background: #9ca3af !important;
        color: #e5e7eb !important;
        border: none !important;
      }

      .loading {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        backdrop-filter: blur(4px);
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
        border: 6px solid rgba(92, 169, 233, 0.2);
        border-top: 6px solid var(--primary);
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
        color: var(--primary);
        font-size: 1.2rem;
        font-weight: 700;
      }

      /* Modal Popup Styles */
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
        background: linear-gradient(145deg, #ffffff, #f0f8ff);
        padding: 30px;
        border: 2px solid var(--primary-dark);
        border-radius: 15px;
        width: 90%;
        max-width: 500px;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        box-shadow: 0 10px 40px rgba(74, 144, 226, 0.3);
        text-align: center;
        animation: modalFadeIn 0.3s ease-out;
      }

      @keyframes modalFadeIn {
        from {
          opacity: 0;
          transform: translate(-50%, -50%) scale(0.9);
        }

        to {
          opacity: 1;
          transform: translate(-50%, -50%) scale(1);
        }
      }

      .modal-header {
        margin-bottom: 20px;
      }

      .modal-header i {
        font-size: 3rem;
        color: var(--error);
        margin-bottom: 15px;
      }

      .modal-header h2 {
        color: var(--error);
        font-size: 1.5rem;
        margin: 0;
        font-weight: 700;
      }

      .modal-body {
        color: var(--text);
        font-size: 1.1rem;
        line-height: 1.6;
        margin-bottom: 25px;
      }

      .modal-body h3 {
        color: var(--primary);
        margin: 10px 0;
        font-weight: 700;
      }

      .modal-footer .modal-btn {
        padding: 14px 40px;
        border: none;
        border-radius: 25px;
        font-size: 1.1rem;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.3s ease;
        background: linear-gradient(135deg, var(--error), #dc2626);
        color: white;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        font-family: "Sarabun", sans-serif;
      }

      .modal-footer .modal-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(239, 68, 68, 0.5);
        background: linear-gradient(135deg, #dc2626, #b91c1c);
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
          height: auto;
        }

        .gallery-item {
          height: 300px;
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

    <!-- Modal Popup -->
    <div class="modal" id="alertModal">
      <div class="modal-content">
        <div class="modal-header">
          <i class="fas fa-exclamation-triangle"></i>
          <h2>ไม่สามารถจองห้องได้</h2>
        </div>
        <div class="modal-body" id="modalMessage">
          <p>คุณมีการจองหรือเช่าห้องอยู่แล้ว</p>
        </div>
        <div class="modal-footer">
          <button class="modal-btn" onclick="closeModal()">
            <i class="fas fa-times"></i> ปิด
          </button>
        </div>
      </div>
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
        <!-- Image Gallery -->
        <div class="image-gallery-container">
          <div class="image-gallery-grid">
            <!-- Room Image 1 -->
            <c:choose>
              <c:when test="${not empty room.roomImage1}">
                <div
                  class="gallery-item"
                  onclick="openFullscreen('${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=1')"
                >
                  <img
                    src="${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=1"
                    alt="ห้องพัก ${room.roomNumber} - รูปที่ 1"
                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/tc1.jpg';"
                  />
                  <div class="zoom-icon">
                    <i class="fas fa-search-plus"></i>
                  </div>
                  <div class="image-label">
                    <i class="fas fa-image"></i>
                    รูปห้องพัก 1
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <div
                  class="gallery-item"
                  onclick="openFullscreen('${pageContext.request.contextPath}/image/tc1.jpg')"
                >
                  <img
                    src="${pageContext.request.contextPath}/image/tc1.jpg"
                    alt="ห้องพัก - มุมมองห้องนอนพร้อมตู้เสื้อผ้า"
                    onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%23ff8c00%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2228%22 font-weight=%22bold%22 text-anchor=%22middle%22 x=%22400%22 y=%22240%22%3Eห้องพัก - มุมมอง 1%3C/text%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2216%22 text-anchor=%22middle%22 x=%22400%22 y=%22270%22%3Eห้องนอนพร้อมตู้เสื้อผ้า%3C/text%3E%3C/svg%3E';"
                  />
                  <div class="zoom-icon">
                    <i class="fas fa-search-plus"></i>
                  </div>
                  <div class="image-label">
                    <i class="fas fa-bed"></i>
                    มุมมองห้องนอนพร้อมตู้เสื้อผ้า
                  </div>
                </div>
              </c:otherwise>
            </c:choose>

            <!-- Room Image 2 -->
            <c:choose>
              <c:when test="${not empty room.roomImage2}">
                <div
                  class="gallery-item"
                  onclick="openFullscreen('${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=2')"
                >
                  <img
                    src="${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=2"
                    alt="ห้องพัก ${room.roomNumber} - รูปที่ 2"
                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/tc2.jpg';"
                  />
                  <div class="zoom-icon">
                    <i class="fas fa-search-plus"></i>
                  </div>
                  <div class="image-label">
                    <i class="fas fa-image"></i>
                    รูปห้องพัก 2
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <div
                  class="gallery-item"
                  onclick="openFullscreen('${pageContext.request.contextPath}/image/tc2.jpg')"
                >
                  <img
                    src="${pageContext.request.contextPath}/image/tc2.jpg"
                    alt="ห้องพัก - ระเบียงพร้อมมุมครัว"
                    onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%23ff6b00%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2228%22 font-weight=%22bold%22 text-anchor=%22middle%22 x=%22400%22 y=%22240%22%3Eห้องพัก - มุมมอง 2%3C/text%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2216%22 text-anchor=%22middle%22 x=%22400%22 y=%22270%22%3Eระเบียงพร้อมมุมครัว%3C/text%3E%3C/svg%3E';"
                  />
                  <div class="zoom-icon">
                    <i class="fas fa-search-plus"></i>
                  </div>
                  <div class="image-label">
                    <i class="fas fa-utensils"></i>
                    ระเบียงพร้อมมุมครัว
                  </div>
                </div>
              </c:otherwise>
            </c:choose>

            <!-- Room Image 3 -->
            <c:choose>
              <c:when test="${not empty room.roomImage3}">
                <div
                  class="gallery-item"
                  onclick="openFullscreen('${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=3')"
                >
                  <img
                    src="${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=3"
                    alt="ห้องพัก ${room.roomNumber} - รูปที่ 3"
                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/tc3.jpg';"
                  />
                  <div class="zoom-icon">
                    <i class="fas fa-search-plus"></i>
                  </div>
                  <div class="image-label">
                    <i class="fas fa-image"></i>
                    รูปห้องพัก 3
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <div
                  class="gallery-item"
                  onclick="openFullscreen('${pageContext.request.contextPath}/image/tc3.jpg')"
                >
                  <img
                    src="${pageContext.request.contextPath}/image/tc3.jpg"
                    alt="ห้องพัก - ลิฟต์อาคาร"
                    onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%2300cc6f%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2228%22 font-weight=%22bold%22 text-anchor=%22middle%22 x=%22400%22 y=%22240%22%3Eห้องพัก - มุมมอง 3%3C/text%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2216%22 text-anchor=%22middle%22 x=%22400%22 y=%22270%22%3Eลิฟต์อาคาร%3C/text%3E%3C/svg%3E';"
                  />
                  <div class="zoom-icon">
                    <i class="fas fa-search-plus"></i>
                  </div>
                  <div class="image-label">
                    <i class="fas fa-building"></i>
                    ลิฟต์อาคาร
                  </div>
                </div>
              </c:otherwise>
            </c:choose>

            <!-- Room Image 4 -->
            <c:choose>
              <c:when test="${not empty room.roomImage4}">
                <div
                  class="gallery-item"
                  onclick="openFullscreen('${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=4')"
                >
                  <img
                    src="${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=4"
                    alt="ห้องพัก ${room.roomNumber} - รูปที่ 4"
                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/tc4.jpg';"
                  />
                  <div class="zoom-icon">
                    <i class="fas fa-search-plus"></i>
                  </div>
                  <div class="image-label">
                    <i class="fas fa-image"></i>
                    รูปห้องพัก 4
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <div
                  class="gallery-item"
                  onclick="openFullscreen('${pageContext.request.contextPath}/image/tc4.jpg')"
                >
                  <img
                    src="${pageContext.request.contextPath}/image/tc4.jpg"
                    alt="ห้องพัก - มุมมองห้องทั้งหมด"
                    onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%2342a5f5%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2228%22 font-weight=%22bold%22 text-anchor=%22middle%22 x=%22400%22 y=%22240%22%3Eห้องพัก - มุมมอง 4%3C/text%3E%3Ctext fill=%22%23ffffff%22 font-family=%22Arial%22 font-size=%2216%22 text-anchor=%22middle%22 x=%22400%22 y=%22270%22%3Eมุมมองห้องทั้งหมด%3C/text%3E%3C/svg%3E';"
                  />
                  <div class="zoom-icon">
                    <i class="fas fa-search-plus"></i>
                  </div>
                  <div class="image-label">
                    <i class="fas fa-home"></i>
                    มุมมองห้องทั้งหมด
                  </div>
                </div>
              </c:otherwise>
            </c:choose>
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
                    word-wrap: break-word;
                    word-break: break-word;
                    white-space: pre-wrap;
                    overflow-wrap: break-word;
                    display: block;
                  "
                >
                  ${room.description}
                </span>
              </div>
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

      function closeModal() {
        document.getElementById("alertModal").style.display = "none";
        document.body.style.overflow = "auto";
      }

      function showModal(message) {
        document.getElementById("modalMessage").innerHTML = message;
        document.getElementById("alertModal").style.display = "block";
        document.body.style.overflow = "hidden";
      }

      function showReservationModal(roomID, roomNumber) {
        const today = new Date();
        const minDate = new Date(today);
        minDate.setDate(today.getDate() + 5); // เพิ่ม 5 วัน

        const todayStr = today.toISOString().split("T")[0];
        const minDateStr = minDate.toISOString().split("T")[0];

        const modalContent =
          `
          <div style="text-align: center;">
            <i class="fas fa-calendar-check" style="font-size: 3rem; color: var(--success); margin-bottom: 20px;"></i>
            <h3 style="color: var(--primary); margin-bottom: 15px; font-size: 1.5rem; font-weight: 700;">ยืนยันการจองห้องพัก</h3>
            <div style="margin: 20px 0; padding: 20px; background: rgba(74, 144, 226, 0.1); border-radius: 12px; border: 2px solid var(--primary);">
              <p style="font-size: 0.9rem; color: var(--muted-text); margin-bottom: 8px; font-weight: 600;">หมายเลขห้อง</p>
              <p style="font-size: 2rem; font-weight: 700; color: var(--primary); margin: 0;">` +
          roomNumber +
          `</p>
            </div>
            <form id="reserveForm" style="margin-top: 20px;">
              <div style="margin-bottom: 15px;">
                <label style="display: block; color: var(--primary); margin-bottom: 8px; font-weight: 700; font-size: 1rem;">
                  <i class="fas fa-calendar"></i> วันที่ต้องการเข้าพัก:
                </label>
                <input type="date" id="checkInDate" name="checkInDate" 
                       min="` +
          minDateStr +
          `" required
                       style="padding: 14px; border-radius: 12px; border: 2px solid var(--primary); 
                              background: var(--muted-bg); color: var(--text); font-size: 1rem; width: 100%; max-width: 400px;
                              font-family: 'Sarabun', sans-serif; font-weight: 600;">
                <p style="font-size: 0.85rem; color: var(--error); margin-top: 8px; margin-bottom: 0; font-weight: 600;">
                  <i class="fas fa-exclamation-circle"></i> ต้องจองล่วงหน้าอย่างน้อย 5 วัน (เลือกได้ตั้งแต่วันที่ ` +
          minDateStr +
          `)
                </p>
              </div>
              <input type="hidden" name="roomID" value="` +
          roomID +
          `">
              <button type="submit" style="background: linear-gradient(135deg, var(--success), #16A34A); 
                                            color: white; border: none; padding: 14px 40px; 
                                            border-radius: 25px; font-size: 1.1rem; font-weight: 700; 
                                            cursor: pointer; margin-top: 15px; box-shadow: 0 4px 12px rgba(34, 197, 94, 0.3);
                                            transition: all 0.3s ease; font-family: 'Sarabun', sans-serif;">
                <i class="fas fa-check"></i> ยืนยันการจอง
              </button>
            </form>
            <p style="margin-top: 20px; color: var(--muted-text); font-size: 0.9rem; font-weight: 500;">
              <i class="fas fa-info-circle"></i> หลังจากส่งคำขอ ผู้จัดการจะตรวจสอบและอนุมัติภายใน 24 ชั่วโมง
            </p>
          </div>
        `;

        document.getElementById("modalMessage").innerHTML = modalContent;
        document.getElementById("alertModal").style.display = "block";
        document.body.style.overflow = "hidden";

        // จัดการการส่งฟอร์ม
        setTimeout(() => {
          document
            .getElementById("reserveForm")
            .addEventListener("submit", function (e) {
              e.preventDefault();
              const checkInDate = document.getElementById("checkInDate").value;
              if (!checkInDate) {
                alert("กรุณาเลือกวันที่เข้าพัก");
                return;
              }

              // ตรวจสอบว่าวันที่เข้าพักอยู่ในอนาคตอย่างน้อย 5 วัน
              const selectedDate = new Date(checkInDate);
              const todayDate = new Date();
              todayDate.setHours(0, 0, 0, 0);
              selectedDate.setHours(0, 0, 0, 0);

              const diffTime = selectedDate - todayDate;
              const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

              if (diffDays < 5) {
                alert("กรุณาเลือกวันที่เข้าพักล่วงหน้าอย่างน้อย 5 วัน");
                return;
              }

              // แสดง loading
              document.getElementById("loading").classList.add("active");
              closeModal();

              // สร้างฟอร์มและส่งข้อมูล
              const form = document.createElement("form");
              form.method = "POST";
              form.action = "MemberReserveRoom";

              const roomInput = document.createElement("input");
              roomInput.type = "hidden";
              roomInput.name = "roomID";
              roomInput.value = roomID;

              const dateInput = document.createElement("input");
              dateInput.type = "hidden";
              dateInput.name = "checkInDate";
              dateInput.value = checkInDate;

              // ส่งเวลาจองปัจจุบัน
              const timestampInput = document.createElement("input");
              timestampInput.type = "hidden";
              timestampInput.name = "reserveTimestamp";
              timestampInput.value = new Date().toISOString();

              form.appendChild(roomInput);
              form.appendChild(dateInput);
              form.appendChild(timestampInput);
              document.body.appendChild(form);
              form.submit();
            });
        }, 100);
      }

      async function handleReserve() {
        const isLoggedIn =
          document.getElementById("isLoggedIn").value === "true";
        const roomStatus = document.getElementById("roomStatus").value;

        if (!isLoggedIn) {
          const loginMessage = `
            <div style="text-align: center;">
              <i class="fas fa-sign-in-alt" style="font-size: 3rem; color: var(--primary); margin-bottom: 20px;"></i>
              <h3 style="color: var(--primary); margin-bottom: 15px; font-size: 1.5rem;">กรุณาเข้าสู่ระบบ</h3>
              <p style="font-size: 1.1rem; color: var(--text); margin: 20px 0;">
                คุณต้องเข้าสู่ระบบก่อนทำการจองห้องพัก
              </p>
            </div>
          `;
          showModal(loginMessage);
          setTimeout(() => {
            window.location.href = "Login";
          }, 2000);
          return;
        }

        if (roomStatus !== "ว่าง") {
          const unavailableMessage = `
            <div style="text-align: center;">
              <i class="fas fa-ban" style="font-size: 3rem; color: var(--error); margin-bottom: 20px;"></i>
              <h3 style="color: var(--error); margin-bottom: 15px; font-size: 1.5rem;">ไม่สามารถจองได้</h3>
              <p style="font-size: 1.1rem; color: var(--text); margin: 20px 0;">
                ห้องนี้ไม่ว่างในขณะนี้
              </p>
            </div>
          `;
          showModal(unavailableMessage);
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
            const alertMessage = `
              <div style="text-align: center;">
                <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: var(--error); margin-bottom: 20px;"></i>
                <h3 style="color: var(--error); margin-bottom: 15px; font-size: 1.5rem;">ไม่สามารถจองห้องได้</h3>
                <div style="margin: 20px 0; padding: 15px; background: rgba(239, 68, 68, 0.1); border-radius: 12px; border: 2px solid var(--error);">
                  <p style="font-size: 1.1rem; margin-bottom: 10px; color: var(--text); font-weight: 600;">
                    คุณมีการจองหรือเช่าห้องอยู่แล้ว ${rentalCheck.activeRentalCount} รายการ
                  </p>
                  <p style="font-size: 1rem; color: var(--muted-text); margin: 10px 0;">
                    <strong>ห้อง:</strong> ${roomList}
                  </p>
                </div>
                <p style="color: var(--muted-text); margin-top: 15px; font-size: 0.95rem;">
                  <i class="fas fa-info-circle"></i> กรุณาคืนห้องเก่าในหน้า "ประวัติการจอง" ก่อนจองห้องใหม่
                </p>
              </div>
            `;
            showModal(alertMessage);
            return;
          }

          // ถ้าไม่มีการจอง แสดง popup เลือกวันที่
          showReservationModal("${room.roomID}", "${room.roomNumber}");
        } catch (error) {
          console.error("Error:", error);
          loading.classList.remove("active");
          const errorMessage = `
            <div style="text-align: center;">
              <i class="fas fa-exclamation-circle" style="font-size: 3rem; color: var(--warning); margin-bottom: 20px;"></i>
              <h3 style="color: var(--warning); margin-bottom: 15px; font-size: 1.5rem;">เกิดข้อผิดพลาด</h3>
              <p style="font-size: 1.1rem; color: var(--text); margin: 20px 0;">
                ไม่สามารถตรวจสอบข้อมูลได้ กรุณาลองใหม่อีกครั้ง
              </p>
            </div>
          `;
          showModal(errorMessage);
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

      // Keyboard navigation for fullscreen and modal
      document.addEventListener("keydown", function (e) {
        const overlay = document.getElementById("fullscreenOverlay");
        const modal = document.getElementById("alertModal");

        if (overlay.classList.contains("active") && e.key === "Escape") {
          closeFullscreen();
        }

        if (modal.style.display === "block" && e.key === "Escape") {
          closeModal();
        }
      });

      // Close modal when clicking outside
      window.onclick = function (event) {
        const modal = document.getElementById("alertModal");
        if (event.target == modal) {
          closeModal();
        }
      };

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
