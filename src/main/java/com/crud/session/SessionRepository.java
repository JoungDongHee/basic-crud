package com.crud.session;

import java.time.Duration;

public interface SessionRepository {

    /**
     * 세션 데이터를 Redis에 저장합니다.
     *
     * @param id       세션 ID
     * @param data     저장할 세션 데이터 객체
     * @param duration 세션 유효 기간
     */
    void save(String id, Object data, Duration duration);

    /**
     * Redis에서 세션 데이터를 가져옵니다.
     *
     * @param id    세션 ID
     * @param clazz 반환될 객체의 클래스 타입
     * @param <T>   반환될 객체의 타입
     * @return 세션 데이터 객체 (없으면 null)
     */
    <T> T findById(String id, Class<T> clazz);

    /**
     * Redis에서 세션 데이터를 삭제합니다.
     *
     * @param id 세션 ID
     */
    void deleteById(String id);
}