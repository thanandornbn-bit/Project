<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
taglib prefix="fmt" uri="jakarta.tags.fmt" %> <%@ page session="true" %> <%@
page import="com.springmvc.model.Manager" %> <% Manager loginManager = (Manager)
session.getAttribute("loginManager"); if (loginManager == null) {
response.sendRedirect("Login"); return; } %>

<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ประวัติการเข้าพัก - ThanaChok Place</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <style>
      :root {
        --bg: #ffffff;
        --primary: #5ca9e9;
        --primary-dark: #4a90e2;
        --text: #1e3a5f;
        --muted-text: #5b7a9d;
        --accent: #e3f2fd;
        --border: #d1e8ff;
        --success: #4caf50;
        --danger: #f44336;
        --warning: #ff9800;
      }

      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Sarabun", sans-serif;
        background: var(--bg);
        color: var(--text);
        line-height: 1.6;
      }

      .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 30px 20px;
      }

      .page-header {
        text-align: center;
        color: var(--primary);
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
      }

      .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 25px;
        padding: 12px 25px;
        background: var(--accent);
        border: 2px solid var(--border);
        color: var(--primary);
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s ease;
        font-weight: 600;
      }

      .back-btn:hover {
        background: var(--primary);
        color: white;
        transform: translateX(-5px);
      }

      .room-info-card {
        background: linear-gradient(
          135deg,
          var(--primary),
          var(--primary-dark)
        );
        color: white;
        padding: 30px;
        border-radius: 15px;
        margin-bottom: 30px;
        box-shadow: 0 4px 20px rgba(92, 169, 233, 0.3);
      }

      .room-info-card h2 {
        font-size: 2rem;
        margin-bottom: 10px;
      }

      .history-list {
        display: flex;
        flex-direction: column;
        gap: 20px;
      }

      .history-card {
        background: white;
        border: 2px solid var(--border);
        border-radius: 15px;
        padding: 25px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      }

      .history-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(92, 169, 233, 0.15);
        border-color: var(--primary);
      }

      .history-card.current {
        border: 3px solid var(--success);
        background: rgba(76, 175, 80, 0.05);
      }

      .history-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 2px solid var(--accent);
      }

      .member-info {
        display: flex;
        align-items: center;
        gap: 12px;
      }

      .member-avatar {
        width: 50px;
        height: 50px;
        background: var(--primary);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.5rem;
        font-weight: 700;
      }

      .member-name {
        font-size: 1.3rem;
        font-weight: 700;
        color: var(--text);
      }

      .status-badge {
        padding: 8px 16px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.9rem;
        display: inline-flex;
        align-items: center;
        gap: 6px;
      }

      .status-current {
        background: rgba(76, 175, 80, 0.1);
        color: var(--success);
        border: 2px solid var(--success);
      }

      .status-past {
        background: rgba(92, 169, 233, 0.1);
        color: var(--primary);
        border: 2px solid var(--primary);
      }

      .history-details {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 15px;
        margin-bottom: 20px;
      }

      .detail-item {
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .detail-item i {
        color: var(--primary);
        width: 20px;
      }

      .detail-label {
        font-weight: 600;
        color: var(--muted-text);
      }

      .detail-value {
        color: var(--text);
        font-weight: 600;
      }

      .action-buttons {
        display: flex;
        gap: 10px;
        justify-content: flex-end;
      }

      .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 10px;
        font-weight: 600;
        font-family: "Sarabun", sans-serif;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
      }

      .btn-return {
        background: linear-gradient(135deg, var(--warning), #fb8c00);
        color: white;
        box-shadow: 0 4px 12px rgba(255, 152, 0, 0.3);
      }

      .btn-return:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 152, 0, 0.4);
      }

      .btn-undo {
        background: linear-gradient(135deg, #9c27b0, #7b1fa2);
        color: white;
        box-shadow: 0 4px 12px rgba(156, 39, 176, 0.3);
      }

      .btn-undo:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(156, 39, 176, 0.4);
      }

      .empty-state {
        text-align: center;
        padding: 80px 20px;
        color: var(--muted-text);
      }

      .empty-state i {
        font-size: 5rem;
        color: var(--border);
        margin-bottom: 20px;
      }

      .empty-state h3 {
        color: var(--primary);
        font-size: 1.8rem;
        margin-bottom: 10px;
      }

      @media (max-width: 768px) {
        .history-header {
          flex-direction: column;
          align-items: flex-start;
          gap: 15px;
        }

        .history-details {
          grid-template-columns: 1fr;
        }

        .action-buttons {
          width: 100%;
        }

        .btn {
          flex: 1;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="page-header">
        <i class="fas fa-history"></i>
        ประวัติการเข้าพักห้อง
      </div>

      <a href="OwnerHome" class="back-btn">
        <i class="fas fa-arrow-left"></i>
        กลับไปหน้าหลัก
      </a>

      <c:if test="${not empty room}">
        <div class="room-info-card">
          <h2><i class="fas fa-door-open"></i> ห้อง ${room.roomNumber}</h2>
          <p>
            ประเภท: ${room.roomtype} | ราคา: ฿<fmt:formatNumber
              value="${room.roomPrice}"
              groupingUsed="true"
            />/เดือน
          </p>
        </div>
      </c:if>

      <c:choose>
        <c:when test="${empty rentHistory}">
          <div class="empty-state">
            <i class="fas fa-inbox"></i>
            <h3>ไม่มีประวัติการเข้าพัก</h3>
            <p>ห้องนี้ยังไม่เคยมีผู้เข้าพัก</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="history-list">
            <c:forEach var="rent" items="${rentHistory}" varStatus="status">
              <div
                class="history-card ${status.index == 0 && rent.status == 'ชำระแล้ว' ? 'current' : ''}"
              >
                <div class="history-header">
                  <div class="member-info">
                    <div class="member-avatar">
                      ${rent.member.firstName.substring(0,1)}
                    </div>
                    <div>
                      <div class="member-name">
                        ${rent.member.firstName} ${rent.member.lastName}
                      </div>
                      <div style="color: var(--muted-text); font-size: 0.9rem">
                        ${rent.member.email}
                      </div>
                    </div>
                  </div>
                  <c:choose>
                    <c:when
                      test="${status.index == 0 && rent.status == 'ชำระแล้ว'}"
                    >
                      <span class="status-badge status-current">
                        <i class="fas fa-home"></i> กำลังเช่าอยู่
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span class="status-badge status-past">
                        <i class="fas fa-check-circle"></i> เคยเช่า
                      </span>
                    </c:otherwise>
                  </c:choose>
                </div>

                <div class="history-details">
                  <div class="detail-item">
                    <i class="fas fa-calendar-plus"></i>
                    <div>
                      <div class="detail-label">เริ่มเช่า:</div>
                      <div class="detail-value">
                        <fmt:formatDate
                          value="${rent.rentDate}"
                          pattern="dd/MM/yyyy"
                        />
                      </div>
                    </div>
                  </div>

                  <c:if test="${not empty rent.returnDate}">
                    <div class="detail-item">
                      <i class="fas fa-calendar-times"></i>
                      <div>
                        <div class="detail-label">คืนห้อง:</div>
                        <div class="detail-value">
                          <fmt:formatDate
                            value="${rent.returnDate}"
                            pattern="dd/MM/yyyy"
                          />
                        </div>
                      </div>
                    </div>
                  </c:if>

                  <div class="detail-item">
                    <i class="fas fa-money-bill-wave"></i>
                    <div>
                      <div class="detail-label">จำนวนเงิน:</div>
                      <div class="detail-value">
                        ฿<fmt:formatNumber
                          value="${rent.totalPrice}"
                          groupingUsed="true"
                        />
                      </div>
                    </div>
                  </div>

                  <div class="detail-item">
                    <i class="fas fa-phone"></i>
                    <div>
                      <div class="detail-label">เบอร์โทร:</div>
                      <div class="detail-value">${rent.member.phoneNumber}</div>
                    </div>
                  </div>
                </div>

                <c:choose>
                  <c:when
                    test="${rent.status == 'รอคืนห้อง' && status.index == 0}"
                  >
                    <div class="action-buttons">
                      <button
                        class="btn btn-undo"
                        onclick="confirmUndoReturn(${rent.rentID}, '${room.roomNumber}', '${rent.member.firstName} ${rent.member.lastName}')"
                      >
                        <i class="fas fa-undo"></i> ยกเลิกการคืนห้อง
                        (แก้ไขผิดพลาด)
                      </button>
                    </div>
                  </c:when>
                  <c:when
                    test="${status.index == 0 && rent.status == 'ชำระแล้ว'}"
                  >
                  </c:when>
                  <c:when
                    test="${status.index == 0 && rent.status != 'ชำระแล้ว' && rent.status != 'รอคืนห้อง'}"
                  >
                    <div class="action-buttons">
                      <button
                        class="btn btn-undo"
                        onclick="confirmReturnToMember(${rent.rentID}, '${room.roomNumber}', '${rent.member.firstName} ${rent.member.lastName}')"
                      >
                        <i class="fas fa-undo-alt"></i> คืนห้องให้ Member
                        (แก้ไขผิดพลาด)
                      </button>
                    </div>
                  </c:when>
                </c:choose>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <div
      id="undoReturnModal"
      style="
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        z-index: 9999;
        justify-content: center;
        align-items: center;
      "
    >
      <div
        style="
          background: white;
          padding: 30px;
          border-radius: 15px;
          max-width: 500px;
          width: 90%;
        "
      >
        <h3 style="color: #9c27b0; margin-bottom: 20px; font-size: 1.5rem">
          <i class="fas fa-undo"></i> ยกเลิกการคืนห้อง (แก้ไขผิดพลาด)
        </h3>
        <form id="undoReturnForm" action="undoReturnRoom" method="post">
          <input type="hidden" id="undoRentIdInput" name="rentId" />

          <div
            id="undoReturnInfo"
            style="
              margin-bottom: 20px;
              padding: 15px;
              background: rgba(156, 39, 176, 0.1);
              border-radius: 10px;
              border: 2px solid #9c27b0;
            "
          ></div>

          <div
            style="
              margin-bottom: 20px;
              padding: 15px;
              background: #fff3e0;
              border-radius: 10px;
              border: 2px solid #ff9800;
            "
          >
            <strong style="color: #e65100"
              ><i class="fas fa-exclamation-triangle"></i> คำเตือน:</strong
            >
            <p style="margin-top: 8px; color: #5d4037">
              การยกเลิกการคืนห้องจะทำให้ผู้เช่ากลับมาเช่าห้องนี้ต่อ
              และสถานะห้องจะเปลี่ยนเป็น "ไม่ว่าง" อีกครั้ง
            </p>
          </div>

          <div style="margin-bottom: 20px">
            <label
              style="
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                color: var(--text);
              "
            >
              <i class="fas fa-sticky-note"></i> เหตุผลในการแก้ไข:
            </label>
            <textarea
              name="notes"
              rows="3"
              placeholder="ระบุเหตุผล เช่น กดผิดห้อง"
              required
              style="
                width: 100%;
                padding: 12px;
                border: 2px solid var(--border);
                border-radius: 10px;
                font-family: 'Sarabun', sans-serif;
                resize: vertical;
              "
            ></textarea>
          </div>

          <div style="display: flex; gap: 10px; justify-content: flex-end">
            <button
              type="button"
              onclick="closeUndoReturnModal()"
              style="
                padding: 12px 24px;
                background: var(--border);
                border: none;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                font-family: 'Sarabun', sans-serif;
              "
            >
              ยกเลิก
            </button>
            <button
              type="submit"
              style="
                padding: 12px 24px;
                background: linear-gradient(135deg, #9c27b0, #7b1fa2);
                color: white;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                font-family: 'Sarabun', sans-serif;
              "
            >
              <i class="fas fa-check"></i> ยืนยันยกเลิกการคืนห้อง
            </button>
          </div>
        </form>
      </div>
    </div>

    <div
      id="returnRoomModal"
      style="
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        z-index: 9999;
        justify-content: center;
        align-items: center;
      "
    >
      <div
        style="
          background: white;
          padding: 30px;
          border-radius: 15px;
          max-width: 500px;
          width: 90%;
        "
      >
        <h3
          style="color: var(--warning); margin-bottom: 20px; font-size: 1.5rem"
        >
          <i class="fas fa-door-open"></i> ยืนยันการคืนห้อง
        </h3>
        <form id="returnRoomForm" action="returnRoom" method="post">
          <input type="hidden" id="rentIdInput" name="rentId" />

          <div
            id="returnInfo"
            style="
              margin-bottom: 20px;
              padding: 15px;
              background: var(--accent);
              border-radius: 10px;
            "
          ></div>

          <div style="margin-bottom: 20px">
            <label
              style="
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                color: var(--text);
              "
            >
              <i class="fas fa-sticky-note"></i> หมายเหตุ:
            </label>
            <textarea
              name="notes"
              rows="4"
              placeholder="กรอกหมายเหตุเพิ่มเติม (ถ้ามี)"
              style="
                width: 100%;
                padding: 12px;
                border: 2px solid var(--border);
                border-radius: 10px;
                font-family: 'Sarabun', sans-serif;
                resize: vertical;
              "
            ></textarea>
          </div>

          <div style="display: flex; gap: 10px; justify-content: flex-end">
            <button
              type="button"
              onclick="closeReturnRoomModal()"
              style="
                padding: 12px 24px;
                background: var(--border);
                border: none;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                font-family: 'Sarabun', sans-serif;
              "
            >
              ยกเลิก
            </button>
            <button
              type="submit"
              style="
                padding: 12px 24px;
                background: linear-gradient(135deg, var(--warning), #fb8c00);
                color: white;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                font-family: 'Sarabun', sans-serif;
              "
            >
              <i class="fas fa-check"></i> ยืนยันคืนห้อง
            </button>
          </div>
        </form>
      </div>
    </div>

    <script>
      function confirmReturn(rentId, roomNumber, memberName) {
        document.getElementById("rentIdInput").value = rentId;
        document.getElementById("returnInfo").innerHTML =
          "<strong>ห้อง:</strong> " +
          roomNumber +
          "<br>" +
          "<strong>ผู้เช่า:</strong> " +
          memberName;
        document.getElementById("returnRoomModal").style.display = "flex";
      }

      function closeReturnRoomModal() {
        document.getElementById("returnRoomModal").style.display = "none";
      }

      document
        .getElementById("returnRoomForm")
        .addEventListener("submit", function () {
          closeReturnRoomModal();
        });

      function confirmUndoReturn(rentId, roomNumber, memberName) {
        document.getElementById("undoRentIdInput").value = rentId;
        document.getElementById("undoReturnInfo").innerHTML =
          "<strong>ห้อง:</strong> " +
          roomNumber +
          "<br>" +
          "<strong>ผู้เช่า:</strong> " +
          memberName +
          "<br><br>" +
          "<span style='color: #9c27b0;'><strong>จะคืนสถานะให้ผู้เช่ากลับมาเช่าห้องนี้อีกครั้ง</strong></span>";
        document.getElementById("undoReturnModal").style.display = "flex";
      }

      function closeUndoReturnModal() {
        document.getElementById("undoReturnModal").style.display = "none";
      }

      document
        .getElementById("undoReturnForm")
        .addEventListener("submit", function () {
          closeUndoReturnModal();
        });

      function confirmReturnToMember(rentId, roomNumber, memberName) {
        document.getElementById("undoRentIdInput").value = rentId;
        document.getElementById("undoReturnInfo").innerHTML =
          "<strong>ห้อง:</strong> " +
          roomNumber +
          "<br>" +
          "<strong>ผู้เช่า:</strong> " +
          memberName +
          "<br><br>" +
          "<span style='color: #9c27b0;'><strong>คืนห้องให้ผู้เช่ากลับมาเช่าห้องนี้ต่อ</strong></span>" +
          "<br>" +
          "<span style='color: #e65100;'>ใช้ในกรณีที่ Manager คืนห้องผิด</span>";
        document.getElementById("undoReturnModal").style.display = "flex";
      }
    </script>
  </body>
</html>
