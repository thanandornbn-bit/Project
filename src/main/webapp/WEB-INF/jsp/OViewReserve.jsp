<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>รายการจองทั้งหมด</h2>
<table border="1">
    <thead>
        <tr>
            <th>เลขห้อง</th>
            <th>ชื่อผู้จอง</th>
            <th>ราคาห้อง</th>
            <th>สถานะค่ามัดจำ</th>
            <th>ดูรายละเอียด</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="rent" items="${rentList}">
            <tr>
                <td>${rent.room.roomNumber}</td>
                <td>${rent.member.firstName} ${rent.member.lastName}</td>
                <td>${rent.room.roomPrice}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty rent.rentalDeposit}">
                            ${rent.rentalDeposit.status}
                        </c:when>
                        <c:otherwise>ไม่มีข้อมูล</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <form action="ViewReservationDetail" method="get">
                        <input type="hidden" name="rentId" value="${rent.rentID}" />
                        <button type="submit">View</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>