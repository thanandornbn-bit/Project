package com.springmvc.model;

import javax.persistence.*;

@Entity
@Table(name = "invoice_type")
public class InvoiceType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "typeId", unique = true)
    private int typeId;

    @Column(name = "typeName", length = 255)
    private String typeName;

    // Default constructor
    public InvoiceType() {
    }

    public InvoiceType(int typeId, String typeName) {
        this.typeId = typeId;
        this.typeName = typeName;
    }

    // Getter & Setter
    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}
