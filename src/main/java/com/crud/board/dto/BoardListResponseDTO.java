package com.crud.board.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardListResponseDTO {
    public int totalCount;
    public int postId;
    private String category;
    private String title;
    private String userName;
    private String createdDate;
    private String updatedDate;
}
