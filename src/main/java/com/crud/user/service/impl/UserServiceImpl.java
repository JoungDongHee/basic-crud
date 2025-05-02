package com.crud.user.service.impl;

import com.crud.user.dto.UserJoinReqeustDTO;
import com.crud.user.service.PasswordService;
import com.crud.user.entity.Users;
import com.crud.user.mapper.UserMapper;
import com.crud.user.service.UserService;
import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Slf4j
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserMapper userMapper;
    private final PasswordService passwordService;

    @Override
    public Users login(String userId, String password) { // userId로 변경
        Users user = userMapper.findByUserId(userId); // userId로 변경
        if (user == null) {
            log.info("사용자 ID가 존재하지 않습니다: {}", userId); // userId로 변경
            return null;
        }
        // 비밀번호 검증
        try {
            boolean isPasswordValid = passwordService.checkPassword(password, user.getPasswordHash());
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

    @Override
    @Transactional
    public Users join(UserJoinReqeustDTO user) {
        //Argon2 argon2 = Argon2Factory.create();
        //argon2.hash(1, 1024, 1, user.getPassword());

        try {
            // 사용자 생성
            Users users = Users.builder()
                    .username(user.getUserId())
                    .passwordHash(passwordService.createPasswordHash(user.getPassword()))
                    .email(user.getEmail())
                    .build();

            userMapper.insertUser(users);
            log.info("Join Success users {}", users);
            return users;
        } catch (Exception e) {
            log.error("Join Failed: {}", e.getMessage(), e);
            return null;
        }
    }

    @Override
    public boolean isUserIdExists(String userId) {
        Users user = userMapper.findByUserId(userId);
        return user != null;
    }
}
