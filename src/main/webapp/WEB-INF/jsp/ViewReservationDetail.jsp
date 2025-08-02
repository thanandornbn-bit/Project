<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<title>รายละเอียดการจอง</title>
</head>
<body>
	<h2>รายละเอียดการจอง</h2>

	<c:if test="${not empty rent}">
		<table border="1" cellpadding="10">
			<tr>
				<th>เลขห้อง</th>
				<td>${rent.room.roomNumber}</td>
			</tr>
			<tr>
				<th>วันที่จอง</th>
				<td>${rent.rentDate}</td>
			</tr>

			<c:if test="${not empty rent.rentalDeposit}">
				<tr>
					<th>ชื่อบัญชีที่โอน</th>
					<td>${rent.rentalDeposit.transferAccountName}</td>
				</tr>
				<tr>
					<th>วันโอน</th>
					<td>${rent.rentalDeposit.paymentDate}</td>

				</tr>
				<tr>
					<th>วันครบกำหนด</th>
					<td>${rent.rentalDeposit.deadlineDate}</td>
				</tr>
				<tr>
					<th>จำนวนเงินที่ชำระ</th>
					<td>${rent.rentalDeposit.totalPrice}บาท</td>
				</tr>
				
				
<tr>
    <th>สลิปต์</th>
    <td>
        <c:if test="${not empty rent.rentalDeposit.paymentSlipImage}">
            

<img src="${pageContext.request.contextPath}/${rent.rentalDeposit.paymentSlipImage}" width="300px" height="300px" alt="สลิปการโอนเงิน"/>


        </c:if>
        <c:if test="${empty rent.rentalDeposit.paymentSlipImage}">
            <p>ไม่มีภาพสลิปการโอนเงิน</p>
        </c:if>
    </td>
</tr>

			<c:if test="${param.success == '1'}">
    <p style="color: green;">✔ อนุมัติเรียบร้อยแล้ว</p>
</c:if>
			

			</c:if>

			<c:if test="${empty rent.rentalDeposit}">
				<tr>
					<td colspan="2">ยังไม่มีข้อมูลการชำระเงิน</td>
				</tr>
			</c:if>
		</table>
	</c:if>

	<c:if test="${empty rent}">
		<p>ไม่พบข้อมูลการจอง</p>
	</c:if>
	
	<form action="approveDeposit" method="post" style="display:inline;">
    <input type="hidden" name="depositID" value="${rent.rentalDeposit.depositID}" />
    <input type="submit" value="Approve" />
</form>

<form action="OViewReserve" method="get" style="display:inline;">
    <input type="submit" value="Back" />
</form>

	
</body>
</html>
