package com.crud;

public class SessionConstants {
    // 세션 관련 상수
    public static final String SESSION_USER_KEY = "loggedInUser";

    // 에러 메시지 상수
    public static final String ERROR_INVALID_LOGIN = "로그인 실패: 사용자 또는 비밀번호가 일치하지 않습니다.";
    public static final String ERROR_ACCOUNT_LOCKED = "계정이 잠겨 있습니다.";

    // 기타 필요 상수들
    public static final int MAX_LOGIN_ATTEMPTS = 5;
}
