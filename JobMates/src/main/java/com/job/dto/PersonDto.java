package com.job.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
public class PersonDto {   
	private Long personIdx;
	private Long userIdx;
	private String personName;
	private String personPhone;
	private String personAddress;
	private String personBirth;
	private String personEducation;
}
