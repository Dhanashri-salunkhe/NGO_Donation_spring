package com.yash.ngo.command;

import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

public class DonationCommand {
    private Integer donationId;
    private Integer userId;
    private String name;
    private Integer campaignId;
    private Double donationAmount;
    private String aadhaarNumber;
    private String panCardNumber;

    public Integer getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(Integer campaignId) {
        this.campaignId = campaignId;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date donationDate;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }



    public DonationCommand() {
        this.donationDate = new Date();
    }

    public Integer getDonationId() {
        return donationId;
    }

    public void setDonationId(Integer donationId) {
        this.donationId = donationId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Double getDonationAmount() {
        return donationAmount;
    }

    public void setDonationAmount(Double donationAmount) {
        this.donationAmount = donationAmount;
    }

    public Date getDonationDate() {
        return donationDate;
    }

    public void setDonationDate(Date donationDate) {
        this.donationDate = donationDate;
    }

    public String getAadhaarNumber() {
        return aadhaarNumber;
    }

    public void setAadhaarNumber(String aadhaarNumber) {
        this.aadhaarNumber = aadhaarNumber;
    }

    public String getPanCardNumber() {
        return panCardNumber;
    }

    public void setPanCardNumber(String panCardNumber) {
        this.panCardNumber = panCardNumber;
    }

    @Override
    public String toString() {
        return "DonationCommand{" +
                "donationId=" + donationId +
                ", userId=" + userId +
                ", donationAmount=" + donationAmount +
                ", donationDate=" + donationDate +
                ", aadhaarNumber='" + aadhaarNumber + '\'' +
                ", panCardNumber='" + panCardNumber + '\'' +
                '}';
    }
}
