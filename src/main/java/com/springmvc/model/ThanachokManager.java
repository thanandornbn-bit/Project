package com.springmvc.model;


import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ThanachokManager {

    // เพิ่มสมาชิกใหม่
    public boolean insertMember(Member member) {
        Session session = null;
        Transaction transaction = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.saveOrUpdate(member);
            transaction.commit();
            return true;
        } catch (Exception ex) {
            if (transaction != null)
                transaction.rollback();
            ex.printStackTrace();
            return false;
        } finally {
            if (session != null)
                session.close();
        }
    }

    // ตรวจสอบการเข้าสู่ระบบของ Member
    public Member findMemberByEmailAndPassword(String email, String password) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            String hql = "FROM Member WHERE email = :email AND password = :password";
            return session.createQuery(hql, Member.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null)
                session.close();
        }
    }

    // ตรวจสอบการเข้าสู่ระบบของ Manager
    public Manager findManagerByEmailAndPassword(String email, String password) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            String hql = "FROM Manager WHERE email = :email AND password = :password";
            return session.createQuery(hql, Manager.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null)
                session.close();
        }
    }

    // เพิ่มห้องใหม่
    public boolean insertRoom(Room room) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();
            session.save(room);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null)
                session.close();
        }
    }

    // อัปเดตข้อมูลห้อง
    public boolean updateRoom(Room room) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.update(room);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null)
                session.close();
        }
    }

    // ค้นหาห้องทั้งหมด
    public List<Room> getAllrooms() {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            return session.createQuery("FROM Room", Room.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null)
                session.close();
        }
    }

    // ค้นหาห้องจาก floor และ status
    public List<Room> findRoomsByFloorAndStatus(String floor, String status) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "FROM Room WHERE 1=1";

            if (floor != null && !floor.isEmpty()) {
                hql += " AND roomNumber LIKE :floorPrefix";
            }

            if (status != null && !status.isEmpty()) {
                hql += " AND roomStatus = :status";
            }

            var query = session.createQuery(hql, Room.class);

            if (floor != null && !floor.isEmpty()) {
                query.setParameter("floorPrefix", floor + "%");
            }

            if (status != null && !status.isEmpty()) {
                query.setParameter("status", status);
            }

            return query.list();

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null)
                session.close();
        }
    }

    // บันทึกการจอง
    public boolean saveRent(Rent rent) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();
            session.save(rent);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive())
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null)
                session.close();
        }
    }

    // บันทึกค่ามัดจำ
    public boolean saveRentalDeposit(RentalDeposit deposit) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.save(deposit);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null)
                session.close();
        }
    }

    // ดึง RentalDeposit ทั้งหมดของสมาชิก
    public List<RentalDeposit> findDepositsByMember(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            String hql = "FROM RentalDeposit rd WHERE rd.rent.member = :member";
            return session.createQuery(hql, RentalDeposit.class)
                    .setParameter("member", member)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null)
                session.close();
        }
    }

    public List<Rent> findAllRentsWithDeposits() {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            String hql = "SELECT DISTINCT r FROM Rent r "
                    + "LEFT JOIN FETCH r.member "
                    + "LEFT JOIN FETCH r.room "
                    + "LEFT JOIN FETCH r.rentalDeposit";

            return session.createQuery(hql, Rent.class).list();

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null)
                session.close();
        }
    }

    public boolean confirmRentalDeposit(int rentalDepositId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();

            RentalDeposit deposit = session.get(RentalDeposit.class, rentalDepositId);
            if (deposit != null) {
                deposit.setStatus("เสร็จสมบูรณ์");
                session.update(deposit);
                tx.commit();
                return true;
            }
            return false;

        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null)
                session.close();
        }
    }

    public RentalDeposit getRentalDepositById(int id) {
        Session session = HibernateConnection.doHibernateConnection().openSession();
        try {
            return session.get(RentalDeposit.class, id);
        } finally {
            session.close();
        }
    }

    public void updateRentalDeposit(RentalDeposit deposit) {
        Session session = HibernateConnection.doHibernateConnection().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(deposit);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    public boolean deleteRoom(int roomID) {
    Session session = null;
    Transaction tx = null;
    try {
        SessionFactory factory = HibernateConnection.doHibernateConnection();
        session = factory.openSession();
        tx = session.beginTransaction();

        Room room = session.get(Room.class, roomID);
        if (room == null) {
            System.out.println("ไม่พบห้อง ID: " + roomID);
            return false;
        }

        // ตรวจสอบว่าห้องว่างหรือไม่เท่านั้น
        if (!"ว่าง".equals(room.getRoomStatus())) {
            System.out.println("ไม่สามารถลบห้องที่ไม่ว่างได้");
            return false;
        }

        // ลบห้องที่ว่าง
        session.delete(room);
        tx.commit();
        return true;

    } catch (Exception e) {
        if (tx != null && tx.isActive()) {
            tx.rollback();
        }
        e.printStackTrace();
        return false;
    } finally {
        if (session != null) {
            session.close();
        }
    }
}

    // ดึงรายการ Invoice ทั้งหมดของผู้เช่า
    public List<Invoice> findInvoicesByMember(int memberID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            String hql = "FROM Invoice i WHERE i.rent.member.memberID = :memberID ORDER BY i.billingDate DESC";
            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("memberID", memberID);
            return query.list();
        }
    }

    // ดึง Invoice เดี่ยวตาม ID
    public Invoice findInvoiceById(int billID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            return session.get(Invoice.class, billID);
        }
    }

    // ดึงรายการย่อยของบิล
    public List<InvoiceDetail> findInvoiceDetailsByInvoiceId(int billID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            String hql = "FROM InvoiceDetail d WHERE d.invoice.billID = :billID";
            Query<InvoiceDetail> query = session.createQuery(hql, InvoiceDetail.class);
            query.setParameter("billID", billID);
            return query.list();
        }
    }

    // ดึงประเภทบิล เช่น ค่าน้ำ ค่าไฟ
    public InvoiceType findInvoiceTypeById(int typeID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            return session.get(InvoiceType.class, typeID);
        }
    }

    // บันทึกรายการ InvoiceDetail
    public void saveInvoiceDetail(InvoiceDetail detail) {
        Transaction tx = null;
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            tx = session.beginTransaction();
            session.save(detail);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    // ดึงประเภทบิลทั้งหมด (ใช้ตอนสร้างบิลใหม่)
    public List<InvoiceType> getAllInvoiceTypes() {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            String hql = "FROM InvoiceType";
            Query<InvoiceType> query = session.createQuery(hql, InvoiceType.class);
            return query.list();
        }
    }

    // อัปเดต Invoice (ยอดรวม)
    public void updateInvoice(Invoice invoice) {
        Transaction tx = null;
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            tx = session.beginTransaction();
            session.update(invoice);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    public Rent findRentByRoomID(int roomID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            String hql = "FROM Rent r WHERE r.room.roomID = :roomID";
            return session.createQuery(hql, Rent.class)
                    .setParameter("roomID", roomID)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    //บันทึก Invoice และ InvoiceDetail ทั้งหมด
    public boolean saveInvoice(Invoice invoice) {
        Transaction tx = null;
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            tx = session.beginTransaction();
            session.save(invoice);
            if (invoice.getDetails() != null) {
                for (InvoiceDetail detail : invoice.getDetails()) {
                    detail.setInvoice(invoice);
                    session.save(detail);
                }
            }

            tx.commit();
            return true;

        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    //หา Room ด้วย roomID
    public Room findRoomById(int roomID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            return session.get(Room.class, roomID);
        }
    }

    //หา Rent ด้วย roomID 
    public Rent findRentById(int rentID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            return session.get(Rent.class, rentID);
        }
    }

    //ดึง InvoiceType ตามชื่อ
    public InvoiceType getInvoiceTypeByName(String name) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // หาข้อมูลที่มีอยู่
            InvoiceType type = session.createQuery("FROM InvoiceType WHERE typeName = :name", InvoiceType.class)
                    .setParameter("name", name)
                    .uniqueResult();

            // ถ้าไม่มี ให้สร้างใหม่
            if (type == null) {
                tx = session.beginTransaction();
                type = new InvoiceType();
                type.setTypeName(name);
                session.save(type);
                tx.commit();
                System.out.println("Created new InvoiceType: " + name);
            }

            return type;

        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
            return null;
        } finally {
            if (session != null)
                session.close();
        }
    }

    //ดึงรายการ Rent ทั้งหมด
    public List<Rent> getAllRents() {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            return session.createQuery("from Rent", Rent.class).list();
        }
    }

    public List<Invoice> getAllInvoices() {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            String hql = "from Invoice i order by i.issueDate desc";
            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Invoice getInvoiceById(int invoiceId) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            return session.get(Invoice.class, invoiceId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Invoice> getInvoicesByMemberID(int memberID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT i FROM Invoice i " +
                    "LEFT JOIN FETCH i.rent r " +
                    "LEFT JOIN FETCH r.member " +
                    "LEFT JOIN FETCH r.room " +
                    "WHERE r.member.memberID = :memberID " +
                    "ORDER BY i.issueDate DESC";

            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("memberID", memberID);

            return query.list();

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // คืนค่า Rent ที่ยังไม่ได้คืนห้อง (active) สำหรับห้องนั้นๆ
    public Rent getRentByRoomID(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ดึงเฉพาะ Rent ที่ยังไม่ได้คืนห้อง (RentalDeposit.status != 'คืนห้องแล้ว')
            String hql = "SELECT DISTINCT r FROM Rent r " +
                    "LEFT JOIN FETCH r.rentalDeposit rd " +
                    "WHERE r.room.roomID = :roomID " +
                    "AND rd.status != 'คืนห้องแล้ว' " +
                    "ORDER BY r.rentDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
            query.setParameter("roomID", roomID);
            query.setMaxResults(1);

            return query.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // ดึงเฉพาะการจองที่ยังไม่ได้คืนห้อง (ไม่รวมสถานะ "คืนห้องแล้ว")
    public List<RentalDeposit> findActiveDepositsByMember(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            String hql = "FROM RentalDeposit rd WHERE rd.rent.member = :member AND rd.status != 'คืนห้องแล้ว'";
            return session.createQuery(hql, RentalDeposit.class)
                    .setParameter("member", member)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null)
                session.close();
        }
    }

    // ตรวจสอบว่ามีบิลค้างชำระหรือไม่
    public boolean hasUnpaidInvoices(int rentId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT COUNT(i) FROM Invoice i WHERE i.rent.rentID = :rentId AND i.status = 0";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("rentId", rentId);

            Long unpaidCount = query.uniqueResult();
            return unpaidCount != null && unpaidCount > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return true;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // คืนห้อง - เปลี่ยนสถานะห้องเป็นว่างและจัดการข้อมูลการจอง
    public boolean returnRoom(int rentId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            // หา Rent และ Room ที่เกี่ยวข้อง
            Rent rent = session.get(Rent.class, rentId);
            if (rent == null) {
                System.out.println("Error: Rent not found for rentId: " + rentId);
                return false;
            }

            Room room = rent.getRoom();
            if (room == null) {
                System.out.println("Error: Room not found for rent: " + rentId);
                return false;
            }

            // ตรวจสอบอีกครั้งว่าไม่มีบิลค้างชำระ
            String checkHql = "SELECT COUNT(i) FROM Invoice i WHERE i.rent.rentID = :rentId AND i.status = 0";
            Query<Long> checkQuery = session.createQuery(checkHql, Long.class);
            checkQuery.setParameter("rentId", rentId);
            Long unpaidCount = checkQuery.uniqueResult();

            if (unpaidCount != null && unpaidCount > 0) {
                System.out.println("Error: Found unpaid invoices: " + unpaidCount);
                return false;
            }

            // เปลี่ยนสถานะห้องเป็น "ว่าง"
            room.setRoomStatus("ว่าง");
            session.update(room);
            System.out.println("Updated room status to ว่าง for room: " + room.getRoomNumber());

            // หา RentalDeposit ด้วย session เดียวกัน
            String depositHql = "FROM RentalDeposit WHERE rent.rentID = :rentId";
            Query<RentalDeposit> depositQuery = session.createQuery(depositHql, RentalDeposit.class);
            depositQuery.setParameter("rentId", rentId);
            RentalDeposit deposit = depositQuery.uniqueResult();

            if (deposit != null) {
                deposit.setStatus("คืนห้องแล้ว");
                session.update(deposit);
                System.out.println(
                        "Updated rental deposit status to คืนห้องแล้ว for depositId: " + deposit.getDepositID());
            } else {
                System.out.println("Warning: RentalDeposit not found for rentId: " + rentId);
            }

            tx.commit();
            System.out.println("Transaction committed successfully for rentId: " + rentId);
            return true;

        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
                System.out.println("Transaction rolled back due to error");
            }
            System.out.println("Error in returnRoom method:");
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // หา RentalDeposit จาก rentId
    public RentalDeposit findRentalDepositByRentId(int rentId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "FROM RentalDeposit WHERE rent.rentID = :rentId";
            Query<RentalDeposit> query = session.createQuery(hql, RentalDeposit.class);
            query.setParameter("rentId", rentId);

            return query.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // ดึงวันที่คืนห้องจากฐานข้อมูล
    public String getReturnDateFromRent(int rentId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String sql = "SELECT description FROM rent WHERE rentID = :rentId";
            Query sqlQuery = session.createNativeQuery(sql);
            sqlQuery.setParameter("rentId", rentId);

            Object result = sqlQuery.uniqueResult();
            if (result != null) {
                String description = result.toString();
                if (description.contains("|RETURN_DATE:")) {
                    String[] parts = description.split("\\|RETURN_DATE:");
                    if (parts.length > 1) {
                        return parts[1];
                    }
                }
            }
            return null;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // อัปเดต findActiveDepositsByMember เพื่อเพิ่มวันที่คืนห้อง
    public List<RentalDeposit> findActiveDepositsByMemberWithReturnDate(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // กรองเฉพาะที่ status ไม่ใช่ "คืนห้องแล้ว"
            String hql = "FROM RentalDeposit rd WHERE rd.rent.member = :member AND " +
                    "(rd.status IS NULL OR rd.status != 'คืนห้องแล้ว')";

            List<RentalDeposit> deposits = session.createQuery(hql, RentalDeposit.class)
                    .setParameter("member", member)
                    .list();

            for (RentalDeposit deposit : deposits) {
                String returnDate = getReturnDateFromRent(deposit.getRent().getRentID());

                deposit.setHasUnpaidInvoices(false); 
            }

            return deposits;

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null)
                session.close();
        }
    }

    // ดึงรายการห้องที่ได้คืนแล้วในช่วงเวลาที่กำหนด (สำหรับ admin)
    public List<Rent> getReturnedRents(Date startDate, Date endDate) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT r FROM Rent r " +
                    "LEFT JOIN FETCH r.member " +
                    "LEFT JOIN FETCH r.room " +
                    "WHERE r.returnDate BETWEEN :startDate AND :endDate " +
                    "ORDER BY r.returnDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);

            return query.list();

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // หาการจองทั้งหมดที่ยังไม่คืนห้อง (สำหรับ admin)
    public List<Rent> getAllActiveRents() {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT r FROM Rent r " +
                    "LEFT JOIN FETCH r.member " +
                    "LEFT JOIN FETCH r.room " +
                    "WHERE r.returnDate IS NULL " +
                    "ORDER BY r.rentDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
            return query.list();

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public List<RentalDeposit> getMemberActiveRentals(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT rd FROM RentalDeposit rd " +
                    "LEFT JOIN FETCH rd.rent r " +
                    "LEFT JOIN FETCH r.room " +
                    "LEFT JOIN FETCH r.member " +
                    "WHERE r.member = :member " +
                    "AND rd.status != 'คืนห้องแล้ว' " +
                    "AND rd.status IS NOT NULL " +
                    "ORDER BY rd.paymentDate DESC";

            Query<RentalDeposit> query = session.createQuery(hql, RentalDeposit.class);
            query.setParameter("member", member);

            return query.list();

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public int countMemberActiveRentals(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT COUNT(rd) FROM RentalDeposit rd " +
                    "WHERE rd.rent.member = :member " +
                    "AND rd.status != 'คืนห้องแล้ว' " +
                    "AND rd.status IS NOT NULL";

            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("member", member);

            Long count = query.uniqueResult();
            return count != null ? count.intValue() : 0;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public boolean isRoomApproved(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT COUNT(rd) FROM RentalDeposit rd " +
                    "WHERE rd.rent.room.roomID = :roomID " +
                    "AND rd.status = 'เสร็จสมบูรณ์' " +
                    "AND rd.rent.room.roomStatus = 'ไม่ว่าง'";

            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("roomID", roomID);

            Long count = query.uniqueResult();
            return count != null && count > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public RentalDeposit getRentalDepositByRoomID(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT rd FROM RentalDeposit rd " +
                    "WHERE rd.rent.room.roomID = :roomID " +
                    "AND rd.rent.room.roomStatus = 'ไม่ว่าง' " +
                    "ORDER BY rd.paymentDate DESC";

            Query<RentalDeposit> query = session.createQuery(hql, RentalDeposit.class);
            query.setParameter("roomID", roomID);
            query.setMaxResults(1);

            return query.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public List<Invoice> getInvoicesByRoomID(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT i FROM Invoice i " +
                    "LEFT JOIN FETCH i.details d " +
                    "LEFT JOIN FETCH d.type " + 
                    "LEFT JOIN FETCH i.rent r " +
                    "LEFT JOIN FETCH r.member " +
                    "LEFT JOIN FETCH r.room " +
                    "WHERE r.room.roomID = :roomID " +
                    "ORDER BY i.issueDate DESC";

            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("roomID", roomID);

            return query.list();

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public Invoice getInvoiceWithDetails(int invoiceId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT i FROM Invoice i " +
                    "LEFT JOIN FETCH i.details d " +
                    "LEFT JOIN FETCH d.type t " +
                    "LEFT JOIN FETCH i.rent r " +
                    "LEFT JOIN FETCH r.member " +
                    "LEFT JOIN FETCH r.room " +
                    "WHERE i.invoiceId = :invoiceId";

            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("invoiceId", invoiceId);

            return query.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // เมธอดตรวจสอบว่าใบแจ้งหนี้มีอยู่จริงไหม
    public boolean invoiceExists(int invoiceId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            String hql = "SELECT COUNT(i) FROM Invoice i WHERE i.invoiceId = :invoiceId";
            Long count = session.createQuery(hql, Long.class)
                    .setParameter("invoiceId", invoiceId)
                    .uniqueResult();

            System.out.println("Invoice " + invoiceId + " exists check: " + count);
            return count != null && count > 0;

        } catch (Exception e) {
            System.out.println("Error checking invoice existence: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public boolean deleteInvoice(int invoiceId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            System.out.println("Starting delete process for invoice ID: " + invoiceId);

            // ตรวจสอบว่ามี Invoice อยู่จริง
            Invoice invoice = session.get(Invoice.class, invoiceId);
            if (invoice == null) {
                System.out.println("Invoice " + invoiceId + " not found");
                return false;
            }

            // ตรวจสอบสถานะการชำระ - ไม่ให้ลบถ้าชำระแล้ว
            if (invoice.getStatus() == 1) {
                System.out
                        .println("Cannot delete paid invoice: " + invoiceId + " (status: " + invoice.getStatus() + ")");
                throw new RuntimeException("ไม่สามารถลบใบแจ้งหนี้ที่ชำระแล้วได้");
            }

            System.out.println("Invoice status: " + invoice.getStatus() + " (0=unpaid, 1=paid)");

            // ลบ InvoiceDetail
            if (invoice.getDetails() != null && !invoice.getDetails().isEmpty()) {
                for (InvoiceDetail detail : invoice.getDetails()) {
                    session.delete(detail);
                }
                System.out.println("Deleted " + invoice.getDetails().size() + " invoice details");
            }

            // ลบ Invoice
            session.delete(invoice);
            System.out.println("Deleted invoice: " + invoiceId);

            tx.commit();
            return true;

        } catch (RuntimeException re) {
            if (tx != null) {
                tx.rollback();
            }
            throw re;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            System.out.println("Error deleting invoice " + invoiceId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // ตรวจสอบสถานะการชำระ
    public boolean canDeleteInvoice(int invoiceId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            Invoice invoice = session.get(Invoice.class, invoiceId);
            if (invoice == null) {
                return false;
            }

            // ตรวจสอบสถานะ: 0 = ยังไม่ชำระ, 1 = ชำระแล้ว
            boolean canDelete = invoice.getStatus() == 0;
            System.out.println(
                    "Invoice " + invoiceId + " can delete: " + canDelete + " (status: " + invoice.getStatus() + ")");

            return canDelete;

        } catch (Exception e) {
            System.out.println("Error checking invoice delete permission: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // ข้อมูลใบแจ้งหนี้พร้อมสถานะ
    public Invoice getInvoiceWithStatus(int invoiceId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            Invoice invoice = session.get(Invoice.class, invoiceId);
            System.out.println("Retrieved invoice " + invoiceId + " with status: " +
                    (invoice != null ? invoice.getStatus() : "null"));

            return invoice;

        } catch (Exception e) {
            System.out.println("Error retrieving invoice: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public boolean hasMemberActiveRental(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT COUNT(rd) FROM RentalDeposit rd " +
                    "WHERE rd.rent.member = :member " +
                    "AND rd.status != 'คืนห้องแล้ว' " +
                    "AND rd.status IS NOT NULL";

            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("member", member);

            Long count = query.uniqueResult();
            return count != null && count > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return true; 
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // ตรวจสอบว่าหมายเลขห้องมีอยู่ในระบบแล้วหรือไม่
    public boolean isRoomNumberExists(String roomNumber) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT COUNT(r) FROM Room r WHERE r.roomNumber = :roomNumber";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("roomNumber", roomNumber);

            Long count = query.uniqueResult();
            return count != null && count > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public Rent getActiveRentByRoomID(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ดึงเฉพาะ Rent ที่สถานะห้อง = 'ไม่ว่าง' และยังไม่ได้คืนห้อง
            String hql = "SELECT DISTINCT r FROM Rent r " +
                    "LEFT JOIN FETCH r.rentalDeposit rd " +
                    "LEFT JOIN FETCH r.room room " +
                    "WHERE room.roomID = :roomID " +
                    "AND room.roomStatus = 'ไม่ว่าง' " +
                    "AND (rd.status IS NULL OR rd.status != 'คืนห้องแล้ว') " +
                    "ORDER BY r.rentDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
            query.setParameter("roomID", roomID);
            query.setMaxResults(1); 

            List<Rent> results = query.list();
            return results.isEmpty() ? null : results.get(0);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

}
