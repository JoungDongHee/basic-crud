package com.crud.user.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserJoinReqeustDTO {
    @NotBlank(message = "사용자 ID 는 빈값일수 없습니다.")
    private String userId;
    @Email(message = "이메일 형식이 틀립니다.")
    private String email;
    @Pattern(regexp = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#\\$%\\^&\\*])(?=\\S+$).{8,}$", message = "비밀번호는 최소 8자 이상, 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.")
    private String password;
}
