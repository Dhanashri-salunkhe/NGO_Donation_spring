package com.yash.ngo.controller;

import com.yash.ngo.command.CampaignCommand;
import com.yash.ngo.domain.Campaign;
import com.yash.ngo.service.CampaignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@Controller
public class CampaignController {

    @Autowired
    private CampaignService campaignService;

    @GetMapping("/campaign")
    public String showCampaigns(Model model) {
        List<Campaign> campaigns = campaignService.getAllCampaigns();
        for (Campaign campaign : campaigns) {
            if (campaign.getImage() != null) {
                campaign.setImageBase64(campaign.getImageBase64());
            }
        }
        model.addAttribute("campaigns", campaigns);
        return "campaign";
    }


    @GetMapping("/support_campaign")
    public String supportCampaign(
            @RequestParam(value = "campaignId", required = true) Integer campaignId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            session.setAttribute("redirectUrl", "/donation_form?campaignId=" + campaignId);
            redirectAttributes.addFlashAttribute("message", "Please log in to support the campaign.");
            return "redirect:/login";
        }

        return "redirect:/donation_form?campaignId=" + campaignId;
    }

    @RequestMapping("/Campaign_Details")
    public String campaignDetails(Model model) {
        try {
            List<Campaign> campaignList = campaignService.getAllCampaigns();
            if (campaignList == null || campaignList.isEmpty()) {
                model.addAttribute("error", "No campaigns found in the database");
            }

            Date currentDate = new Date();
            int totalCampaigns = campaignList.size();
            double totalRaised = campaignList.stream().mapToDouble(Campaign::getFundRaised).sum();
            int activeCampaigns = (int) campaignList.stream().filter(c -> c.getEndDate().after(currentDate)).count();
            long successfulCampaigns = campaignList.stream().filter(c -> c.getFundRaised() >= c.getTargetAmount()).count();
            double successRate = totalCampaigns > 0 ? (successfulCampaigns * 100.0) / totalCampaigns : 0;

            model.addAttribute("campaignList", campaignList);
            model.addAttribute("totalCampaigns", totalCampaigns);
            model.addAttribute("activeCampaigns", activeCampaigns);
            model.addAttribute("totalRaised", totalRaised);
            model.addAttribute("successRate", Math.round(successRate));
            model.addAttribute("campaignCommand", new CampaignCommand());
            return "Campaign_Details";
        } catch (Exception e) {
            model.addAttribute("error", "Error fetching campaign details: " + e.getMessage());
            return "Campaign_Details";
        }
    }

    @GetMapping("/admin_dashboard/search_campaigns")
    public String searchCampaigns(@RequestParam("keyword") String keyword, Model model) {
        List<Campaign> searchResults = campaignService.searchCampaigns(keyword);
        model.addAttribute("campaigns", searchResults);
        return "Campaign_Details";
    }

    @GetMapping("/campaign_view/{campaignId}")
    public String showCampaignDetails(@PathVariable Integer campaignId, Model model) {
        Campaign campaign = campaignService.findById(campaignId);
        if (campaign != null) {
            System.out.println("Funds Raised: " + campaign.getFundRaised());
            model.addAttribute("campaign", campaign);
            return "campaign_view";
        } else {
            model.addAttribute("message", "Campaign not found");
            return "error";
        }
    }

    @PostMapping(value = "/add")
    public String addCampaign(
            @ModelAttribute("campaignCommand") CampaignCommand campaignCommand,
            RedirectAttributes redirectAttributes) {

        try {
            if (campaignCommand.getTitle() == null || campaignCommand.getTitle().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Title is required");
                return "redirect:/Campaign_Details";
            }

            if (campaignCommand.getEndDate().before(campaignCommand.getStartDate())) {
                redirectAttributes.addFlashAttribute("errorMessage", "End date must be after start date");
                return "redirect:/Campaign_Details";
            }

            campaignCommand.setFundRaised(0.0);

            MultipartFile file = campaignCommand.getImage();
            Blob imageBlob = null;
            if (file != null && !file.isEmpty()) {
                try {
                    imageBlob = new javax.sql.rowset.serial.SerialBlob(file.getBytes());
                    String imageName = file.getOriginalFilename();
                    String contentType = file.getContentType();
                    campaignService.saveImage(imageName, contentType, imageBlob);
                } catch (SQLException e) {
                    e.printStackTrace();
                    redirectAttributes.addFlashAttribute("errorMessage", "Error processing image: " + e.getMessage());
                    return "redirect:/Campaign_Details";
                }
            }

            campaignService.register(
                    campaignCommand.getTitle(),
                    campaignCommand.getDescription(),
                    campaignCommand.getTargetAmount(),
                    campaignCommand.getStartDate(),
                    campaignCommand.getEndDate(),
                    imageBlob // Pass the image Blob
            );

            redirectAttributes.addFlashAttribute("successMessage", "Campaign added successfully");
            return "redirect:/Campaign_Details";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error adding campaign: " + e.getMessage());
            return "redirect:/Campaign_Details";
        }
    }

//    @RequestMapping("/campaign_view/campaign")
//    public String campaign1() {
//        return "campaign";
//
//    }


}
