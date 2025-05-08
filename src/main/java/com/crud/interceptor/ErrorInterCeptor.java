package com.crud.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.HandlerInterceptor;


@Slf4j
@ComponentScan
public class ErrorInterCeptor implements HandlerInterceptor {
    private static final String UUID_KEY = "uuid";
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        String attribute = (String)request.getAttribute(UUID_KEY);
        log.info("EXCEPTION : {} , uuid:{}", ex.getMessage(), attribute);
    }
}
