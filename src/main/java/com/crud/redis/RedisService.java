package com.crud.redis;




public interface RedisService {
    // 객체를 Redis에 저장하는 메서드
    void set(String key, Object value);

    // Redis에서 객체를 가져오는 메서드
    <T> T get(String key, Class<T> clazz);

    // Redis에서 객체를 삭제하는 메서드
    void delete(String key);
}
