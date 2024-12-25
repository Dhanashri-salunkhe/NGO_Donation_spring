package com.yash.ngo.test;

import com.yash.ngo.config.SpringRootConfig;
import com.yash.ngo.dao.CampaignDAO;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class TestCampaignDAODelete {
    public static void main(String[] args){
        ApplicationContext ctx = new AnnotationConfigApplicationContext(SpringRootConfig.class);
        CampaignDAO campaignDAO = ctx.getBean(CampaignDAO.class);

        Integer campaignId = 3;
        campaignDAO.delete(campaignId);

        System.out.println("Campaign deleted with ID: " + campaignId);
    }
}
