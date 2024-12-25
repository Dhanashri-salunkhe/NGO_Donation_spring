package com.yash.ngo.service;

import com.yash.ngo.exception.UserBlockedException;
import com.yash.ngo.dao.BaseDAO;
import com.yash.ngo.dao.UserDAO;
import com.yash.ngo.domain.User;
import com.yash.ngo.rm.UserRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl extends BaseDAO implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Override
    public void register(User u) {
        userDAO.save(u);
    }

    @Override
    public User login(String loginName, String password) throws UserBlockedException {
        String sql = "select userId, name, phone, email, address, role, loginStatus, loginName" +
                " from user where loginName=:ln and password=:pw";

        Map m = new HashMap();
        m.put("ln", loginName);
        m.put("pw", password);

        try {
            User u = getNamedParameterJdbcTemplate().queryForObject(sql, m, new UserRowMapper());
            if(u.getLoginStatus().equals(UserService.LOGIN_STATUS_BLOCKED)) {
                throw new UserBlockedException("Your accunt is blocked. Please contact to admin");
            }
            else {
                return u;
            }
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }

    }

    @Override public List<User> getUserList() { return userDAO.findAll(); }

    @Override public void changeLoginStatus(Integer userId, Integer loginStatus) { String sql = "UPDATE user SET loginStatus=:loginStatus WHERE userId=:userId"; Map<String, Object> m = new HashMap<>(); m.put("loginStatus", loginStatus); m.put("userId", userId); getNamedParameterJdbcTemplate().update(sql, m); }

}