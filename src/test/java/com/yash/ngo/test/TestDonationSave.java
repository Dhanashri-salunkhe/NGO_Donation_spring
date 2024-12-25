package com.yash.ngo.test;

import com.yash.ngo.config.SpringRootConfig;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TestDonationSave {
    public static void main(String[] args) {
        // Load the Spring application context
        ApplicationContext ctx = new AnnotationConfigApplicationContext(SpringRootConfig.class);

        // Get the DataSource bean from the application context
        DataSource ds = ctx.getBean(DataSource.class);
        JdbcTemplate jt = new JdbcTemplate(ds);

        // Prepare the SQL insert statement for the donation table
        String sql = "INSERT INTO donation(`userId`, `donationAmount`, `donationDate`, `aadhaarNumber`, `panCardNumber`) VALUES(?, ?, ?, ?, ?)";

        // Set up the parameters for the insert
        Object[] param = new Object[]{
                5,
                6000,
                convertStringToDate("2024-11-22"),
                "123456789012",
                "ABCDE1234F"
        };


        jt.update(sql, param);
        System.out.println("Donation data saved");
    }

    // Helper method to convert String to Date
    private static Date convertStringToDate(String dateString) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return dateFormat.parse(dateString);
        } catch (ParseException e) {
            System.err.println("Invalid date format: " + e.getMessage());
            return null;
        }
    }
}