<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 수정</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>

<div class="container mt-5">
    <div id="alertPlaceholder" class="mb-3"></div>

    <div class="card">
        <div class="card-header">
            <h1 class="mb-0">글 수정</h1>
        </div>
        <div class="card-body">
            <!-- 실제 폼 전송 시, 수정 대상 ID를 포함하고 method="POST" 또는 "PUT/PATCH" action="[서버 URL]" 등이 필요합니다. -->
            <form method="POST" action="/board/update" enctype="multipart/form-data">
                <!-- 게시글 ID -->
                <input type="hidden" name="postId" value="${view.postId}">

                <div class="mb-3">
                    <label for="postTitle" class="form-label">제목</label>
                    <!-- 서버에서 받아온 기존 제목을 value 속성에 설정 -->
                    <input type="text" class="form-control" id="postTitle" name="title" value="${view.title}" required>
                </div>

                <div class="mb-3">
                    <label for="postCategory" class="form-label">카테고리</label>
                    <select class="form-select" id="postCategory" name="category" required>
                        <option disabled value="">카테고리를 선택하세요</option>
                        <option value="notice" ${view.category == 'notice' ? 'selected' : ''}>공지</option>
                        <option value="free" ${view.category == 'free' ? 'selected' : ''}>자유</option>
                        <option value="qna" ${view.category == 'qna' ? 'selected' : ''}>질문/답변</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="postContent" class="form-label">내용</label>
                    <!-- 서버에서 받아온 기존 내용을 textarea 안에 설정 -->
                    <textarea class="form-control" id="postContent" name="content" rows="10" required>${view.content}</textarea>
                </div>

                <!-- 기존 파일 첨부 파일 목록 -->
                <div class="mb-3">
                    <label class="form-label">현재 첨부된 파일</label>
                    <div id="existingFilesList">
                        <c:forEach var="file" items="${view.files}">
                            <span class="badge bg-secondary me-1 mb-1" data-file-id="${file.attachmentId}">
                                ${file.originalFilename}
                                <button type="button" class="btn-close btn-close-white ms-1" aria-label="Remove file" style="font-size: 0.6em;" onclick="removeExistingFile(this, ${file.attachmentId}, '${file.originalFilename}')"></button>
                            </span>
                        </c:forEach>
                    </div>
                    <hr/>
                    <label for="postFiles" class="form-label">새 파일 첨부 (선택)</label>
                    <input class="form-control" type="file" id="postFiles" name="file" multiple onchange="validateFiles(this.files); updateFileListUI(this.files)">
                    <small class="form-text text-muted">새 파일을 첨부하거나 위 목록에서 기존 파일을 삭제할 수 있습니다.</small>
                    <input type="hidden" name="deletedFiles" id="deletedFilesInput" value="">
                </div>

                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-primary me-2">저장</button>
                    <a href="javascript:history.back()" class="btn btn-secondary">취소</a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- Script for handling file removal marking -->
<script>
    let filesToDelete = [];

    function removeExistingFile(buttonElement, fileId, fileName) {
        if (confirm(`'${fileName}' 파일을 삭제하시겠습니까? 이 작업은 저장 버튼을 눌러야 최종 반영됩니다.`)) {
            // Add fileId to the list of files to be deleted
            if (!filesToDelete.includes(fileId)) {
                filesToDelete.push(fileId);
            }
            // Update the hidden input value
            document.getElementById('deletedFilesInput').value = JSON.stringify(filesToDelete);

            // Visually remove the badge (optional)
            buttonElement.closest('.badge').remove();

            console.log('Files marked for deletion:', filesToDelete);
        }
    }

    function updateFileListUI(files) {
        const fileListContainer = document.getElementById('existingFilesList');
        fileListContainer.innerHTML = '';  // Clear current list

        for (let i = 0; i < files.length; i++) {
            const fileItem = document.createElement('span');
            fileItem.classList.add('badge', 'bg-secondary', 'me-1', 'mb-1');
            fileItem.textContent = files[i].name;
            fileListContainer.appendChild(fileItem);
        }
    }

    function validateFiles(files) {
        // Perform any validation on the files if necessary
        console.log('Selected files:', files);
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
