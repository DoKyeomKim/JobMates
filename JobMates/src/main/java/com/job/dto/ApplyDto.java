package com.job.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
public class ApplyDto {   
	private Long applyIdx;
	private Long personIdx;
	private Long postingIdx;
	private Long resumeIdx;
	private String createdDate;
	private Long applyStatus;
}
