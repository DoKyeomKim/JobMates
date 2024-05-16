package com.job.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApplyDto {   
	private Long applyIdx;
	private Long postingIdx;
	private Long resumeIdx;
	private String createdDate;
	private Long applyStatus;
	private Long personIdx;
	private Long companyIdx;
}
