package com.yash.ngo.service;

import com.yash.ngo.dao.CampaignDAO;
import com.yash.ngo.dao.DonationDAO;
import com.yash.ngo.domain.Campaign;
import com.yash.ngo.domain.Donation;
import com.yash.ngo.service.DonationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DonationServiceImpl implements DonationService {

    @Autowired
    private final DonationDAO donationDAO;
    @Autowired
    private CampaignDAO campaignDAO;

    @Autowired
    public DonationServiceImpl(DonationDAO donationDAO) {
        this.donationDAO = donationDAO;
    }

    @Override
    @Transactional
    public void saveDonation(Donation donation) {
        donationDAO.save(donation);

    }

    @Override
    public Donation findById(Integer donationId) {
        return donationDAO.findById(donationId);
    }

    @Override
    public List<Donation> findAll() {
        List<Donation> donations = donationDAO.findAll();
        System.out.println("Donations in service: " + donations.size());
        return donations;
    }

    @Override
    public List<Donation> findByProperty(String propName, Object propValue) {
        return donationDAO.findByProperty(propName, propValue);
    }

    @Override
    public void updateDonation(Donation donation) {
        donationDAO.update(donation);
    }

    @Override
    public void deleteDonation(Integer donationId) {
        donationDAO.delete(donationId);
    }

    @Override public List<Donation> search(String searchId, String searchName) {
        return donationDAO.search(searchId, searchName);
    }
    @Override
    public List<Donation> getUserDonationHistory(Integer userId) {
        return donationDAO.findDonationHistoryByUserId(userId);
    }

    public void updateFundRaised(Integer campaignId, Double amount)
    {
        Campaign campaign = campaignDAO.findById(campaignId);
        if (campaign != null)
        {
            Double currentFund = campaign.getFundRaised();
            campaign.setFundRaised(currentFund + amount);
            campaignDAO.update(campaign);
        }
    }


}
