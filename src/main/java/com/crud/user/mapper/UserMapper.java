package com.crud.user.mapper;

import com.crud.user.entity.Users;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    Users findById(@Param("username") String username);
    Users login(@Param("username") String username, @Param("password") String password);
}
