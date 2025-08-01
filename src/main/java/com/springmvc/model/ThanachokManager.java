package com.springmvc.model;

import java.util.ArrayList;
import java.util.Calendar;
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
            if (transaction != null) transaction.rollback();
            ex.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
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
            if (session != null) session.close();
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
            if (session != null) session.close();
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
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
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
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
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
            if (session != null) session.close();
        }
    }

    // ค้นหาห้องจาก ID
    public Room findRoomById(int roomID) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            return session.get(Room.class, roomID);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
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
            if (session != null) session.close();
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
            if (tx != null && tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
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
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
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
            if (session != null) session.close();
        }
    }
    
    
    
    public List<Rent> findAllRentsWithDeposits() {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ใช้ LEFT JOIN FETCH เพื่อดึงข้อมูลที่เกี่ยวข้องมาพร้อมกัน
            String hql = "SELECT DISTINCT r FROM Rent r "
                       + "LEFT JOIN FETCH r.member "
                       + "LEFT JOIN FETCH r.room "
                       + "LEFT JOIN FETCH r.rentalDeposit";

            return session.createQuery(hql, Rent.class).list();

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) session.close();
        }
    }

    
    public Rent findRentById(int id) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            return session.get(Rent.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
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
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
        }
    }

    
    public RentalDeposit getRentalDepositById(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            return session.get(RentalDeposit.class, id);
        } finally {
            session.close();
        }
    }
    
    public void updateRentalDeposit(RentalDeposit deposit) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(deposit);  // อัพเดต entity
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
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
            if (room != null) {
                // ตรวจสอบสถานะต้องเป็น "ว่าง" เท่านั้นถึงจะลบได้
                if ("ว่าง".equals(room.getRoomStatus())) {
                    session.delete(room);
                    tx.commit();
                    return true;
                } else {
                    System.out.println("ไม่สามารถลบห้องที่ไม่ว่างได้");
                    return false;
                }
            }
            return false;

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
        }
    }

    
    /* ---------- helper สร้าง detail ---------- */
    private InvoiceDetail buildDetail(Session s, Invoice inv, String billName,
                                      double amt, String unit) {

        String hql = "FROM InvoiceType WHERE billname = :name";
        InvoiceType type = s.createQuery(hql, InvoiceType.class)
                            .setParameter("name", billName)
                            .uniqueResult();

        InvoiceDetail d = new InvoiceDetail();
        d.setInvoice(inv);
        d.setBilltype(type);
        d.setAmount(amt);
        d.setUnit(unit);
        return d;
    }

    /* ---------- สร้างบิลให้ 1 ห้อง ---------- */
    public Invoice createMonthlyInvoice(Rent rent,
                                        double waterUnit,  double waterRate,
                                        double elecUnit,   double elecRate,
                                        double internetFee, double fine) {

        Session s = null; Transaction tx = null;
        try {
            s = HibernateConnection.doHibernateConnection().openSession();
            tx = s.beginTransaction();

            // ---------- Invoice หลัก ----------
            Invoice inv = new Invoice();
            inv.setRent(rent);
            inv.setBillingDate(new Date());

            Calendar c = Calendar.getInstance();
            c.add(Calendar.DAY_OF_MONTH, 7);
            inv.setDueDate(c.getTime());
            inv.setStatus("pending");
            s.save(inv);   // save ก่อนเพื่อให้มี billID

            List<InvoiceDetail> dets = new ArrayList<>();

            // ---------- ค่าห้อง ----------
            double roomPrice = Double.parseDouble(rent.getRoom().getRoomPrice());
            dets.add(buildDetail(s, inv, "Room", roomPrice, null));

            // ---------- ค่าน้ำ ----------
            double water = waterUnit * waterRate;
            dets.add(buildDetail(s, inv, "Water", water,
                     String.format("%.0f หน่วย", waterUnit)));

            // ---------- ค่าไฟ ----------
            double elec = elecUnit * elecRate;
            dets.add(buildDetail(s, inv, "Electricity", elec,
                     String.format("%.0f หน่วย", elecUnit)));

            // ---------- ค่าเน็ต ----------
            dets.add(buildDetail(s, inv, "Internet", internetFee, null));

            // ---------- ค่าปรับ (ถ้ามี) ----------
            if (fine > 0) {
                dets.add(buildDetail(s, inv, "Fine", fine, null));
            }

            double total = dets.stream().mapToDouble(InvoiceDetail::getAmount).sum();
            inv.setTotalAmount(total);
            s.update(inv);     // อัปเดตราคารวม

            // save รายการย่อย
            for (InvoiceDetail d : dets) s.save(d);

            tx.commit();
            return inv;

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return null;
        } finally {
            if (s != null) s.close();
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

    // บันทึก Invoice และคืนค่า ID ที่เพิ่ม
    public int saveInvoice(Invoice invoice) {
        Transaction tx = null;
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            tx = session.beginTransaction();
            int id = (int) session.save(invoice);
            tx.commit();
            return id;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return -1;
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
            if (tx != null) tx.rollback();
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

    // ดึง Rent ทั้งหมดของผู้เช่า (หรือทั้งหมดของระบบ)
    public List<Rent> getAllRents() {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            String hql = "FROM Rent";
            Query<Rent> query = session.createQuery(hql, Rent.class);
            return query.list();
        }
    }
    

 // อัปเดต Invoice (ยอดรวม)
    public void updateInvoice(Invoice invoice) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.update(invoice);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }


    
    


}
