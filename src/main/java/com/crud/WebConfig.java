package com.crud;

import com.crud.interceptor.CommonInterceptor;
import com.crud.interceptor.ErrorInterCeptor;
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

        WebMvcConfigurer.super.addInterceptors(registry);
    }
}
