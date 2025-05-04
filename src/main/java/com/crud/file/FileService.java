package com.crud.file;

import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

public interface FileService {
    boolean uploadFile(int postId,MultipartFile fileData);

    Optional<Attachments> findByAttachmentId(long postId);
}
