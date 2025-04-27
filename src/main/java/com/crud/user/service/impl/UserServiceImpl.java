package com.crud.user.service.impl;

import com.crud.user.service.PasswordService;
import com.crud.user.entity.Users;
import com.crud.user.mapper.UserMapper;
import com.crud.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements UserService {

    private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private PasswordService passwordService;

    @Override
    public Users login(String userId, String password) { // userId로 변경
        Users user = userMapper.findByUserId(userId); // userId로 변경
        if (user == null) {
            log.info("사용자 ID가 존재하지 않습니다: {}", userId); // userId로 변경
            return null;
        }
        // 비밀번호 검증
        try {
            boolean isPasswordValid = passwordService.checkPassword(password, user.getPassword());
            if (!isPasswordValid) {
                log.info("로그인 실패: 비밀번호가 일치하지 않습니다.");
                return null;
            }
        } catch (Exception e) {
            log.error("비밀번호 검증 오류", e);
            return null;
        }

        log.info("로그인 성공: 사용자 {}", userId); // userId로 변경
        return user;
    }
}
