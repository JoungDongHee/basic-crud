package com.crud.board.controller;

import com.crud.SessionConstants;
import com.crud.board.dto.BoardListResDTO;
import com.crud.board.dto.BoardViewResDTO;
import com.crud.board.dto.BoardWriteReqDTO;
import com.crud.board.entity.Categories;
import com.crud.board.entity.Posts;
import com.crud.board.service.BoardService;
import com.crud.file.Attachments;
import com.crud.file.FileService;
import com.crud.user.entity.Users;
import com.crud.file.FileUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
    private final FileService fileService;

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        int pageSize = 10; // 페이지당 게시글 수
        int blockSize = 5; // 페이지 블록 크기
        List<BoardListResDTO> boardList = boardService.boardList(page,pageSize);
        int totalBoardCount = boardService.countBoardList();
        int totalPage = (int) Math.ceil((double) totalBoardCount / pageSize);

        // 페이지 블록 계산
        int startPage = ((page - 1) / blockSize) * blockSize + 1; //1
        int endPage = Math.min(startPage + blockSize - 1, totalPage); // 2

        // 이전 페이지 존재 여부
        if (page > 1) { // 페이지가 1보다 크면 이전페이지 존재 true
            model.addAttribute("prevPage", page - 1);
        }

        // 다음 페이지 존재 여부
        if (page < totalPage) { // 페이지 번호가 totalPage 보다 작으면 다음 페이지 존재
            model.addAttribute("nextPage", page + 1);
        }
        model.addAttribute("currentPage", page);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("boardList", boardList);
        model.addAttribute("totalBoardCount", totalBoardCount);
        return "board/list";
    }

    @GetMapping("/write")
    public String write(Model model) {
        List<Categories> categoryList = boardService.getCategoryList();
        model.addAttribute("category",categoryList);
        return "board/write";
    }

    @PostMapping("/write")
    public String write(@Validated @ModelAttribute BoardWriteReqDTO boardWriteRqDTO , BindingResult bindingResult, Model model , HttpSession session) {

        if (bindingResult.hasErrors()) {
            log.info("bindingResult : {}", bindingResult.getAllErrors());
            List<Categories> categoryList = boardService.getCategoryList();
            model.addAttribute("category", categoryList);
            model.addAttribute("boardWriteRqDTO", boardWriteRqDTO); // DTO 값 복원
            return "board/write";
        }


        Users users = (Users)session.getAttribute(SessionConstants.SESSION_USER_KEY);
        // 성공 로직 (예: DB 저장 등) 입력
        Posts posts;
        try {
            posts = boardService.createBoard(boardWriteRqDTO,users);
        }catch (RuntimeException e) {
            bindingResult.addError(new ObjectError("boardCheck", e.getMessage()));
            List<Categories> categoryList = boardService.getCategoryList();
            model.addAttribute("category", categoryList);
            model.addAttribute("boardWriteRqDTO", boardWriteRqDTO); // DTO 값 복원
            return "board/write";
        }

        return "redirect:/board/view/"+posts.getPostId();
    }

    @GetMapping("/edit/{viewnumber}")
    public String edit(HttpServletRequest request,@PathVariable int viewnumber, Model model) {
        return "board/edit";
    }

    @GetMapping("/view/{viewnumber}")
    public String view(@PathVariable int viewnumber,Model model , HttpSession session) {
        BoardViewResDTO view = boardService.getView(viewnumber,session);
        Optional<Attachments> byAttachmentId = fileService.findByAttachmentId(viewnumber);
        Attachments attachment = byAttachmentId.orElse(new Attachments());  // 파일이 없을 경우 빈 Attachments 객체 반환
        model.addAttribute("view",view);
        model.addAttribute("file",attachment);
        return "board/view";
    }


    @DeleteMapping("/view/{viewnumber}")
    public String delete(@PathVariable int viewnumber,HttpServletRequest request) {
        HttpSession session = request.getSession();
        Users user = (Users)session.getAttribute(SessionConstants.SESSION_USER_KEY);
        try {
            Boolean deleteView = boardService.deleteView(viewnumber,user);
            log.info("End deleting viewnumber {} , checked {}", viewnumber,deleteView);
        }catch (NullPointerException e) {
            return "redirect:/board/list";
        }
        return "redirect:/board/list";
    }
}
