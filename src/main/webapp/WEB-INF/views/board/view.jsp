<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 서버에서 받아온 게시글 제목으로 동적 설정 필요 -->
    <title>게시글 상세 보기</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<!-- 게시글 상세 보기 화면 -->

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="list.html">게시판</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto"> <!-- ms-auto added -->
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
        <div class="card-body">
            <!-- 서버에서 받아온 게시글 제목 -->
            <h1 class="card-title mb-3">첫 번째 게시글입니다.</h1>

            <div class="card-subtitle text-muted mb-4 border-bottom pb-2">
                <span>
                    <strong>카테고리:</strong> 공지 |
                    <strong>작성자:</strong> 홍길동
                </span>
                <span class="float-end"><strong>작성일:</strong> 2024-07-26</span>
            </div>

            <!-- 서버에서 받아온 게시글 내용 -->
            <div class="card-text mb-4" style="min-height: 150px;">
                <p>여기에 게시글의 본문 내용이 표시됩니다.</p>
                <p>여러 줄의 텍스트가 들어갈 수 있습니다.</p>
                <!-- HTML 태그 렌더링이 필요하다면 서버에서 처리 후 출력 -->
            </div>

            <!-- 첨부 파일 섹션 (파일이 있을 경우) -->
            <div class="mb-4 border-top pt-3">
                <h5><i class="bi bi-paperclip"></i> 첨부 파일</h5>
                <ul class="list-group list-group-flush">
                    <!-- 서버에서 받아온 첨부파일 목록 반복 출력 -->
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <a href="#" download><i class="bi bi-file-earmark-text me-2"></i>existing_file_1.pdf</a>
                        <!-- <span class="badge bg-light text-dark rounded-pill">1.2 MB</span> -->
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <a href="#" download><i class="bi bi-file-earmark-image me-2"></i>image.jpg</a>
                        <!-- <span class="badge bg-light text-dark rounded-pill">850 KB</span> -->
                    </li>
                </ul>
            </div>

            <div class="d-flex justify-content-end pt-3 border-top">
                <!-- 로그인 상태 및 작성자 확인 후 수정/삭제 버튼 표시 (서버 로직 필요) -->
                <a href="edit.html?id=1" class="btn btn-outline-secondary me-2">수정</a>
                <!-- 삭제 버튼은 id를 동적으로 전달해야 함 -->
                <button type="button" class="btn btn-outline-danger me-2" onclick="deletePost(1)">삭제</button>
                <a href="list.html" class="btn btn-primary">목록</a>
            </div>
        </div> <!-- End card-body -->
    </div> <!-- End card -->

</div>

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>
    // 삭제 확인 함수
    function deletePost(id) {
        if (confirm('정말로 삭제하시겠습니까?')) {
            // 실제로는 서버에 삭제 요청 (POST 또는 DELETE 메서드 사용)
            console.log('Deleting post with id:', id);
            // 성공 시 목록 페이지로 리디렉션
            alert('삭제되었습니다.');
            window.location.href = 'list.html'; // 목록 페이지로 이동
        }
    }
</script>
</body>
</html>