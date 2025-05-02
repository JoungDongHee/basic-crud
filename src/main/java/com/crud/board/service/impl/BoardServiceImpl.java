package com.crud.board.service.impl;

import com.crud.board.dto.BoardListResDTO;
import com.crud.board.dto.BoardViewResDTO;
import com.crud.board.dto.BoardWriteReqDTO;
import com.crud.board.entity.Categories;
import com.crud.board.entity.Posts;
import com.crud.board.mapper.BoardMapper;
import com.crud.board.service.BoardService;
import com.crud.user.entity.Users;
import com.crud.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {
    private final BoardMapper boardMapper;
    private final UserMapper userMapper;

    @Override
    public List<BoardListResDTO> boardList() {
       return boardMapper.boardList();
    }

    @Override
    public List<Categories> getCategoryList() {
        return boardMapper.getCategoryList();
    }

    @Override
    @Transactional
    public Posts createBoard(BoardWriteReqDTO requestDto , Users users) {
        Users byUserId = userMapper.findByUserId(users.getUsername());
        if (byUserId.getUserId() != users.getUserId()){
            return null;
        }
        Posts posts = Posts.builder()
                .title(requestDto.getTitle())
                .content(requestDto.getContent())
                .userId(users.getUserId())
                .categoryId(Long.parseLong(requestDto.getCategory()))
                .build();
        boardMapper.createBoard(posts);
        return posts;
    }

    @Override
    public BoardViewResDTO getView(int viewnumber) {
        return boardMapper.getView(viewnumber);
    }

    @Override
    @Transactional
    public Boolean deleteView(int viewnumber,Users users) {
        Users byUserId = userMapper.findByUserId(users.getUsername());
        if (byUserId.getUserId() != users.getUserId()){
            log.info("User id {} not match", users.getUsername());
            return false;
        }

        log.info("Start deleting view {}", viewnumber);
        Posts view = boardMapper.findByPostId(viewnumber,users.getUserId());
        if(view != null){
            boardMapper.deleteView(viewnumber,users.getUserId());
            return true;
        }
        return false;
    }
}
