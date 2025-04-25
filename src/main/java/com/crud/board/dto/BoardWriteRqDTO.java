package com.crud.board.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.Value;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
public class BoardWriteRqDTO {
    @NotNull(message = "제목은 필수 값 입니다.")
    private String title;
    @NotNull(message = "카테고리는 필수 값 입니다.")
    private String category;
    @NotNull(message = "본 문은 필수 값 입니다.")
    private String content;
    private MultipartFile file;
}
