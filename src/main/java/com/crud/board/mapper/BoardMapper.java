package com.crud.board.mapper;

import com.crud.board.dto.BoardListResponseDTO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;


@Mapper
public interface BoardMapper {
    List<BoardListResponseDTO> boardList();
}
