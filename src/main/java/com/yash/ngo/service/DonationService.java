package com.yash.ngo.service;

import com.yash.ngo.command.DonationCommand;
import com.yash.ngo.domain.Donation;

import java.util.List;

public interface DonationService
{
    public static final Integer DONATION_STATUS_PENDING = 1;
    public static final Integer DONATION_STATUS_COMPLETED = 2;
    public static final Integer DONATION_STATUS_CANCELLED = 3;


    public void saveDonation(Donation donation);

    public Donation findById(Integer donationId);

    public List<Donation> findAll();

    public List<Donation> findByProperty(String propName, Object propValue);

    public void updateDonation(Donation donation);

    public void deleteDonation(Integer donationId);

    List<Donation> search(String searchId, String searchName);

    public List<Donation> getUserDonationHistory(Integer userId);

    public void updateFundRaised(Integer campaignId, Double amount);




}