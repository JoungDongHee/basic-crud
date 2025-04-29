package com.crud.board.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class BoardViewResDTO {
    private String title;
    private String content;
    private String category;
    private String author;
    private String createdDate;
    //private List<MultipartFile> file;
}
