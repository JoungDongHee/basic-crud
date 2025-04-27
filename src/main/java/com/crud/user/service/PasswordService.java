package com.crud.user.service;

public interface PasswordService {
    boolean checkPassword(String plainPassword, String hashedPassword);
}