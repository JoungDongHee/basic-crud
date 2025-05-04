package com.crud.file;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Component
public class FileUtil {
    @Value("${file.dir}")
    private String fileDir;

    public Attachments upload(MultipartFile file) throws IOException {
        if(file.isEmpty()) {
            return null;
        }

        String originalFilename = file.getOriginalFilename();
        String uuidFileName = createFileName(originalFilename);

        Attachments uploadFile = new Attachments();
        uploadFile.setOriginalFilename(originalFilename);
        uploadFile.setStoredFilename(uuidFileName);
        uploadFile.setFilepath(getFullPath(uuidFileName));
        uploadFile.setFilesize(file.getSize());
        uploadFile.setMimetype(file.getContentType());

        file.transferTo(new File(getFullPath(uuidFileName)));
        return uploadFile;
    }

    /**
     * 파일 저장소 위치
     * @param filename
     * @return
     */
    public String getFullPath(String filename) {
        return fileDir + filename;
    }

    /**
     * UUID 를 사용한 파일 명 생성
     * @param originalFilename
     * @return
     */
    public String createFileName(String originalFilename) {
        // 파일 확장자명 제외
        String ext = getString(originalFilename);
        String uuid = UUID.randomUUID().toString();
        return uuid +"."+ext;
    }

    private static String getString(String originalFilename) {
        int pos = originalFilename.lastIndexOf(".");
        return originalFilename.substring(pos + 1);
    }
}
