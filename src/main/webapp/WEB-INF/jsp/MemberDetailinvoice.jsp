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
    <title>รายละเอียดบิล</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        .header { font-size: 24px; text-align: center; margin-bottom: 20px; }
        table { width: 80%; margin: auto; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        .total { font-weight: bold; color: #2c3e50; }
    </style>
</head>
<body>
    <div class="header">รายละเอียดบิล</div>

    <div style="text-align:center;">
        Hello, ${loginMember.firstName} ${loginMember.lastName}
    </div>

    <div style="text-align:center; margin: 20px;">
        <strong>วันที่ออกบิล:</strong> ${invoice.billingDate} |
        <strong>ครบกำหนด:</strong> ${invoice.dueDate} |
        <strong>สถานะ:</strong> ${invoice.status}
    </div>

    <table>
        <thead>
            <tr>
                <th>ประเภท</th>
                <th>จำนวน</th>
                <th>หน่วย</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="detail" items="${invoiceDetails}">
                <tr>
                    <td>${detail.billtype.billname}</td>
                    <td>${detail.amount}</td>
                    <td>${detail.unit}</td>
                </tr>
            </c:forEach>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="2" class="total">ยอดรวม</td>
                <td class="total">${invoice.totalAmount}</td>
            </tr>
        </tfoot>
    </table>
</body>
</html>
