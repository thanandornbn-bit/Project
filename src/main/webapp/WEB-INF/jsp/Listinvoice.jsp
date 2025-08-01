<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>รายการบิลของคุณ</title>
</head>
<body>
    <h2>รายการบิลค่าเช่ารายเดือน</h2>

    <c:if test="${empty invoiceList}">
        <p>ไม่มีบิลในระบบ</p>
    </c:if>

    <c:if test="${not empty invoiceList}">
        <table border="1">
            <thead>
                <tr>
                    <th>รหัสบิล</th>
                    <th>วันที่ออกบิล</th>
                    <th>ครบกำหนด</th>
                    <th>สถานะ</th>
                    <th>ยอดรวม (บาท)</th>
                    <th>ดูรายละเอียด</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${invoiceList}" var="inv">
                    <tr>
                        <td>${inv.billID}</td>
                        <td>${inv.billingDate}</td>
                        <td>${inv.dueDate}</td>
                        <td>${inv.status}</td>
                        <td>${inv.totalAmount}</td>
                        <td>
                            <a href="Detailinvoice?billID=${inv.billID}">ดู</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>
