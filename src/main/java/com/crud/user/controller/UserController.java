package com.crud.user.controller;

import com.crud.user.dto.UserRequestDTO;
import com.crud.user.entity.Users;
import com.crud.user.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    private final UserService userService;

    @PostMapping("/login")
    public String login(@Validated @ModelAttribute UserRequestDTO userRequestDTO, BindingResult bindingResult, HttpServletRequest request) {
        log.info("로그인 시도: {}", userRequestDTO.getUserId());
        if (bindingResult.hasErrors()) {
            return "user/login";
        }

        Users login;
        try {
            login = userService.login(userRequestDTO.getUserId(), userRequestDTO.getPassword()); // userId로 변경
        } catch (Exception e) {
            log.error("로그인 중 오류 발생", e);
            bindingResult.reject("loginFailed", "로그인 실패");
            return "user/login";
        }
    @GetMapping("/login")
    public String login() {
        return "user/login";
        if (login == null) {
            bindingResult.reject("loginFailed", "로그인 실패 사용자 또는 비밀번호가 일치하지 않습니다.");
            return "user/login";
        }

        if (login == null) {
            log.info("로그인 실패: 사용자 {} 또는 비밀번호가 일치하지 않습니다.", userRequestDTO.getLoginId());
            bindingResult.addError(new ObjectError("userRequestDTO",null,null,"로그인 실패 사용자 또는 비밀번호가 일치하지 않습니다."));
            return "user/login";
        }


        // 로그인 성공 시 세션 관리
        HttpSession session = request.getSession();
        // 기존 세션 정보 삭제 (로그인 상태 갱신)
        session.setAttribute("loggedInUser", login);
        log.info("User logged in successfully: {}", login.getUsername());// 변경

        // 로그인 후 리다이렉트

        // 로그인 후 리다이렉트
        return "redirect:/board/list";
    }


    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            log.info("User logged out: {}", session.getAttribute("loggedInUser"));
            session.invalidate();
        }
        return "redirect:/user/login";
    }

    @GetMapping("/join")
    public String join() {
        return "user/join";
    }
}
