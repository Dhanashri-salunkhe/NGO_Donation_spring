package com.yash.ngo.rm;

import com.yash.ngo.domain.Image;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ImageRowMapper implements RowMapper<Image> {

    @Override
    public Image mapRow(ResultSet rs, int rowNum) throws SQLException {
        Image image = new Image();
        image.setImageId(rs.getInt("imageId"));
        image.setName(rs.getString("name"));
        image.setContentType(rs.getString("contentType"));
        image.setData(rs.getBlob("data"));
        return image;
    }
}
