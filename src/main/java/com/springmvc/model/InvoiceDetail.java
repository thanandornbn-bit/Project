package com.springmvc.model;

import java.math.BigDecimal;

import javax.persistence.*;

@Entity
@Table(name = "invoice_detail")
public class InvoiceDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int detailId;

    private BigDecimal amount;   // จำนวนเงินรวม
    private BigDecimal price;    // ราคาต่อหน่วย (ถ้ามี)
    private int quantity;        // หน่วย (ถ้ามี)

    @ManyToOne
    @JoinColumn(name = "invoice_id")
    private Invoice invoice;

    @ManyToOne
    @JoinColumn(name = "type_id")
    private InvoiceType type;

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
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

    public InvoiceDetail(int detailId, BigDecimal amount, BigDecimal price, int quantity, Invoice invoice,
            InvoiceType type) {
        this.detailId = detailId;
        this.amount = amount;
        this.price = price;
        this.quantity = quantity;
        this.invoice = invoice;
        this.type = type;
    }

    public InvoiceDetail() {
        //TODO Auto-generated constructor stub
    }

    
}



