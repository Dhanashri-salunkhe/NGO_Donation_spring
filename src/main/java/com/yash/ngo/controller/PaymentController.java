package com.yash.ngo.controller;

import com.yash.ngo.command.DonationCommand;
import com.yash.ngo.domain.Donation;
import com.yash.ngo.domain.Receipt;
import com.yash.ngo.domain.User;
import com.yash.ngo.service.DonationService;
import com.yash.ngo.service.PaymentService;
import com.yash.ngo.domain.PdfGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.logging.Logger;

@Controller
public class PaymentController {

    private static final Logger logger = Logger.getLogger(PaymentController.class.getName());

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private DonationService donationService;

    private String razorpayKeyId = "rzp_test_BZSOgBnXQoiSLs";

    @GetMapping("/checkout")
    public String showCheckoutPage(Model model) {
        model.addAttribute("razorpayKeyId", razorpayKeyId);
        return "checkout";
    }

    @PostMapping("/create-order")
    public String createOrder(@ModelAttribute("command") DonationCommand cmd, Model model, HttpSession session) {
        logger.info("Inside createOrder method");

        Double amount = cmd.getDonationAmount();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            session.setAttribute("donationAmount", amount);
            return "redirect:login";
        }

        try {
            logger.info("amount: " + amount);
            session.setAttribute("amount", amount);
            String orderId = paymentService.createOrder(amount, "INR", "receipt_" + System.currentTimeMillis());

            // Store the pending donation in the session
            Donation pendingDonation = new Donation();
            pendingDonation.setUserId(userId);
            pendingDonation.setDonationAmount(amount);
            pendingDonation.setCampaignId(cmd.getCampaignId());
            pendingDonation.setAadhaarNumber(cmd.getAadhaarNumber());
            pendingDonation.setPanCardNumber(cmd.getPanCardNumber());
            session.setAttribute("pendingDonation", pendingDonation);

            model.addAttribute("orderId", orderId);
            model.addAttribute("amount", amount);
            model.addAttribute("razorpayKeyId", razorpayKeyId);
            model.addAttribute("currency", "INR");

            logger.info("Order created with ID: " + orderId);
            logger.info("Amount: " + amount);
            logger.info("Key ID: " + razorpayKeyId);

            return "payment";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error creating order: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/verify")
    public String verifyPayment(
            @RequestParam String razorpay_order_id,
            @RequestParam String razorpay_payment_id,
            @RequestParam String razorpay_signature,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        logger.info("Verifying payment...");
        logger.info("Order ID: " + razorpay_order_id);
        logger.info("Payment ID: " + razorpay_payment_id);

        boolean isValid = paymentService.verifySignature(
                razorpay_order_id,
                razorpay_payment_id,
                razorpay_signature
        );

        if (isValid) {
            try {
                // Retrieve pending donation from session
                Donation pendingDonation = (Donation) session.getAttribute("pendingDonation");
                if (pendingDonation == null) {
                    redirectAttributes.addFlashAttribute("err", "No pending donation found");
                    return "redirect:/donation_form";
                }

                // Fetch user details
                User user = (User) session.getAttribute("currentUser");

                // Save donation and update fund raised
                pendingDonation.setDonationDate(new Date());
                donationService.saveDonation(pendingDonation);
                donationService.updateFundRaised(pendingDonation.getCampaignId(), pendingDonation.getDonationAmount());

                // Store donationId in the session
                session.setAttribute("donationId", pendingDonation.getDonationId());

                // Generate payment receipt
                Receipt receipt = new Receipt();
                receipt.setReceiptId("RCP" + System.currentTimeMillis());
                receipt.setName(user.getName()); // Set user's name
                receipt.setAmount(pendingDonation.getDonationAmount());
                receipt.setDonationDate(pendingDonation.getDonationDate());

                receipt.setPaymentId(razorpay_payment_id);

                // Store receipt in session
                session.setAttribute("receipt", receipt);

                // Clear other session attributes
                session.removeAttribute("pendingDonation");
                session.removeAttribute("amount");
                session.removeAttribute("orderId");

                return "redirect:/donationSuccess";

            } catch (Exception e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("err", "Error completing donation: " + e.getMessage());
                return "redirect:/donation_form";
            }
        } else {
            redirectAttributes.addFlashAttribute("err", "Invalid payment signature");
            return "redirect:/donation_form";
        }
    }


    @GetMapping("/downloadReceipt")
    public void downloadReceipt(@RequestParam Integer donationId, HttpSession session, HttpServletResponse response) {
        try {
            Donation donation = donationService.findById(donationId);
            if (donation == null) {
                response.sendRedirect("/donationNotFound"); // Redirect or handle appropriately
                return;
            }

            User user = (User) session.getAttribute("currentUser");
            if (user != null) {
                // Generate payment receipt
                Receipt receipt = new Receipt();
                receipt.setReceiptId("RCP" + System.currentTimeMillis());
                receipt.setName(user.getName()); // Set user's name
                receipt.setAmount(donation.getDonationAmount());
                receipt.setDonationDate(donation.getDonationDate());

                // Use a method to generate a unique payment ID if it doesn't already exist
                receipt.setPaymentId(donationId.toString()); // Assuming you want to use donationId as paymentId

                // Generate PDF receipt
                byte[] pdfBytes = PdfGenerator.generateReceiptPdf(receipt);

                // Return PDF response
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=receipt.pdf");
                response.getOutputStream().write(pdfBytes);
                response.getOutputStream().flush();
                response.getOutputStream().close();
            } else {
                response.sendRedirect("/donationSuccess");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
