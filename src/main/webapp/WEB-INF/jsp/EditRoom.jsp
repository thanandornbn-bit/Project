<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>แก้ไขห้องพัก</title>
</head>
<body>
    <h1>แก้ไขห้องพัก</h1>

    <form action="UpdateRoom" method="post" enctype="multipart/form-data">
        <input type="hidden" name="roomID" value="${room.roomID}"/>

        เลขห้อง:
        <input type="text" name="roomNumber" value="${room.roomNumber}" required/><br><br>

        ประเภทห้อง:
        <select name="roomtype" required>
            <option value="แอร์"   ${room.roomtype == 'แอร์' ? 'selected' : ''}>แอร์</option>
        </select><br><br>

        คำอธิบาย:
        <input type="text" name="description" value="${room.description}" required/><br><br>

        รูปใหม่ (ถ้าต้องการเปลี่ยน):
        <input type="file" name="images" accept="image/*" multiple/><br><br>

        ราคาห้อง:
        <input type="text" name="roomPrice" value="${room.roomPrice}" required/><br><br>

        <input type="submit" value="อัปเดตห้อง"/>
        <input type="button" value="ย้อนกลับ" onclick="window.location.href='OwnerHome';"/>
    </form>
</body>
</html>
