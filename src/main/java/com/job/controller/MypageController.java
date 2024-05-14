package com.job.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.job.dto.PersonDto;
import com.job.dto.UserDto;
import com.job.mapper.MypageMapper;
import com.job.mapper.UserMapper;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MypageController {
	@Autowired
	private MypageMapper mypageMapper;
	// 공고 관리 페이지
	@RequestMapping("/mypage")
	public ModelAndView  mypage(HttpSession session) {
		UserDto user = (UserDto) session.getAttribute("login");

		ModelAndView mv = new ModelAndView();
		Boolean isLoggedInObj = (Boolean) session.getAttribute("isLoggedIn");
		boolean isLoggedIn = isLoggedInObj != null && isLoggedInObj.booleanValue();
		if (isLoggedIn) {
			if (user != null) {
				Long userType = user.getUserType();
				Long userIdx = user.getUserIdx();
				PersonDto persondto = mypageMapper.getPersonByUserIdx(userIdx);
				mv.addObject("persondto", persondto);
				mv.addObject("userType", userType);
				mv.setViewName("section/mypage");
				return mv;
			}
		} else {
			mv.setViewName("redirect:/personlogin");
			return mv;
		}
		
		
		return mv; 
	}
	
	@RequestMapping("/mypageUpdateForm")
	public ModelAndView mypageUpdateForm(PersonDto personDto) {
		Long personIdx = (long) 1;
		personDto.setPersonIdx(personIdx);
		
		PersonDto persondto = mypageMapper.getPerson(personDto);
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("persondto", persondto);
		mv.setViewName("section/mypageUpdateForm");
		return mv; 
	}
	
	
	@PostMapping("/mypageUpdate")
	public ModelAndView mypageUpdate(PersonDto personDto) {
	    Long personIdx = (long) 1;
	    personDto.setPersonIdx(personIdx);

	    // 업데이트 메서드 호출 (반환 유형이 int 또는 void로 변경되었다고 가정)
	    mypageMapper.updatePerson(personDto);

	    // 필요하다면 업데이트된 정보 재조회 로직 추가
	    // 예: PersonDto updatedPersonDto = someService.findPersonById(personIdx);

	    ModelAndView mv = new ModelAndView();
	    mv.addObject("persondto", personDto); // 업데이트된 정보를 모델에 추가
	    mv.setViewName("redirect:/mypage");
	    return mv;
	}
	
	
	
	

	

}

















