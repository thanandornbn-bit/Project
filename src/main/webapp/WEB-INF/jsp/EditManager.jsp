<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
page session="true" %> <%@ page import="com.springmvc.model.Manager" %> <%
Manager manager = (Manager) session.getAttribute("loginManager"); if (manager ==
null) { response.sendRedirect("Login"); return; } %>
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <title>แก้ไขข้อมูลผู้จัดการ - ThanaChok Place</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <style>
      body {
        font-family: "Sarabun", sans-serif;
        background: #f5f7fa;
      }
      .edit-container {
        max-width: 500px;
        margin: 40px auto;
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 4px 24px rgba(74, 144, 226, 0.12);
        padding: 32px;
      }
      h2 {
        color: #4a90e2;
        text-align: center;
        margin-bottom: 28px;
      }
      .form-group {
        margin-bottom: 20px;
      }
      label {
        font-weight: 600;
        color: #1e3a5f;
        display: block;
        margin-bottom: 8px;
      }
      input[type="text"],
      input[type="email"],
      input[type="password"] {
        width: 100%;
        padding: 12px;
        border-radius: 8px;
        border: 1px solid #d1e8ff;
        font-size: 1rem;
      }
      .btn {
        background: linear-gradient(135deg, #4a90e2, #5ca9e9);
        color: #fff;
        border: none;
        padding: 12px 32px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 1rem;
        cursor: pointer;
        margin-top: 18px;
        width: 100%;
      }
      .btn:hover {
        background: #357abd;
      }
      .message {
        margin-bottom: 18px;
        color: #22c55e;
        text-align: center;
      }
      .error {
        color: #dc2626;
      }
    </style>
  </head>
  <body>
    <div class="edit-container">
      <h2>แก้ไขข้อมูลผู้จัดการ</h2>
      <c:if test="${not empty message}">
        <div class="message">${message}</div>
        <a
          href="OwnerHome"
          class="btn"
          style="margin-top: 10px; background: #22c55e"
          >กลับไปหน้า OwnerHome</a
        >
      </c:if>
      <c:if test="${not empty error}">
        <div class="message error">${error}</div>
      </c:if>
      <form action="EditManager" method="post">
        <div class="form-group">
          <label for="email">อีเมล</label>
          <input
            type="email"
            id="email"
            name="email"
            value="${manager.email}"
            required
          />
        </div>
        <div class="form-group">
          <label for="password">รหัสผ่าน (ถ้าไม่เปลี่ยนให้เว้นว่าง)</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="กรอกรหัสผ่านใหม่ถ้าต้องการเปลี่ยน"
          />
        </div>
        <div class="form-group">
          <label for="promptPayNumber">หมายเลข PromptPay</label>
          <input
            type="text"
            id="promptPayNumber"
            name="promptPayNumber"
            value="${manager.promptPayNumber}"
          />
        </div>
        <div class="form-group">
          <label for="accountName">ชื่อบัญชี</label>
          <input
            type="text"
            id="accountName"
            name="accountName"
            value="${manager.accountName}"
          />
        </div>
        <button type="submit" class="btn">บันทึกข้อมูล</button>
      </form>
    </div>
  </body>
</html>
