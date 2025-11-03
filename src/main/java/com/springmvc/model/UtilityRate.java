package com.springmvc.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "utility_rates")
public class UtilityRate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "rate_id")
    private int rateId;

    @Column(name = "rate_per_unit_water", nullable = false)
    private double ratePerUnitWater;

    @Column(name = "rate_per_unit_electric", nullable = false)
    private double ratePerUnitElectric;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "effective_date", nullable = false)
    private Date effectiveDate;

    @Column(name = "is_active", nullable = false)
    private boolean isActive;

    @Column(name = "notes")
    private String notes;

    // Constructors
    public UtilityRate() {
        this.isActive = true;
        this.effectiveDate = new Date();
    }

    public UtilityRate(double ratePerUnitWater, double ratePerUnitElectric) {
        this.ratePerUnitWater = ratePerUnitWater;
        this.ratePerUnitElectric = ratePerUnitElectric;
        this.isActive = true;
        this.effectiveDate = new Date();
    }

    // Getters and Setters
    public int getRateId() {
        return rateId;
    }

    public void setRateId(int rateId) {
        this.rateId = rateId;
    }

    public double getRatePerUnitWater() {
        return ratePerUnitWater;
    }

    public void setRatePerUnitWater(double ratePerUnitWater) {
        this.ratePerUnitWater = ratePerUnitWater;
    }

    public double getRatePerUnitElectric() {
        return ratePerUnitElectric;
    }

    public void setRatePerUnitElectric(double ratePerUnitElectric) {
        this.ratePerUnitElectric = ratePerUnitElectric;
    }

    public Date getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "UtilityRate{" +
                "rateId=" + rateId +
                ", ratePerUnitWater=" + ratePerUnitWater +
                ", ratePerUnitElectric=" + ratePerUnitElectric +
                ", effectiveDate=" + effectiveDate +
                ", isActive=" + isActive +
                ", notes='" + notes + '\'' +
                '}';
    }
}
