package com.crud.board.mapper;

import com.crud.board.dto.BoardListResDTO;
import com.crud.board.dto.BoardViewResDTO;
import com.crud.board.entity.Categories;
import com.crud.board.entity.Posts;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;


@Mapper
public interface BoardMapper {
    List<BoardListResDTO> boardList(int offset,int pageSize);
    int createBoard(Posts board);
    List<Categories> getCategoryList();

    BoardViewResDTO getView(int viewnumber);

    void deleteView(int viewnumber,int userid);

    Posts findByPostId(int viewnumber,int userid);

    int countBoardList();
}
