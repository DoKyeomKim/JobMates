package com.job.dto;

import com.job.entity.Resume;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResumeDto {   
	private Long resumeIdx;
	private Long userIdx;
	private String resumeTitle;
	private String portfolio;
	private Long publish;
	private String resumeComment;
	private String createdDate;
	
	public static ResumeDto createResumeDto(Resume resume) {
		return new ResumeDto(
				resume.getResumeIdx(),
				resume.getUser().getUserIdx(),
				resume.getResumeTitle(),
				resume.getPortfolio(),
				resume.getPublish(),
				resume.getResumeComment(),
				resume.getCreatedDate()
				);
	}

}
