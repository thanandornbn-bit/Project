package com.springmvc.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.model.Invoice;
import com.springmvc.model.InvoiceDetail;
import com.springmvc.model.InvoiceType;
import com.springmvc.model.Manager;
import com.springmvc.model.Rent;
import com.springmvc.model.Room;
import com.springmvc.model.ThanachokManager;

@Controller
public class InvoiceController {

    // แสดงฟอร์มเพิ่มบิลใหม่
    @RequestMapping(value = "/ManagerAddInvoice", method = RequestMethod.GET)
public ModelAndView showAddInvoiceForm(@RequestParam("roomID") int roomID,
        HttpSession session,
        RedirectAttributes redirectAttributes) {
    Manager manager = (Manager) session.getAttribute("loginManager");
    if (manager == null) {
        return new ModelAndView("redirect:/Login");
    }

    ThanachokManager tm = new ThanachokManager();

    // ดึงข้อมูลห้อง
    Room room = tm.findRoomById(roomID);

    if (room == null) {
        redirectAttributes.addFlashAttribute("error", "ไม่พบข้อมูลห้องพักที่ระบุ");
        return new ModelAndView("redirect:/OwnerHome");
    }

    // ตรวจสอบว่าห้องมีผู้เช่าหรือไม่
    if ("ว่าง".equals(room.getRoomStatus())) {
        redirectAttributes.addFlashAttribute("error", "ห้องนี้ยังไม่มีผู้เช่า ไม่สามารถสร้างบิลได้");
        return new ModelAndView("redirect:/OwnerHome");
    }

    // เช็คว่ามีบิลในเดือนนี้แล้วหรือยัง
    boolean hasCurrentMonthInvoice = tm.hasInvoiceForCurrentMonth(roomID);
    if (hasCurrentMonthInvoice) {
        redirectAttributes.addFlashAttribute("error",
                "ห้อง " + room.getRoomNumber()
                        + " มีบิลในเดือนนี้แล้ว ไม่สามารถสร้างบิลซ้ำได้ กรุณารอจนถึงเดือนหน้า");
        return new ModelAndView("redirect:/OwnerHome");
    }

    // ดึงข้อมูลการเช่าที่ active
    Rent rent = tm.getActiveRentByRoomID(roomID);

    if (rent == null) {
        redirectAttributes.addFlashAttribute("error", "ไม่พบข้อมูลการเช่าที่ใช้งานอยู่ของห้องนี้");
        return new ModelAndView("redirect:/OwnerHome");
    }

    // คำนวณวันที่ออกบิลและวันครบกำหนด
    LocalDate today = LocalDate.now();
    LocalDate dueDate = today.plusDays(7); // ครบกำหนด 7 วัน

    // ดึงเลขมิเตอร์จากบิลก่อนหน้า
    java.util.Map<String, Integer> prevReadings = tm.getPreviousMeterReadings(roomID);

    ModelAndView mav = new ModelAndView("ManagerAddInvoice");
    mav.addObject("room", room);
    mav.addObject("rent", rent);
    mav.addObject("today", today);
    mav.addObject("dueDate", dueDate);
    
    // ส่งข้อมูลเลขมิเตอร์จากบิลก่อนหน้า
    mav.addObject("prevWater", prevReadings.get("prevWater"));
    mav.addObject("prevElectric", prevReadings.get("prevElectric"));
    mav.addObject("waterRate", prevReadings.get("waterRate"));
    mav.addObject("electricRate", prevReadings.get("electricRate"));

    System.out.println("=== Add Invoice Form ===");
    System.out.println("Room: " + roomID);
    System.out.println("Previous Water Meter: " + prevReadings.get("prevWater"));
    System.out.println("Previous Electric Meter: " + prevReadings.get("prevElectric"));

    return mav;
}

    // บันทึกบิลใหม่
    // แทนที่ method saveInvoice ใน InvoiceController.java

@RequestMapping(value = "/SaveInvoice", method = RequestMethod.POST)
public String saveInvoice(HttpServletRequest request,
        HttpSession session,
        RedirectAttributes redirectAttributes) {

    Manager manager = (Manager) session.getAttribute("loginManager");
    if (manager == null) {
        return "redirect:/Login";
    }

    try {
        // รับข้อมูลจากฟอร์ม
        int rentId = Integer.parseInt(request.getParameter("rentId"));
        String issueDateStr = request.getParameter("issueDate");
        String dueDateStr = request.getParameter("dueDate");
        double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
        int statusId = Integer.parseInt(request.getParameter("statusId"));

        // ข้อมูลค่าสาธารณูปโภค
        double roomPrice = Double.parseDouble(request.getParameter("roomPrice"));
        double internetPrice = Double.parseDouble(request.getParameter("internetPrice"));
        double penalty = Double.parseDouble(request.getParameter("penalty"));

        // น้ำ
        int prevWater = Integer.parseInt(request.getParameter("prevWater"));
        int currWater = Integer.parseInt(request.getParameter("currWater"));
        double waterRate = Double.parseDouble(request.getParameter("waterRate"));

        // ไฟฟ้า
        int prevElectric = Integer.parseInt(request.getParameter("prevElectric"));
        int currElectric = Integer.parseInt(request.getParameter("currElectric"));
        double electricRate = Double.parseDouble(request.getParameter("electricRate"));


        // ตรวจสอบข้อมูล
        ThanachokManager tm = new ThanachokManager();

        // ดึงข้อมูล Rent
        Rent rent = tm.findRentById(rentId);
        if (rent == null) {
            redirectAttributes.addFlashAttribute("error", "ไม่พบข้อมูลการเช่า");
            return "redirect:/OwnerHome";
        }

        // แปลงวันที่
        LocalDate issueDate = LocalDate.parse(issueDateStr);
        LocalDate dueDate = LocalDate.parse(dueDateStr);

        // สร้าง Invoice
        Invoice invoice = new Invoice();
        invoice.setRent(rent);
        invoice.setIssueDate(issueDate);
        invoice.setDueDate(dueDate);
        invoice.setTotalAmount(BigDecimal.valueOf(totalPrice));
        invoice.setStatus(statusId);

        // ========== สร้าง InvoiceDetails ==========
        List<InvoiceDetail> details = new ArrayList<>();

        // ค่าห้อง
        InvoiceDetail roomDetail = createInvoiceDetail(tm, invoice, "ค่าห้อง",
                roomPrice, 1, roomPrice);
        if (roomDetail != null) {
            details.add(roomDetail);
            System.out.println("Added: ค่าห้อง = " + roomPrice);
        }

        // ค่าอินเทอร์เน็ต
        if (internetPrice > 0) {
            InvoiceDetail internetDetail = createInvoiceDetail(tm, invoice, "ค่าอินเทอร์เน็ต",
                    internetPrice, 1, internetPrice);
            if (internetDetail != null) {
                details.add(internetDetail);
                System.out.println("Added: ค่าอินเทอร์เน็ต = " + internetPrice);
            }
        }

        // ค่าน้ำ - บันทึก currWater เป็น quantity (เพื่อใช้เป็น prevWater ของบิลถัดไป)
        int waterUsage = currWater - prevWater;
        if (waterUsage > 0 || currWater > 0) {
            double waterTotal = waterUsage * waterRate;
            InvoiceDetail waterDetail = createInvoiceDetail(tm, invoice, "ค่าน้ำ",
                    waterRate, currWater, waterTotal); // บันทึกเลขมิเตอร์ปัจจุบัน
            if (waterDetail != null) {
                details.add(waterDetail);
                System.out.println("Added: ค่าน้ำ = " + waterTotal +
                        " (Current meter: " + currWater + ", Usage: " + waterUsage + " @ " + waterRate + ")");
            }
        }

        // ค่าไฟฟ้า - บันทึก currElectric เป็น quantity
        int electricUsage = currElectric - prevElectric;
        if (electricUsage > 0 || currElectric > 0) {
            double electricTotal = electricUsage * electricRate;
            InvoiceDetail electricDetail = createInvoiceDetail(tm, invoice, "ค่าไฟฟ้า",
                    electricRate, currElectric, electricTotal); // บันทึกเลขมิเตอร์ปัจจุบัน
            if (electricDetail != null) {
                details.add(electricDetail);
                System.out.println("Added: ค่าไฟฟ้า = " + electricTotal +
                        " (Current meter: " + currElectric + ", Usage: " + electricUsage + " @ " + electricRate + ")");
            }
        }

        // ค่าปรับ
        if (penalty > 0) {
            InvoiceDetail penaltyDetail = createInvoiceDetail(tm, invoice, "ค่าปรับ",
                    penalty, 1, penalty);
            if (penaltyDetail != null) {
                details.add(penaltyDetail);
                System.out.println("Added: ค่าปรับ = " + penalty);
            }
        }

        // เพิ่ม details ลงใน invoice
        invoice.setDetails(details);

        System.out.println("Total details: " + details.size());

        // บันทึกลงฐานข้อมูล
        boolean success = tm.saveInvoice(invoice);

        if (success) {
            System.out.println("Invoice saved successfully! ID: " + invoice.getInvoiceId());
            redirectAttributes.addFlashAttribute("message",
                    "สร้างบิล INV-" + invoice.getInvoiceId() + " สำเร็จ " +
                            "ยอดรวม ฿" + String.format("%,.2f", totalPrice));
            return "redirect:/EditInvoice?roomID=" + rent.getRoom().getRoomID();
        } else {
            System.out.println("Failed to save invoice");
            redirectAttributes.addFlashAttribute("error",
                    "ไม่สามารถบันทึกบิลได้ กรุณาลองใหม่อีกครั้ง");
            return "redirect:/ManagerAddInvoice?roomID=" + rent.getRoom().getRoomID();
        }

    } catch (NumberFormatException e) {
        System.out.println("Number format error: " + e.getMessage());
        e.printStackTrace();
        redirectAttributes.addFlashAttribute("error",
                "ข้อมูลที่กรอกไม่ถูกต้อง กรุณาตรวจสอบตัวเลขที่กรอก");
        return "redirect:/OwnerHome";
    } catch (Exception e) {
        System.out.println("General error: " + e.getMessage());
        e.printStackTrace();
        redirectAttributes.addFlashAttribute("error",
                "เกิดข้อผิดพลาด: " + e.getMessage());
        return "redirect:/OwnerHome";
    }
}

private InvoiceDetail createInvoiceDetail(ThanachokManager tm, Invoice invoice,
        String typeName, double price,
        int quantity, double amount) {
    try {
        // ค้นหาหรือสร้าง InvoiceType
        InvoiceType type = tm.getInvoiceTypeByName(typeName);
        if (type == null) {
            System.out.println("Warning: Could not create/find InvoiceType: " + typeName);
            return null;
        }

        // สร้าง InvoiceDetail
        InvoiceDetail detail = new InvoiceDetail();
        detail.setInvoice(invoice);
        detail.setType(type);
        detail.setPrice(BigDecimal.valueOf(price));
        detail.setQuantity(quantity);
        detail.setAmount(BigDecimal.valueOf(amount));

        System.out.println("Created detail: " + typeName +
                " (Price: " + price + ", Qty: " + quantity + ", Amount: " + amount + ")");

        return detail;
    } catch (Exception e) {
        System.out.println("Error creating invoice detail for " + typeName + ": " + e.getMessage());
        e.printStackTrace();
        return null;
    }
}


    // แก้ไขใบแจ้งหนี้ของห้องที่เลือก
	@RequestMapping(value = "/EditInvoice", method = RequestMethod.GET)
	public ModelAndView showEditInvoice(@RequestParam("roomID") int roomID, HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();

		Room room = tm.findRoomById(roomID);

		List<Invoice> invoices = tm.getInvoicesByRoomID(roomID);

		ModelAndView mav = new ModelAndView("EditInvoice");
		mav.addObject("room", room);
		mav.addObject("invoices", invoices);
		return mav;
	}

	// แสดงฟอร์มแก้ไขใบแจ้งหนี้เฉพาะห้องที่เลือก
	@RequestMapping(value = "/EditInvoiceForm", method = RequestMethod.GET)
	public ModelAndView showEditInvoiceForm(@RequestParam("invoiceId") int invoiceId, HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		ThanachokManager tm = new ThanachokManager();
		Invoice invoice = tm.getInvoiceWithDetails(invoiceId);
		if (invoice == null) {
			ModelAndView mav = new ModelAndView("EditInvoice");
			mav.addObject("error", "ไม่พบใบแจ้งหนี้ที่ต้องการแก้ไข");
			return mav;
		}

		ModelAndView mav = new ModelAndView("EditInvoiceForm");
		mav.addObject("invoice", invoice);
		mav.addObject("invoiceDetails", invoice.getDetails());
		return mav;
	}

	// บันทึกการแก้ไขใบแจ้งหนี้
	@RequestMapping(value = "/UpdateInvoice", method = RequestMethod.POST)
	public ModelAndView updateInvoice(HttpServletRequest request, HttpSession session) {
		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			return new ModelAndView("redirect:/Login");
		}

		try {
			int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
			int status = Integer.parseInt(request.getParameter("status"));

			ThanachokManager tm = new ThanachokManager();
			Invoice invoice = tm.getInvoiceById(invoiceId);

			if (invoice != null) {
				invoice.setStatus(status);
				tm.updateInvoice(invoice);

				ModelAndView mav = new ModelAndView("redirect:/EditInvoice");
				mav.addObject("roomID", invoice.getRent().getRoom().getRoomID());
				mav.addObject("message", "อัปเดตใบแจ้งหนี้เรียบร้อยแล้ว");
				return mav;
			} else {
				ModelAndView mav = new ModelAndView("EditInvoiceForm");
				mav.addObject("error", "ไม่พบใบแจ้งหนี้ที่ต้องการอัปเดต");
				return mav;
			}

		} catch (Exception e) {
			e.printStackTrace();
			ModelAndView mav = new ModelAndView("EditInvoiceForm");
			mav.addObject("error", "เกิดข้อผิดพลาดในการอัปเดตข้อมูล: " + e.getMessage());
			return mav;
		}
	}

	//ลบใบแจ้งหนี้
	@RequestMapping(value = "/DeleteInvoice", method = RequestMethod.GET)
	public String deleteInvoice(@RequestParam("invoiceId") int invoiceId,
			@RequestParam("roomID") int roomID,
			HttpSession session,
			RedirectAttributes redirectAttributes) {


		Manager manager = (Manager) session.getAttribute("loginManager");
		if (manager == null) {
			System.out.println("No manager session - redirecting to login");
			return "redirect:/Login";
		}

		try {
			ThanachokManager tm = new ThanachokManager();
			// ตรวจสอบว่าใบแจ้งหนี้มีอยู่จริงและดึงข้อมูล
			Invoice invoice = tm.getInvoiceWithStatus(invoiceId);
			if (invoice == null) {
				redirectAttributes.addFlashAttribute("error",
						"ไม่พบใบแจ้งหนี้ที่ต้องการลบ (ID: " + invoiceId + ")");
				return "redirect:/EditInvoice?roomID=" + roomID;
			}
			// ตรวจสอบสถานะการชำระ
			if (invoice.getStatus() == 1) {
				redirectAttributes.addFlashAttribute("error",
						"ไม่สามารถลบใบแจ้งหนี้ INV-" + invoiceId + " ได้ เนื่องจากได้ชำระเงินแล้ว");
				System.out.println("Cannot delete paid invoice: " + invoiceId);
				return "redirect:/EditInvoice?roomID=" + roomID;
			}

			// ลบใบแจ้งหนี้
			System.out.println("Attempting to delete unpaid invoice: " + invoiceId);
			boolean deleted = tm.deleteInvoice(invoiceId);

			if (deleted) {
				redirectAttributes.addFlashAttribute("message",
						"ลบใบแจ้งหนี้ INV-" + invoiceId + " เรียบร้อยแล้ว");
				System.out.println("Successfully deleted invoice: " + invoiceId);
			} else {
				redirectAttributes.addFlashAttribute("error",
						"ไม่สามารถลบใบแจ้งหนี้ได้ กรุณาลองใหม่อีกครั้ง");
				System.out.println("Failed to delete invoice: " + invoiceId);
			}

		} catch (RuntimeException re) {
			System.out.println("Runtime exception: " + re.getMessage());
			redirectAttributes.addFlashAttribute("error", re.getMessage());
		} catch (Exception e) {
			System.out.println("General exception: " + e.getMessage());
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error",
					"เกิดข้อผิดพลาดในระบบ: " + e.getMessage());
		}

		return "redirect:/EditInvoice?roomID=" + roomID;
	}




// แทนที่ methods เดิมใน InvoiceController.java ด้วยเวอร์ชันที่แก้ไขแล้ว

@RequestMapping(value = "/EditInvoiceFormFull", method = RequestMethod.GET)
public ModelAndView showEditInvoiceFormFull(@RequestParam("invoiceId") int invoiceId, 
                                             HttpSession session,
                                             RedirectAttributes redirectAttributes) {
    Manager manager = (Manager) session.getAttribute("loginManager");
    if (manager == null) {
        return new ModelAndView("redirect:/Login");
    }

    ThanachokManager tm = new ThanachokManager();
    
    // ดึงข้อมูล Invoice พร้อม Details
    Invoice invoice = tm.getInvoiceWithDetails(invoiceId);
    
    if (invoice == null) {
        redirectAttributes.addFlashAttribute("error", "ไม่พบใบแจ้งหนี้ที่ต้องการแก้ไข");
        return new ModelAndView("redirect:/OwnerHome");
    }

    ModelAndView mav = new ModelAndView("EditInvoiceFormFull");
    mav.addObject("invoice", invoice);
    
    // แยกข้อมูลจาก InvoiceDetails
    double roomPrice = 0;
    double internetPrice = 0;
    double penalty = 0;
    int prevWater = 0;
    int currWater = 0;
    double waterRate = 18;
    int prevElectric = 0;
    int currElectric = 0;
    double electricRate = 7;

    // ดึงเลขมิเตอร์จากบิลก่อนหน้า (บิลที่เก่ากว่าบิลปัจจุบัน)
    int roomID = invoice.getRent().getRoom().getRoomID();
    
    // หาบิลก่อนหน้าบิลที่กำลังแก้ไข
    Invoice previousInvoice = tm.getInvoiceBeforeDate(roomID, invoice.getIssueDate());
    
    if (previousInvoice != null && previousInvoice.getDetails() != null) {
        for (InvoiceDetail detail : previousInvoice.getDetails()) {
            String typeName = detail.getType().getTypeName();
            
            if ("ค่าน้ำ".equals(typeName)) {
                prevWater = detail.getQuantity(); // เลขมิเตอร์ครั้งก่อน
                waterRate = detail.getPrice().doubleValue();
            } else if ("ค่าไฟฟ้า".equals(typeName)) {
                prevElectric = detail.getQuantity();
                electricRate = detail.getPrice().doubleValue();
            }
        }
    }

    // ดึงข้อมูลจากบิลปัจจุบันที่กำลังแก้ไข
    if (invoice.getDetails() != null) {
        for (InvoiceDetail detail : invoice.getDetails()) {
            String typeName = detail.getType().getTypeName();
            
            switch (typeName) {
                case "ค่าห้อง":
                    roomPrice = detail.getPrice().doubleValue();
                    break;
                case "ค่าอินเทอร์เน็ต":
                    internetPrice = detail.getPrice().doubleValue();
                    break;
                case "ค่าปรับ":
                    penalty = detail.getAmount().doubleValue();
                    break;
                case "ค่าน้ำ":
                    // เลขปัจจุบัน = เลขครั้งก่อน + จำนวนที่ใช้
                    currWater = prevWater + detail.getQuantity();
                    waterRate = detail.getPrice().doubleValue();
                    break;
                case "ค่าไฟฟ้า":
                    currElectric = prevElectric + detail.getQuantity();
                    electricRate = detail.getPrice().doubleValue();
                    break;
            }
        }
    }

    mav.addObject("roomPrice", roomPrice);
    mav.addObject("internetPrice", internetPrice);
    mav.addObject("penalty", penalty);
    mav.addObject("prevWater", prevWater);
    mav.addObject("currWater", currWater);
    mav.addObject("waterRate", waterRate);
    mav.addObject("prevElectric", prevElectric);
    mav.addObject("currElectric", currElectric);
    mav.addObject("electricRate", electricRate);

    System.out.println("=== Edit Invoice Form ===");
    System.out.println("Invoice ID: " + invoiceId);
    System.out.println("Previous Water: " + prevWater + " -> Current: " + currWater);
    System.out.println("Previous Electric: " + prevElectric + " -> Current: " + currElectric);

    return mav;
}

// บันทึกการแก้ไขบิลแบบเต็ม (เหมือนเดิม)
@RequestMapping(value = "/UpdateInvoiceFull", method = RequestMethod.POST)
public String updateInvoiceFull(HttpServletRequest request,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
    Manager manager = (Manager) session.getAttribute("loginManager");
    if (manager == null) {
        return "redirect:/Login";
    }

    try {
        // รับข้อมูลจากฟอร์ม
        int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        String issueDateStr = request.getParameter("issueDate");
        String dueDateStr = request.getParameter("dueDate");
        double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
        int status = Integer.parseInt(request.getParameter("status"));

        // ข้อมูลค่าใช้จ่าย
        double roomPrice = Double.parseDouble(request.getParameter("roomPrice"));
        double internetPrice = Double.parseDouble(request.getParameter("internetPrice"));
        double penalty = Double.parseDouble(request.getParameter("penalty"));

        // น้ำ
        int prevWater = Integer.parseInt(request.getParameter("prevWater"));
        int currWater = Integer.parseInt(request.getParameter("currWater"));
        double waterRate = Double.parseDouble(request.getParameter("waterRate"));

        // ไฟฟ้า
        int prevElectric = Integer.parseInt(request.getParameter("prevElectric"));
        int currElectric = Integer.parseInt(request.getParameter("currElectric"));
        double electricRate = Double.parseDouble(request.getParameter("electricRate"));

        System.out.println("=== Update Invoice Full Request ===");
        System.out.println("Invoice ID: " + invoiceId);
        System.out.println("Room ID: " + roomID);
        System.out.println("Total Price: " + totalPrice);

        ThanachokManager tm = new ThanachokManager();
        
        // ดึงข้อมูล Invoice เดิม
        Invoice invoice = tm.getInvoiceWithDetails(invoiceId);
        if (invoice == null) {
            redirectAttributes.addFlashAttribute("error", "ไม่พบใบแจ้งหนี้ที่ต้องการแก้ไข");
            return "redirect:/EditInvoice?roomID=" + roomID;
        }

        // เก็บ details เดิมไว้
        List<InvoiceDetail> oldDetails = new ArrayList<>(invoice.getDetails());

        // แปลงวันที่
        LocalDate issueDate = LocalDate.parse(issueDateStr);
        LocalDate dueDate = LocalDate.parse(dueDateStr);

        // อัปเดตข้อมูล Invoice
        invoice.setIssueDate(issueDate);
        invoice.setDueDate(dueDate);
        invoice.setTotalAmount(BigDecimal.valueOf(totalPrice));
        invoice.setStatus(status);

        // สร้าง InvoiceDetails ใหม่
        List<InvoiceDetail> newDetails = new ArrayList<>();

        // ค่าห้อง
        if (roomPrice > 0) {
            InvoiceDetail roomDetail = new InvoiceDetail();
            roomDetail.setInvoice(invoice);
            roomDetail.setType(tm.getInvoiceTypeByName("ค่าห้อง"));
            roomDetail.setPrice(BigDecimal.valueOf(roomPrice));
            roomDetail.setQuantity(1);
            roomDetail.setAmount(BigDecimal.valueOf(roomPrice));
            newDetails.add(roomDetail);
            System.out.println("Added: ค่าห้อง = " + roomPrice);
        }

        // ค่าอินเทอร์เน็ต
        if (internetPrice > 0) {
            InvoiceDetail internetDetail = new InvoiceDetail();
            internetDetail.setInvoice(invoice);
            internetDetail.setType(tm.getInvoiceTypeByName("ค่าอินเทอร์เน็ต"));
            internetDetail.setPrice(BigDecimal.valueOf(internetPrice));
            internetDetail.setQuantity(1);
            internetDetail.setAmount(BigDecimal.valueOf(internetPrice));
            newDetails.add(internetDetail);
            System.out.println("Added: ค่าอินเทอร์เน็ต = " + internetPrice);
        }

        // ค่าน้ำ - บันทึก currWater เป็น quantity (เพื่อใช้เป็น prevWater ของบิลถัดไป)
        int waterUsage = currWater - prevWater;
        if (waterUsage > 0) {
            double waterTotal = waterUsage * waterRate;
            InvoiceDetail waterDetail = new InvoiceDetail();
            waterDetail.setInvoice(invoice);
            waterDetail.setType(tm.getInvoiceTypeByName("ค่าน้ำ"));
            waterDetail.setPrice(BigDecimal.valueOf(waterRate));
            waterDetail.setQuantity(currWater); // บันทึกเลขปัจจุบัน
            waterDetail.setAmount(BigDecimal.valueOf(waterTotal));
            newDetails.add(waterDetail);
            System.out.println("Added: ค่าน้ำ = " + waterTotal + " (Current meter: " + currWater + ", Usage: " + waterUsage + ")");
        }

        // ค่าไฟฟ้า - บันทึก currElectric เป็น quantity
        int electricUsage = currElectric - prevElectric;
        if (electricUsage > 0) {
            double electricTotal = electricUsage * electricRate;
            InvoiceDetail electricDetail = new InvoiceDetail();
            electricDetail.setInvoice(invoice);
            electricDetail.setType(tm.getInvoiceTypeByName("ค่าไฟฟ้า"));
            electricDetail.setPrice(BigDecimal.valueOf(electricRate));
            electricDetail.setQuantity(currElectric); // บันทึกเลขปัจจุบัน
            electricDetail.setAmount(BigDecimal.valueOf(electricTotal));
            newDetails.add(electricDetail);
            System.out.println("Added: ค่าไฟฟ้า = " + electricTotal + " (Current meter: " + currElectric + ", Usage: " + electricUsage + ")");
        }

        // ค่าปรับ
        if (penalty > 0) {
            InvoiceDetail penaltyDetail = new InvoiceDetail();
            penaltyDetail.setInvoice(invoice);
            penaltyDetail.setType(tm.getInvoiceTypeByName("ค่าปรับ"));
            penaltyDetail.setPrice(BigDecimal.valueOf(penalty));
            penaltyDetail.setQuantity(1);
            penaltyDetail.setAmount(BigDecimal.valueOf(penalty));
            newDetails.add(penaltyDetail);
            System.out.println("Added: ค่าปรับ = " + penalty);
        }

        // เซ็ต details ใหม่
        invoice.setDetails(newDetails);
        System.out.println("Total new details: " + newDetails.size());

        // บันทึกการแก้ไข
        boolean success = tm.updateInvoiceFull(invoice, oldDetails);

        if (success) {
            System.out.println("Invoice updated successfully! ID: " + invoice.getInvoiceId());
            redirectAttributes.addFlashAttribute("message",
                    "แก้ไขบิล INV-" + invoice.getInvoiceId() + " เรียบร้อยแล้ว " +
                            "ยอดรวม ฿" + String.format("%,.2f", totalPrice));
            return "redirect:/EditInvoice?roomID=" + roomID;
        } else {
            System.out.println("Failed to update invoice");
            redirectAttributes.addFlashAttribute("error",
                    "ไม่สามารถแก้ไขบิลได้ กรุณาลองใหม่อีกครั้ง");
            return "redirect:/EditInvoiceFormFull?invoiceId=" + invoiceId;
        }

    } catch (NumberFormatException e) {
        System.out.println("Number format error: " + e.getMessage());
        e.printStackTrace();
        redirectAttributes.addFlashAttribute("error",
                "ข้อมูลที่กรอกไม่ถูกต้อง กรุณาตรวจสอบตัวเลขที่กรอก");
        String invoiceId = request.getParameter("invoiceId");
        return "redirect:/EditInvoiceFormFull?invoiceId=" + invoiceId;
    } catch (Exception e) {
        System.out.println("General error: " + e.getMessage());
        e.printStackTrace();
        redirectAttributes.addFlashAttribute("error",
                "เกิดข้อผิดพลาด: " + e.getMessage());
        String invoiceId = request.getParameter("invoiceId");
        return "redirect:/EditInvoiceFormFull?invoiceId=" + invoiceId;
    }
}
}