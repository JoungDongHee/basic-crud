
package com.crud.user.entity;

import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Users implements Serializable {
  private long userId;
  private String username;
  private String email;
  private String passwordHash;

  // 직렬화에서 제외하려면 transient 키워드 사용
  private transient Timestamp createdAt;
  private transient Timestamp updatedAt;

  @Override
  public String toString() {
    return "Users{" +
            "userId=" + userId +
            ", username='" + username + '\'' +
            ", email='" + email + '\'' +
            '}';
  }
}