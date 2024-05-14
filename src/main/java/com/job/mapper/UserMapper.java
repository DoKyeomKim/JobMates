package com.job.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.job.dto.UserDto;

@Mapper
public interface UserMapper {

	void insertUser(UserDto userDto);







	






	UserDto login(String userId, String userPw);














	HashMap<String, Object> getUser(UserDto userDto);


































}
