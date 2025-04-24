<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 목록 (Bootstrap)</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Optional: Add custom CSS link here if needed later -->
    <!-- <link rel="stylesheet" href="style.css"> -->
</head>
<body>
<!-- 게시글 목록 화면 -->

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
                <!-- Logged-in state (Example - comment out the above and uncomment below when logged in) -->
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
    <!-- Alert Placeholder - Moved here -->
    <div id="alertPlaceholder" class="mb-3"></div>

    <h1 class="mb-4 text-center">게시판</h1>

    <div class="d-flex justify-content-end mb-3">
        <a href="create.html" class="btn btn-primary">새 글 작성</a>
    </div>

    <table class="table table-striped table-hover table-bordered">
        <thead class="table-dark">
        <tr>
            <th scope="col">번호</th>
            <th scope="col">카테고리</th>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>
        </tr>
        </thead>
        <tbody>
        <!-- 게시글 데이터가 동적으로 추가될 부분 -->
        <tr>
            <th scope="row">1</th>
            <td>공지</td>
            <td><a href="view.html?id=1">첫 번째 게시글입니다.</a></td>
            <td>홍길동</td>
            <td>2024-07-26</td>
        </tr>
        <tr>
            <th scope="row">2</th>
            <td>자유</td>
            <td><a href="view.html?id=2">두 번째 게시글 제목</a></td>
            <td>김철수</td>
            <td>2024-07-25</td>
        </tr>
        <!-- 예시 데이터 -->
        </tbody>
    </table>

    <!-- Pagination -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">이전</a>
            </li>
            <li class="page-item active" aria-current="page">
                <a class="page-link" href="#">1</a>
            </li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
                <a class="page-link" href="#">다음</a>
            </li>
        </ul>
    </nav>
    <!-- End Pagination -->

</div>

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>
    // 간단한 삭제 확인 함수 (실제 구현에서는 서버 통신 필요)
    function deletePost(id) {
        if (confirm('정말로 삭제하시겠습니까?')) {
            // 실제로는 서버에 삭제 요청을 보내야 합니다.
            console.log('Deleting post with id:', id);
            // 성공 시 해당 행을 테이블에서 제거하는 로직 추가
            alert('삭제되었습니다.');
            // window.location.reload(); // 페이지 새로고침 또는 DOM 조작
        }
    }
</script>
</body>
</html>