package com.yash.ngo.dao;

import com.yash.ngo.dao.ImageDAO;
import com.yash.ngo.domain.Image;
import com.yash.ngo.rm.ImageRowMapper;
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
public class ImageDAOImpl extends BaseDAO implements ImageDAO {

    @Override
    public Integer saveImage(Image image) {
        String sql = "INSERT INTO image(name, contentType, data) "
                + "VALUES(:name, :contentType, :data)";

        Map<String, Object> m = new HashMap<>();
        m.put("name", image.getName());
        m.put("contentType", image.getContentType());
        m.put("data", image.getData());

        KeyHolder kh = new GeneratedKeyHolder();
        SqlParameterSource ps = new MapSqlParameterSource(m);

        System.out.println("Executing SQL: " + sql + " with parameters: " + m);

        super.getNamedParameterJdbcTemplate().update(sql, ps, kh);
        Integer imageId = kh.getKey().intValue();
        image.setImageId(imageId);
        return imageId;
    }

    @Override
    public Image findById(Integer imageId) {
        String sql = "SELECT imageId, name, contentType, data FROM image WHERE imageId=?";
        try {
            return getJdbcTemplate().queryForObject(sql, new ImageRowMapper(), imageId);
        } catch (EmptyResultDataAccessException e) {
            System.out.println("No image found with ID: " + imageId);
            return null;
        }
    }

    @Override
    public void deleteImage(Integer imageId) {
        String sql = "DELETE FROM image WHERE imageId=?";
        getJdbcTemplate().update(sql, imageId);
    }
}
