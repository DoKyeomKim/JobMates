package com.job.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
public class PostingDto {   
	private Long postingIdx;
	private Long userIdx;
	private String postingTitle;
	private String postingComment;
	private String experience;
	private String empType;
	private String salary;
	private String startTime;
	private String endTime;
	private String postingDeadline;
	private String jobType;
	private String createdDate;
	private String postingAddress;
}
