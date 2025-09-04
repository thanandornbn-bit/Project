package com.springmvc.model;

import javax.persistence.*;

@Entity
@Table(name = "invoice_type")
public class InvoiceType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int typeId;

    private String typeName; // ค่าไฟ, ค่าน้ำ, ค่าห้อง, ค่าเน็ต, ค่าปรับ

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

    public InvoiceType(int typeId, String typeName) {
        this.typeId = typeId;
        this.typeName = typeName;
    }

    public InvoiceType() {
        //TODO Auto-generated constructor stub
    }

    
}

