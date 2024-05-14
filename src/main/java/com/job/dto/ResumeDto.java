package com.job.dto;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
public class ResumeDto {   
	private Long resumeIdx;
	private Long userIdx;
	private String resumeTitle;
	private String portfolio;
	private Long publish;
	private String resumeComment;
	private String createdDate;
	public void setCreatedDate(Date date) {
		// TODO Auto-generated method stub
		
	}
}
