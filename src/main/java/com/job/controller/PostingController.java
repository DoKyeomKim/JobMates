package com.job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PostingController {

	// 공고 관리 페이지
	@GetMapping("/postings")
	public  String  postings() {
		return "section/postings"; 
	}
	// 이력서 관리 페이지
	@GetMapping("/resumes")
	public  String  resumes() {
		return "section/resumes"; 
	}

}

















