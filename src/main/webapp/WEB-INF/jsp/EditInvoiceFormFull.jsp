<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ page session="true" %>
                <%@ page import="com.springmvc.model.Manager" %>

                    <% Manager loginManager=(Manager) session.getAttribute("loginManager"); if (loginManager==null) {
                        response.sendRedirect("Login"); return; } %>

                        <!DOCTYPE html>
                        <html lang="th">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>แก้ไขบิล #INV-${invoice.invoiceId} - ThanaChok Place</title>
                            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                                rel="stylesheet">
                            <link
                                href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
                                rel="stylesheet">
                            <style>
                                :root {
                                    --bg: #ffffff;
                                    --text: #2c3e50;
                                    --primary: #5ca9e9;
                                    --primary-dark: #4a8ac7;
                                    --muted-bg: #f0f7ff;
                                    --accent: #e3f2fd;
                                    --success: #4caf50;
                                    --warning: #ffc107;
                                    --danger: #f44336;
                                    --card-border: #d1e8ff;
                                    --hover-bg: #e8f4ff;
                                }

                                * {
                                    margin: 0;
                                    padding: 0;
                                    box-sizing: border-box;
                                }

                                body {
                                    font-family: "Sarabun", sans-serif;
                                    background: var(--bg);
                                    min-height: 100vh;
                                    color: var(--text);
                                    line-height: 1.6;
                                }

                                .container {
                                    max-width: 1400px;
                                    margin: 0 auto;
                                    padding: 30px 20px;
                                }

                                .page-header {
                                    text-align: center;
                                    color: var(--primary);
                                    font-size: 2.5rem;
                                    font-weight: 700;
                                    margin-bottom: 30px;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    gap: 15px;
                                }

                                .back-btn {
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 8px;
                                    margin-bottom: 25px;
                                    padding: 12px 24px;
                                    background: var(--primary);
                                    color: white;
                                    text-decoration: none;
                                    border-radius: 8px;
                                    transition: all 0.3s ease;
                                    font-weight: 600;
                                    border: none;
                                }

                                .back-btn:hover {
                                    background: var(--primary-dark);
                                    transform: translateX(-5px);
                                    box-shadow: 0 4px 12px rgba(92, 169, 233, 0.3);
                                }

                                .form-card {
                                    background: white;
                                    border-radius: 12px;
                                    box-shadow: 0 2px 8px rgba(92, 169, 233, 0.08);
                                    border: 1px solid var(--card-border);
                                    overflow: hidden;
                                }

                                .card-header {
                                    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                                    color: white;
                                    padding: 24px 28px;
                                }

                                .card-header h2 {
                                    font-size: 1.5rem;
                                    font-weight: 600;
                                    margin: 0;
                                    display: flex;
                                    align-items: center;
                                    gap: 12px;
                                }

                                .card-body {
                                    padding: 28px;
                                }

                                .room-info-card {
                                    background: white;
                                    border-radius: 12px;
                                    padding: 28px;
                                    margin-bottom: 28px;
                                    border: 1px solid var(--card-border);
                                    box-shadow: 0 2px 8px rgba(92, 169, 233, 0.08);
                                }

                                .room-info-card h3 {
                                    color: var(--primary);
                                    margin-bottom: 20px;
                                    font-size: 1.5rem;
                                    font-weight: 600;
                                    display: flex;
                                    align-items: center;
                                    gap: 10px;
                                }

                                .room-info-grid {
                                    display: grid;
                                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                                    gap: 16px;
                                }

                                .room-info-item {
                                    background: var(--muted-bg);
                                    padding: 16px;
                                    border-radius: 8px;
                                    border-left: 4px solid var(--primary);
                                }

                                .room-info-item strong {
                                    color: #7a8b99;
                                    display: block;
                                    font-size: 0.9rem;
                                    margin-bottom: 6px;
                                    font-weight: 500;
                                }

                                .room-info-item span {
                                    color: var(--text);
                                    font-size: 1.1rem;
                                    font-weight: 600;
                                }

                                .form-section {
                                    margin-bottom: 24px;
                                    padding: 24px;
                                    background: var(--muted-bg);
                                    border-radius: 12px;
                                    border: 1px solid var(--card-border);
                                }

                                .section-title {
                                    color: var(--primary);
                                    font-size: 1.3rem;
                                    font-weight: 600;
                                    margin-bottom: 20px;
                                    display: flex;
                                    align-items: center;
                                    gap: 10px;
                                }

                                .form-group {
                                    margin-bottom: 20px;
                                }

                                .form-group label {
                                    display: block;
                                    font-weight: 700;
                                    color: #2c3e50;
                                    margin-bottom: 10px;
                                    font-size: 1rem;
                                }

                                .form-control {
                                    width: 100%;
                                    padding: 12px 16px;
                                    background: white;
                                    border: 2px solid var(--card-border);
                                    border-radius: 8px;
                                    font-size: 1rem;
                                    color: var(--text);
                                    font-family: "Sarabun", sans-serif;
                                    transition: all 0.3s ease;
                                }

                                .form-control:focus {
                                    outline: none;
                                    border-color: var(--primary);
                                    box-shadow: 0 0 0 3px rgba(92, 169, 233, 0.1);
                                }

                                .form-control:disabled,
                                .form-control[readonly] {
                                    background: #f5f5f5;
                                    color: #2c3e50;
                                    cursor: not-allowed;
                                    font-weight: 600;
                                }

                                .total-section {
                                    background: var(--muted-bg);
                                    border: 2px solid var(--primary);
                                    border-radius: 12px;
                                    padding: 30px;
                                    text-align: center;
                                    margin-top: 30px;
                                }

                                .total-label {
                                    font-size: 1.3rem;
                                    font-weight: 600;
                                    color: var(--text);
                                    margin-bottom: 10px;
                                }

                                .total-amount {
                                    font-size: 2.5rem;
                                    font-weight: bold;
                                    color: var(--primary);
                                    margin-bottom: 20px;
                                }

                                .status-section {
                                    margin-top: 20px;
                                }

                                .btn-group {
                                    display: flex;
                                    gap: 15px;
                                    justify-content: center;
                                    margin-top: 30px;
                                    flex-wrap: wrap;
                                }

                                .btn {
                                    padding: 12px 28px;
                                    border: none;
                                    border-radius: 8px;
                                    cursor: pointer;
                                    font-size: 1rem;
                                    font-weight: 600;
                                    transition: all 0.3s ease;
                                    text-decoration: none;
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 8px;
                                    min-width: 140px;
                                    justify-content: center;
                                    font-family: "Sarabun", sans-serif;
                                }

                                .btn-primary {
                                    background: linear-gradient(135deg, var(--success), #66BB6A);
                                    color: white;
                                    box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
                                }

                                .btn-primary:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 6px 16px rgba(76, 175, 80, 0.4);
                                }

                                .btn-secondary {
                                    background: #e0e0e0;
                                    color: var(--text);
                                    border: none;
                                }

                                .btn-secondary:hover {
                                    background: #bdbdbd;
                                    transform: translateY(-2px);
                                }

                                .btn-success {
                                    background: linear-gradient(135deg, var(--success), #66BB6A);
                                    color: white;
                                }

                                .btn-success:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 6px 16px rgba(76, 175, 80, 0.4);
                                }

                                .loading {
                                    display: none;
                                    position: fixed;
                                    top: 0;
                                    left: 0;
                                    width: 100%;
                                    height: 100%;
                                    background: rgba(255, 255, 255, 0.95);
                                    z-index: 999;
                                    justify-content: center;
                                    align-items: center;
                                }

                                .spinner {
                                    width: 60px;
                                    height: 60px;
                                    border: 5px solid var(--muted-bg);
                                    border-top: 5px solid var(--primary);
                                    border-radius: 50%;
                                    animation: spin 1s linear infinite;
                                }

                                @keyframes spin {
                                    0% {
                                        transform: rotate(0deg);
                                    }

                                    100% {
                                        transform: rotate(360deg);
                                    }
                                }

                                .toast {
                                    position: fixed;
                                    top: 20px;
                                    right: 20px;
                                    background: white;
                                    padding: 16px 22px;
                                    border-radius: 12px;
                                    box-shadow: 0 6px 20px rgba(92, 169, 233, 0.2);
                                    z-index: 1001;
                                    display: none;
                                    animation: slideInRight 0.3s ease;
                                    border: 2px solid var(--card-border);
                                    color: var(--text);
                                    max-width: 400px;
                                    font-weight: 500;
                                }

                                .toast.success {
                                    border-left: 5px solid var(--success);
                                }

                                .toast.error {
                                    border-left: 5px solid var(--danger);
                                }

                                @keyframes slideInRight {
                                    from {
                                        transform: translateX(100%);
                                        opacity: 0;
                                    }

                                    to {
                                        transform: translateX(0);
                                        opacity: 1;
                                    }
                                }

                                @media (max-width: 768px) {
                                    .container {
                                        padding: 15px;
                                    }

                                    .page-header {
                                        font-size: 2rem;
                                    }

                                    .card-body {
                                        padding: 20px;
                                    }

                                    .room-info-grid {
                                        grid-template-columns: 1fr;
                                    }

                                    .btn-group {
                                        flex-direction: column;
                                    }

                                    .btn {
                                        width: 100%;
                                    }

                                    .total-amount {
                                        font-size: 2rem;
                                    }
                                }
                            </style>
                        </head>

                        <body>
                            <div class="loading" id="loading">
                                <div class="spinner"></div>
                            </div>

                            <div id="toast" class="toast">
                                <div id="toast-message"></div>
                            </div>

                            <div class="container">
                                <div class="page-header">
                                    <i class="fas fa-file-invoice"></i>
                                    แก้ไขบิล #INV-${invoice.invoiceId}
                                </div>

                                <a href="EditInvoice?roomID=${invoice.rent.room.roomID}" class="back-btn">
                                    <i class="fas fa-arrow-left"></i>
                                    กลับไปรายการบิล
                                </a>

                                <div class="form-card">
                                    <div class="card-header">
                                        <h2>
                                            <i class="fas fa-file-invoice"></i>
                                            แก้ไขบิล #INV-${invoice.invoiceId}
                                        </h2>
                                    </div>

                                    <div class="card-body">
                                        <c:choose>
                                            <c:when test="${not empty invoice}">
                                                <!-- Room Information Card -->
                                                <div class="room-info-card">
                                                    <h3>
                                                        <i class="fas fa-home"></i>
                                                        ข้อมูลห้องพัก
                                                    </h3>
                                                    <div class="room-info-grid">
                                                        <div class="room-info-item">
                                                            <strong><i class="fas fa-door-open"></i>
                                                                หมายเลขห้อง</strong>
                                                            <span>${invoice.rent.room.roomNumber}</span>
                                                        </div>
                                                        <div class="room-info-item">
                                                            <strong><i class="fas fa-user"></i> ผู้เช่า</strong>
                                                            <span>${invoice.rent.member.firstName}
                                                                ${invoice.rent.member.lastName}</span>
                                                        </div>
                                                        <div class="room-info-item">
                                                            <strong><i class="fas fa-calendar-plus"></i>
                                                                วันที่ออกบิล</strong>
                                                            <span>${invoice.issueDate}</span>
                                                        </div>
                                                        <div class="room-info-item">
                                                            <strong><i class="fas fa-calendar-check"></i>
                                                                วันครบกำหนด</strong>
                                                            <span>${invoice.dueDate}</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <form action="UpdateInvoiceFull" method="post" id="invoiceForm">
                                                    <input type="hidden" name="invoiceId"
                                                        value="${invoice.invoiceId}" />
                                                    <input type="hidden" name="roomID"
                                                        value="${invoice.rent.room.roomID}" />
                                                    <input type="hidden" name="issueDate"
                                                        value="${invoice.issueDate}" />
                                                    <input type="hidden" name="dueDate" value="${invoice.dueDate}" />
                                                    <input type="hidden" name="rentId" value="${invoice.rent.rentID}" />
                                                    <input type="hidden" name="statusId" value="${invoice.status}" />

                                                    <!-- Bills Cards Container -->
                                                    <div id="billsCardsContainer" style="position: relative">
                                                        <!-- Cards จะถูกสร้างที่นี่โดย JavaScript -->
                                                    </div>

                                                    <!-- Hidden inputs สำหรับส่งข้อมูล -->
                                                    <div id="hiddenInputsContainer" style="display: none"></div>

                                                    <!-- Total Section -->
                                                    <div class="total-section">
                                                        <div class="total-label">ยอดรวมทั้งสิ้น (<span
                                                                id="totalBillsCount">0</span> บิล)</div>
                                                        <div class="total-amount" id="totalDisplay">
                                                            ฿
                                                            <fmt:formatNumber value="${invoice.totalAmount}"
                                                                groupingUsed="true" pattern="#,##0.00" />
                                                        </div>
                                                        <input type="hidden" id="totalPrice" name="totalPrice"
                                                            value="${invoice.totalAmount}" />

                                                        <div class="status-section">
                                                            <div class="form-group">
                                                                <label for="statusSelect">สถานะการชำระ:</label>
                                                                <select name="status" id="statusSelect"
                                                                    class="form-control">
                                                                    <option value="0" ${invoice.status==0 ? 'selected'
                                                                        : '' }>ยังไม่ได้ชำระ</option>
                                                                    <option value="1" ${invoice.status==1 ? 'selected'
                                                                        : '' }>ชำระแล้ว</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="btn-group">
                                                        <button type="button" onclick="saveAllBills()"
                                                            class="btn btn-primary" id="saveAllBtn">
                                                            <i class="fas fa-save"></i>
                                                            บันทึกการแก้ไข
                                                        </button>
                                                        <a href="EditInvoice?roomID=${invoice.rent.room.roomID}"
                                                            class="btn btn-secondary">
                                                            <i class="fas fa-times"></i>
                                                            ยกเลิก
                                                        </a>
                                                    </div>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="error-container">
                                                    <i class="fas fa-exclamation-triangle"></i>
                                                    <h3>ไม่พบข้อมูลบิล</h3>
                                                    <p>
                                                        <c:choose>
                                                            <c:when test="${not empty error}">
                                                                ${error}
                                                            </c:when>
                                                            <c:otherwise>
                                                                ไม่พบข้อมูลบิลที่ต้องการแก้ไข
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <a href="OwnerHome" class="btn btn-primary">
                                                        <i class="fas fa-arrow-left"></i>
                                                        กลับหน้าจัดการห้อง
                                                    </a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <script>
                                let bills = [];
                                let billCounter = 1;
                                let currentCardId = 1;
                                const roomPrice = ${ roomPrice };

                                let currentPrevWater = ${ prevWater };
                                let currentPrevElectric = ${ prevElectric };
                                const initialWaterRate = ${ waterRate };
                                const initialElectricRate = ${ electricRate };
                                let usedTypes = [];

                                // ข้อมูลบิลเดิมที่จะโหลดมา
                                const existingInvoiceData = {
                                    roomPrice: ${ roomPrice },
                                    internetPrice: ${ internetPrice },
                                    penalty: ${ penalty },
                                    penaltyRemark: '<c:out value="${penaltyRemark}" escapeXml="true" />',
                                    prevWater: ${ prevWater },
                                    currWater: ${ currWater },
                                    waterRate: ${ waterRate },
                                    prevElectric: ${ prevElectric },
                                    currElectric: ${ currElectric },
                                    electricRate: ${ electricRate },
                                    waterDetailId: ${ waterDetailId },
                                    electricDetailId: ${ electricDetailId },
                                    internetDetailId: ${ internetDetailId },
                                    penaltyDetailId: ${ penaltyDetailId },
                                    roomDetailId: ${ roomDetailId }
        };
                                
                                console.log('DEBUG: existingInvoiceData loaded:', existingInvoiceData);
                                console.log('DEBUG: penaltyRemark value:', existingInvoiceData.penaltyRemark);

                                function showToast(message, type = 'success') {
                                    const toast = document.getElementById('toast');
                                    const toastMessage = document.getElementById('toast-message');
                                    toastMessage.textContent = message;
                                    toast.className = `toast ${type}`;
                                    toast.style.display = 'block';
                                    setTimeout(() => { toast.style.display = 'none'; }, 5000);
                                }
                                // สร้าง Card ใหม่
                                function createNewCard() {
                                    const container = document.getElementById('billsCardsContainer');
                                    const cardId = 'card_' + currentCardId++;

                                    const card = document.createElement('div');
                                    card.id = cardId;
                                    card.className = 'form-section';
                                    card.style.cssText = 'margin-bottom: 15px; animation: slideUp 0.5s ease;';

                                    card.innerHTML = '<div class="section-title" style="display: flex; justify-content: space-between; align-items: center;">' +
                                        '<div>' +
                                        '<i class="fas fa-file-invoice-dollar"></i> ' +
                                        'รายการที่ ' + (bills.length + 1) +
                                        '</div>' +
                                        '<div style="color: #999; font-size: 0.9rem;">กรอกข้อมูลและกดเพิ่มบิล</div>' +
                                        '</div>' +
                                        '<div class="form-group">' +
                                        '<label><i class="fas fa-list"></i> เลือกประเภท</label>' +
                                        '<select class="form-control billType" onchange="handleTypeChange(\'' + cardId + '\')">' +
                                        '<option value="">-- เลือกประเภท --</option>' +
                                        '<option value="water" ' + (usedTypes.includes('water') ? 'disabled style="display:none"' : '') + '>ค่าน้ำ</option>' +
                                        '<option value="electricity" ' + (usedTypes.includes('electricity') ? 'disabled style="display:none"' : '') + '>ค่าไฟฟ้า</option>' +
                                        '<option value="internet" ' + (usedTypes.includes('internet') ? 'disabled style="display:none"' : '') + '>ค่าอินเทอร์เน็ต</option>' +
                                        '<option value="penalty" ' + (usedTypes.includes('penalty') ? 'disabled style="display:none"' : '') + '>ค่าปรับ</option>' +
                                        '<option value="other">อื่นๆ</option>' +
                                        '</select>' +
                                        '</div>' +
                                        '<div class="form-inputs-container"></div>' +
                                        '<div class="btn-group" style="justify-content: center; margin-top: 20px;">' +
                                        '<button type="button" onclick="addBill(\'' + cardId + '\')" class="btn btn-success" style="padding: 12px 35px;">' +
                                        '<i class="fas fa-plus-circle"></i> เพิ่มบิล' +
                                        '</button>' +
                                        '<button type="button" onclick="removeCard(\'' + cardId + '\')" class="btn-secondary" style="padding: 12px 25px; display: none;" id="removeBtn_' + cardId + '">' +
                                        '<i class="fas fa-trash"></i> ลบ' +
                                        '</button>' +
                                        '</div>';

                                    container.appendChild(card);
                                }

                                // จัดการเมื่อเปลี่ยนประเภทใน dropdown
                                function handleTypeChange(cardId) {
                                    const card = document.getElementById(cardId);
                                    const typeSelect = card.querySelector('.billType');
                                    const type = typeSelect.value;
                                    const inputsContainer = card.querySelector('.form-inputs-container');

                                    if (!type) {
                                        inputsContainer.innerHTML = '';
                                        return;
                                    }

                                    let html = '';

                                    if (type === 'water' || type === 'electricity') {
                                        const prevMeter = type === 'water' ? currentPrevWater : currentPrevElectric;
                                        const rate = type === 'water' ? initialWaterRate : initialElectricRate;
                                        const label = type === 'water' ? 'ค่าน้ำ' : 'ค่าไฟฟ้า';

                                        html = '<div class="form-group">' +
                                            '<label><i class="fas fa-history"></i> มิเตอร์เดือนก่อน</label>' +
                                            '<input type="number" class="form-control prevMeter" value="' + prevMeter + '" readonly style="background: #f5f5f5; cursor: not-allowed;" />' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-tachometer-alt"></i> มิเตอร์ปัจจุบัน</label>' +
                                            '<input type="number" class="form-control currMeter" placeholder="กรอกมิเตอร์ปัจจุบัน" oninput="calculateMeter(\'' + cardId + '\')" min="' + prevMeter + '" />' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-chart-line"></i> จำนวนหน่วยที่ใช้</label>' +
                                            '<input type="number" class="form-control usage" value="0" readonly style="background: #e3f2fd; color: #1565c0; font-weight: bold; cursor: not-allowed; font-size: 1.1rem;" />' +
                                            '<small style="color: #424242; margin-top: 5px; display: block; font-weight: 600;"><i class="fas fa-info-circle"></i> (ปัจจุบัน - เดือนก่อน)</small>' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-tag"></i> ราคาต่อหน่วย (฿)</label>' +
                                            '<input type="number" class="form-control rate" value="' + rate + '" step="0.01" readonly style="background: #f5f5f5; cursor: not-allowed; font-weight: 700; color: #2c3e50;" />' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-calculator"></i> จำนวนเงิน' + label + '</label>' +
                                            '<input type="number" class="form-control amount" readonly style="background: rgba(76, 175, 80, 0.1); color: #2e7d32; font-weight: bold; font-size: 1.1rem; border: 2px solid #4caf50;" />' +
                                            '<small style="color: #424242; margin-top: 5px; display: block; font-weight: 600;"><i class="fas fa-calculator"></i> (หน่วยที่ใช้ × ราคาต่อหน่วย)</small>' +
                                            '</div>';
                                    } else if (type === 'internet') {
                                        html = '<div class="form-group">' +
                                            '<label><i class="fas fa-wifi"></i> ราคาอินเทอร์เน็ต (ต่อเดือน)</label>' +
                                            '<input type="number" class="form-control amount" placeholder="ระบุจำนวนเงิน" step="0.01" min="0" style="font-weight: 600;" />' +
                                            '</div>';
                                    } else if (type === 'penalty') {
                                        html = '<div class="form-group">' +
                                            '<label><i class="fas fa-sticky-note"></i> หมายเหตุ <span style="color: #f44336;">*</span></label>' +
                                            '<textarea class="form-control remark" placeholder="กรอกเหตุผลที่เรียกเก็บค่าปรับ (ต้องกรอก)" rows="3" required style="resize: vertical; min-height: 80px;"></textarea>' +
                                            '<small style="color: #424242; margin-top: 5px; display: block; font-weight: 600;"><i class="fas fa-info-circle"></i> โปรดระบุเหตุผลในการเรียกเก็บค่าปรับ</small>' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-money-bill-wave"></i> จำนวนเงิน (฿)</label>' +
                                            '<input type="number" class="form-control amount" placeholder="ระบุจำนวนเงิน" step="0.01" min="0" />' +
                                            '</div>';
                                    } else if (type === 'other') {
                                        html = '<div class="form-group">' +
                                            '<label><i class="fas fa-edit"></i> ชื่อรายการ</label>' +
                                            '<input type="text" class="form-control itemName" placeholder="ระบุชื่อรายการ" />' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-money-bill-wave"></i> จำนวนเงิน (฿)</label>' +
                                            '<input type="number" class="form-control amount" placeholder="ระบุจำนวนเงิน" step="0.01" min="0" />' +
                                            '</div>';
                                    } else {
                                        html = '<div class="form-group">' +
                                            '<label><i class="fas fa-money-bill-wave"></i> จำนวนเงิน (฿)</label>' +
                                            '<input type="number" class="form-control amount" placeholder="ระบุจำนวนเงิน" step="0.01" min="0" />' +
                                            '</div>';
                                    }

                                    inputsContainer.innerHTML = html;
                                    setupCardEventListeners(cardId);
                                }

                                // คำนวณค่ามิเตอร์
                                function calculateMeter(cardId) {
                                    const card = document.getElementById(cardId);
                                    const prevMeter = parseFloat(card.querySelector('.prevMeter').value) || 0;
                                    const currMeter = parseFloat(card.querySelector('.currMeter').value) || 0;
                                    const rate = parseFloat(card.querySelector('.rate').value) || 0;
                                    const usageInput = card.querySelector('.usage');

                                    if (currMeter >= prevMeter) {
                                        const usage = currMeter - prevMeter;
                                        const total = usage * rate;

                                        // แสดงจำนวนหน่วยที่ใช้
                                        if (usageInput) {
                                            usageInput.value = usage.toFixed(2);
                                        }

                                        card.querySelector('.amount').value = total.toFixed(2);
                                    } else {
                                        // ถ้ามิเตอร์ปัจจุบันน้อยกว่าเดือนก่อน รีเซ็ตค่า
                                        if (usageInput) {
                                            usageInput.value = '0';
                                        }
                                        card.querySelector('.amount').value = '';
                                    }

                                    calculateAllBillsTotal();
                                }

                                // เพิ่มบิลเข้าลิสต์
                                function addBill(cardId) {
                                    const card = document.getElementById(cardId);
                                    const typeSelect = card.querySelector('.billType');
                                    const type = typeSelect.value;

                                    if (!type) {
                                        showToast('กรุณาเลือกประเภทค่าใช้จ่าย', 'error');
                                        return;
                                    }

                                    if (type === 'water' || type === 'electricity') {
                                        const prevMeter = parseFloat(card.querySelector('.prevMeter').value) || 0;
                                        const currMeter = parseFloat(card.querySelector('.currMeter').value) || 0;
                                        const amount = parseFloat(card.querySelector('.amount').value) || 0;

                                        if (!currMeter) {
                                            showToast('กรุณากรอกหน่วยปัจจุบัน', 'error');
                                            return;
                                        }

                                        if (currMeter < prevMeter) {
                                            showToast('หน่วยปัจจุบันต้องมากกว่าหรือเท่ากับหน่วยเดือนก่อน', 'error');
                                            return;
                                        }

                                        if (amount <= 0) {
                                            showToast('จำนวนเงินต้องมากกว่า 0', 'error');
                                            return;
                                        }
                                    } else if (type === 'penalty') {
                                        const remarkInput = card.querySelector('.remark');
                                        const remark = remarkInput ? remarkInput.value.trim() : '';
                                        const amount = parseFloat(card.querySelector('.amount').value) || 0;

                                        if (!remark) {
                                            showToast('กรุณากรอกหมายเหตุสำหรับค่าปรับ', 'error');
                                            return;
                                        }

                                        if (amount <= 0) {
                                            showToast('จำนวนเงินต้องมากกว่า 0', 'error');
                                            return;
                                        }
                                    } else if (type === 'other') {
                                        const itemName = card.querySelector('.itemName').value.trim();
                                        const amount = parseFloat(card.querySelector('.amount').value) || 0;

                                        if (!itemName) {
                                            showToast('กรุณาระบุชื่อรายการ', 'error');
                                            return;
                                        }

                                        if (amount <= 0) {
                                            showToast('จำนวนเงินต้องมากกว่า 0', 'error');
                                            return;
                                        }
                                    } else {
                                        const amount = parseFloat(card.querySelector('.amount').value) || 0;
                                        if (amount <= 0) {
                                            showToast('จำนวนเงินต้องมากกว่า 0', 'error');
                                            return;
                                        }
                                    }

                                    if (type !== 'other') {
                                        usedTypes.push(type);
                                    }

                                    // เก็บ cardId กับข้อมูล
                                    bills.push({
                                        id: billCounter++,
                                        cardId: cardId,
                                        type: type
                                    });

                                    // ซ่อนปุ่มเพิ่มบิล และแสดงปุ่มลบของ card นี้
                                    card.querySelector('button[onclick*="addBill"]').style.display = 'none';
                                    document.getElementById('removeBtn_' + cardId).style.display = 'inline-flex';

                                    const sectionTitle = card.querySelector('.section-title');
                                    if (sectionTitle) {
                                        sectionTitle.style.borderBottom = '2px solid #00ff88';
                                        sectionTitle.innerHTML = '<div style="color: #00ff88; font-weight: 600;">' +
                                            '<i class="fas fa-check-circle"></i> รายการที่ ' + bills.length + ' (แก้ไขได้)' +
                                            '</div>';
                                    }

                                    // อัพเดตมิเตอร์สำหรับบิลถัดไป
                                    if (type === 'water') {
                                        const currMeter = parseFloat(card.querySelector('.currMeter').value) || 0;
                                        currentPrevWater = currMeter;
                                    } else if (type === 'electricity') {
                                        const currMeter = parseFloat(card.querySelector('.currMeter').value) || 0;
                                        currentPrevElectric = currMeter;
                                    }
                                    createNewCard();
                                    calculateAllBillsTotal();
                                    showToast('เพิ่มบิลเรียบร้อย', 'success');
                                }

                                // คำนวณยอดรวมจากทุก Card 
                                function calculateAllBillsTotal() {
                                    let total = roomPrice;
                                    let billCount = 0;

                                    const container = document.getElementById('billsCardsContainer');
                                    if (container) {
                                        const allCards = container.querySelectorAll('.form-section');
                                        allCards.forEach(card => {
                                            const amountInput = card.querySelector('.amount');
                                            if (amountInput && amountInput.value) {
                                                const amount = parseFloat(amountInput.value) || 0;
                                                if (amount > 0) {
                                                    total += amount;
                                                    billCount++;
                                                }
                                            }
                                        });
                                    }

                                    const totalDisplay = document.getElementById('totalDisplay');
                                    if (totalDisplay) {
                                        totalDisplay.textContent = '฿' + total.toLocaleString('th-TH', {
                                            minimumFractionDigits: 2,
                                            maximumFractionDigits: 2
                                        });
                                    }

                                    const totalBillsCount = document.getElementById('totalBillsCount');
                                    if (totalBillsCount) {
                                        totalBillsCount.textContent = billCount;
                                    }

                                    const totalPriceInput = document.getElementById('totalPrice');
                                    if (totalPriceInput) {
                                        totalPriceInput.value = total.toFixed(2);
                                    }
                                }

                                function setupCardEventListeners(cardId) {
                                    const card = document.getElementById(cardId);
                                    if (!card) return;

                                    const inputs = card.querySelectorAll('input[type="number"], input[type="text"], textarea');
                                    inputs.forEach(input => {
                                        input.addEventListener('input', function () {
                                            calculateAllBillsTotal();
                                        });
                                    });
                                }

                                // ลบ Card
                                function removeCard(cardId) {
                                    const bill = bills.find(b => b.cardId === cardId);
                                    if (!bill) return;

                                    removeBill(bill.id);
                                }

                                // ลบบิล
                                function removeBill(billId) {
                                    if (confirm('ต้องการลบบิลนี้หรือไม่?')) {
                                        const bill = bills.find(b => b.id === billId);

                                        if (bill) {
                                            const card = document.getElementById(bill.cardId);
                                            if (card) {
                                                card.remove();
                                            }

                                            if (bill.type !== 'other') {
                                                usedTypes = usedTypes.filter(t => t !== bill.type);
                                            }

                                            if (bill.type === 'water') {
                                                let lastWaterMeter = ${ prevWater };
                                                bills.forEach(b => {
                                                    if (b.type === 'water' && b.id !== billId) {
                                                        const c = document.getElementById(b.cardId);
                                                        if (c) {
                                                            const curr = parseFloat(c.querySelector('.currMeter').value) || 0;
                                                            if (curr > lastWaterMeter) lastWaterMeter = curr;
                                                        }
                                                    }
                                                });
                                                currentPrevWater = lastWaterMeter;
                                            } else if (bill.type === 'electricity') {
                                                let lastElectricMeter = ${ prevElectric };
                                                bills.forEach(b => {
                                                    if (b.type === 'electricity' && b.id !== billId) {
                                                        const c = document.getElementById(b.cardId);
                                                        if (c) {
                                                            const curr = parseFloat(c.querySelector('.currMeter').value) || 0;
                                                            if (curr > lastElectricMeter) lastElectricMeter = curr;
                                                        }
                                                    }
                                                });
                                                currentPrevElectric = lastElectricMeter;
                                            }
                                        }

                                        bills = bills.filter(b => b.id !== billId);
                                        calculateAllBillsTotal();
                                    }
                                }

                                // บันทึกบิลทั้งหมด
                                function saveAllBills() {
                                    const container = document.getElementById('hiddenInputsContainer');
                                    container.innerHTML = '';

                                    let grandTotal = roomPrice;
                                    let validBills = [];

                                    const billsContainer = document.getElementById('billsCardsContainer');
                                    if (billsContainer) {
                                        const allCards = billsContainer.querySelectorAll('.form-section');

                                        allCards.forEach(card => {
                                            const typeSelect = card.querySelector('.billType');
                                            if (!typeSelect || !typeSelect.value) return;

                                            const type = typeSelect.value;
                                            const detailId = card.getAttribute('data-detail-id') || 0;  // ดึง detailId จาก card
                                            let name = '';
                                            let detail = '';
                                            let amount = 0;
                                            let meterData = null;
                                            let isValid = false;

                                            if (type === 'water' || type === 'electricity') {
                                                const prevMeterInput = card.querySelector('.prevMeter');
                                                const currMeterInput = card.querySelector('.currMeter');
                                                const rateInput = card.querySelector('.rate');
                                                const amountInput = card.querySelector('.amount');

                                                if (prevMeterInput && currMeterInput && rateInput && amountInput) {
                                                    const prevMeter = parseFloat(prevMeterInput.value) || 0;
                                                    const currMeter = parseFloat(currMeterInput.value) || 0;
                                                    const rate = parseFloat(rateInput.value) || 0;
                                                    amount = parseFloat(amountInput.value) || 0;

                                                    if (currMeter >= prevMeter && amount > 0) {
                                                        const usage = currMeter - prevMeter;
                                                        name = type === 'water' ? 'ค่าน้ำ' : 'ค่าไฟฟ้า';
                                                        detail = usage + ' หน่วย (' + prevMeter + ' → ' + currMeter + ') @ ฿' + rate.toFixed(2);
                                                        meterData = { prev: prevMeter, curr: currMeter, rate: rate, usage: usage };
                                                        isValid = true;
                                                    }
                                                }
                                            } else if (type === 'other') {
                                                const itemNameInput = card.querySelector('.itemName');
                                                const amountInput = card.querySelector('.amount');

                                                if (itemNameInput && amountInput) {
                                                    name = itemNameInput.value.trim();
                                                    amount = parseFloat(amountInput.value) || 0;
                                                    detail = '-';
                                                    if (name && amount > 0) {
                                                        isValid = true;
                                                    }
                                                }
                                            } else if (type === 'penalty') {
                                                const amountInput = card.querySelector('.amount');
                                                const remarkInput = card.querySelector('.remark');
                                                
                                                if (amountInput && remarkInput) {
                                                    name = 'ค่าปรับ';
                                                    amount = parseFloat(amountInput.value) || 0;
                                                    const remark = remarkInput.value.trim();
                                                    detail = '-';
                                                    
                                                    meterData = { remark: remark };
                                                    console.log('DEBUG: Penalty remark collected from card:', remark);
                                                    
                                                    if (amount > 0) {
                                                        isValid = true;
                                                    }
                                                }
                                            } else {
                                                const amountInput = card.querySelector('.amount');
                                                if (amountInput) {
                                                    const typeNames = {
                                                        internet: 'ค่าอินเทอร์เน็ต'
                                                    };
                                                    name = typeNames[type] || type;
                                                    amount = parseFloat(amountInput.value) || 0;
                                                    detail = '-';
                                                    
                                                    if (amount > 0) {
                                                        isValid = true;
                                                    }
                                                }
                                            }

                                            if (isValid) {
                                                validBills.push({ type, name, detail, amount, meterData, detailId });
                                            }
                                        });
                                    }

                                    if (validBills.length === 0) {
                                        showToast('กรุณากรอกข้อมูลบิลอย่างน้อย 1 รายการให้สมบูรณ์', 'error');
                                        return;
                                    }

                                    // item_0 = ค่าห้อง
                                    const roomDetailId = existingInvoiceData.roomDetailId || 0;
                                    container.innerHTML += '<input type="hidden" name="item_0_detailId" value="' + roomDetailId + '" />' +
                                        '<input type="hidden" name="item_0_type" value="room" />' +
                                        '<input type="hidden" name="item_0_name" value="ค่าเช่าห้อง" />' +
                                        '<input type="hidden" name="item_0_detail" value="-" />' +
                                        '<input type="hidden" name="item_0_amount" value="' + roomPrice + '" />';

                                    validBills.forEach((bill, index) => {
                                        const i = index + 1;

                                        grandTotal += bill.amount;

                                        container.innerHTML += '<input type="hidden" name="item_' + i + '_detailId" value="' + (bill.detailId || 0) + '" />' +
                                            '<input type="hidden" name="item_' + i + '_type" value="' + bill.type + '" />' +
                                            '<input type="hidden" name="item_' + i + '_name" value="' + bill.name + '" />' +
                                            '<input type="hidden" name="item_' + i + '_detail" value="' + bill.detail + '" />' +
                                            '<input type="hidden" name="item_' + i + '_amount" value="' + bill.amount + '" />';

                                        if (bill.meterData) {
                                            if (bill.meterData.remark !== undefined) {
                                                const remarkValue = bill.meterData.remark || '';
                                                container.innerHTML += '<input type="hidden" name="item_' + i + '_remark" value="' + remarkValue + '" />';
                                                console.log('DEBUG: Creating hidden input item_' + i + '_remark with value:', remarkValue);
                                            } else {
                                                container.innerHTML += '<input type="hidden" name="item_' + i + '_prevMeter" value="' + bill.meterData.prev + '" />' +
                                                    '<input type="hidden" name="item_' + i + '_currMeter" value="' + bill.meterData.curr + '" />' +
                                                    '<input type="hidden" name="item_' + i + '_rate" value="' + bill.meterData.rate + '" />' +
                                                    '<input type="hidden" name="item_' + i + '_usage" value="' + bill.meterData.usage + '" />';
                                            }
                                        }
                                    });

                                    container.innerHTML += '<input type="hidden" name="itemCount" value="' + (validBills.length + 1) + '" />' +
                                        '<input type="hidden" name="totalPrice" value="' + grandTotal.toFixed(2) + '" />';

                                    document.getElementById('loading').style.display = 'flex';
                                    document.querySelector('form').submit();
                                }

                                // โหลดข้อมูลบิลเดิม
                                function loadExistingInvoice() {
                                    const container = document.getElementById('billsCardsContainer');
                                    // ค่าน้ำ
                                    if (existingInvoiceData.currWater > 0) {
                                        createCardWithData('water', {
                                            detailId: existingInvoiceData.waterDetailId,
                                            prevMeter: existingInvoiceData.prevWater,
                                            currMeter: existingInvoiceData.currWater,
                                            rate: existingInvoiceData.waterRate
                                        });
                                    }
                                    // ค่าไฟ
                                    if (existingInvoiceData.currElectric > 0) {
                                        createCardWithData('electricity', {
                                            detailId: existingInvoiceData.electricDetailId,
                                            prevMeter: existingInvoiceData.prevElectric,
                                            currMeter: existingInvoiceData.currElectric,
                                            rate: existingInvoiceData.electricRate
                                        });
                                    }
                                    // ค่าอินเทอร์เน็ต
                                    if (existingInvoiceData.internetPrice > 0) {
                                        createCardWithData('internet', {
                                            detailId: existingInvoiceData.internetDetailId,
                                            amount: existingInvoiceData.internetPrice
                                        });
                                    }
                                    // ค่าปรับ
                                    if (existingInvoiceData.penalty > 0) {
                                        createCardWithData('penalty', {
                                            detailId: existingInvoiceData.penaltyDetailId,
                                            amount: existingInvoiceData.penalty,
                                            remark: existingInvoiceData.penaltyRemark
                                        });
                                    }
                                    createNewCard();
                                    calculateAllBillsTotal();
                                }

                                // สร้าง Card พร้อมข้อมูล
                                function createCardWithData(type, data) {
                                    const container = document.getElementById('billsCardsContainer');
                                    const cardId = 'card_' + currentCardId++;

                                    const card = document.createElement('div');
                                    card.id = cardId;
                                    card.className = 'form-section';
                                    card.style.cssText = 'margin-bottom: 15px;';

                                    const typeLabels = {
                                        water: 'ค่าน้ำ',
                                        electricity: 'ค่าไฟฟ้า',
                                        internet: 'ค่าอินเทอร์เน็ต',
                                        penalty: 'ค่าปรับ'
                                    };

                                    const typeIcons = {
                                        water: 'fa-tint',
                                        electricity: 'fa-bolt',
                                        internet: 'fa-wifi',
                                        penalty: 'fa-exclamation-triangle'
                                    };

                                    let formInputsHTML = '';

                                    if (type === 'water' || type === 'electricity') {
                                        const usage = data.currMeter - data.prevMeter;
                                        const amount = usage * data.rate;
                                        const label = type === 'water' ? 'ค่าน้ำ' : 'ค่าไฟฟ้า';
                                        
                                        formInputsHTML = '<div class="form-group">' +
                                            '<label><i class="fas fa-history"></i> มิเตอร์เดือนก่อน</label>' +
                                            '<input type="number" class="form-control prevMeter" value="' + data.prevMeter + '" readonly style="background: #f5f5f5; cursor: not-allowed;" />' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-tachometer-alt"></i> มิเตอร์ปัจจุบัน</label>' +
                                            '<input type="number" class="form-control currMeter" value="' + data.currMeter + '" oninput="calculateMeter(\'' + cardId + '\')" min="' + data.prevMeter + '" />' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-chart-line"></i> จำนวนหน่วยที่ใช้</label>' +
                                            '<input type="number" class="form-control usage" value="' + usage.toFixed(2) + '" readonly style="background: #e3f2fd; color: #1565c0; font-weight: bold; cursor: not-allowed; font-size: 1.1rem;" />' +
                                            '<small style="color: #424242; margin-top: 5px; display: block; font-weight: 600;"><i class="fas fa-info-circle"></i> (ปัจจุบัน - เดือนก่อน)</small>' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-tag"></i> ราคาต่อหน่วย (฿)</label>' +
                                            '<input type="number" class="form-control rate" value="' + data.rate + '" step="0.01" readonly style="background: #f5f5f5; cursor: not-allowed; font-weight: 700; color: #2c3e50;" />' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-calculator"></i> จำนวนเงิน' + label + '</label>' +
                                            '<input type="number" class="form-control amount" value="' + amount.toFixed(2) + '" readonly style="background: rgba(76, 175, 80, 0.1); color: #2e7d32; font-weight: bold; font-size: 1.1rem; border: 2px solid #4caf50;" />' +
                                            '<small style="color: #424242; margin-top: 5px; display: block; font-weight: 600;"><i class="fas fa-calculator"></i> (หน่วยที่ใช้ × ราคาต่อหน่วย)</small>' +
                                            '</div>';
                                    } else if (type === 'penalty') {
                                        const remarkValue = data.remark || '';
                                        formInputsHTML = '<div class="form-group">' +
                                            '<label><i class="fas fa-sticky-note"></i> หมายเหตุ <span style="color: #f44336;">*</span></label>' +
                                            '<textarea class="form-control remark" rows="3" required style="resize: vertical; min-height: 80px;">' + remarkValue + '</textarea>' +
                                            '<small style="color: #424242; margin-top: 5px; display: block; font-weight: 600;"><i class="fas fa-info-circle"></i> โปรดระบุเหตุผลในการเรียกเก็บค่าปรับ</small>' +
                                            '</div>' +
                                            '<div class="form-group">' +
                                            '<label><i class="fas fa-money-bill-wave"></i> จำนวนเงิน (฿)</label>' +
                                            '<input type="number" class="form-control amount" value="' + data.amount + '" step="0.01" min="0" />' +
                                            '</div>';
                                    } else {
                                        formInputsHTML = '<div class="form-group">' +
                                            '<label><i class="fas fa-money-bill-wave"></i> จำนวนเงิน (฿)</label>' +
                                            '<input type="number" class="form-control amount" value="' + data.amount + '" step="0.01" min="0" />' +
                                            '</div>';
                                    }

                                    card.innerHTML = '<div class="section-title" style="border-bottom: 2px solid #00ff88;">' +
                                        '<div style="color: #00ff88; font-weight: 600;">' +
                                        '<i class="fas ' + typeIcons[type] + '"></i> ' + typeLabels[type] +
                                        '</div>' +
                                        '</div>' +
                                        '<div class="form-group">' +
                                        '<label><i class="fas fa-list"></i> ประเภท</label>' +
                                        '<select class="form-control billType" disabled style="background: rgba(0,0,0,0.4);">' +
                                        '<option value="' + type + '" selected>' + typeLabels[type] + '</option>' +
                                        '</select>' +
                                        '</div>' +
                                        '<div class="form-inputs-container">' + formInputsHTML + '</div>' +
                                        '<div class="btn-group" style="justify-content: center; margin-top: 20px;">' +
                                        '<button type="button" onclick="removeCard(\'' + cardId + '\')" class="btn-secondary" style="padding: 12px 25px;" id="removeBtn_' + cardId + '">' +
                                        '<i class="fas fa-trash"></i> ลบ' +
                                        '</button>' +
                                        '</div>';

                                    container.appendChild(card);

                                    // เก็บ detailId ไว้ใน card element
                                    if (data.detailId) {
                                        card.setAttribute('data-detail-id', data.detailId);
                                    }

                                    bills.push({
                                        id: billCounter++,
                                        cardId: cardId,
                                        type: type,
                                        detailId: data.detailId || 0  
                                    });

                                    usedTypes.push(type);

                                    // อัพเดตมิเตอร์
                                    if (type === 'water') {
                                        currentPrevWater = data.currMeter;
                                    } else if (type === 'electricity') {
                                        currentPrevElectric = data.currMeter;
                                    }
                                    setupCardEventListeners(cardId);
                                }
                                document.addEventListener('DOMContentLoaded', function () {
                                    loadExistingInvoice();
                                });

                                window.addEventListener('load', function () {
                                    <c:if test="${not empty error}">
                                        setTimeout(function() {
                                            showToast('<c:out value="${error}" />', 'error');
                }, 500);
                                    </c:if>

                                    setTimeout(() => {
                                        document.getElementById('loading').style.display = 'none';
                                    }, 500);

                                    document.body.style.opacity = '0';
                                    document.body.style.transition = 'opacity 0.5s ease-in-out';
                                    setTimeout(() => {
                                        document.body.style.opacity = '1';
                                    }, 100);
                                });

                                document.addEventListener('DOMContentLoaded', function () {
                                    const sections = document.querySelectorAll('.form-section, .total-section, .room-info-card');
                                    sections.forEach((section, index) => {
                                        section.style.animationDelay = (index * 0.1) + 's';
                                    });
                                });

                                document.querySelectorAll('input[type="number"]').forEach(input => {
                                    input.addEventListener('input', function () {
                                        if (this.value < 0) {
                                            this.value = 0;
                                        }
                                    });
                                });

                                document.addEventListener('keydown', function (e) {
                                    if ((e.ctrlKey || e.metaKey) && e.key === 's') {
                                        e.preventDefault();
                                        saveAllBills();
                                    }
                                    if (e.key === 'Escape') {
                                        if (confirm('คุณต้องการยกเลิกการแก้ไขบิลหรือไม่?')) {
                                            window.location.href = 'EditInvoice?roomID=${invoice.rent.room.roomID}';
                                        }
                                    }
                                });

                                if (window.history.replaceState) {
                                    window.history.replaceState(null, null, window.location.href);
                                }
                            </script>
                        </body>

                        </html>