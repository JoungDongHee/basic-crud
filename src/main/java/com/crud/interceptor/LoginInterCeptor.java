package com.crud.interceptor;

import com.crud.SessionConstants;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
public class LoginInterCeptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        log.info("loginInterCeptor preHandle");

        String requestURI = request.getRequestURI();

        log.info("인증체크 인터셉터 실행 {}",requestURI);
        HttpSession session = request.getSession();

        if(session == null || session.getAttribute(SessionConstants.SESSION_USER_KEY)==null){
            log.info("미인증 사용자 요청");
            // 로그인 으로 리다이렉트
            response.sendRedirect(request.getContextPath()+"/user/login?redirectUrl="+request.getRequestURI());
            return false;
        }
        return true;
    }
}
