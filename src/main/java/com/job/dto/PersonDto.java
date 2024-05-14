package com.job.dto;




import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PersonDto {   
	private Long personIdx;
	private Long userIdx;
	private String personName;
	private String personPhone;
	private String personAddress;
	private String personBirth;

	private String userEmail;

}
