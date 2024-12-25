package com.yash.ngo.rm;

import com.yash.ngo.domain.Campaign;
import org.springframework.jdbc.core.RowMapper;

import javax.sql.rowset.serial.SerialBlob;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CampaignRowMapper implements RowMapper<Campaign> {
    @Override
    public Campaign mapRow(ResultSet rs, int rowNum) throws SQLException {
        Campaign campaign = new Campaign();
        campaign.setCampaignId(rs.getInt("campaignId"));
        campaign.setTitle(rs.getString("title"));
        campaign.setDescription(rs.getString("description"));
        campaign.setFundRaised(rs.getDouble("fundRaised"));
        campaign.setTargetAmount(rs.getDouble("targetAmount"));
        campaign.setStartDate(rs.getDate("startDate"));
        campaign.setEndDate(rs.getDate("endDate"));

        // Map the image Blob
        Blob imageBlob = rs.getBlob("image");
        campaign.setImage(imageBlob);

        return campaign;
    }
}
