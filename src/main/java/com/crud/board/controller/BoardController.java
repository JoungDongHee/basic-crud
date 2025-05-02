package com.crud.board.controller;

import com.crud.SessionConstants;
import com.crud.board.dto.BoardListResDTO;
import com.crud.board.dto.BoardViewResDTO;
import com.crud.board.dto.BoardWriteReqDTO;
import com.crud.board.entity.Categories;
import com.crud.board.entity.Posts;
import com.crud.board.service.BoardService;
import com.crud.user.entity.Users;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        List<BoardListResDTO> boardList = boardService.boardList();
        model.addAttribute("boardList", boardList);
        return "board/list";
    }

    @GetMapping("/write")
    public String write(Model model) {
        List<Categories> categoryList = boardService.getCategoryList();
        model.addAttribute("category",categoryList);
        return "board/write";
    }

    @PostMapping("/write")
    public String write(@Validated BoardWriteReqDTO boardWriteRqDTO , BindingResult bindingResult, Model model , HttpSession session) {
        if (bindingResult.hasErrors()) {
            log.info("bindingResult : {}", bindingResult.getAllErrors());
            List<Categories> categoryList = boardService.getCategoryList();
            model.addAttribute("category", categoryList);
            model.addAttribute("boardWriteRqDTO", boardWriteRqDTO); // DTO 값 복원
            return "board/write";
        }
        Users users = (Users)session.getAttribute(SessionConstants.SESSION_USER_KEY);
        // 성공 로직 (예: DB 저장 등) 입력
        Posts posts = boardService.createBoard(boardWriteRqDTO,users);
        return "redirect:/board/view/"+posts.getPostId();
    }

    @GetMapping("/edit")
    public String edit(HttpServletRequest request) {
        return "board/edit";
    }

    @GetMapping("/view/{viewnumber}")
    public String view(@PathVariable int viewnumber,Model model) {
        BoardViewResDTO view = boardService.getView(viewnumber);
        List<MultipartFile> fileList = new ArrayList<>();
        model.addAttribute("view",view);
        model.addAttribute("fileList",fileList);
        return "board/view";
    }
}
