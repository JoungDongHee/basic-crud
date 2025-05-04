package com.crud.file;

import org.apache.ibatis.annotations.Mapper;

import java.io.File;

@Mapper
public interface FileMappler {
    void insertFile(Attachments attachment);

    Attachments findByAttachmentId(long postId);
}
