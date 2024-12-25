package com.yash.ngo.config;

import javax.servlet.ServletException; // Change here
import javax.servlet.ServletContext; // Change here
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class NgoDispatchServiceInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{SpringRootConfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{SpringWebConfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException { // Change here
        super.onStartup(servletContext);
    }
}