package com.crud.user.service;


import com.crud.user.entity.Users;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
    Users login(String loginId, String password);
}
