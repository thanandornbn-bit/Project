package com.springmvc.model;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

@Entity
@Table(name = "invoice")
public class Invoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "invoiceId", unique = true)
    private int invoiceId;

    @Temporal(TemporalType.DATE)
    @Column(name = "dueDate")
    private Date dueDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "issueDate")
    private Date issueDate;

    @Column(name = "status")
    private int status;

    @Column(name = "totalAmount", precision = 19, scale = 2)
    private double totalAmount;

    @ManyToOne
    @JoinColumn(name = "rent_id")
    private Rent rent;

    @OneToMany(mappedBy = "invoice", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<InvoiceDetail> details = new ArrayList<>();

    public Invoice() {
    }

    public Invoice(int invoiceId, Date dueDate, Date issueDate, int status, double totalAmount, Rent rent) {
        this.invoiceId = invoiceId;
        this.dueDate = dueDate;
        this.issueDate = issueDate;
        this.status = status;
        this.totalAmount = totalAmount;
        this.rent = rent;
    }
    
    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Rent getRent() {
        return rent;
    }

    public void setRent(Rent rent) {
        this.rent = rent;
    }

    public List<InvoiceDetail> getDetails() {
        return details;
    }

    public void setDetails(List<InvoiceDetail> details) {
        this.details = details;
    }
}
