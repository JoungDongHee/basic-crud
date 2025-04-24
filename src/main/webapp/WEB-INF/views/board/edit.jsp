<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<!-- 게시글 수정 화면 -->

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="list.html">게시판</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <!-- Logged-out state -->
                <li class="nav-item">
                    <a class="nav-link" href="login.html">로그인</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.html">회원가입</a>
                </li>
                <!-- Logged-in state (Example) -->
                <!--
                <li class="nav-item">
                  <span class="navbar-text me-2">[사용자 이름]님 환영합니다!</span>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#">로그아웃</a>
                </li>
                -->
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <!-- Alert Placeholder -->
    <div id="alertPlaceholder" class="mb-3"></div>

    <div class="card">
        <div class="card-header">
            <h1 class="mb-0">글 수정</h1>
        </div>
        <div class="card-body">
            <!-- 실제 폼 전송 시, 수정 대상 ID를 포함하고 method="POST" 또는 "PUT/PATCH" action="[서버 URL]" 등이 필요합니다. -->
            <form enctype="multipart/form-data">
                <!-- 서버에서 게시글 ID를 받아 hidden input 등으로 관리할 수 있습니다. -->
                <!-- <input type="hidden" name="postId" value="[게시글 ID]"> -->

                <div class="mb-3">
                    <label for="postTitle" class="form-label">제목</label>
                    <!-- 서버에서 받아온 기존 제목을 value 속성에 설정 -->
                    <input type="text" class="form-control" id="postTitle" value="기존 게시글 제목 예시" required>
                </div>
                <div class="mb-3">
                    <label for="postCategory" class="form-label">카테고리</label>
                    <select class="form-select" id="postCategory" required>
                        <option disabled value="">카테고리를 선택하세요</option>
                        <!-- 서버에서 받아온 기존 카테고리에 selected 속성 추가 -->
                        <option value="notice">공지</option>
                        <option value="free" selected>자유</option>
                        <option value="qna">질문/답변</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="postContent" class="form-label">내용</label>
                    <!-- 서버에서 받아온 기존 내용을 textarea 안에 설정 -->
                    <textarea class="form-control" id="postContent" rows="10" required>기존 게시글 내용 예시입니다.</textarea>
                </div>

                <!-- Updated File Attachment Section -->
                <div class="mb-3">
                    <label class="form-label">현재 첨부된 파일</label>
                    <div id="existingFilesList">
                        <!-- 서버에서 받아온 기존 파일 목록 반복 출력 (예시) -->
                        <span class="badge bg-secondary me-1 mb-1" data-file-id="1">
                      existing_file_1.pdf
                      <button type="button" class="btn-close btn-close-white ms-1" aria-label="Remove file" style="font-size: 0.6em;" onclick="removeExistingFile(this, 1, 'existing_file_1.pdf')"></button>
                    </span>
                        <span class="badge bg-secondary me-1 mb-1" data-file-id="2">
                      image.jpg
                      <button type="button" class="btn-close btn-close-white ms-1" aria-label="Remove file" style="font-size: 0.6em;" onclick="removeExistingFile(this, 2, 'image.jpg')"></button>
                    </span>
                        <!-- 파일이 없을 경우 메시지 (선택 사항) -->
                        <!-- <p class="text-muted small">첨부된 파일이 없습니다.</p> -->
                    </div>
                    <hr/>
                    <label for="postFiles" class="form-label">새 파일 첨부 (선택)</label>
                    <input class="form-control" type="file" id="postFiles" multiple>
                    <small class="form-text text-muted">새 파일을 첨부하거나 위 목록에서 기존 파일을 삭제할 수 있습니다.</small>
                    <!-- 삭제될 파일 ID를 서버로 보내기 위한 숨겨진 필드 (JavaScript로 관리) -->
                    <input type="hidden" name="deletedFiles" id="deletedFilesInput" value="">
                </div>
                <!-- End Updated File Attachment Section -->

                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-primary me-2">저장</button>
                    <!-- 취소 시 이전 페이지(상세보기 또는 목록)로 이동 -->
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

            // If no files are left, show a message (optional)
            const listElement = document.getElementById('existingFilesList');
            if (!listElement.querySelector('.badge')) {
                // listElement.innerHTML = '<p class="text-muted small">첨부된 파일이 없습니다.</p>';
            }
            console.log('Files marked for deletion:', filesToDelete);
        }
    }
</script>

</body>
</html>