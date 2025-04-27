package com.crud.board.entity;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@ToString
public class Categories {
  private long categoryId;
  private String name;
  private String createdAt;
  private String updatedAt;
}
