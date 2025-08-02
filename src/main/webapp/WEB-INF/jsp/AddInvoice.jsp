<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>เพิ่มบิล</title>
</head>
<body>
    <h2>เพิ่มบิลห้อง ${room.roomNumber}</h2>

    <form action="saveInvoice" method="post">
        <input type="hidden" name="roomID" value="${room.roomID}" />

        วันที่ออกบิล: <input type="date" name="billingDate" required /><br/>
        วันครบกำหนด: <input type="date" name="dueDate" required /><br/>
        สถานะ: 
        <select name="status">
            <option value="pending">รอดำเนินการ</option>
            <option value="paid">ชำระแล้ว</option>
            <option value="overdue">เกินกำหนด</option>
        </select><br/>

        <h3>รายละเอียดบิล</h3>
        <c:forEach var="type" items="${invoiceTypes}">
            <div>
                <label>${type.billname}</label>
                <input type="hidden" name="billtypeID" value="${type.billtypeID}" />
                จำนวนเงิน: <input type="number" step="0.01" name="amount_${type.billtypeID}" />
                หน่วย: <input type="text" name="unit_${type.billtypeID}" />
            </div>
        </c:forEach>

        <button type="submit">บันทึก</button>
    </form>
</body>
</html>
