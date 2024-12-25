package com.yash.ngo.domain;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Date;

public class Campaign {
    private Integer campaignId;
    private String title;
    private String description;
    private Double fundRaised = 0.0;
    private Double targetAmount;
    private Date startDate;
    private Date endDate;
    private Integer imageId;
    private Blob image;
    private String imageBase64;

    public Campaign() {}

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getFundRaised() {
        return fundRaised;
    }

    public void setFundRaised(Double fundRaised) {
        this.fundRaised = fundRaised;
    }

    public Double getTargetAmount() {
        return targetAmount;
    }

    public void setTargetAmount(Double targetAmount) {
        this.targetAmount = targetAmount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getImageId() {
        return imageId;
    }

    public void setImageId(Integer imageId) {
        this.imageId = imageId;
    }

    public Blob getImage() {
        return image;
    }

    public void setImage(Blob image) {
        this.image = image;
    }

    public String getImageBase64() { if (this.image != null) { try { return Base64.getEncoder().encodeToString(this.image.getBytes(1, (int) this.image.length())); } catch (
            SQLException e) { e.printStackTrace(); } } return null; }

    public void setImageBase64(String imageBase64) { this.imageBase64 = imageBase64; }
}
