package com.crud.user.controller;

import com.crud.user.dto.UserRequestDTO;
import com.crud.user.entity.Users;
import com.crud.user.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Slf4j
@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/login")
    public String login() {
        return "user/login";
    }

    @PostMapping("/login")
    public String login(@Validated @ModelAttribute UserRequestDTO userRequestDTO, BindingResult bindingResult, HttpServletRequest request) {
        // 폼 검증 오류 처리
        if (bindingResult.hasErrors()) {
            log.info("bindingResult : {}", bindingResult.getAllErrors());
            return "user/login";
        }

        // 로그인 시도
        Users login = null;
        try {
            login = userService.login(userRequestDTO.getLoginId(), userRequestDTO.getPassword());
        } catch (Exception e) {
            log.error("로그인 처리 중 오류 발생", e);
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
        log.info("User logged in successfully: {}", login.getUsername());

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
