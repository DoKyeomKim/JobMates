package com.job.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
public class ResumeFileDto {   
	private Long resumeFileIdx;
	private Long resumeIdx;
	private String originalName;
	private String filePath;
	private Long fileSize;
	private String uploadDate;
}
