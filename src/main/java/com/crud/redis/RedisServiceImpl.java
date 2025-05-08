package com.crud.redis;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import java.io.*;
import java.time.Duration;
import java.util.Base64;
import java.util.Objects;

@RequiredArgsConstructor
@Service
public class RedisServiceImpl implements RedisService {

    private RedisTemplate redisTemplate;

    // 객체를 Redis에 저장하는 메서드
    @Override
    public void set(String key, Object value) {
        redisTemplate.opsForValue().set(key, serialize(value), Duration.ofHours(1)); // 유효기간 1시간
    }

    // Redis에서 객체를 가져오는 메서드
    @Override
    public <T> T get(String key, Class<T> clazz) {
        String value = Objects.requireNonNull(redisTemplate.opsForValue().get(key)).toString();
        return value == null ? null : deserialize(value, clazz);
    }

    // Redis에서 객체를 삭제하는 메서드
    @Override
    public void delete(String key) {
        redisTemplate.delete(key);
    }

    // 직렬화: 객체 -> String
    private String serialize(Object object) {
        try (ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
             ObjectOutputStream objectOutputStream = new ObjectOutputStream(byteArrayOutputStream)) {
            objectOutputStream.writeObject(object);
            return Base64.getEncoder().encodeToString(byteArrayOutputStream.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException("Serialization error", e);
        }
    }

    // 역직렬화: String -> 객체
    private <T> T deserialize(String data, Class<T> clazz) {
        byte[] dataBytes = Base64.getDecoder().decode(data);
        try (ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(dataBytes);
             ObjectInputStream objectInputStream = new ObjectInputStream(byteArrayInputStream)) {
            return clazz.cast(objectInputStream.readObject());
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("Deserialization error", e);
        }
    }
}
