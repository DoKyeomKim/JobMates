package com.job.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.job.dto.PostingDto;
import com.job.service.MainService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {

	@Autowired
	private MainService mainService;
	
	
	// 메인 페이지
	@GetMapping("/")
	public  String  main() {
		return "section/main"; 	
	}
	
	@GetMapping("/SearchResult")
	public ModelAndView searchResult(@RequestParam("keyword") String keyword) {
		ModelAndView mv = new ModelAndView("fragment/searchBox");
		List<PostingDto> lists = mainService.findByKeyword(keyword);
		mv.addObject("results", lists != null ? lists : Collections.emptyList());
		if (keyword != null) {
			mv.addObject("isSearched", true);
		}
		return mv;
	}
	
}

















