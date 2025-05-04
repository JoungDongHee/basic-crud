package com.crud.board.service.impl;

import com.crud.SessionConstants;
import com.crud.board.dto.BoardListResDTO;
import com.crud.board.dto.BoardViewResDTO;
import com.crud.board.dto.BoardWriteReqDTO;
import com.crud.board.entity.Categories;
import com.crud.board.entity.Posts;
import com.crud.board.mapper.BoardMapper;
import com.crud.board.service.BoardService;
import com.crud.file.FileService;
import com.crud.user.entity.Users;
import com.crud.user.mapper.UserMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {
    private final BoardMapper boardMapper;
    private final UserMapper userMapper;
    private final FileService fileService;

    @Override
    public List<BoardListResDTO> boardList(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return boardMapper.boardList(offset,pageSize);
    }

    @Override
    public int countBoardList() {
        return boardMapper.countBoardList();
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

        boolean uploadFile = fileService.uploadFile((int) posts.getPostId(), requestDto.getFile());
        if (!uploadFile) {
            log.info("file upload failed : file is not safe");
            return null;
        }
        return posts;
    }

    @Override
    public BoardViewResDTO getView(int viewnumber , HttpSession session) {
        BoardViewResDTO view = boardMapper.getView(viewnumber);
        extracted(session, view);
        return view;
    }

    private static void extracted(HttpSession session, BoardViewResDTO view) {
        Users user = (Users) session.getAttribute(SessionConstants.SESSION_USER_KEY);
        Optional<Users> user1 = Optional.ofNullable(user);
        Boolean edite = user1.map(users -> view.getUserId().
                equals(String.valueOf(users.getUserId()))).orElse(false);
        view.setEdite(edite);
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
        Posts view = boardMapper.findByPostId(viewnumber,(int)users.getUserId());
        if(view != null){
            boardMapper.deleteView(viewnumber,(int)users.getUserId());
            return true;
        }
        return false;
    }
}
