//package com.yash.ngo.test;
//
//import com.yash.ngo.config.SpringRootConfig;
//import com.yash.ngo.dao.CampaignDAO;
//import com.yash.ngo.domain.Campaign;
//import org.springframework.context.ApplicationContext;
//import org.springframework.context.annotation.AnnotationConfigApplicationContext;
//import java.util.Date;
//
//public class TestCampaignDAOSave {
//    public static void main(String[] args){
//        ApplicationContext ctx = new AnnotationConfigApplicationContext(SpringRootConfig.class);
//        CampaignDAO campaignDAO = ctx.getBean(CampaignDAO.class);
//
//        Campaign c = new Campaign();
//        c.setTitle("New Campaign");
//        c.setDescription("This is a test campaign");
//        c.setTargetAmount(10000.00);
//        c.setStartDate(new Date());
//
//        c.setEndDate(new Date(System.currentTimeMillis() + 7L * 24 * 60 * 60 * 1000));
//
//        campaignDAO.save(c.getTitle(), c.getDescription(), c.getTargetAmount(), c.getStartDate(), c.getEndDate());
//        System.out.println("Campaign data saved successfully");
//    }
//}