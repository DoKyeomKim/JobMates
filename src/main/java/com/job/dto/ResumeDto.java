package com.job.dto;

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
}
