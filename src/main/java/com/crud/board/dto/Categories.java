package com.crud.board.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Categories {
  private long categoryId;
  private String name;
  private String createdAt;
  private String updatedAt;
}
