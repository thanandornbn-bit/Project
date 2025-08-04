package com.springmvc.model;

import javax.persistence.*;

@Entity
@Table(name = "invoice_detail")
public class InvoiceDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int invoDetailID;

    @Column(nullable = false)
    private double amount;

    @Column(length = 100)
    private String unit;

    @ManyToOne
    @JoinColumn(name = "invoice_id", nullable = false)
    private Invoice invoice;

    @ManyToOne
    @JoinColumn(name = "invoice_type_id", nullable = false)
    private InvoiceType invoiceType;

    // Getters and Setters
    public int getInvoDetailID() {
        return invoDetailID;
    }

    public void setInvoDetailID(int invoDetailID) {
        this.invoDetailID = invoDetailID;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public InvoiceType getInvoiceType() {
        return invoiceType;
    }

    public void setInvoiceType(InvoiceType invoiceType) {
        this.invoiceType = invoiceType;
    }
}
