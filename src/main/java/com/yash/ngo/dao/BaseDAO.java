package com.yash.ngo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

import javax.sql.DataSource;

abstract public class BaseDAO extends NamedParameterJdbcDaoSupport {
    @Autowired
    public void setDataSource2(DataSource dataSource) {
        super.setDataSource(dataSource);
    }
}
