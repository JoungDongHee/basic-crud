package com.crud.board.mapper;

import com.crud.board.dto.BoardListResDTO;
import com.crud.board.dto.BoardViewResDTO;
import com.crud.board.entity.Categories;
import com.crud.board.entity.Posts;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;


@Mapper
public interface BoardMapper {
    List<BoardListResDTO> boardList();
    int createBoard(Posts board);
    List<Categories> getCategoryList();

    BoardViewResDTO getView(int viewnumber);
    List<BoardListResDTO> boardListWithPaging(int offset, int pageSize);
    int countBoardList();
}
