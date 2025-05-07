package com.crud.file;

import com.crud.file.adapter.MalwareScannerManager;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
    @Transactional
    public UploadResult uploadFile(int postId,MultipartFile fileData) {

        if(fileData.isEmpty()){
            return new UploadResult(false,"file is empty");
        }
        try {
            boolean scan = malwareScannerManager.scan(fileData, fileData.getContentType());
            if (!scan){
                log.info("file upload failed : file is not safe");
                return new UploadResult(false,"file is not safe");
            }
            Attachments upload = fileUtil.upload(fileData);
            upload.setPostId(postId);
            fileMappler.insertFile(upload);
        }catch (IOException e){
            log.info("file upload error : {}", e.getMessage());
            return new UploadResult(false,"file upload error");
        }

        return new UploadResult(true,"file upload success");
    }

    @Override
    public Optional<Attachments> findByAttachmentId(long postId) {
        Attachments byAttachmentId = fileMappler.findByAttachmentId(postId);
        return Optional.ofNullable(byAttachmentId);

    }
}
