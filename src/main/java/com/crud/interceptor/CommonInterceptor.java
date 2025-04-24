package com.crud.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.UUID;

@Slf4j
public class CommonInterceptor implements HandlerInterceptor {
    private static final String UUID_KEY = "uuid";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        String uuid = UUID.randomUUID().toString();
        String requestURI = request.getRequestURI();
        log.info("REQUEST UUID : {} , requestURI:{}", uuid, requestURI);
        request.setAttribute(UUID_KEY, uuid);
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        String uuid = (String)request.getAttribute(UUID_KEY);
        String requestURI = request.getRequestURI();
        log.info("RESPONSE UUID : {} , requestURI:{}", uuid, requestURI);
    }
}
