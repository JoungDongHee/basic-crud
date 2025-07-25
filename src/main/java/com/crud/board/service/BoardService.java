package com.crud.board.service;


import com.crud.board.dto.BoardListResDTO;
import com.crud.board.dto.BoardViewResDTO;
import com.crud.board.dto.BoardWriteReqDTO;
import com.crud.board.entity.Categories;
import com.crud.board.entity.Posts;
import com.crud.user.entity.Users;
import jakarta.servlet.http.HttpSession;
import org.apache.tomcat.util.http.fileupload.FileUploadException;

import java.util.List;

public interface BoardService {
    List<BoardListResDTO> boardList(int page, int pageSize);
    Posts createBoard(BoardWriteReqDTO requestDto, Users users);

    List<Categories> getCategoryList();

    BoardViewResDTO getView(int viewnumber, HttpSession session);
    Boolean deleteView(int viewnumber,Users users);

    int countBoardList();
}
