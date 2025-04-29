<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                <li><a href="/user/login.do">로그인</a></li>
                <li><a href="/user/register.do">회원가입</a></li>
                <li><a href="/user/forgot-password.do">비밀번호 찾기</a></li>
            </ul>
        </nav>
    </header>
</body>
</html>