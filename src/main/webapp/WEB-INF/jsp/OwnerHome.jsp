<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
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
<html>
<head>
    <meta charset="UTF-8">
    <title>ThanaChok Place - Manager</title>
    <style>
        .action-btn {
            padding: 5px 10px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        .btn-add { background-color: #28a745; color: white; }
        .btn-edit { background-color: #007bff; color: white; }
        .btn-edit-invoice { background-color: #ffc107; color: black; }
        .btn-delete { background-color: #dc3545; color: white; }
        .btn-add:hover { background-color: #218838; }
        .btn-edit:hover { background-color: #0056b3; }
        .btn-edit-invoice:hover { background-color: #e0a800; }
        .btn-delete:hover { background-color: #c82333; }
    </style>
</head>
<body>
    <div class="header">ThanaChok Place - จัดการห้องพัก</div>

    <div class="welcome-message">Welcome, ${loginManager.email}!</div>

    <form action="Logout" method="post">
        <button type="submit" class="logout-btn">Logout</button>
    </form>

    <div class="nav" style="text-align: center;">
        <a href="OwnerHome">หน้าหลัก</a> | <a href="AddRoom">จัดการห้องพัก</a> | <a href="OViewReserve">ดูรายงาน</a>
    </div>

    <form method="get" action="OwnerHome" style="text-align: center; margin-top: 20px;">
        ชั้น:
        <select name="floor">
            <option value="">ทั้งหมด</option>
            <c:forEach var="i" begin="1" end="9">
                <option value="${i}" ${param.floor == i ? 'selected' : ''}>ชั้น ${i}</option>
            </c:forEach>
        </select>
        สถานะ:
        <select name="status">
            <option value="">ทั้งหมด</option>
            <option value="ว่าง" ${param.status == 'ว่าง' ? 'selected' : ''}>ว่าง</option>
            <option value="ไม่ว่าง" ${param.status == 'ไม่ว่าง' ? 'selected' : ''}>ไม่ว่าง</option>
        </select>

        <button type="submit">ค้นหา</button>
    </form>

    <table border="1" style="margin: 20px auto; width: 80%; text-align: center;">
        <thead>
            <tr>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Price</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="room" items="${roomList}">
                <tr>
                    <td>${room.roomNumber}</td>
                    <td>${room.roomtype}</td>
                    <td>${room.roomPrice}</td>
                    <td>${room.roomStatus}</td>
                    <td>
                        <c:if test="${room.roomStatus == 'ไม่ว่าง'}">
                            <a href="ManagerAddInvoice?roomID=${room.roomID}">
                                <button class="action-btn btn-add">เพิ่มบิล</button>
                            </a>
                            <a href="EditInvoice?roomID=${room.roomID}">
                                <button class="action-btn btn-edit-invoice">แก้ไขใบแจ้งหนี้</button>
                            </a>
                        </c:if>
                        <a href="editRoom?id=${room.roomID}">
                            <button class="action-btn btn-edit">แก้ไข</button>
                        </a>
                        <c:if test="${room.roomStatus == 'ว่าง'}">
                            <a href="deleteRoom?id=${room.roomID}" onclick="return confirm('คุณต้องการลบห้อง ${room.roomNumber} ใช่หรือไม่?')">
                                <button class="action-btn btn-delete">ลบ</button>
                            </a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>