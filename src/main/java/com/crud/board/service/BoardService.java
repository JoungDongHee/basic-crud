package com.crud.board.service;


import com.crud.board.dto.BoardListResponseDTO;
import com.crud.board.dto.BoardWriteRqDTO;

import java.util.List;

public interface BoardService {
    List<BoardListResponseDTO> boardList();
    int createBoard(BoardWriteRqDTO requestDto);
}
