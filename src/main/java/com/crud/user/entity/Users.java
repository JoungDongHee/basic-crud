package com.crud.user.entity;


import lombok.*;

import java.security.Timestamp;

@Builder
@Data
public class Users {
  private long userId;
  private String username;
  private String email;
  private String passwordHash;

  // 직렬화에서 제외하려면 transient 키워드 사용
  private transient java.sql.Timestamp createdAt;
  private transient java.sql.Timestamp updatedAt;

  @Override
  public String toString() {
    return "Users{" +
            "userId=" + userId +
            ", username='" + username + '\'' +
            ", email='" + email + '\'' +
            '}';
  }
}
