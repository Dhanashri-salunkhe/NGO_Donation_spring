package com.yash.ngo.command;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class CampaignCommand {
    private Integer campaignId;
    private String title;
    private String description;
    private Double fundRaised = 0.0;
    private Double targetAmount;
    private Date startDate;
    private Date endDate;
    private MultipartFile image; // Add this field

    public CampaignCommand() {
    }

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

    public MultipartFile getImage() {
        return image;
    }

    public void setImage(MultipartFile image) {
        this.image = image;
    }
}
