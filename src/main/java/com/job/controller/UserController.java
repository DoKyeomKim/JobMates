package com.job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserController {

	// 로그인 페이지
	@GetMapping("/login")
	public  String  login() {
		return "section/login"; 
	}

}

















