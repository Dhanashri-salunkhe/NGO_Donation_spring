package com.yash.ngo.test;

import com.yash.ngo.config.SpringRootConfig;
import com.yash.ngo.dao.UserDAO;
import com.yash.ngo.domain.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class TestUserDAOSave {
    public static void main(String[] args){
        ApplicationContext ctx=new AnnotationConfigApplicationContext(SpringRootConfig.class);
        UserDAO userDAO=ctx.getBean(UserDAO.class);
        User u=new User();
        u.setName("abc");
        u.setPhone("12345904");
        u.setEmail("abc@email.com");
        u.setAddress("Pune");
        u.setLoginName("abc");
        u.setPassword("dhanashri@123");
        u.setRole(1);
        u.setLoginStatus(1);
        userDAO.save(u);
        System.out.println("data saved");
    }
}

