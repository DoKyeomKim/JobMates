package com.job.dto;
import com.job.entity.Person;

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
	private String personEducation;
	private String userEmail;
	
	public static PersonDto createPersonDto(Person person) {
		return new PersonDto(person.getPersonIdx(), person.getUser().getUserIdx(), 
				person.getPersonName(), person.getPersonPhone(), person.getPersonAddress(), person.getPersonBirth(),
				person.getPersonEducation(),person.getUser().getUserEmail());
	}
	
}