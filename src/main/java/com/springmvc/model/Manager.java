package com.springmvc.model;

import javax.persistence.*;

@Entity
@Table(name = "manager")
public class Manager {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "managerID", unique = true)
    private int managerID;

    @Column(name = "email", length = 255)
    private String email;

    @Column(name = "password", length = 255)
    private String password;

    @Column(name = "promptPayNumber", length = 20)
    private String promptPayNumber;

    @Column(name = "accountName", length = 255)
    private String accountName;

    public int getManagerID() {
        return managerID;
    }

    public void setManagerID(int managerID) {
        this.managerID = managerID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPromptPayNumber() {
        return promptPayNumber;
    }

    public void setPromptPayNumber(String promptPayNumber) {
        this.promptPayNumber = promptPayNumber;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    // Default constructor (required by JPA/Hibernate)
    public Manager() {
    }

    public Manager(int managerID, String email, String password, String promptPayNumber, String accountName) {
        this.managerID = managerID;
        this.email = email;
        this.password = password;
        this.promptPayNumber = promptPayNumber;
        this.accountName = accountName;
    }
}
