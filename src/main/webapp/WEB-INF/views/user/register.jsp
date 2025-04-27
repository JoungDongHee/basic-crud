<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<!-- 회원가입 화면 -->

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
                    <a class="nav-link active" href="register.html">회원가입</a> <!-- Active class added -->
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
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h1 class="text-center mb-0">회원가입</h1> <!-- Moved H1 here -->
                </div>
                <div class="card-body">
                    <!-- Alert Placeholder -->
                    <div id="alertPlaceholder" class="mb-3"></div>

                    <!-- 실제 회원가입 처리를 위해서는 method="POST" action="[서버 URL]" 필요 -->
                    <form>
                        <div class="mb-3">
                            <label for="regUsername" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="regUsername" placeholder="사용할 아이디 입력" required>
                            <!-- 아이디 중복 확인 기능 추가 가능 -->
                        </div>
                        <div class="mb-3">
                            <label for="regEmail" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="regEmail" placeholder="이메일 주소 입력" required>
                        </div>
                        <div class="mb-3">
                            <label for="regPassword" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="regPassword" placeholder="비밀번호 입력" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">비밀번호 확인</label>
                            <input type="password" class="form-control" id="confirmPassword" placeholder="비밀번호 다시 입력" required>
                            <!-- 비밀번호 일치 여부 검증 필요 -->
                        </div>
                        <div class="d-grid gap-2 mb-3">
                            <button type="submit" class="btn btn-success">회원가입</button>
                        </div>
                        <div class="text-center">
                            <small>이미 계정이 있으신가요? <a href="login.html">로그인</a></small>
                        </div>
                    </form>
                </div> <!-- End card-body -->
            </div> <!-- End card -->
        </div> <!-- End col-md-6 -->
    </div> <!-- End row -->
</div> <!-- End container -->

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>