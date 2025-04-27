package com.crud.user.service.impl;
import com.crud.user.service.PasswordService;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
@Service
public class PasswordServiceImpl implements PasswordService {
    private final Argon2PasswordEncoder argon2 = Argon2PasswordEncoder.defaultsForSpringSecurity_v5_8();
    @Override
    public boolean checkPassword(String plainPassword, String hashedPassword) {
        return argon2.verify(hashedPassword, plainPassword);
    }
}