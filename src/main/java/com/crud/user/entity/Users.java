package com.crud.user.entity;


import lombok.*;

@Builder
@Data
public class Users {
  private long userId;
  private String username;
  private String email;
  private String passwordHash;
  private java.sql.Timestamp createdAt;
  private java.sql.Timestamp updatedAt;

  @Override
  public String toString() {
    return "Users{" +
            "userId=" + userId +
            ", username='" + username + '\'' +
            ", email='" + email + '\'' +
            '}';
  }
}
