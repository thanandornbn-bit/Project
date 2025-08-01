<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="SaveInvoice" method="post">
	<p>ห้องที่เลือก: ${roomID}</p>
    <input type="hidden" name="rentID" value="${rent.rentID}" />
    
    วันที่ออกบิล: <input type="date" name="billingDate" required><br>
    กำหนดชำระ: <input type="date" name="dueDate" required><br>
    สถานะ:
    <select name="status">
        <option value="pending">รอชำระ</option>
        <option value="paid">ชำระแล้ว</option>
        <option value="overdue">เลยกำหนด</option>
    </select><br><br>

    <table>
        <tr><th>ประเภท</th><th>ยอด</th><th>หน่วย</th></tr>
        <c:forEach var="type" items="${typeList}">
            <tr>
                <td>
                    ${type.billname}
                    <input type="hidden" name="typeID" value="${type.billtypeID}" />
                </td>
                <td><input type="number" step="0.01" name="amount" required /></td>
                <td><input type="text" name="unit" /></td>
            </tr>
        </c:forEach>
    </table>

    <button type="submit">บันทึกบิล</button>
</form>

</body>
</html>