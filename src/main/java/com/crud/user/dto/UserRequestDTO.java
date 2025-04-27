package com.crud.user.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRequestDTO {
    @NotBlank(message = "로그인 ID 는 공백일수 없습니다.")
    private String loginId;

    @NotBlank(message = "사용자 비밀번호는 공백일수 없습니다.")
    private String password;
}