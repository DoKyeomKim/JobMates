package com.job.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UserDto {   
	private Long userIdx;
	private String userId;
	private String userPw;
	private Long userType;
	private String userEmail;
	private String createdDate;
}
