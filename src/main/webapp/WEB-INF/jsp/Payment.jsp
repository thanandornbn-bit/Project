<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.springmvc.model.*"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat"%>
<%
Member loginMember = (Member) session.getAttribute("loginMember");
Room reservedRoom = (Room) request.getAttribute("room");
Date today = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy", new Locale("th", "TH"));
String todayStr = sdf.format(today);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
}

.container {
    width: 80%;
    margin: auto;
    padding: 20px;
    background: #fff;
    box-shadow: 0px 0px 10px #ccc;
}

h2 {
    text-align: center;
    color: #2c3e50;
}

.detail, .note, .qr, .form {
    margin: 20px 0;
    font-size: 18px;
}

.note {
    color: red;
    font-style: italic;
}

.qr img {
    display: block;
    margin: auto;
    width: 200px;
    height: auto;
}

input[type="text"], input[type="file"] {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
}

button {
    padding: 10px 20px;
    background-color: #27ae60;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background-color: #219150;
}

.result {
    font-weight: bold;
    margin-top: 10px;
}
</style>
<script>
function calculateDeadline() {
    var paymentDate = document.getElementsByName("paymentDate")[0].value;
    var paymentDateParts = paymentDate.split("/");
    var paymentDateObj = new Date(paymentDateParts[2], paymentDateParts[1] - 1, paymentDateParts[0]);

    // Add 7 days
    paymentDateObj.setDate(paymentDateObj.getDate() + 7);

    var deadline = paymentDateObj.getDate();
    var deadlineMonth = paymentDateObj.getMonth() + 1;
    var deadlineYear = paymentDateObj.getFullYear();
    
    if (deadline < 10) deadline = "0" + deadline;
    if (deadlineMonth < 10) deadlineMonth = "0" + deadlineMonth;

    var formattedDeadline = deadline + "/" + deadlineMonth + "/" + deadlineYear;
    document.getElementsByName("deadline")[0].value = formattedDeadline;
    document.getElementsByName("calculatedDeadline")[0].value = formattedDeadline;
}

document.addEventListener("DOMContentLoaded", function() {
    calculateDeadline();
    document.getElementsByName("paymentDate")[0].addEventListener("change", calculateDeadline);
});
</script>
</head>
<body>

<form action="confirmPayment" method="post" enctype="multipart/form-data">
    <div class="container">
        <h2>Payment</h2>

        <div class="detail">
            <p><strong>Room:</strong> ${room.roomNumber}</p>
            <p><strong>Room Type:</strong> ${room.roomtype}</p>
            <p><strong>Deposit Amount:</strong> <b>500 บาท</b></p>
        </div>

        <div class="note">** หมายเหตุ: หากไม่มาติดต่อที่หอพักภายในระยะเวลาที่กำหนด การจองจะถือว่าเป็นโมฆะ</div>

        <div class="qr">
            <p><strong>ชำระเงินผ่าน QR Code (PromptPay):</strong></p>
            <img src="https://promptpay.io/0635803516/1.png" alt="QR Code PromptPay" />
            <p style="text-align: center;">PromptPay: 063-580-3516<br>จำนวนเงิน: 1 บาท</p>
        </div>

        <div class="form">
            <input type="hidden" name="roomID" value="${room.roomID}" />
            <input type="hidden" name="depositAmount" value="500" />
            <input type="hidden" name="price" value="500" />
            <input type="hidden" name="deadline" />
            
            <label>ชื่อบัญชีที่โอน:</label>
            <input type="text" name="transferAccountName" required />

            <label>วันที่ชำระ:</label>
            <input type="text" name="paymentDate" value="<%=todayStr%>" readonly />

            <label>วันที่สิ้นสุด:</label>
            <input type="text" name="calculatedDeadline" readonly />

            <label>อัปโหลดสลิปโอนเงิน:</label>
            <input type="file" name="paymentSlip" accept="image/*" required />

            <button type="submit">ยืนยันการชำระเงิน</button>
            <button type="submit">ยกเลิก</button>
        </div>
    </div>
</form>
</body>
</html>
