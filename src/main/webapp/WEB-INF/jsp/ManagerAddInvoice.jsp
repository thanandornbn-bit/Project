<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>เพิ่มบิลใหม่</title>
    <script>
        function calculateTotal() {
            let roomPrice = parseFloat(document.getElementById("roomPrice").value) || 0;
            let internetPrice = parseFloat(document.getElementById("internetPrice").value) || 0;
            let penalty = parseFloat(document.getElementById("penalty").value) || 0;

            let prevWater = parseFloat(document.getElementById("prevWater").value) || 0;
            let currWater = parseFloat(document.getElementById("currWater").value) || 0;
            let waterRate = parseFloat(document.getElementById("waterRate").value) || 0;
            let waterTotal = (currWater - prevWater) * waterRate;
            document.getElementById("waterTotal").value = waterTotal.toFixed(2);

            let prevElectric = parseFloat(document.getElementById("prevElectric").value) || 0;
            let currElectric = parseFloat(document.getElementById("currElectric").value) || 0;
            let electricRate = parseFloat(document.getElementById("electricRate").value) || 0;
            let electricityTotal = (currElectric - prevElectric) * electricRate;
            if (electricityTotal < 0) electricityTotal = 0;
            document.getElementById("electricityTotal").value = electricityTotal.toFixed(2);

            let total = roomPrice + internetPrice + waterTotal + electricityTotal + penalty;
            document.getElementById("totalPrice").value = total.toFixed(2);
        }

        window.onload = function() { calculateTotal(); }
    </script>
</head>
<body>
<h2>เพิ่มบิลใหม่</h2>

<form action="SaveInvoice" method="post">
    <table>
        <tr>
            <td>เลือกห้อง:</td>
            <td>
                <select name="roomId" id="roomSelect" required>
                    <c:forEach var="rent" items="${rents}">
                        <option value="${rent.room.roomID}"
                                data-price="${rent.room.roomPrice}"
                                <c:if test="${rent.room.roomID == selectedRoomID}">selected</c:if>>
                            ${rent.room.roomNumber} - ${rent.room.description} (ราคา ${rent.room.roomPrice})
                        </option>
                    </c:forEach>
                </select>
                <input type="text" id="roomPrice" name="roomPrice" readonly
                       value="${selectedRoomPrice != null ? selectedRoomPrice : 0}"/>
            </td>
        </tr>

        <tr>
            <td>วันที่ออกบิล:</td>
            <td><input type="text" name="issueDate" value="${today}" readonly/></td>
        </tr>

        <tr>
            <td>วันครบกำหนด:</td>
            <td><input type="text" name="dueDate" value="${dueDate}" readonly/></td>
        </tr>

        <tr>
            <td>ค่าอินเตอร์เน็ต:</td>
            <td><input type="number" id="internetPrice" name="internetPrice" value="100" oninput="calculateTotal()"/></td>
        </tr>

        

        <tr>
            <td>ค่าน้ำ:</td>
            <td>
                หน่วยปัจจุบัน: <input type="number" id="currWater" name="currWater" value="100" oninput="calculateTotal()"/><br/>
                หน่วยเดือนก่อน: <input type="number" id="prevWater" name="prevWater" value="0" oninput="calculateTotal()"/><br/>
                ราคาต่อหน่วย: <input type="number" id="waterRate" name="waterRate" value="1" oninput="calculateTotal()"/><br/>
                รวมค่าน้ำ: <input type="text" id="waterTotal" name="water" readonly/>
            </td>
        </tr>

        <tr>
            <td>ค่าไฟ:</td>
            <td>
                หน่วยปัจจุบัน: <input type="number" id="currElectric" name="currElectric" value="0" oninput="calculateTotal()"/><br/>
                หน่วยเดือนก่อน: <input type="number" id="prevElectric" name="prevElectric" value="0" oninput="calculateTotal()"/><br/>
                ราคาต่อหน่วย: <input type="number" id="electricRate" name="electricRate" value="7" oninput="calculateTotal()"/><br/>
                รวมค่าไฟ: <input type="text" id="electricityTotal" name="electricity" readonly/>
            </td>
        </tr>

        <tr>
            <td>ค่าปรับ:</td>
            <td><input type="number" id="penalty" name="penalty" value="0" oninput="calculateTotal()"/></td>
        </tr>

        <tr>
            <td>ราคารวม:</td>
            <td><input type="text" id="totalPrice" name="totalPrice" readonly/></td>
        </tr>

        <tr>
            <td>สถานะการชำระ:</td>
            <td>
                <select name="statusId">
                    <option value="1">ชำระแล้ว</option>
                    <option value="0">ยังไม่ได้ชำระ</option>
                </select>
            </td>
        </tr>
    </table>

    <br/>
    <button type="submit">บันทึกบิล</button>
</form>
</body>
</html>
