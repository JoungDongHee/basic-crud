package com.crud.user.controller;

import com.crud.SessionConstants;
import com.crud.user.dto.UserJoinReqeustDTO;
import com.crud.user.dto.UserLginRequestDTO;
import com.crud.user.entity.Users;
import com.crud.user.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.http.HttpRequest;


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

    /**사용자의 로그인 정보를 검증하고, 인증을 시도하며, 로그인 성공 시 세션을 관리합니다.*/
    @PostMapping("/login")
    public String login(@Validated @ModelAttribute UserLginRequestDTO requestDTO, BindingResult bindingResult, HttpServletRequest request) {
        // 폼 검증 오류 처리
        if (bindingResult.hasErrors()) {
            log.info("bindingResult : {}", bindingResult.getAllErrors());
            return "user/login";
        }

        // 로그인 시도
        Users login = null;
        try {
            login = userService.login(requestDTO.getLoginId(), requestDTO.getPassword());
        } catch (Exception e) {
            log.error("로그인 처리 중 오류 발생", e);
            return "user/login";
        }

        if (login == null) {
            log.info("로그인 실패: 사용자 {} 또는 비밀번호가 일치하지 않습니다.", requestDTO.getLoginId());
            bindingResult.addError(new ObjectError("userRequestDTO",null,null,"로그인 실패 사용자 또는 비밀번호가 일치하지 않습니다."));
            return "user/login";
        }

        // 로그인 성공 시 세션 관리
        HttpSession session = request.getSession();
        // 기존 세션 정보 삭제 (로그인 상태 갱신)
        session.setAttribute(SessionConstants.SESSION_USER_KEY, login);
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

    @GetMapping("/register")
    public String register(@ModelAttribute UserJoinReqeustDTO requestDto) {
        return "user/register";
    }

    /**
     * 사용자 ID의 중복 여부를 확인합니다.
     * @param userId 확인할 사용자 ID
     * @return 사용자 ID의 사용 가능 여부 (true: 사용 가능, false: 이미 사용 중)
     */
    @PostMapping("/check-id")
    @ResponseBody
    public ResponseEntity<Boolean> checkUserIdAvailability(@RequestParam String userId) {
        log.info("Checking user ID availability: {}", userId);
        boolean exists = userService.isUserIdExists(userId);
        boolean isAvailable = !exists;
        return ResponseEntity.ok(isAvailable);
    }

    @PostMapping("/register")
    public String join(@ModelAttribute UserJoinReqeustDTO requestDto, BindingResult bindingResult, HttpServletRequest request) {
        if(bindingResult.hasErrors()){
            log.info("bindingResult : {}", bindingResult.getAllErrors());
            return "user/register";
        }

        Object loginSession = request.getSession().getAttribute(SessionConstants.SESSION_USER_KEY);
        if(loginSession != null){
            return "redirect:/";
        }

        // 사용자 ID 중복 확인
        if(userService.isUserIdExists(requestDto.getUserId())) {
            bindingResult.addError(new ObjectError("requestDto", null, null, "이미 사용중인 ID입니다."));
            return "user/register";
        }

        Users join = userService.join(requestDto);

        if(join != null){
            return "redirect:/user/login?redirectUrl=/board/list";
        } else {
            // 회원가입 실패 처리
            bindingResult.addError(new ObjectError("requestDto", null, null, "회원가입에 실패했습니다."));
            return "user/register";
        }
    }
}
