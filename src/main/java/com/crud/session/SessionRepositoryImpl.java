package com.crud.session;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

import java.time.Duration;
import java.util.Objects;

@Repository
@RequiredArgsConstructor
public class SessionRepositoryImpl implements SessionRepository {

    private final RedisTemplate<String, Object> redisTemplate;

    @Override
    public void save(String id, Object data, Duration duration) {
        redisTemplate.opsForValue().set(id, data, duration);
    }

    @Override
    public <T> T findById(String id, Class<T> clazz) {
        Object value = redisTemplate.opsForValue().get(id);
        if (value != null && clazz.isInstance(value)) {
            return clazz.cast(value);
        }
        return null;
    }

    @Override
    public void deleteById(String id) {
        redisTemplate.delete(id);
    }
}