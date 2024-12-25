package com.yash.ngo.domain;

import java.math.BigDecimal;
import java.util.Date;

public class Donation {
    private Integer donationId;
    private Integer userId;
    private String name;
    private Double donationAmount;
    private Date donationDate;
    private String aadhaarNumber;
    private String panCardNumber;
    private Integer campaignId;
    private String title;
    private Integer status;

    public Integer getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(Integer campaignId) {
        this.campaignId = campaignId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
        return this.donationAmount;
    }

    public void setDonationAmount(double donationAmount) {
        this.donationAmount = donationAmount;
    }

    public Date getDonationDate() {
        return this.donationDate;
    }

    public void setDonationDate(Date donationDate) {
        this.donationDate = donationDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String toString() { return "Donation{" + "donationId=" + donationId + ", userId=" + userId + ", donationAmount=" + donationAmount + ", donationDate=" + donationDate + ", aadhaarNumber='" + aadhaarNumber + '\'' + ", panCardNumber='" + panCardNumber + '\'' + '}'; }


}
