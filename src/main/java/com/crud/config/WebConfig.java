package com.crud.config;

import com.crud.interceptor.CommonInterceptor;
import com.crud.interceptor.ErrorInterCeptor;
import com.crud.interceptor.LoginInterCeptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new CommonInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("*.ico");
        registry.addInterceptor(new ErrorInterCeptor())
                .addPathPatterns("/error/**")
                .excludePathPatterns("*.ico");
        registry.addInterceptor(new LoginInterCeptor())
                .addPathPatterns("/board/write","/board/delete","/board/edit","/user/logout")
                .excludePathPatterns("*.ico");

        WebMvcConfigurer.super.addInterceptors(registry);
    }
}
