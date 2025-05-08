<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header</title>
    <style>
        nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
            background-color: #f0f0f0;
            padding: 10px;
        }

        nav li {
            margin: 0 10px;
        }

        nav a {
            text-decoration: none;
            color: #333;
        }
    </style>
</head>
<body>
<header>
    <nav>
        <ul>
            <li><a href="/">홈</a></li>
            <li><a href="/board/list.do">게시글 목록</a></li>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <!-- 로그인된 상태에서 사용자 이름과 로그아웃 버튼 표시 -->
                    <li>${sessionScope.loggedInUser.username} 님 반갑습니다.</li>
                    <li><a href="/user/logout.do">로그아웃</a></li>
                </c:when>
                <c:otherwise>
                    <!-- 로그인하지 않은 경우 로그인 버튼 표시 -->
                    <li><a href="/user/login.do">로그인</a></li>
                    <!-- 회원가입 및 비밀번호 찾기 버튼은 항상 표시 -->
                    <li><a href="/user/register.do">회원가입</a></li>
                    <li><a href="/user/forgot-password.do">비밀번호 찾기</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>
</header>
</body>
</html>
