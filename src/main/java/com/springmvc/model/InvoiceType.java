package com.springmvc.model;

import javax.persistence.*;

@Entity
@Table(name = "invoice_type")
public class InvoiceType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int billtypeID;

    @Column(nullable = false, length = 100)
    private String billname;

    @Column
    private Double defaultPrice;

    // Getters and Setters
    public int getBilltypeID() {
        return billtypeID;
    }

    public void setBilltypeID(int billtypeID) {
        this.billtypeID = billtypeID;
    }

    public String getBillname() {
        return billname;
    }

    public void setBillname(String billname) {
        this.billname = billname;
    }

    public Double getDefaultPrice() {
        return defaultPrice;
    }

    public void setDefaultPrice(Double defaultPrice) {
        this.defaultPrice = defaultPrice;
    }
}
