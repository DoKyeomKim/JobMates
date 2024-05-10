package com.job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {

	// 메인 페이지
	@GetMapping("/")
	public  String  main() {
		return "section/main"; 	
	}

}

















