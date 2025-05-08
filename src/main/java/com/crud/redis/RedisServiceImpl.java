package com.crud.redis;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import java.io.*;
import java.time.Duration; // Duration import 유지
import java.util.concurrent.TimeUnit;

@RequiredArgsConstructor
@Service
public class RedisServiceImpl implements RedisService {

    private final RedisTemplate<String, Object> redisTemplate; // RedisTemplate 타입 명시

    // 객체를 Redis에 저장하는 메서드
    @Override
    public void set(String key, Object value) {
        redisTemplate.opsForValue().set(key, value, Duration.ofHours(1)); // 유효기간 1시간
    }

    // Redis에서 객체를 가져오는 메서드
    @Override
    public <T> T get(String key, Class<T> clazz) {
        // JSON 역직렬화는 RedisTemplate이 처리
        Object value = redisTemplate.opsForValue().get(key);
        if (value != null && clazz.isInstance(value)) {
            return clazz.cast(value);
        }
        return null;
    }

    // Redis에서 객체를 삭제하는 메서드
    @Override
    public void delete(String key) {
        redisTemplate.delete(key);
    }
}
