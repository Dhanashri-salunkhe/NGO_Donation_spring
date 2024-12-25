package com.yash.ngo.dao;

import com.yash.ngo.domain.Campaign;
import com.yash.ngo.rm.CampaignRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Blob;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CampaignDAOImpl extends BaseDAO implements CampaignDAO {

    @Override
    public void save(String title, String description, Double targetAmount, Date startDate, Date endDate, Blob image) {
        String sql = "INSERT INTO campaign(title, description, targetAmount, startDate, endDate, image) " +
                "VALUES(:title, :description, :targetAmount, :startDate, :endDate, :image)";

        Map<String, Object> m = new HashMap<>();
        m.put("title", title);
        m.put("description", description);
        m.put("targetAmount", targetAmount);
        m.put("startDate", startDate);
        m.put("endDate", endDate);
        m.put("image", image);

        KeyHolder kh = new GeneratedKeyHolder();
        SqlParameterSource ps = new MapSqlParameterSource(m);
        super.getNamedParameterJdbcTemplate().update(sql, ps, kh);
    }

    @Override
    public void update(Campaign campaign) {
        String sql = "UPDATE campaign " +
                "SET title=:title, description=:description, fundRaised=:fundRaised, " +
                "targetAmount=:targetAmount, startDate=:startDate, endDate=:endDate, image=:image " +
                "WHERE campaignId=:campaignId";

        Map<String, Object> m = new HashMap<>();
        m.put("title", campaign.getTitle());
        m.put("description", campaign.getDescription());
        m.put("fundRaised", campaign.getFundRaised());
        m.put("targetAmount", campaign.getTargetAmount());
        m.put("startDate", campaign.getStartDate());
        m.put("endDate", campaign.getEndDate());
        m.put("image", campaign.getImage());
        m.put("campaignId", campaign.getCampaignId());

        getNamedParameterJdbcTemplate().update(sql, m);
    }

    @Override
    public Campaign findById(Integer campaignId) {
        String sql = "SELECT c.campaignId, c.title, c.description, c.fundRaised, c.targetAmount, c.startDate, c.endDate, c.image " +
                "FROM campaign c  WHERE c.campaignId=?";
        return getJdbcTemplate().queryForObject(sql, new CampaignRowMapper(), campaignId);
    }

    @Override
    public List<Campaign> findAll() {
        String sql = "SELECT c.campaignId, c.title, c.description, c.fundRaised, c.targetAmount, c.startDate, c.endDate, c.image " +
                "FROM campaign c ";
        return getJdbcTemplate().query(sql, new CampaignRowMapper());
    }

    @Override
    public List<Campaign> findByProperty(String propName, Object propValue) {
        String sql = "SELECT c.campaignId, c.title, c.description, c.fundRaised, c.targetAmount, c.startDate, c.endDate, c.image " +
                "FROM campaign c  WHERE " + propName + " = ?";
        return getJdbcTemplate().query(sql, new CampaignRowMapper(), propValue);
    }

    @Override
    public Double calculateTotalFundsRaised(Integer campaignId) {
        String sql = "SELECT COALESCE(SUM(donationAmount), 0) FROM donation WHERE campaignId = ?";
        return getJdbcTemplate().queryForObject(sql, Double.class, campaignId);
    }


    @Override
    public void delete(Integer campaignId) {
        String sql = "DELETE FROM campaign WHERE campaignId = :campaignId";
        Map<String, Object> params = new HashMap<>();
        params.put("campaignId", campaignId);
        getNamedParameterJdbcTemplate().update(sql, params);
    }



}
