package com.job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MypageController {

	// 공고 관리 페이지
	@GetMapping("/mypage")
	public  String  postings() {
		return "section/mypage"; 
	}

}

















