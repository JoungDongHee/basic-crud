package com.crud.interceptor;

import com.crud.config.SessionConstants;
import com.crud.session.SessionRepository;
import com.crud.user.entity.Users;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Slf4j
@Component // 빈으로 등록
@RequiredArgsConstructor // SessionRepository 주입을 위한 생성자 생성
public class LoginInterCeptor implements HandlerInterceptor {

    private final SessionRepository sessionRepository; // 필드 선언

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        log.info("loginInterCeptor preHandle");

        String requestURI = request.getRequestURI();

        log.info("인증체크 인터셉터 실행 {}", requestURI);

        // SessionRepository를 사용하여 Redis에서 세션 데이터 가져옴
        HttpSession session = request.getSession(false); // 기존 세션 가져오기 (없으면 null)
        if (session != null) {
 Users loggedInUser = sessionRepository.findById(session.getId(), Users.class);

        if(loggedInUser == null){
            log.info("미인증 사용자 요청");
            // 로그인 으로 리다이렉트
            response.sendRedirect(request.getContextPath()+"/user/login?redirectUrl="+request.getRequestURI());
            return false;
        }
        } else {
             log.info("세션이 존재하지 않습니다. 미인증 사용자 요청");
             response.sendRedirect(request.getContextPath() + "/user/login?redirectUrl=" + request.getRequestURI());
             return false;
        }
        return true;
    }
}
