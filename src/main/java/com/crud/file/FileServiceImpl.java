package com.crud.file;

import com.crud.file.adapter.MalwareScannerManager;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class FileServiceImpl implements FileService {

    private final FileUtil fileUtil;
    private final FileMappler fileMappler;
    private final MalwareScannerManager malwareScannerManager;

    @Override
    public boolean uploadFile(int postId,MultipartFile fileData) {
        try {
            boolean scan = malwareScannerManager.scan(fileData, fileData.getContentType());
            if (!scan){
                log.info("file upload failed : file is not safe");
                return false;
            }
            Attachments upload = fileUtil.upload(fileData);
            upload.setPostId(postId);
            fileMappler.insertFile(upload);
        }catch (IOException e){
            log.info("file upload error : {}", e.getMessage());
            return false;
        }

        return true;
    }

    @Override
    public Optional<Attachments> findByAttachmentId(long postId) {
        Attachments byAttachmentId = fileMappler.findByAttachmentId(postId);
        return Optional.ofNullable(byAttachmentId);

    }
}
