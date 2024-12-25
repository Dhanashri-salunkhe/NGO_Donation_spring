package com.yash.ngo.service;

import com.yash.ngo.domain.Campaign;

import java.sql.Blob;
import java.util.Date;
import java.util.List;

public interface CampaignService {
    void register(String title, String description, Double targetAmount, Date startDate, Date endDate, Blob image);
    Integer saveImage(String name, String contentType, Blob data);
    List<Campaign> getAllCampaigns();
    Campaign findById(Integer campaignId);
    List<Campaign> searchCampaigns(String keyword);
}
