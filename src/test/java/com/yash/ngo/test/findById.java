package com.yash.ngo.test;

import com.yash.ngo.config.SpringRootConfig;
import com.yash.ngo.dao.CampaignDAO;
import com.yash.ngo.domain.Campaign;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class findById {
    public static void main(String[] args){
        ApplicationContext ctx = new AnnotationConfigApplicationContext(SpringRootConfig.class);
        CampaignDAO campaignDAO = ctx.getBean(CampaignDAO.class);

        int campaignId = 1;
        Campaign campaign = campaignDAO.findById(campaignId);
        System.out.println("ID: " + campaign.getCampaignId());
        System.out.println("Title: " + campaign.getTitle());
        System.out.println("Description: " + campaign.getDescription());
        System.out.println("Target Amount: " + campaign.getTargetAmount());
        System.out.println("Start Date: " + campaign.getStartDate());
        System.out.println("End Date: " + campaign.getEndDate());
        System.out.println("Campaign data retrieved successfully");
    }
}
