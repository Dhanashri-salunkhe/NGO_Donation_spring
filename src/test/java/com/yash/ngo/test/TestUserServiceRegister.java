package com.yash.ngo.test;

import com.yash.ngo.config.SpringRootConfig;
import com.yash.ngo.dao.UserDAO;
import com.yash.ngo.domain.User;
import com.yash.ngo.service.UserService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class TestUserServiceRegister {
    public static void main(String[] args){
        ApplicationContext ctx=new AnnotationConfigApplicationContext(SpringRootConfig.class);
        UserService userService=ctx.getBean(UserService.class);
        User u=new User();
        u.setName("xyz");
        u.setPhone("12345904");
        u.setEmail("abc@email.com");
        u.setAddress("Pune");
        u.setLoginName("abcd");
        u.setPassword("123");
        u.setRole(UserService.ROLE_ADMIN);
        u.setLoginStatus(UserService.LOGIN_STATUS_ACTIVE);
        userService.register(u);
        System.out.println("registered successfully");
    }
}

