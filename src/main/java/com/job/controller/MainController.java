package com.job.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.job.dto.ApplyDto;
import com.job.dto.ApplyStatusDto;
import com.job.dto.CompanyDto;
import com.job.dto.PersonDto;
import com.job.dto.PostingDto;
import com.job.dto.PostingScrapDto;
import com.job.dto.PostingWithFileDto;
import com.job.dto.ResumeDto;
import com.job.dto.SkillDto;
import com.job.dto.UserDto;
import com.job.service.MainService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {

	@Autowired
	private MainService mainService;

	@GetMapping("/")
	public ModelAndView main(HttpSession session) {
		ModelAndView mv = new ModelAndView("section/main");
		UserDto user = (UserDto) session.getAttribute("login");

		Boolean isLoggedInObj = (Boolean) session.getAttribute("isLoggedIn");
		boolean isLoggedIn = isLoggedInObj != null && isLoggedInObj.booleanValue();

		log.info("isLoggedIn = {}", isLoggedIn);
		log.info("user = {}", user);
		if (isLoggedIn) {
			if (user != null) {
				Long userType = user.getUserType();
				log.info("user = {}", user);
				if (userType == 1) {
					Long userIdx = user.getUserIdx();
					List<PostingWithFileDto> lists = mainService.findPostingsByUserIdx(userIdx);
					log.info("lists = {}", lists);
					mv.addObject("userType", userType);
					mv.addObject("posts", lists);
					return mv;
				} else {
					Long userIdx = user.getUserIdx();
					PersonDto person = mainService.findPersonByUserIdx(userIdx);
					log.info("person = {}", person);
					List<PostingWithFileDto> lists = mainService.findAllPosting();
					List<SkillDto> skillList = mainService.findAllSkills();
					log.info("lists = {}", lists);
					mv.addObject("person", person);
					mv.addObject("userType", userType);
					mv.addObject("skills", skillList);
					mv.addObject("posts", lists);
					return mv;
				}
			}
		} else {
			List<PostingWithFileDto> lists = mainService.findAllPosting();
			log.info("lists = {}", lists);
			List<SkillDto> skillList = mainService.findAllSkills();
			mv.addObject("skills", skillList);
			mv.addObject("posts", lists);
			return mv;
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
	public ModelAndView searchResult(@RequestParam("region") String region,
			@RequestParam("experience") String experience, @RequestParam("selectedSkills") List<Long> selectedSkills,
			@RequestParam("selectedJobs") List<String> selectedJobs) {
		ModelAndView mv = new ModelAndView("fragment/postResult");
		List<PostingWithFileDto> lists = mainService.findPostingBySearchResult(region, experience, selectedSkills,
				selectedJobs);
		mv.addObject("posts", lists);
		log.info("lists = {}", lists);

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
			mainService.deleteScrap(postingScrapDto);
			log.info("postingScrapDto = {}", postingScrapDto);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			log.info("postingScrapDto = {}", postingScrapDto);
			log.error("스크랩 삭제 처리 중 오류 발생", e); // 로그 출력 예
			return ResponseEntity.badRequest().body("스크랩 삭제에 실패했습니다.");
		}
	}

	@GetMapping("/CheckScrap")
	public ResponseEntity<?> checkScrap(@RequestParam("postingIdx") Long postingIdx,
			@RequestParam("personIdx") Long personIdx) {
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

	@GetMapping("/MainPosting/{postingIdx}")
	public ModelAndView mainPosting(@PathVariable("postingIdx") Long postingIdx, HttpSession session) {
		ModelAndView mv = new ModelAndView("section/mainPosting");
		UserDto user = (UserDto) session.getAttribute("login");

		Boolean isLoggedInObj = (Boolean) session.getAttribute("isLoggedIn");
		boolean isLoggedIn = isLoggedInObj != null && isLoggedInObj.booleanValue();

		if (isLoggedIn) {
			if (user != null) {
				Long userType = user.getUserType();
				Long userIdx = user.getUserIdx();
				PersonDto person = mainService.findPersonByUserIdx(userIdx);
				PostingDto posting = mainService.findPostingByPostingIdx(postingIdx);
				Long postingUserIdx = posting.getUserIdx();
				CompanyDto company = mainService.findCompanyByUserIdx(postingUserIdx);
				List<SkillDto> skills = mainService.findSkillListByPostingIdx(postingIdx);
				mv.addObject("userType", userType);
				mv.addObject("company", company);
				mv.addObject("person", person);
				mv.addObject("posting", posting);
				mv.addObject("skills", skills);
				log.info("company = {}", company);
				log.info("posting = {}", posting);
				log.info("skills = {}", skills);
			}
		} else {
			mv.setViewName("redirect:/personlogin");
		}
		return mv;
	}

	@GetMapping("/applyForm/{postingIdx}")
	public ModelAndView applyForm(@PathVariable("postingIdx") Long postingIdx) {
		ModelAndView mv = new ModelAndView("fragment/applyForm");
		Long userIdx = (long) 3;
		PersonDto person = mainService.findPersonByUserIdx(userIdx);
		PostingDto posting = mainService.findPostingByPostingIdx(postingIdx);
		Long postingUserIdx = posting.getUserIdx();
		CompanyDto company = mainService.findCompanyByUserIdx(postingUserIdx);
		List<ResumeDto> resumes = mainService.findResumeByUserIdx(userIdx);
		mv.addObject("company", company);
		mv.addObject("posting", posting);
		mv.addObject("person", person);
		mv.addObject("resumes", resumes);
		return mv;
	}

	@GetMapping("/ResumeSelect")
	public ModelAndView selectResume(@RequestParam("resumeIdx") Long resumeIdx) {
		ModelAndView mv = new ModelAndView("fragment/selectedResume");
		ResumeDto resume = mainService.findResumeByResumeIdx(resumeIdx);
		mv.addObject("resume", resume);
		return mv;
	}

	@PostMapping("/ApplyPosting")
	public ResponseEntity<?> postApply(@RequestBody ApplyDto applyDto) {
		try {
			mainService.insertApply(applyDto);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.badRequest().body("스크랩 추가에 실패했습니다.");
		}
	}

	@GetMapping("/ApplyPage")
	public ModelAndView applyPage(HttpSession session) {
		ModelAndView mv = new ModelAndView("section/apply");
		UserDto user = (UserDto) session.getAttribute("login");
		Long userIdx = user.getUserIdx();
		Long userType = user.getUserType();

		if (userType == 2) {
			PersonDto person = mainService.findPersonByUserIdx(userIdx);
			Long personIdx = person.getPersonIdx();
			List<ApplyStatusDto> applyList = mainService.findApplyList(personIdx);
			mv.addObject("apply", applyList);
		} else {
			if (userType == 1) {

			}
		}

		mv.addObject("userType", userType);
		return mv;
	}

	@DeleteMapping("/Applycancel/{applyIdx}")
	public ResponseEntity<?> cancelApply(@PathVariable("applyIdx") Long applyIdx) {
	    try {
	        log.info("applyIdxs = {}", applyIdx);
	        mainService.deleteAllByApplyIdxs(applyIdx);
	        return ResponseEntity.ok().build();
	    } catch (Exception e) {
	        return ResponseEntity.badRequest().body("지원 취소에 실패했습니다.");
	    }
	}

}