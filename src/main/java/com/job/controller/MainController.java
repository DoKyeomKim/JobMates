package com.job.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.job.dto.PostingDto;
import com.job.dto.SkillDto;
import com.job.entity.Skill;
import com.job.service.MainService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {

	@Autowired
	private MainService mainService;

	// 메인 페이지
	@GetMapping("/")
	public ModelAndView main() {
		ModelAndView mv = new ModelAndView("section/main");
		List<SkillDto> skillList = mainService.findAllSkills();
		log.info("skills = {}", skillList);
		mv.addObject("skills", skillList);
		return mv;
	}

	@GetMapping("/SearchJobType")
	public ModelAndView SearchJobType(@RequestParam("keyword") String keyword) {
		ModelAndView mv = new ModelAndView("fragment/searchBox");
		List<PostingDto> lists = mainService.findByKeyword(keyword);

		// 빈 리스트 생성
		List<PostingDto> results = lists != null ? lists : Collections.emptyList();

		// 결과 리스트 추가
		mv.addObject("results", results);

		if (keyword != null) {
			mv.addObject("isSearched", true);
		}
		return mv;
	}

	@GetMapping("/SearchResult")
	public ModelAndView searchResult(@RequestParam("region") String region,@RequestParam("experience") String experience, @RequestParam("selectedSkills") List<Long> selectedSkills, @RequestParam("selectedJobs") List<String> selectedJobs) {
		ModelAndView mv = new ModelAndView("fragment/postResult");
		List<PostingDto> lists = mainService.findPostingBySearchResult(region, experience, selectedSkills, selectedJobs);
		mv.addObject("posts", lists);
		log.info("lists = {}",lists);
		
		List<SkillDto> skillList = mainService.findAllSkills();
		log.info("skills = {}", skillList);
		mv.addObject("skills", skillList);
		
		return mv;
	}
}
