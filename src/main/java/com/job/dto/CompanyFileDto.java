package com.job.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
public class CompanyFileDto {   
	private Long companyFileIdx;
	private Long companyIdx;
	private String originalName;
	private String filePath;
	private Long fileSize;
	private String uploadDate;
}
