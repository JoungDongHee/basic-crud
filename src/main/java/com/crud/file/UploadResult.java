package com.crud.file;

import lombok.Data;

@Data
public class UploadResult {
    private boolean success;
    private String message;

    public UploadResult(boolean success, String message) {
        this.success = success;
        this.message = message;
    }
}
