<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<head><title>รายละเอียดการจอง</title></head>
<body>
    <h2>รายละเอียดการจอง</h2>

    <p><strong>ชื่อผู้จอง:</strong> ${rent.member.firstName} ${rent.member.lastName}</p>
    <p><strong>วันที่จอง:</strong> ${rent.rentDate}</p>

    <c:if test="${not empty rent.rentalDeposit}">
        <h3>ค่ามัดจำ</h3>
        <p><strong>วันที่:</strong> ${rent.rentalDeposit.rentalDepositDate}</p>
        <p><strong>ชื่อบัญชี:</strong> ${rent.rentalDeposit.transferAccountName}</p>
        <p><strong>ยอดเงิน:</strong> ${rent.rentalDeposit.totalPrice}</p>
        <p><strong>สถานะ:</strong> ${rent.rentalDeposit.status}</p>
        <p><strong>วันที่ชำระ:</strong> ${rent.rentalDeposit.paymentDate}</p>
        <p><strong>วันสิ้นสุด:</strong> ${rent.rentalDeposit.deadlineDate}</p>

        <p><strong>สลิปโอนเงิน:</strong><br/>
            
    
<c:if test="${not empty rent.rentalDeposit}">
    <img src="${pageContext.request.contextPath}/SlipImage?rentalDepositId=${rent.rentalDeposit.depositID}" width="300"/>
</c:if>


        </p>

        <c:if test="${rent.rentalDeposit.status != 'เสร็จสมบูรณ์'}">
            <form method="post" action="ConfirmDeposit">
                <input type="hidden" name="depositId" value="${rent.rentalDeposit.rentalDepositID}" />
                <button type="submit">ยืนยันการชำระ</button>
            </form>
        </c:if>
    </c:if>

    <a href="OViewReserve">← กลับ</a>
</body>
</html>