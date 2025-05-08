package com.crud.board.dto;

import com.crud.file.Attachments;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Builder
@Data
public class BoardViewResDTO {
    private int postId;
    private String title;
    private String content;
    private String category;
    private String author;
    private String createdDate;
    private String userId;
    private boolean edite;
    private int likeCount;
    private int dislikeCount;
}
