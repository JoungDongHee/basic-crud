package com.crud.board.entity;


import lombok.Builder;
import lombok.Data;
@Data
@Builder
public class Categories {
  private long categoryId;
  private String name;
  private java.sql.Timestamp createdAt;
  private java.sql.Timestamp updatedAt;
}
