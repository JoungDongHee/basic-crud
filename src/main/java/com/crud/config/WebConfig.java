package com.crud.config;

import com.crud.interceptor.CommonInterceptor;
import com.crud.interceptor.ErrorInterCeptor;
import com.crud.interceptor.LoginInterCeptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@RequiredArgsConstructor
public class WebConfig implements WebMvcConfigurer {

    private final LoginInterCeptor loginInterCeptor;  // 생성자 주입

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new CommonInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("*.ico");
        registry.addInterceptor(new ErrorInterCeptor())
                .addPathPatterns("/error/**")
                .excludePathPatterns("*.ico");
        registry.addInterceptor(loginInterCeptor)     // 주입받은 인터셉터 사용
                .addPathPatterns("/board/write","/board/delete","/board/edit","/user/logout")
                .excludePathPatterns("*.ico");

        WebMvcConfigurer.super.addInterceptors(registry);
    }
}