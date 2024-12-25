//package com.yash.ngo.test;
//
//import com.yash.ngo.config.SpringRootConfig;
//import com.yash.ngo.service.CampaignService;
//import org.springframework.context.ApplicationContext;
//import org.springframework.context.annotation.AnnotationConfigApplicationContext;
//
//import java.util.Date;
//
//public class CampaignServiceRegister {
//    public static void main(String[] args) {
//        ApplicationContext ctx = new AnnotationConfigApplicationContext(SpringRootConfig.class);
//        CampaignService campaignService = ctx.getBean(CampaignService.class);
//
//        // Define campaign details
//        String title = "New Campaign";
//        String description = "This is a test campaign 2";
//        Double targetAmount = 10000.00;
//        Date startDate = new Date(); // Current date
//        Date endDate = new Date(System.currentTimeMillis() + 7L * 24 * 60 * 60 * 1000); // 7 days from now
//
//        // Register the campaign
//        campaignService.register(title, description, targetAmount, startDate, endDate);
//        System.out.println("Campaign registered successfully");
//    }
//}
