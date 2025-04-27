<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<!-- 로그인 화면 -->

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="/board/list">게시판</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <!-- Logged-out state -->
                <li class="nav-item">
                    <a class="nav-link active" href="/user/login">로그인</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user/register">회원가입</a>
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
                    <h1 class="text-center mb-0">로그인</h1>
                </div>
                <div class="card-body">
                    <!-- Alert Placeholder -->
                    <div id="alertPlaceholder" class="mb-3">
                        <spring:hasBindErrors name="requestDTO">
                            <div class="text-danger">
                                <c:if test="${not empty errors}">
                                    <c:out value="${errors.allErrors[0].defaultMessage}" />
                                </c:if>
                            </div>
                        </spring:hasBindErrors>
                    </div>

                    <!-- 로그인 처리를 위한 폼 -->
                    <form action="/user/login" method="post">
                        <div class="mb-3">
                            <label for="loginId" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="loginId" name="loginId" placeholder="아이디 입력" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호 입력" required>
                        </div>
                        <div class="d-grid gap-2 mb-3">
                            <button type="submit" class="btn btn-primary">로그인</button>
                        </div>
                        <div class="text-center">
                            <small><a href="/user/">회원가입</a> | <a href="/user/forgot-password">비밀번호 찾기</a></small>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
