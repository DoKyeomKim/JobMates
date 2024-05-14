package com.job.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.job.dto.PersonDto;
import com.job.dto.UserDto;

@Mapper
public interface MypageMapper {

	PersonDto getPerson(PersonDto personDto);

	void updatePerson(PersonDto personDto);

	PersonDto getPersonByUserIdx(Long userIdx);
	
	

}
