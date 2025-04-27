package com.crud.user.service;


import com.crud.user.dto.UserJoinReqeustDTO;
import com.crud.user.entity.Users;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
    Users login(String loginId, String password);
    Users join(UserJoinReqeustDTO user);

    /**
     * 사용자 ID의 존재 여부를 확인합니다.
     * @param userId 확인할 사용자 ID
     * @return 사용자 ID가 이미 존재하면 true, 존재하지 않으면 false
     */
    boolean isUserIdExists(String userId);
}
