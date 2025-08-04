<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page session="true" %>
<%@ page import="com.springmvc.model.Member" %>

<%
    Member loginMember = (Member) session.getAttribute("loginMember");
    if (loginMember == null) {
        response.sendRedirect("Login");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ThanaChok Place</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        .header { font-size: 24px; text-align: center; margin-bottom: 20px; }
        .nav a { margin: 0 10px; text-decoration: none; color: #3498db; }
        table { width: 80%; margin: auto; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        .status-paid { color: green; font-weight: bold; }
        .status-unpaid { color: red; font-weight: bold; }
    </style>
</head>
<body>
    <div class="header">ThanaChok Place - รายการบิลของคุณ</div>

    <div style="text-align:center;">
        Hello, ${loginMember.firstName} ${loginMember.lastName}
    </div>

    <div class="nav" style="text-align:center; margin: 20px;">
        <a href="Homesucess">หน้าหลัก</a>
        <a href="MemberListinvoice">แจ้งหนี้</a>
        <a href="Record">ประวัติการจอง</a>
    </div>

    <c:if test="${empty invoiceList}">
        <p style="text-align:center;">ไม่มีบิลในระบบ</p>
    </c:if>

    <c:if test="${not empty invoiceList}">
        <table>
            <thead>
                <tr>
                    <th>เดือน</th>
                    <th>สถานะ</th>
                    <th>ดูรายละเอียด</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="inv" items="${invoiceList}">
                    <tr>
                        <td>${inv.billingDate}</td>
                        <td>
                            <span class="${inv.status == 'paid' ? 'status-paid' : 'status-unpaid'}">
                                ${inv.status == 'paid' ? 'ชำระแล้ว' : 'ค้างชำระ'}
                            </span>
                        </td>
                        <td><a href="Detailinvoice?billID=${inv.billID}">ดู</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>
