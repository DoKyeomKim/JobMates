package com.job.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.job.dto.PersonDto;
import com.job.dto.PostingDto;
import com.job.dto.PostingScrapDto;
import com.job.dto.PostingWithFileDto;
import com.job.dto.SkillDto;
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
		Long userType= (long) 2;
		
		if(userType == 1) {
			Long userIdx = (long) 1;
			List<PostingWithFileDto> lists = mainService.findPostingByUserIdx(userIdx);
			log.info("lists = {}", lists);
			mv.addObject("userType", userType);
			mv.addObject("posts", lists);
		} else {
			Long userIdx = (long) 3;
			PersonDto person = mainService.findPersonByUserIdx(userIdx);
			log.info("person = {}",person);
			List<PostingWithFileDto> lists = mainService.findAllPosting();
			List<SkillDto> skillList = mainService.findAllSkills();
			log.info("lists = {}", lists);
			mv.addObject("person", person);
			mv.addObject("userType", userType);
			mv.addObject("skills", skillList);
			mv.addObject("posts", lists);
		}
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
		List<PostingWithFileDto> lists = mainService.findPostingBySearchResult(region, experience, selectedSkills, selectedJobs);
		mv.addObject("posts", lists);
		log.info("lists = {}",lists);
		
		List<SkillDto> skillList = mainService.findAllSkills();
		log.info("skills = {}", skillList);
		mv.addObject("skills", skillList);
		
		return mv;
	}
	
	@PostMapping("/ScrapAdd")
	public ResponseEntity<?> addScrap(@RequestBody PostingScrapDto postingScrapDto) {
		try {
			mainService.insertPostingScrap(postingScrapDto);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.badRequest().body("스크랩 추가에 실패했습니다.");
		}
	}

	@DeleteMapping("/ScrapDelete")
	public ResponseEntity<?> deleteScrap(@RequestBody PostingScrapDto postingScrapDto) {
		try {
			mainService.deletePostingScrap(postingScrapDto);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.badRequest().body("스크랩 삭제에 실패했습니다.");
		}
	}

	@GetMapping("/CheckScrap")
	public ResponseEntity<?> checkScrap(@RequestParam("postingIdx") Long postingIdx, @RequestParam("personIdx") Long personIdx) {
		Long scarapCount = mainService.countPostingScrap(personIdx, postingIdx);
		try {

			if (scarapCount != 0) {
				boolean isScraped = true;
				return ResponseEntity.ok(isScraped);
			} else {
				boolean isScraped = false;
				return ResponseEntity.ok(isScraped);
			}

		} catch (Exception e) {
			return ResponseEntity.badRequest().body("스크랩 상태 확인에 실패했습니다.");
		}
	}
	
	
}
