package com.yash.ngo.dao;

import com.yash.ngo.domain.Campaign;
import com.yash.ngo.domain.Donation;
import com.yash.ngo.domain.User;

import java.util.List;

public interface DonationDAO {
    public void save(Donation d);
    public void update(Donation d);
    public void delete(Donation d);
    public void delete(Integer donationId);
    public Donation findById(Integer donationId);
    public List<Donation> findAll();
    public List<Donation> findByProperty(String propName, Object propValue);
    public List<Donation> search(String searchId, String searchName);
    List<Donation> findDonationHistoryByUserId(Integer userId);
    public void update(Campaign campaign);


}
