package com.crud.board.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
public class BoardWriteReqDTO {
    @NotNull
    @NotEmpty(message = "제목은 필수 값 입니다.")
    private String title;
    @NotNull(message = "카테고리는 필수 값 입니다.")
    @NotEmpty
    private String category;
    @NotNull
    @NotEmpty(message = "본문 은 필수 값 입니다.")
    private String content;
    private MultipartFile file;
}
