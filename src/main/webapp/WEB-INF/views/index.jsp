<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티 게시판</title>
    <!-- Bootstrap CSS -->
</head>
<body>
<!-- 홈페이지 (최상위 인덱스) -->

<div class="container mt-5">
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">커뮤니티 게시판에 오신 것을 환영합니다!</h1>
            <p class="col-md-8 fs-4">자유롭게 의견을 나누고 정보를 공유하는 공간입니다.</p>
            <a href="list.do" class="btn btn-primary btn-lg" type="button">게시판 바로가기</a>
        </div>
    </div>

    <div class="row align-items-md-stretch">
        <div class="col-md-12">
            <div class="h-100 p-5 bg-white border rounded-3 text-center">
                <h2>다양한 이야기들</h2>
                <p>여러분의 이야기를 들려주세요.</p>
                <img src="https://images.unsplash.com/photo-1517048676732-d65bc937f952?q=80&w=1740&auto=format&fit=crop" class="img-fluid rounded shadow-sm mt-3" alt="Community Discussion image">
            </div>
        </div>
    </div>

    <footer class="pt-3 mt-4 text-muted border-top">
        &copy; 2024 커뮤니티 게시판
    </footer>
</div>

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>