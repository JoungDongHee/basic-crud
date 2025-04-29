package com.crud.board.entity;


import lombok.*;

@Builder
@ToString
@Setter
@Getter
public class Posts {
  private long postId;
  private long categoryId;
  private long userId;
  private String title;
  private String content;
  private java.sql.Timestamp createdAt;
  private java.sql.Timestamp updatedAt;
}
