package com.crud.user.service.impl;
import com.crud.user.service.PasswordService;
import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import org.springframework.stereotype.Service;

//@Service
public class PasswordArgonServiceImpl implements PasswordService {

    /**
     * 비밀번호 검증
     */
    @Override
    public boolean checkPassword(String plainPassword, String hashedPassword) {
        Argon2 argon2 = Argon2Factory.create();
        return argon2.verify(hashedPassword, plainPassword);
    }

    @Override
    public String createPasswordHash(String plainPassword) {
        Argon2 argon2 = Argon2Factory.create();
        return argon2.hash(1, 1024, 1, plainPassword);
    }
}