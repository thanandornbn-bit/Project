package com.springmvc.model;

import java.util.ArrayList;
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

    // ตรวจสอบว่า Email มีอยู่ในระบบแล้วหรือไม่ (ไม่สนใจตัวพิมพ์ใหญ่-เล็ก)
    public boolean isEmailExists(String email) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            String hql = "FROM Member WHERE LOWER(email) = LOWER(:email)";
            Member member = session.createQuery(hql, Member.class)
                    .setParameter("email", email)
                    .uniqueResult();
            return member != null;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
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

    // บันทึกการจอง (Reserve)
    public boolean insertReserve(Reserve reserve) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();

            // อนุญาตให้หลายคนจองห้องเดียวกันได้
            // ไม่ต้องเช็คว่ามีการจองอื่นอยู่หรือไม่
            // เช็คเฉพาะว่าห้องมีสถานะ "ไม่ว่าง" (มีคนเช่าแล้วและชำระเงินสำเร็จ)

            Room room = session.get(Room.class, reserve.getRoom().getRoomID());
            if (room != null && "ไม่ว่าง".equals(room.getRoomStatus())) {
                // ห้องถูกเช่าไปแล้ว (มีคนชำระเงินและ Manager อนุมัติแล้ว)
                tx.rollback();
                return false;
            }

            session.save(reserve);
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

    // ดึงรายการจองทั้งหมด (สำหรับ Manager)
    public List<Reserve> findAllReserves() {
        Session session = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            // เรียงจากวันที่จองเก่าสุดไปใหม่สุด (ASC)
            String hql = "FROM Reserve r ORDER BY r.reserveDate ASC";
            return session.createQuery(hql, Reserve.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null)
                session.close();
        }
    }

    // ดึงรายการจองตาม Member
    public List<Reserve> findReservesByMember(Member member) {
        Session session = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            String hql = "FROM Reserve r WHERE r.member = :member ORDER BY r.reserveDate DESC";
            return session.createQuery(hql, Reserve.class)
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

    // ดึงรายการจองตาม ID
    public Reserve findReserveById(int reserveId) {
        Session session = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            return session.get(Reserve.class, reserveId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null)
                session.close();
        }
    }

    // อัปเดตสถานะการจอง
    public boolean updateReserveStatus(int reserveId, String status) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();

            Reserve reserve = session.get(Reserve.class, reserveId);
            if (reserve != null) {
                reserve.setStatus(status);

                // บันทึกเวลาอนุมัติเพื่อใช้ตรวจสอบหมดเวลา 24 ชั่วโมง
                if ("อนุมัติแล้ว".equals(status)) {
                    // บวกเวลา 7 ชั่วโมงสำหรับเวลาไทย
                    java.util.Calendar cal = java.util.Calendar.getInstance();
                    cal.add(java.util.Calendar.HOUR_OF_DAY, 7);
                    reserve.setApprovedDate(cal.getTime());
                }
                session.update(reserve);

                // อนุญาตให้อนุมัติได้หลายคน ไม่ปฏิเสธคนอื่น
                // การปฏิเสธจะเกิดขึ้นอัตโนมัติเมื่อมีคนชำระเงินค่ามัดจำสำเร็จ

                // ถ้าปฏิเสธการจอง → เปลี่ยนสถานะห้องกลับเป็น "ว่าง"
                // (ถ้าไม่มีการจองอื่นรออนุมัติ)
                if ("ปฏิเสธ".equals(status)) {
                    // เช็คว่ามีการจองอื่นที่รออนุมัติหรืออนุมัติแล้วหรือไม่
                    String checkOtherReservesHql = "FROM Reserve WHERE room.roomID = :roomId " +
                            "AND reserveID != :currentReserveId " +
                            "AND status IN ('รอการอนุมัติ', 'อนุมัติแล้ว')";
                    List<Reserve> otherReserves = session.createQuery(checkOtherReservesHql, Reserve.class)
                            .setParameter("roomId", reserve.getRoom().getRoomID())
                            .setParameter("currentReserveId", reserveId)
                            .list();

                    // เช็คว่ามีคนเช่าห้องนี้อยู่หรือไม่
                    String checkRentsHql = "FROM Rent WHERE room.roomID = :roomId " +
                            "AND status IN ('รออนุมัติ', 'ชำระแล้ว')";
                    List<Rent> rents = session.createQuery(checkRentsHql, Rent.class)
                            .setParameter("roomId", reserve.getRoom().getRoomID())
                            .list();

                    // ถ้าไม่มีการจองอื่นและไม่มีคนเช่า → เปลี่ยนสถานะห้องเป็น "ว่าง"
                    if (otherReserves.isEmpty() && rents.isEmpty()) {
                        Room room = reserve.getRoom();
                        room.setRoomStatus("ว่าง");
                        session.update(room);
                    }
                }

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

    // อัปเดตข้อมูลการจอง (Reserve) ทั้งหมด
    public boolean updateReserve(Reserve reserve) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();

            session.update(reserve);
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

    // ปฏิเสธการจองที่อนุมัติแล้วแต่ไม่ชำระเงินภายใน 24 ชั่วโมง (อัตโนมัติ)
    public int autoRejectExpiredReservations() {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();

            // หาการจองที่สถานะ "อนุมัติแล้ว" และเกินเวลาอนุมัติมา 24 ชั่วโมงแล้ว
            java.util.Date now = new java.util.Date();
            long oneDayInMillis = 24 * 60 * 60 * 1000; // 24 ชั่วโมง

            String hql = "FROM Reserve WHERE status = 'อนุมัติแล้ว' AND approvedDate IS NOT NULL";
            List<Reserve> approvedReserves = session.createQuery(hql, Reserve.class).list();

            int updatedCount = 0;
            for (Reserve reserve : approvedReserves) {
                long timeDiff = now.getTime() - reserve.getApprovedDate().getTime();
                if (timeDiff >= oneDayInMillis) {
                    reserve.setStatus("ปฏิเสธ");
                    session.update(reserve);
                    updatedCount++;
                }
            }

            tx.commit();
            return updatedCount;
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
            return 0;
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
    // ค้นหาห้องจาก floor และ status
    public List<Room> findRoomsByFloorAndStatus(String floor, String status) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ถ้าไม่มีทั้ง floor และ status ให้ดึงทั้งหมด
            if ((floor == null || floor.isEmpty()) && (status == null || status.isEmpty())) {
                return session.createQuery("FROM Room ORDER BY roomNumber", Room.class).list();
            }

            String hql = "FROM Room WHERE 1=1";

            if (floor != null && !floor.isEmpty()) {
                hql += " AND roomNumber LIKE :floorPrefix";
            }

            if (status != null && !status.isEmpty()) {
                hql += " AND roomStatus = :status";
            }

            hql += " ORDER BY roomNumber"; // เพิ่มการเรียงลำดับ

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

    // ดึง Rent ทั้งหมดของสมาชิก
    public List<Rent> findDepositsByMember(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            String hql = "FROM Rent rd WHERE rd.member = :member";
            return session.createQuery(hql, Rent.class)
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
                    + "";

            return session.createQuery(hql, Rent.class).list();

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null)
                session.close();
        }
    }

    public boolean confirmRent(int RentId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();

            Rent rent = session.get(Rent.class, RentId);
            System.out.println("=== confirmRent Debug ===");
            System.out.println("RentId: " + RentId);
            System.out.println("Rent found: " + (rent != null));
            if (rent != null) {
                System.out.println("Current status: " + rent.getStatus());
                System.out.println("Room: " + (rent.getRoom() != null ? rent.getRoom().getRoomNumber() : "null"));
                System.out.println("Member: " + (rent.getMember() != null ? rent.getMember().getFirstName() : "null"));
            }

            if (rent != null && "รออนุมัติ".equals(rent.getStatus())) {
                // เปลี่ยนสถานะจาก "รออนุมัติ" เป็น "ชำระแล้ว" (ได้ห้องแล้ว)
                rent.setStatus("ชำระแล้ว");
                session.update(rent);

                // อัปเดตสถานะห้องเป็น "ไม่ว่าง"
                Room room = rent.getRoom();
                Member paidMember = rent.getMember();
                if (room != null && paidMember != null) {
                    room.setRoomStatus("ไม่ว่าง");
                    session.update(room);

                    System.out.println("=== Start Processing Payment Approval ===");
                    System.out.println("Paid Member ID: " + paidMember.getMemberID());
                    System.out
                            .println("Paid Member Name: " + paidMember.getFirstName() + " " + paidMember.getLastName());
                    System.out.println("Room ID: " + room.getRoomID());

                    // หาการจองทั้งหมดของห้องนี้
                    String findAllReservesHql = "FROM Reserve r WHERE r.room.roomID = :roomId ORDER BY r.reserveDate ASC";
                    List<Reserve> allReserves = session.createQuery(findAllReservesHql, Reserve.class)
                            .setParameter("roomId", room.getRoomID())
                            .list();

                    System.out.println("=== All Reserves for Room " + room.getRoomNumber() + " ===");
                    for (Reserve r : allReserves) {
                        System.out.println("  Reserve ID: " + r.getReserveId() +
                                ", Member ID: " + r.getMember().getMemberID() +
                                ", Member: " + r.getMember().getFirstName() + " " + r.getMember().getLastName() +
                                ", Status: " + r.getStatus());
                    }

                    // หาการจองที่ได้รับอนุมัติแล้วหรือชำระแล้วของห้องนี้
                    String findApprovedReservesHql = "FROM Reserve r " +
                            "WHERE r.room.roomID = :roomId " +
                            "AND r.status IN ('อนุมัติแล้ว', 'ชำระแล้ว') " +
                            "ORDER BY r.approvedDate ASC";
                    List<Reserve> approvedReserves = session.createQuery(findApprovedReservesHql, Reserve.class)
                            .setParameter("roomId", room.getRoomID())
                            .list();

                    System.out.println("Found " + approvedReserves.size() + " approved/paid reserves for this room");

                    Reserve paidReserve = null;

                    // หาการจองของคนที่จ่ายเงิน (ตรวจสอบ member ID)
                    for (Reserve reserve : approvedReserves) {
                        System.out.println("Checking reserve ID " + reserve.getReserveId() +
                                " for member " + reserve.getMember().getMemberID() +
                                " (firstName: " + reserve.getMember().getFirstName() + ")");
                        if (reserve.getMember().getMemberID() == paidMember.getMemberID()) {
                            paidReserve = reserve;
                            System.out.println("Match found! This is the paid member's reserve.");
                            break;
                        }
                    }

                    if (paidReserve != null) {
                        // อัปเดตการจองของคนที่จ่ายเงินเป็น "เช่าอยู่" ผ่าน HQL เพื่อ commit ทันที
                        String updatePaidReserveHql = "UPDATE Reserve r SET r.status = 'เช่าอยู่' " +
                                "WHERE r.reserveId = :paidReserveId";
                        int updated = session.createQuery(updatePaidReserveHql)
                                .setParameter("paidReserveId", paidReserve.getReserveId())
                                .executeUpdate();
                        System.out.println("Updated reserve ID " + paidReserve.getReserveId()
                                + " to 'เช่าอยู่' (rows affected: " + updated + ")");

                        // Flush เพื่อให้ update commit ทันที
                        session.flush();
                        System.out.println("Flushed session to commit changes");

                        // ปฏิเสธการจองอื่นๆ ทั้งหมดของห้องนี้ (รอการอนุมัติ + อนุมัติแล้ว + ชำระแล้ว
                        // ยกเว้นที่เปลี่ยนเป็น "เช่าอยู่" แล้ว)
                        String rejectOthersHql = "UPDATE Reserve r SET r.status = 'ปฏิเสธ' " +
                                "WHERE r.room.roomID = :roomId " +
                                "AND r.reserveId != :paidReserveId " +
                                "AND r.status IN ('รอการอนุมัติ', 'อนุมัติแล้ว', 'ชำระแล้ว')";
                        int rejected = session.createQuery(rejectOthersHql)
                                .setParameter("roomId", room.getRoomID())
                                .setParameter("paidReserveId", paidReserve.getReserveId())
                                .executeUpdate();
                        System.out.println("Rejected " + rejected + " other reserves");
                    } else {
                        System.out.println(
                                "ERROR: No approved reserve found for paid member ID " + paidMember.getMemberID());
                    }
                }

                tx.commit();
                System.out.println("=== Rent confirmed successfully ===");
                return true;
            }
            System.out.println("=== Cannot confirm: rent is null or status is not 'รออนุมัติ' ===");
            return false;

        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            System.out.println("=== Error in confirmRent: " + e.getMessage() + " ===");
            e.printStackTrace();
            return false;
        } finally {
            if (session != null)
                session.close();
        }
    }

    public boolean deleteRent(int rentId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();

            Rent rent = session.get(Rent.class, rentId);
            if (rent != null) {
                session.delete(rent);
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

    // Get room rental history ordered by newest first
    public List<Rent> getRoomRentalHistory(int roomId) {
        Session session = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();

            String hql = "FROM Rent WHERE room.roomID = :roomId ORDER BY rentDate DESC";
            List<Rent> rentHistory = session.createQuery(hql, Rent.class)
                    .setParameter("roomId", roomId)
                    .list();

            return rentHistory;

        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            if (session != null)
                session.close();
        }
    }

    // Get rent by ID
    public Rent getRentById(int rentId) {
        Session session = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            return session.get(Rent.class, rentId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null)
                session.close();
        }
    }

    // Update rent information
    public boolean updateRent(Rent rent) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory factory = HibernateConnection.doHibernateConnection();
            session = factory.openSession();
            tx = session.beginTransaction();

            session.update(rent);

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

    // บันทึก Invoice และ InvoiceDetail ทั้งหมด
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

    // หา Room ด้วย roomID
    public Room findRoomById(int roomID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            return session.get(Room.class, roomID);
        }
    }

    // หา Rent ด้วย roomID
    public Rent findRentById(int rentID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            return session.get(Rent.class, rentID);
        }
    }

    // ดึง InvoiceType ตามชื่อ
    public InvoiceType getInvoiceTypeByName(String name) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ลองหาข้อมูลที่มีอยู่
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

    // ดึงรายการ Rent ทั้งหมด
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

    // คืนค่า Rent ที่ยังไม่ได้คืนห้อง (active) สำหรับห้องนั้นๆ
    public Rent getRentByRoomID(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ดึงเฉพาะ Rent ที่ยังไม่ได้คืนห้อง (r.status != 'คืนห้องแล้ว')
            String hql = "SELECT r FROM Rent r " +
                    "LEFT JOIN FETCH r.room " +
                    "LEFT JOIN FETCH r.member " +
                    "WHERE r.room.roomID = :roomID " +
                    "AND r.status != 'คืนห้องแล้ว' " +
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
    public List<Rent> findActiveDepositsByMember(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            String hql = "FROM Rent rd WHERE rd.member = :member AND rd.status != 'คืนห้องแล้ว'";
            return session.createQuery(hql, Rent.class)
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

    // ดึงรายการบิลค้างชำระพร้อมข้อมูลเดือน
    public List<Invoice> getUnpaidInvoices(int rentId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "FROM Invoice i WHERE i.rent.rentID = :rentId AND i.status = 0 ORDER BY i.issueDate ASC";
            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("rentId", rentId);

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

            String depositHql = "FROM Rent WHERE rent.rentID = :rentId";
            Query<Rent> depositQuery = session.createQuery(depositHql, Rent.class);
            depositQuery.setParameter("rentId", rentId);
            Rent deposit = depositQuery.uniqueResult();

            if (deposit != null) {
                deposit.setStatus("คืนห้องแล้ว");
                session.update(deposit);
            }

            tx.commit();

            return true;

        } catch (Exception e) {
            if (tx != null) {
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

    // หา Rent จาก rentId
    public Rent findRentByRentId(int rentId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "FROM Rent WHERE rent.rentID = :rentId";
            Query<Rent> query = session.createQuery(hql, Rent.class);
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
            @SuppressWarnings("rawtypes")
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

    public List<Rent> findActiveDepositsByMemberWithReturnDate(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // กรองเฉพาะที่ status ไม่ใช่ "คืนห้องแล้ว"
            String hql = "FROM Rent rd WHERE rd.member = :member AND " +
                    "(rd.status IS NULL OR rd.status != 'คืนห้องแล้ว')";

            List<Rent> deposits = session.createQuery(hql, Rent.class)
                    .setParameter("member", member)
                    .list();

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

    public List<Rent> getMemberActiveRentals(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT rd FROM Rent rd " +
                    "LEFT JOIN FETCH rd.rent r " +
                    "LEFT JOIN FETCH r.room " +
                    "LEFT JOIN FETCH r.member " +
                    "WHERE r.member = :member " +
                    "AND rd.status != 'คืนห้องแล้ว' " +
                    "AND rd.status IS NOT NULL " +
                    "ORDER BY rd.paymentDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
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

            String hql = "SELECT COUNT(rd) FROM Rent rd " +
                    "WHERE rd.member = :member " +
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

            String hql = "SELECT COUNT(rd) FROM Rent rd " +
                    "WHERE rd.room.roomID = :roomID " +
                    "AND rd.status = 'เสร็จสมบูรณ์' " +
                    "AND rd.room.roomStatus = 'ไม่ว่าง'";

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

            // ปิด cache เพื่อให้ดึงข้อมูลล่าสุดจาก database
            session.setCacheMode(org.hibernate.CacheMode.IGNORE);

            String hql = "SELECT DISTINCT i FROM Invoice i " +
                    "LEFT JOIN FETCH i.details d " +
                    "LEFT JOIN FETCH d.type t " +
                    "LEFT JOIN FETCH i.rent r " +
                    "LEFT JOIN FETCH r.member " +
                    "LEFT JOIN FETCH r.room " +
                    "WHERE i.invoiceId = :invoiceId";

            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("invoiceId", invoiceId);
            query.setCacheable(false); // ปิด query cache

            Invoice invoice = query.uniqueResult();

            // บังคับให้โหลด details ทั้งหมด (ป้องกัน lazy loading)
            if (invoice != null && invoice.getDetails() != null) {
                invoice.getDetails().size(); // initialize collection
                System.out.println("Loaded invoice " + invoiceId + " with " + invoice.getDetails().size() + " details");
            }

            return invoice;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // ตรวจสอบว่าใบแจ้งหนี้มีอยู่จริงไหม
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
            Invoice invoice = session.get(Invoice.class, invoiceId);
            if (invoice == null) {
                System.out.println("Invoice " + invoiceId + " not found");
                return false;
            }

            // ลบ InvoiceDetail
            if (invoice.getDetails() != null && !invoice.getDetails().isEmpty()) {
                for (InvoiceDetail detail : invoice.getDetails()) {
                    session.delete(detail);
                }
            }

            // ลบ Invoice
            session.delete(invoice);

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

    // เพิ่มเมธอดตรวจสอบสถานะการชำระ
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

    // เพิ่มเมธอดดึงข้อมูลใบแจ้งหนี้พร้อมสถานะ
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

            String hql = "SELECT COUNT(rd) FROM Rent rd " +
                    "WHERE rd.member = :member " +
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

    public List<Rent> findAllRentsByRoomID(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT r FROM Rent r " +
                    "LEFT JOIN FETCH r.room rm " +
                    "LEFT JOIN FETCH r.member m " +
                    "WHERE rm.roomID = :roomID " +
                    "ORDER BY r.rentDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
            query.setParameter("roomID", roomID);

            return query.list();

        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
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

            // ดึง Rent ที่กำลัง active (ชำระแล้ว, เสร็จสมบูรณ์, รอคืนห้อง)
            // และยังไม่ได้คืนห้อง
            String hql = "SELECT r FROM Rent r " +
                    "LEFT JOIN FETCH r.room rm " +
                    "LEFT JOIN FETCH r.member m " +
                    "WHERE rm.roomID = :roomID " +
                    "AND (r.status = 'ชำระแล้ว' OR r.status = 'เสร็จสมบูรณ์' OR r.status = 'รอคืนห้อง') " +
                    "ORDER BY r.rentDate DESC";

            System.out.println("=== getActiveRentByRoomID Debug ===");
            System.out.println("Query: " + hql);
            System.out.println("RoomID parameter: " + roomID);

            Query<Rent> query = session.createQuery(hql, Rent.class);
            query.setParameter("roomID", roomID);
            query.setMaxResults(1);

            List<Rent> results = query.list();
            System.out.println("Results found: " + results.size());
            if (!results.isEmpty()) {
                Rent r = results.get(0);
                System.out.println("Rent ID: " + r.getRentID() + ", Status: " + r.getStatus());
            }

            return results.isEmpty() ? null : results.get(0);

        } catch (Exception e) {
            System.out.println("Error in getActiveRentByRoomID: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public List<Invoice> getInvoicesByMemberID(int memberID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT i FROM Invoice i " +
                    "LEFT JOIN FETCH i.rent r " +
                    "LEFT JOIN FETCH r.member m " +
                    "LEFT JOIN FETCH r.room " +
                    "LEFT JOIN FETCH i.details " +
                    "WHERE m.memberID = :memberID " +
                    "ORDER BY i.issueDate DESC";

            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("memberID", memberID);

            List<Invoice> invoices = query.list();

            System.out.println("Retrieved " + invoices.size() + " invoices for memberID: " + memberID);

            return invoices;

        } catch (Exception e) {
            System.out.println("Error getting invoices for memberID " + memberID + ": " + e.getMessage());
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public List<Invoice> findInvoicesByMember(int memberID) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            String hql = "SELECT DISTINCT i FROM Invoice i " +
                    "LEFT JOIN FETCH i.rent r " +
                    "LEFT JOIN FETCH r.room " +
                    "LEFT JOIN FETCH r.member m " +
                    "WHERE m.memberID = :memberID " +
                    "ORDER BY i.issueDate DESC";
            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("memberID", memberID);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    // เช็คว่ามีบิลในเดือนปัจจุบันสำหรับห้องนี้หรือยัง
    public boolean hasInvoiceForCurrentMonth(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // หาเดือนและปีปัจจุบัน
            java.time.LocalDate now = java.time.LocalDate.now();
            int currentMonth = now.getMonthValue();
            int currentYear = now.getYear();

            String hql = "SELECT COUNT(i) FROM Invoice i " +
                    "WHERE i.rent.room.roomID = :roomID " +
                    "AND MONTH(i.issueDate) = :month " +
                    "AND YEAR(i.issueDate) = :year";

            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("roomID", roomID);
            query.setParameter("month", currentMonth);
            query.setParameter("year", currentYear);

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

    public boolean updateInvoiceFull(Invoice invoice, List<InvoiceDetail> oldDetails) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            System.out.println("=== Starting Invoice Update ===");
            System.out.println("Invoice ID: " + invoice.getInvoiceId());
            System.out.println("Old details count: " + (oldDetails != null ? oldDetails.size() : 0));
            System.out
                    .println("New details count: " + (invoice.getDetails() != null ? invoice.getDetails().size() : 0));

            // ดึง Invoice จากฐานข้อมูลใน session
            Invoice dbInvoice = session.get(Invoice.class, invoice.getInvoiceId());

            if (dbInvoice == null) {
                System.out.println("ERROR: Invoice not found in database");
                return false;
            }

            // อัปเดตข้อมูลพื้นฐานของ Invoice
            dbInvoice.setIssueDate(invoice.getIssueDate());
            dbInvoice.setDueDate(invoice.getDueDate());
            dbInvoice.setTotalAmount(invoice.getTotalAmount());
            dbInvoice.setStatus(invoice.getStatus());

            System.out.println("Updated basic invoice info");

            // อัปเดต InvoiceDetails โดยใช้ ID เดิม (ถ้ามี) หรือสร้างใหม่
            System.out.println("Processing details...");

            // เคลียร์ collection เพื่อเตรียมอัปเดต
            dbInvoice.getDetails().clear();
            session.flush();

            System.out.println("Cleared collection, now processing new details");

            // ประมวลผล InvoiceDetails ใหม่
            if (invoice.getDetails() != null && !invoice.getDetails().isEmpty()) {
                for (InvoiceDetail newDetail : invoice.getDetails()) {
                    InvoiceDetail detail = null;

                    // ถ้ามี ID และ > 0 แสดงว่าเป็น detail เดิม → ค้นหาและอัปเดต
                    if (newDetail.getId() > 0) {
                        // ค้นหา detail เดิมจาก session
                        detail = session.get(InvoiceDetail.class, newDetail.getId());
                        if (detail != null) {
                            System.out.println("Found existing detail ID: " + detail.getId() + " - updating");
                        } else {
                            System.out.println("Detail ID " + newDetail.getId() + " not found, creating new");
                        }
                    }

                    // ถ้าไม่เจอ detail เดิม → สร้างใหม่
                    if (detail == null) {
                        detail = new InvoiceDetail();
                        System.out.println("Creating new detail for: " + newDetail.getType().getTypeName());
                    }

                    // อัปเดตข้อมูล
                    detail.setInvoice(dbInvoice);
                    detail.setType(newDetail.getType());
                    detail.setPrice(newDetail.getPrice());
                    detail.setQuantity(newDetail.getQuantity());
                    detail.setAmount(newDetail.getAmount());

                    dbInvoice.getDetails().add(detail);
                    System.out.println("Saved detail: " + newDetail.getType().getTypeName() +
                            " (ID: " + (detail.getId() > 0 ? detail.getId() : "NEW") + ") = ฿" + newDetail.getAmount());
                }
            }

            System.out.println("Total details after update: " + dbInvoice.getDetails().size());

            // บันทึกการเปลี่ยนแปลง
            session.update(dbInvoice);

            tx.commit();
            System.out.println("=== Invoice Update SUCCESS ===");
            return true;

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
                System.out.println("Transaction rolled back");
            }
            System.out.println("=== Invoice Update FAILED ===");
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public Invoice getInvoiceForEdit(int invoiceId) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT i FROM Invoice i " +
                    "LEFT JOIN FETCH i.details d " +
                    "LEFT JOIN FETCH d.type t " +
                    "LEFT JOIN FETCH i.rent r " +
                    "LEFT JOIN FETCH r.member m " +
                    "LEFT JOIN FETCH r.room room " +
                    "WHERE i.invoiceId = :invoiceId";

            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("invoiceId", invoiceId);

            Invoice invoice = query.uniqueResult();

            if (invoice != null) {
                invoice.getDetails().size();
                System.out.println("Retrieved invoice " + invoiceId + " with " +
                        invoice.getDetails().size() + " details");
            }

            return invoice;

        } catch (Exception e) {
            System.out.println("Error retrieving invoice for edit: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public boolean deleteInvoiceDetails(int invoiceId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            String hql = "DELETE FROM InvoiceDetail d WHERE d.invoice.invoiceId = :invoiceId";
            int deletedCount = session.createQuery(hql)
                    .setParameter("invoiceId", invoiceId)
                    .executeUpdate();

            tx.commit();
            System.out.println("Deleted " + deletedCount + " invoice details for invoice " + invoiceId);
            return true;

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            System.out.println("Error deleting invoice details: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public Invoice getLatestInvoiceByRoomID(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT i FROM Invoice i " +
                    "LEFT JOIN FETCH i.details d " +
                    "LEFT JOIN FETCH d.type t " +
                    "LEFT JOIN FETCH i.rent r " +
                    "WHERE r.room.roomID = :roomID " +
                    "ORDER BY i.issueDate DESC, i.invoiceId DESC";

            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("roomID", roomID);
            query.setMaxResults(1);

            List<Invoice> results = query.list();

            if (!results.isEmpty()) {
                Invoice invoice = results.get(0);
                System.out.println("Found latest invoice ID: " + invoice.getInvoiceId() +
                        " for room " + roomID);
                return invoice;
            }

            System.out.println("No previous invoice found for room " + roomID);
            return null;

        } catch (Exception e) {
            System.out.println("Error getting latest invoice: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public java.util.Map<String, Integer> getPreviousMeterReadings(int roomID) {
        java.util.Map<String, Integer> readings = new java.util.HashMap<>();
        readings.put("prevWater", 0);
        readings.put("prevElectric", 0);
        readings.put("waterRate", 18);
        readings.put("electricRate", 7);

        try {
            Invoice latestInvoice = getLatestInvoiceByRoomID(roomID);

            if (latestInvoice != null && latestInvoice.getDetails() != null) {
                for (InvoiceDetail detail : latestInvoice.getDetails()) {
                    String typeName = detail.getType().getTypeName();

                    if ("ค่าน้ำ".equals(typeName)) {
                        // เลขครั้งก่อน = เลขครั้งนี้จากบิลก่อนหน้า
                        readings.put("prevWater", detail.getQuantity());
                        readings.put("waterRate", (int) detail.getPrice());
                        System.out.println("Previous water meter: " + detail.getQuantity() +
                                " @ " + detail.getPrice() + " baht/unit");
                    } else if ("ค่าไฟฟ้า".equals(typeName)) {
                        readings.put("prevElectric", detail.getQuantity());
                        readings.put("electricRate", (int) detail.getPrice());
                        System.out.println("Previous electric meter: " + detail.getQuantity() +
                                " @ " + detail.getPrice() + " baht/unit");
                    }
                }
            }

        } catch (Exception e) {
            System.out.println("Error getting previous meter readings: " + e.getMessage());
            e.printStackTrace();
        }

        return readings;
    }

    public java.util.Map<String, Integer> calculateCurrentMeterFromUsage(Invoice invoice) {
        java.util.Map<String, Integer> meters = new java.util.HashMap<>();
        meters.put("currWater", 0);
        meters.put("currElectric", 0);

        try {
            // ดึงข้อมูลจากบิลก่อนหน้า
            int roomID = invoice.getRent().getRoom().getRoomID();
            java.util.Map<String, Integer> prevReadings = getPreviousMeterReadings(roomID);

            if (invoice.getDetails() != null) {
                for (InvoiceDetail detail : invoice.getDetails()) {
                    String typeName = detail.getType().getTypeName();

                    if ("ค่าน้ำ".equals(typeName)) {
                        int prevWater = prevReadings.get("prevWater");
                        int waterUsage = detail.getQuantity();
                        meters.put("currWater", prevWater + waterUsage);
                        System.out.println("Calculated current water: " + (prevWater + waterUsage) +
                                " (prev: " + prevWater + " + usage: " + waterUsage + ")");
                    } else if ("ค่าไฟฟ้า".equals(typeName)) {
                        int prevElectric = prevReadings.get("prevElectric");
                        int electricUsage = detail.getQuantity();
                        meters.put("currElectric", prevElectric + electricUsage);
                        System.out.println("Calculated current electric: " + (prevElectric + electricUsage) +
                                " (prev: " + prevElectric + " + usage: " + electricUsage + ")");
                    }
                }
            }

        } catch (Exception e) {
            System.out.println("Error calculating current meter: " + e.getMessage());
            e.printStackTrace();
        }

        return meters;
    }

    public Invoice getInvoiceBeforeDate(int roomID, Date currentInvoiceDate) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT i FROM Invoice i " +
                    "LEFT JOIN FETCH i.details d " +
                    "LEFT JOIN FETCH d.type t " +
                    "LEFT JOIN FETCH i.rent r " +
                    "WHERE r.room.roomID = :roomID " +
                    "AND i.issueDate < :currentDate " +
                    "ORDER BY i.issueDate DESC, i.invoiceId DESC";

            Query<Invoice> query = session.createQuery(hql, Invoice.class);
            query.setParameter("roomID", roomID);
            query.setParameter("currentDate", currentInvoiceDate);
            query.setMaxResults(1);

            List<Invoice> results = query.list();

            if (!results.isEmpty()) {
                Invoice invoice = results.get(0);
                System.out.println("Found previous invoice ID: " + invoice.getInvoiceId() +
                        " (date: " + invoice.getIssueDate() + ") for room " + roomID);
                return invoice;
            }

            System.out.println("No invoice before " + currentInvoiceDate + " found for room " + roomID);
            return null;

        } catch (Exception e) {
            System.out.println("Error getting invoice before date: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // คืนห้อง - Manager สามารถคืนห้องได้เลยโดยไม่มีเงื่อนไข
    public boolean managerreturnRoom(int rentId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            // หา Rent และ Room ที่เกี่ยวข้อง
            Rent rent = session.get(Rent.class, rentId);
            if (rent == null) {
                System.out.println("❌ Error: Rent not found for rentId: " + rentId);
                return false;
            }

            Room room = rent.getRoom();
            if (room == null) {
                System.out.println("❌ Error: Room not found for rent: " + rentId);
                return false;
            }

            // เปลี่ยนสถานะห้องเป็น "ว่าง"
            room.setRoomStatus("ว่าง");
            session.update(room);

            // หา Rent และอัปเดตสถานะ
            String depositHql = "FROM Rent WHERE rent.rentID = :rentId";
            Query<Rent> depositQuery = session.createQuery(depositHql, Rent.class);
            depositQuery.setParameter("rentId", rentId);
            Rent deposit = depositQuery.uniqueResult();

            if (deposit != null) {
                deposit.setStatus("คืนห้องแล้ว");
                session.update(deposit);
            }
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

    public List<Rent> findCurrentRentalsByMember(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ดึงทั้งสถานะ "ชำระแล้ว", "เสร็จสมบูรณ์" และ "รอคืนห้อง" พร้อม fetch room
            String hql = "FROM Rent r " +
                    "LEFT JOIN FETCH r.room " +
                    "LEFT JOIN FETCH r.member " +
                    "WHERE r.member = :member " +
                    "AND (r.status = 'ชำระแล้ว' OR r.status = 'เสร็จสมบูรณ์' OR r.status = 'รอคืนห้อง') " +
                    "ORDER BY r.rentDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
            query.setParameter("member", member);

            List<Rent> rentals = query.list();

            return rentals;

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // ตรวจสอบว่า Member มี Rent ของห้องนี้อยู่แล้วหรือไม่
    public List<Rent> findRentsByMemberAndRoom(Member member, Room room) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "FROM Rent r " +
                    "WHERE r.member = :member " +
                    "AND r.room = :room " +
                    "ORDER BY r.rentDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
            query.setParameter("member", member);
            query.setParameter("room", room);

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

    // ดึงเฉพาะประวัติที่คืนห้องแล้ว (สถานะ "คืนห้องแล้ว")
    public List<Rent> findReturnedRentalsByMember(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT rd FROM Rent rd " +
                    "LEFT JOIN FETCH rd.rent r " +
                    "LEFT JOIN FETCH r.room " +
                    "LEFT JOIN FETCH r.member " +
                    "WHERE r.member = :member " +
                    "AND rd.status = 'คืนห้องแล้ว' " +
                    "ORDER BY rd.paymentDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
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

    // ส่งคำขอคืนห้อง (เปลี่ยนสถานะเป็น "รอคืนห้อง")
    public boolean requestReturnRoom(int rentId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            // ตรวจสอบว่ามีบิลค้างชำระหรือไม่
            String checkHql = "SELECT COUNT(i) FROM Invoice i WHERE i.rent.rentID = :rentId AND i.status = 0";
            Query<Long> checkQuery = session.createQuery(checkHql, Long.class);
            checkQuery.setParameter("rentId", rentId);
            Long unpaidCount = checkQuery.uniqueResult();

            if (unpaidCount != null && unpaidCount > 0) {
                System.out.println("Error: Found unpaid invoices: " + unpaidCount);
                return false;
            }

            // หา Rent และเปลี่ยนสถานะเป็น "รอคืนห้อง"
            String depositHql = "FROM Rent WHERE rentID = :rentId";
            Query<Rent> depositQuery = session.createQuery(depositHql, Rent.class);
            depositQuery.setParameter("rentId", rentId);
            Rent deposit = depositQuery.uniqueResult();

            if (deposit != null) {
                deposit.setStatus("รอคืนห้อง");

                // บันทึกวันที่และเวลาที่ส่งคำขอคืนห้อง (เวลาไทย GMT+7)
                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.setTimeZone(java.util.TimeZone.getTimeZone("Asia/Bangkok"));
                cal.add(java.util.Calendar.HOUR_OF_DAY, 7); // บวกเวลาเพิ่ม 7 ชั่วโมง
                deposit.setReturnDate(cal.getTime());

                session.update(deposit);
                tx.commit();
                return true;
            }

            return false;

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

    // ดึงรายการคำขอคืนห้องทั้งหมด (สถานะ "รอคืนห้อง")
    public List<Rent> findPendingReturnRequests() {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            String hql = "SELECT DISTINCT rd FROM Rent rd " +
                    "LEFT JOIN FETCH rd.room " +
                    "LEFT JOIN FETCH rd.member " +
                    "WHERE rd.status = 'รอคืนห้อง' " +
                    "ORDER BY rd.rentDate DESC";

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

    // อนุมัติการคืนห้อง (Manager)
    public boolean approveReturnRoom(int rentId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            // หา Rent และ Room
            Rent rent = session.get(Rent.class, rentId);
            if (rent == null) {
                return false;
            }

            Room room = rent.getRoom();
            if (room == null) {
                return false;
            }

            // เปลี่ยนสถานะห้องเป็น "ว่าง"
            room.setRoomStatus("ว่าง");
            session.update(room);

            // หา Rent และเปลี่ยนสถานะเป็น "คืนห้องแล้ว"
            String depositHql = "FROM Rent WHERE rentID = :rentId";
            Query<Rent> depositQuery = session.createQuery(depositHql, Rent.class);
            depositQuery.setParameter("rentId", rentId);
            Rent deposit = depositQuery.uniqueResult();

            if (deposit != null) {
                deposit.setStatus("คืนห้องแล้ว");
                session.update(deposit);
            }

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

    // ยกเลิกคำขอคืนห้อง (เปลี่ยนกลับเป็น "เสร็จสมบูรณ์")
    public boolean cancelReturnRequest(int rentId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            String depositHql = "FROM Rent WHERE rentID = :rentId";
            Query<Rent> depositQuery = session.createQuery(depositHql, Rent.class);
            depositQuery.setParameter("rentId", rentId);
            Rent deposit = depositQuery.uniqueResult();

            if (deposit != null && "รอคืนห้อง".equals(deposit.getStatus())) {
                // เปลี่ยนสถานะกลับเป็น "ชำระแล้ว" เพื่อให้ผู้ใช้สามารถเช่าต่อได้
                deposit.setStatus("ชำระแล้ว");
                session.update(deposit);
                tx.commit();
                return true;
            }

            return false;

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

    // Manager คืนห้องให้ลูกค้า (กรณีต้องการคืนห้องทันที)
    public boolean managerForceReturnRoom(int rentId, String notes) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            // หา Rent
            Rent rent = session.get(Rent.class, rentId);
            if (rent == null) {
                return false;
            }

            Room room = rent.getRoom();
            if (room == null) {
                return false;
            }

            // เปลี่ยนสถานะห้องเป็น "ว่าง"
            room.setRoomStatus("ว่าง");
            session.update(room);

            // เปลี่ยนสถานะการเช่าเป็น "คืนห้องแล้ว" และบันทึกหมายเหตุ
            rent.setStatus("คืนห้องแล้ว");
            rent.setNotes(notes);

            // บันทึกวันที่คืนห้อง (เวลาไทย + 7 ชั่วโมง)
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.setTimeZone(java.util.TimeZone.getTimeZone("Asia/Bangkok"));
            cal.add(java.util.Calendar.HOUR_OF_DAY, 7);
            rent.setReturnDate(cal.getTime());

            session.update(rent);

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

    // ยกเลิกการคืนห้อง (กรณีกดผิด / แก้ไขผิดพลาด)
    public boolean undoRoomReturn(int rentId) {
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            System.out.println("=== Undo Room Return ===");
            System.out.println("Rent ID: " + rentId);

            // หา Rent ที่ต้องการยกเลิกการคืน
            Rent rent = session.get(Rent.class, rentId);
            if (rent == null) {
                System.out.println("ERROR: Rent not found");
                return false;
            }

            System.out.println("Current Rent Status: " + rent.getStatus());

            // ตรวจสอบว่าต้องเป็นสถานะที่สามารถยกเลิกได้ (เช่น "คืนห้องแล้ว" หรือ
            // "เสร็จสมบูรณ์")
            if (!"คืนห้องแล้ว".equals(rent.getStatus()) && !"เสร็จสมบูรณ์".equals(rent.getStatus())) {
                System.out.println("ERROR: Cannot undo - status is not 'คืนห้องแล้ว' or 'เสร็จสมบูรณ์'");
                return false;
            }

            Room room = rent.getRoom();
            if (room == null) {
                System.out.println("ERROR: Room not found");
                return false;
            }

            Member member = rent.getMember();
            if (member == null) {
                System.out.println("ERROR: Member not found");
                return false;
            }

            System.out.println("Room ID: " + room.getRoomID() + ", Room Number: " + room.getRoomNumber());
            System.out.println("Member ID: " + member.getMemberID() + ", Name: " + member.getFirstName() + " "
                    + member.getLastName());

            // 1. เปลี่ยนสถานะ Rent กลับเป็น "ชำระแล้ว"
            rent.setStatus("ชำระแล้ว");
            rent.setReturnDate(null); // ลบวันที่คืนห้อง
            session.update(rent);
            System.out.println("Updated Rent status to 'ชำระแล้ว'");

            // 2. เปลี่ยนสถานะห้องกลับเป็น "ไม่ว่าง"
            room.setRoomStatus("ไม่ว่าง");
            session.update(room);
            System.out.println("Updated Room status to 'ไม่ว่าง'");

            // 3. เปลี่ยนสถานะ Reserve กลับเป็น "เช่าอยู่"
            String updateReserveHql = "UPDATE Reserve r SET r.status = 'เช่าอยู่' " +
                    "WHERE r.room.roomID = :roomId AND r.member.memberID = :memberId " +
                    "AND r.status IN ('เสร็จสมบูรณ์', 'คืนห้องแล้ว')";

            int reserveUpdated = session.createQuery(updateReserveHql)
                    .setParameter("roomId", room.getRoomID())
                    .setParameter("memberId", member.getMemberID())
                    .executeUpdate();

            System.out.println("Updated " + reserveUpdated + " Reserve(s) to 'เช่าอยู่'");

            tx.commit();
            System.out.println("=== Undo Room Return SUCCESS ===");
            return true;

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            System.out.println("=== Undo Room Return FAILED ===");
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // ดึงข้อมูลการจองทั้งหมดของ Member (รวมทุกสถานะ ยกเว้น "คืนห้องแล้ว")
    public List<Rent> findAllDepositsByMemberForRecord(Member member) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ดึง Rent ที่เป็นของ Member โดยตรง พร้อม eager fetch ข้อมูลที่จำเป็น
            String hql = "SELECT DISTINCT r FROM Rent r " +
                    "LEFT JOIN FETCH r.room room " +
                    "LEFT JOIN FETCH r.member " +
                    "WHERE r.member = :member " +
                    "ORDER BY r.rentDate DESC";

            Query<Rent> query = session.createQuery(hql, Rent.class);
            query.setParameter("member", member);

            List<Rent> rents = query.list();

            // Initialize lazy properties to avoid LazyInitializationException
            for (Rent rent : rents) {
                if (rent.getRoom() != null) {
                    // Force initialization
                    rent.getRoom().getRoomNumber();
                    rent.getRoom().getRoomPrice();
                    rent.getRoom().getDescription();
                    rent.getRoom().getRoomtype();
                }
                if (rent.getMember() != null) {
                    rent.getMember().getFirstName();
                }
                // Initialize other properties
                rent.getStatus();
                rent.getRentDate();
                rent.getReturnDate();
                rent.getTotalPrice();
            }

            return rents;

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

}
