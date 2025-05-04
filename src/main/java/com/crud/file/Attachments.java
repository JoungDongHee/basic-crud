package com.crud.file;


import lombok.Builder;
import lombok.Data;


@Data
public class Attachments {
  private long attachmentId;
  private long postId;
  private String originalFilename;
  private String storedFilename;
  private String filepath;
  private long filesize;
  private String mimetype;
  private java.sql.Timestamp createdAt;
}
