package com.crud.board.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page) {
        return "board/list";
    }

    @GetMapping("/write")
    public String write() {
        return "board/write";
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
