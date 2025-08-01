<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>รายละเอียดบิล</title>
</head>
<body>
    <h2>รายละเอียดบิลเลขที่ ${invoice.billID}</h2>
    <p>วันที่ออกบิล: ${invoice.billingDate}</p>
    <p>วันครบกำหนด: ${invoice.dueDate}</p>
    <p>สถานะ: ${invoice.status}</p>
    <p>ยอดรวม: <b>${invoice.totalAmount}</b> บาท</p>

    <hr/>

    <h3>รายการค่าใช้จ่าย</h3>
    <table border="1">
        <thead>
            <tr>
                <th>ประเภท</th>
                <th>จำนวนเงิน</th>
                <th>หน่วย</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${invoiceDetails}" var="detail">
                <tr>
                    <td>${detail.billtype.billname}</td>
                    <td>${detail.amount}</td>
                    <td>${detail.unit}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <p><a href="Listinvoice">← ย้อนกลับ</a></p>
</body>
</html>
