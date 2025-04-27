package com.crud.user.service.impl;

import com.crud.user.entity.Users;
import com.crud.user.mapper.UserMapper;
import com.crud.user.service.UserService;
import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


@Slf4j
@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService {
    private final UserMapper userMapper;

    @Override
    public Users login(String loginId, String password) {
        Argon2 argon2 = Argon2Factory.create();
        Users storedUser = userMapper.findById(loginId);

        if (storedUser == null) {
            log.info("로그인 실패: 사용자 {}를 찾을 수 없습니다.", loginId);
            return null;
        }

        // 비밀번호 해시 생성
        String passwordHash = argon2.hash(2, 65536, 1, password.toCharArray());
        log.info("사용자 {}가 입력한 비밀번호의 해시값: {}", loginId, passwordHash);  // 비밀번호 해시값 로그 남기기

        // 비밀번호 검증
        try {
            boolean isPasswordValid = argon2.verify(storedUser.getPasswordHash(), password.toCharArray());
            if (!isPasswordValid) {
                log.info("로그인 실패: 비밀번호가 일치하지 않습니다.");
                return null;
            }
        } catch (Exception e) {
            log.error("비밀번호 검증 오류", e);
            return null;
        }

        log.info("로그인 성공: 사용자 {}", loginId);
        return storedUser;
    }

}
