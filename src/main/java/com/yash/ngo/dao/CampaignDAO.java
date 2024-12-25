package com.yash.ngo.dao;

import com.yash.ngo.domain.Campaign;

import java.sql.Blob;
import java.util.Date;
import java.util.List;

public interface CampaignDAO {
    void save(String title, String description, Double targetAmount, Date startDate, Date endDate, Blob image);
    void update(Campaign campaign);
    Campaign findById(Integer campaignId);
    List<Campaign> findAll();
    List<Campaign> findByProperty(String propName, Object propValue);
    public Double calculateTotalFundsRaised(Integer campaignId);

    public void delete(Integer campaignId);


}
