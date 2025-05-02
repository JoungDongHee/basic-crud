package com.crud.user.service.impl;

import com.crud.user.service.PasswordService;
import org.springframework.stereotype.Service;


@Service
public class PasswordServiceImpl implements PasswordService {
    @Override
    public boolean checkPassword(String plainPassword, String hashedPassword) {
        return true;
    }

    @Override
    public String createPasswordHash(String plainPassword) {
        return plainPassword;
    }
}
