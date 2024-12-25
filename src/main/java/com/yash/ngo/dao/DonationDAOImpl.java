package com.yash.ngo.dao;

import com.yash.ngo.domain.Campaign;
import com.yash.ngo.domain.Donation;
import com.yash.ngo.rm.DonationRowMapper;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class DonationDAOImpl extends BaseDAO implements DonationDAO {

    @Override
    public void save(Donation d) {
        String sql = "INSERT INTO donation(userId, donationAmount, donationDate, aadhaarNumber, panCardNumber, campaignId) "
                + "VALUES(:userId, :donationAmount, :donationDate, :aadhaarNumber, :panCardNumber, :campaignId)";

        Map<String, Object> m = new HashMap<>();
        m.put("userId", d.getUserId());
        m.put("donationAmount", d.getDonationAmount());
        m.put("donationDate", d.getDonationDate());
        m.put("aadhaarNumber", d.getAadhaarNumber());
        m.put("panCardNumber", d.getPanCardNumber());
        m.put("campaignId", d.getCampaignId());

        KeyHolder kh = new GeneratedKeyHolder();
        SqlParameterSource ps = new MapSqlParameterSource(m);

        System.out.println("Executing SQL: " + sql + " with parameters: " + m);

        super.getNamedParameterJdbcTemplate().update(sql, ps, kh);
        Integer donationId = kh.getKey().intValue();
        d.setDonationId(donationId);
    }

    @Override
    public void update(Donation d) {
        String sql = "UPDATE donation "
                + "SET userId=:userId, "
                + "donationAmount=:donationAmount, "
                + "donationDate=:donationDate, "
                + "aadhaarNumber=:aadhaarNumber, "
                + "panCardNumber=:panCardNumber, "
                + "campaignId=:campaignId "  // Add this line
                + "WHERE donationId=:donationId";

        Map<String, Object> m = new HashMap<>();
        m.put("userId", d.getUserId());
        m.put("donationAmount", d.getDonationAmount());
        m.put("donationDate", d.getDonationDate());
        m.put("aadhaarNumber", d.getAadhaarNumber());
        m.put("panCardNumber", d.getPanCardNumber());
        m.put("campaignId", d.getCampaignId());  // Add this line
        m.put("donationId", d.getDonationId());

        getNamedParameterJdbcTemplate().update(sql, m);
    }

    @Override
    public void delete(Donation d) {
        this.delete(d.getDonationId());
    }

    @Override
    public void delete(Integer donationId) {
        String sql = "DELETE FROM donation WHERE donationId=?";
        getJdbcTemplate().update(sql, donationId);
    }

    @Override
    public Donation findById(Integer donationId) {
        String sql = "SELECT d.donationId, d.userId, u.name, d.donationAmount, d.donationDate, " +
                "d.aadhaarNumber, d.panCardNumber, c.title " +
                "FROM donation d " +
                "JOIN user u ON d.userId = u.userId " +
                "LEFT JOIN campaign c ON d.campaignId = c.campaignId " +
                "WHERE d.donationId=?";
        try {
            return getJdbcTemplate().queryForObject(sql, new DonationRowMapper(), donationId);
        } catch (EmptyResultDataAccessException e) {
            System.out.println("No donation found with ID: " + donationId);
            return null;
        }
    }



    @Override
    public List<Donation> findAll() {
        String sql = "SELECT d.donationId, d.userId, u.name, d.donationAmount, d.donationDate, " +
                "d.aadhaarNumber, d.panCardNumber, c.title " +
                "FROM donation d " +
                "JOIN user u ON d.userId = u.userId " +
                "LEFT JOIN campaign c ON d.campaignId = c.campaignId";
        List<Donation> donations = getJdbcTemplate().query(sql, new DonationRowMapper());
        System.out.println("Donations retrieved in DAO: " + donations.size());
        return donations;
    }

    @Override
    public List<Donation> findByProperty(String propName, Object propValue) {
        String sql = "SELECT d.donationId, d.userId, u.name, d.donationAmount, d.donationDate, " +
                "d.aadhaarNumber, d.panCardNumber, c.title " +
                "FROM donation d " +
                "JOIN user u ON d.userId = u.userId " +
                "LEFT JOIN campaign c ON d.campaignId = c.campaignId " +
                "WHERE " + propName + " = ?";
        return getJdbcTemplate().query(sql, new DonationRowMapper(), propValue);
    }

    @Override
    public List<Donation> search(String searchId, String searchName) {
        String sql = "SELECT d.donationId, d.userId, u.name, d.donationAmount, d.donationDate, " +
                "d.aadhaarNumber, d.panCardNumber, c.title " +
                "FROM donation d " +
                "JOIN user u ON d.userId = u.userId " +
                "LEFT JOIN campaign c ON d.campaignId = c.campaignId " +
                "WHERE 1=1";
        Map<String, Object> params = new HashMap<>();
        if (searchId != null && !searchId.isEmpty()) {
            sql += " AND d.donationId = :donationId";
            params.put("donationId", searchId);
        }
        if (searchName != null && !searchName.isEmpty()) {
            sql += " AND u.name LIKE :name";
            params.put("name", "%" + searchName + "%");
        }
        return getNamedParameterJdbcTemplate().query(sql, params, new DonationRowMapper());
    }

    @Override
    public List<Donation> findDonationHistoryByUserId(Integer userId) {
        String sql = "SELECT d.donationId, d.userId, u.name, d.donationAmount, d.donationDate, " +
                "d.aadhaarNumber, d.panCardNumber, c.campaignId, c.title " +
                "FROM donation d " +
                "JOIN user u ON d.userId = u.userId " +
                "LEFT JOIN campaign c ON d.campaignId = c.campaignId " +
                "WHERE d.userId = ? " +
                "ORDER BY d.donationDate DESC";

        return getJdbcTemplate().query(sql, new DonationRowMapper(), userId);
    }

    @Override public void update(Campaign campaign) { String sql = "UPDATE campaign SET fundRaised = :fundRaised WHERE campaignId = :campaignId"; Map<String, Object> params = new HashMap<>(); params.put("fundRaised", campaign.getFundRaised()); params.put("campaignId", campaign.getCampaignId()); getNamedParameterJdbcTemplate().update(sql, params); }


}
