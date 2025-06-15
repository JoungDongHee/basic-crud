package com.crud;

import com.crud.board.service.BoardService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class BoardServiceTests {

    @Autowired
    BoardService boardService;

    @Test
    void countBoardListReturnsNonNegative() {
        int count = boardService.countBoardList();
        assertThat(count).isGreaterThanOrEqualTo(0);
    }
}
