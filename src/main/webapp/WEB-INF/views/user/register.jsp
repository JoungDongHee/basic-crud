<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>
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
        <a class="navbar-brand" href="/board/list">게시판</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto"> <!-- ms-auto added -->
                <!-- Logged-out state -->
                <li class="nav-item">
                    <a class="nav-link" href="/user/login">로그인</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/user/register">회원가입</a> <!-- Active class added -->
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
                    <div id="alertPlaceholder" class="mb-3">
                        <spring:hasBindErrors name="requestDto">
                            <div class="text-danger spring-generated">
                                <c:forEach items="${errors.allErrors}" var="error">
                                    <div><c:out value="${error.defaultMessage}" /></div>
                                </c:forEach>
                            </div>
                        </spring:hasBindErrors>
                    </div>

                    <!-- 회원가입 처리 폼 -->
                    <form action="/user/register" method="post">
                        <div class="mb-3">
                            <label for="userId" class="form-label">아이디</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="userId" name="userId" placeholder="사용할 아이디 입력" required>
                                <button class="btn btn-outline-secondary" type="button" id="checkIdBtn">중복확인</button>
                            </div>
                            <div id="userIdFeedback" class="form-text mt-1"></div>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="이메일 주소 입력" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호 입력" required>
                            <small class="text-muted">비밀번호는 최소 8자 이상, 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.</small>
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
                            <small>이미 계정이 있으신가요? <a href="/user/login">로그인</a></small>
                        </div>
                    </form>
                </div> <!-- End card-body -->
            </div> <!-- End card -->
        </div> <!-- End col-md-6 -->
    </div> <!-- End row -->
</div> <!-- End container -->

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- Password validation script -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');
    const alertPlaceholder = document.getElementById('alertPlaceholder');
    const userId = document.getElementById('userId');
    const checkIdBtn = document.getElementById('checkIdBtn');
    const userIdFeedback = document.getElementById('userIdFeedback');

    function checkUserIdAvailability(userIdValue) {
        const encodedUserId = encodeURIComponent(userIdValue);
        return fetch(`/user/check-id?userId=${encodedUserId}`)
            .then(response => response.json())
            .then(isAvailable => {
                if (isAvailable) {
                    userIdFeedback.className = 'form-text text-success mt-1';
                    userIdFeedback.textContent = '사용 가능한 아이디입니다.';
                    userId.dataset.validated = 'true';
                } else {
                    userIdFeedback.className = 'form-text text-danger mt-1';
                    userIdFeedback.textContent = '이미 사용중인 아이디입니다.';
                    userId.dataset.validated = 'false';
                }
            })
            .catch(error => {
                console.error('Error checking user ID:', error);
                userIdFeedback.className = 'form-text text-danger mt-1';
                userIdFeedback.textContent = '아이디 확인 중 오류가 발생했습니다.';
            });
    }





    // 아이디 중복 확인 기능
    checkIdBtn.addEventListener('click', function() {
        const userIdValue = userId.value.trim();

        if (!userIdValue) {
            userIdFeedback.className = 'form-text text-danger mt-1';
            userIdFeedback.textContent = '아이디를 입력해주세요.';
            return;
        }

        // AJAX 요청으로 아이디 중복 확인
        checkUserIdAvailability(userIdValue);
    });

    // 아이디 입력 필드 변경 시 검증 상태 초기화
    userId.addEventListener('input', function() {
        userId.dataset.validated = '';
        userIdFeedback.textContent = '';
    });

    form.addEventListener('submit', function(event) {
        // Clear previous alerts
        if (!alertPlaceholder.querySelector('.spring-generated')) {
            alertPlaceholder.innerHTML = '';
        }

        // Check if passwords match
        if (password.value !== confirmPassword.value) {
            event.preventDefault();
            const alertDiv = document.createElement('div');
            alertDiv.className = 'text-danger';
            alertDiv.textContent = '비밀번호가 일치하지 않습니다.';
            alertPlaceholder.appendChild(alertDiv);
        }

        // 아이디 중복 확인 여부 검증
        if (userId.dataset.validated === 'false') {
            event.preventDefault();
            const alertDiv = document.createElement('div');
            alertDiv.className = 'text-danger';
            alertDiv.textContent = '이미 사용중인 아이디입니다. 다른 아이디를 선택해주세요.';
            alertPlaceholder.appendChild(alertDiv);
        }
    });
});
</script>
</body>
</html>
