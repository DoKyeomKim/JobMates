package com.job.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class UserDto {   
	private Long userIdx;
	private String userId;
	private String userPw;
	private Long userType;
	private String createdDate;
	private String userEmail;
}
