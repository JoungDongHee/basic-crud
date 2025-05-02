<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 글 작성</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<!-- 게시글 작성 화면 -->

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
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <!-- Alert Placeholder -->
    <div id="alertPlaceholder" class="mb-3"></div>

    <div class="card">
        <div class="card-header">
            <h1 class="mb-0">새 글 작성</h1>
        </div>
        <div class="card-body">
            <form method="POST" action="/board/write" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="postTitle" class="form-label">제목</label>
                    <input type="text" class="form-control" id="postTitle" name="title" value="${boardWriteRqDTO.title}" placeholder="제목을 입력하세요">
                    <spring:hasBindErrors name="boardWriteRqDTO">
                        <div class="text-danger">
                            <c:if test="${errors.hasFieldErrors('title')}">
                                <c:out value="${errors.getFieldError('title').defaultMessage}" />
                            </c:if>
                        </div>
                    </spring:hasBindErrors>
                </div>
                <div class="mb-3">
                    <label for="postCategory" class="form-label">카테고리</label>
                    <select class="form-select" id="postCategory" name="category" >
                        <option selected disabled value="">카테고리를 선택하세요</option>
                        <c:forEach items="${category}" var="cat">
                            <option value="${cat.categoryId}" <c:if test="${boardWriteRqDTO.category == cat.categoryId.toString()}">selected</c:if>>${cat.name}</option>
                        </c:forEach>
                    </select>
                    <spring:hasBindErrors name="boardWriteRqDTO">
                        <div class="text-danger">
                            <c:if test="${errors.hasFieldErrors('category')}">
                                <c:out value="${errors.getFieldError('category').defaultMessage}" />
                            </c:if>
                        </div>
                    </spring:hasBindErrors>
                </div>
                <div class="mb-3">
                    <label for="postContent" class="form-label">내용</label>
                    <textarea class="form-control" id="postContent" rows="10" placeholder="내용을 입력하세요" name="content">${boardWriteRqDTO.content}</textarea>
                    <spring:hasBindErrors name="boardWriteRqDTO">
                        <div class="text-danger">
                            <c:if test="${errors.hasFieldErrors('content')}">
                                <c:out value="${errors.getFieldError('content').defaultMessage}" />
                            </c:if>
                        </div>
                    </spring:hasBindErrors>
                </div>
                <div class="mb-3">
                    <label for="postFiles" class="form-label">파일 첨부</label>
                    <input class="form-control" type="file" id="postFiles" name="file" multiple>
                </div>
                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-primary me-2">저장</button>
                    <a href="/board/list" class="btn btn-secondary">취소</a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
