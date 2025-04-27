package com.crud.user.mapper;

import com.crud.user.entity.Users;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    Users findByUserId(String userId);
    void insertUser(Users user);
}
