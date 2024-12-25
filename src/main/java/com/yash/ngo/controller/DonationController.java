package com.yash.ngo.controller;

import com.yash.ngo.command.DonationCommand;
import com.yash.ngo.domain.Campaign;
import com.yash.ngo.domain.Donation;
import com.yash.ngo.domain.User;
import com.yash.ngo.service.CampaignService;
import com.yash.ngo.service.DonationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Date;
import java.util.List;

@Controller
public class DonationController {

    @Autowired
    private DonationService donationService;

    @Autowired
    private CampaignService campaignService;

    @GetMapping("/donation_form")
    public String showDonationForm(
            @RequestParam(value = "campaignId", required = false) Integer campaignId,
            Model model,
            HttpSession session) {

        Integer userId = (Integer) session.getAttribute("userId");

        DonationCommand donationCommand = new DonationCommand();
        donationCommand.setDonationDate(new Date());

        if (userId != null) {
            donationCommand.setUserId(userId);
        }

        if (campaignId != null) {
            donationCommand.setCampaignId(campaignId);

            Campaign campaign = campaignService.findById(campaignId);
            model.addAttribute("selectedCampaign", campaign);
        }

        model.addAttribute("donationCommand", donationCommand);
        return "donation_form";
    }

    @GetMapping("/donationSuccess")
    public String showDonationSuccess() {
        return "donationSuccess"; // This will look for donationSuccess.jsp
    }

    @PostMapping("/donate")
    public String donate(
            @Valid @ModelAttribute("donationCommand") DonationCommand donationCommand,
            BindingResult result,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            redirectAttributes.addFlashAttribute("err", "Please log in to make a donation");
            return "redirect:/login";
        }

        if (donationCommand.getUserId() == null) {
            donationCommand.setUserId(userId);
        }

        if (result.hasErrors()) {
            result.getAllErrors().forEach(error -> System.out.println(error.getDefaultMessage()));
            return "donation_form";
        }

        try {
            Donation donation = new Donation();
            donation.setUserId(donationCommand.getUserId());
            donation.setDonationAmount(donationCommand.getDonationAmount());
            donation.setDonationDate(donationCommand.getDonationDate());
            donation.setAadhaarNumber(donationCommand.getAadhaarNumber());
            donation.setPanCardNumber(donationCommand.getPanCardNumber());
            donation.setCampaignId(donationCommand.getCampaignId());

            // Log donation details before saving
            System.out.println("Saving donation: " + donation);

            donationService.saveDonation(donation);

            // Store donation details in session for payment creation
            session.setAttribute("pendingDonation", donation);

            // Redirect to payment creation
            redirectAttributes.addAttribute("amount", donation.getDonationAmount());
            return "redirect:/create-order";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("err", "Error processing donation: " + e.getMessage());
            return "redirect:/donation_form";
        }
    }

    @GetMapping("/donate")
    public String completeDonation(HttpSession session, RedirectAttributes redirectAttributes) {
        Donation pendingDonation = (Donation) session.getAttribute("pendingDonation");

        if (pendingDonation == null) {
            redirectAttributes.addFlashAttribute("err", "No pending donation found");
            return "redirect:/index";
        }

        try {
            // Update donation status to COMPLETED using the constant
            pendingDonation.setStatus(DonationService.DONATION_STATUS_COMPLETED);
            donationService.updateDonation(pendingDonation);

            // Clear session attributes
            session.removeAttribute("pendingDonation");
            session.removeAttribute("amount");
            session.removeAttribute("orderId");

            redirectAttributes.addFlashAttribute("successMessage", "Donation successfully processed!");
            return "redirect:/donationSuccess";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("err", "Error completing donation");
            return "redirect:/index";
        }
    }

    @GetMapping("/donations")
    public String listDonations(Model model) {
        try {
            List<Donation> donations = donationService.findAll();
            model.addAttribute("donationList", donations);
            return "donations";
        } catch (Exception e) {
            model.addAttribute("error", "Error fetching donations: " + e.getMessage());
            return "donations";
        }
    }

    @GetMapping("/admin_dashboard")
    public String listDonationsForAdmin(Model model, @ModelAttribute("msg") String msg) {
        List<Donation> donationList = donationService.findAll();
        System.out.println("Donations retrieved: " + donationList.size());
        for (Donation donation : donationList) {
            System.out.println(donation);
        }
        model.addAttribute("donationList", donationList);
        model.addAttribute("msg", msg);
        return "dashboard_admin";
    }

    @GetMapping("/admin_dashboard/search")
    public String searchDonations(@RequestParam(value = "searchId", required = false) String searchId,
                                  @RequestParam(value = "searchName", required = false) String searchName,
                                  Model model) {
        List<Donation> donationList = donationService.search(searchId, searchName);
        model.addAttribute("donationList", donationList);
        return "dashboard_admin";
    }

    @GetMapping("/donation_history")
    public String showDonationHistory(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            redirectAttributes.addFlashAttribute("err", "Please log in to view donation history");
            return "redirect:/login";
        }

        try {
            List<Donation> donationHistory = donationService.getUserDonationHistory(userId);

            // Calculate total donation amount
            double totalDonationAmount = donationHistory.stream()
                    .mapToDouble(Donation::getDonationAmount)
                    .sum();

            model.addAttribute("donationHistory", donationHistory);
            model.addAttribute("totalDonationAmount", totalDonationAmount);

            return "donation_history";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("err", "Error retrieving donation history: " + e.getMessage());
            return "redirect:/index";
        }
    }

    @PostMapping("/process_donation")
    public String processDonation(@ModelAttribute Donation donation,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        try {
            // Set user ID from session
            Integer userId = (Integer) session.getAttribute("userId");
            donation.setUserId(userId);

            // Set donation date
            donation.setDonationDate(new Date());

            // Save donation (which will also update campaign funds)
            donationService.saveDonation(donation);

            redirectAttributes.addFlashAttribute("successMessage", "Donation successful!");
            return "redirect:/campaign_view/" + donation.getCampaignId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Donation failed: " + e.getMessage());
            return "redirect:/donation_form?campaignId=" + donation.getCampaignId();
        }
    }

    private void addUserInSession(User user, HttpSession session) {
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("role", user.getRole());
        session.setAttribute("currentUser", user);
    }
}


//    @PostMapping("/donate")
//    public String donate(
//            @Valid @ModelAttribute("donationCommand") DonationCommand donationCommand,
//            BindingResult result,
//            HttpSession session,
//            RedirectAttributes redirectAttributes) {
//
//        Integer userId = (Integer) session.getAttribute("userId");
//        if (userId == null) {
//            redirectAttributes.addFlashAttribute("err", "Please log in to make a donation");
//            return "redirect:/login";
//        }
//
//
//        if (donationCommand.getUserId() == null) {
//            donationCommand.setUserId(userId);
//        }
//
//
//        if (result.hasErrors()) {
//            result.getAllErrors().forEach(error ->
//                    System.out.println(error.getDefaultMessage()));
//            return "donation_form";
//        }
//
//        try {
//            Donation donation = new Donation();
//            donation.setUserId(donationCommand.getUserId());
//            donation.setDonationAmount(donationCommand.getDonationAmount());
//            donation.setDonationDate(donationCommand.getDonationDate());
//            donation.setAadhaarNumber(donationCommand.getAadhaarNumber());
//            donation.setPanCardNumber(donationCommand.getPanCardNumber());
//            donation.setCampaignId(donationCommand.getCampaignId());
//
//            donationService.saveDonation(donation);
//            donationService.updateFundRaised(donation.getCampaignId(), donation.getDonationAmount());
//
//            redirectAttributes.addFlashAttribute("successMessage", "Donation successfully recorded!");
//            return "redirect:/donationSuccess";
//
//
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            redirectAttributes.addFlashAttribute("err",
//                    "Error processing donation: " + e.getMessage());
//            return "redirect:/donation_form";
//        }
//    }

