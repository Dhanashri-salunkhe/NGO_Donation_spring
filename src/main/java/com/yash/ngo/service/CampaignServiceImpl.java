package com.yash.ngo.service;

import com.yash.ngo.dao.CampaignDAO;
import com.yash.ngo.dao.ImageDAO;
import com.yash.ngo.domain.Campaign;
import com.yash.ngo.domain.Image;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Blob;
import java.util.Date;
import java.util.List;

@Service
public class CampaignServiceImpl implements CampaignService {

    @Autowired
    private CampaignDAO campaignDAO;

    @Autowired
    private ImageDAO imageDAO;

    @Override
    public void register(String title, String description, Double targetAmount, Date startDate, Date endDate, Blob image) {
        campaignDAO.save(title, description, targetAmount, startDate, endDate, image);
    }

    @Override
    public Integer saveImage(String name, String contentType, Blob data) {
        Image image = new Image();
        image.setName(name);
        image.setContentType(contentType);
        image.setData(data);
        return imageDAO.saveImage(image);
    }

    @Override
    public List<Campaign> getAllCampaigns() {
        List<Campaign> campaigns = campaignDAO.findAll();
        for (Campaign campaign : campaigns) {
            Double totalFundsRaised = campaignDAO.calculateTotalFundsRaised(campaign.getCampaignId());
            campaign.setFundRaised(totalFundsRaised);
        }
        return campaigns;
    }

    @Override
    public Campaign findById(Integer campaignId) {
        return campaignDAO.findById(campaignId);
    }

    @Override
    public List<Campaign> searchCampaigns(String keyword) {
        return campaignDAO.findByProperty("title", "%" + keyword + "%");
    }
}
