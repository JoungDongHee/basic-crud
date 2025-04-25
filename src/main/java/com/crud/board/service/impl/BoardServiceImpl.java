package com.crud.board.service.impl;

import com.crud.board.dto.BoardListResponseDTO;
import com.crud.board.dto.BoardWriteRqDTO;
import com.crud.board.mapper.BoardMapper;
import com.crud.board.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
    private final BoardMapper boardMapper;

    @Override
    public List<BoardListResponseDTO> boardList() {
       return boardMapper.boardList();
    }

    @Override
    public int createBoard(BoardWriteRqDTO requestDto) {
        return 0;
    }
}
