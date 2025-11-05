package com.springmvc.model;

import javax.persistence.*;

@Entity
@Table(name = "invoice_detail")
public class InvoiceDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private int id;

    @Column(name = "amount", precision = 19, scale = 2)
    private double amount;

    @Column(name = "price", precision = 19, scale = 2)
    private double price;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "remark", columnDefinition = "TEXT")
    private String remark;

    @ManyToOne
    @JoinColumn(name = "invoice_id")
    private Invoice invoice;

    @ManyToOne
    @JoinColumn(name = "type_id")
    private InvoiceType type;

    public InvoiceDetail() {
    }

    public InvoiceDetail(int id, double amount, double price, int quantity, Invoice invoice, InvoiceType type) {
        this.id = id;
        this.amount = amount;
        this.price = price;
        this.quantity = quantity;
        this.invoice = invoice;
        this.type = type;
        this.remark = null;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public InvoiceType getType() {
        return type;
    }

    public void setType(InvoiceType type) {
        this.type = type;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
