package com.yash.ngo.test;

import com.yash.ngo.config.SpringRootConfig;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

public class TestDataSource {
    public static void main(String[] args) {
        ApplicationContext ctx = new AnnotationConfigApplicationContext(SpringRootConfig.class);

        DataSource ds = ctx.getBean(DataSource.class);
        JdbcTemplate jt = new JdbcTemplate(ds);

        String sql = "INSERT INTO user(`name`, `phone`, `email`, `address`, `loginName`, `password`) VALUES(?, ?, ?, ?, ?, ?)";
        Object[] param = new Object[]{"Salunkhe", "7499073841", "dhanshri@email.com", "chalisgaon", "salunkhe", "d123"};
        jt.update(sql,param);
        System.out.println("sql executed");
    }
}
