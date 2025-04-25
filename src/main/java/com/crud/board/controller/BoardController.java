package com.crud.board.controller;

import com.crud.board.dto.BoardListResponseDTO;
import com.crud.board.dto.BoardWriteRqDTO;
import com.crud.board.mapper.BoardMapper;
import com.crud.board.service.BoardService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Slf4j
@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        List<BoardListResponseDTO> boardList = boardService.boardList();
        model.addAttribute("boardList", boardList);
        return "board/list";
    }

    @GetMapping("/write")
    public String write() {

        return "board/write";
    }

    @PostMapping("/write")
    public String write(@Validated BoardWriteRqDTO boardWriteRqDTO , BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            log.info("bindingResult : {}", bindingResult.getAllErrors());
            model.addAttribute("boardWriteRqDTO", boardWriteRqDTO); // DTO 값 복원
            return "board/write";
        }

        // 성공 로직 (예: DB 저장 등) 입력
        int board = boardService.createBoard(boardWriteRqDTO);
        return "redirect:/board/list";
    }

    @GetMapping("/edit")
    public String edit(HttpServletRequest request) {
        return "board/edit";
    }

    @GetMapping("/view")
    public String view() {
        return "board/view";
    }
}
