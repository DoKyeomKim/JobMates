package com.job.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
public class CompanyDto {   
	private Long companyIdx;
	private Long userIdx;
	private String companyName;
	private String companyRepName;
	private String companyPhone;
	private String companyAddress;
	private String companyMgrName;
	private String companyMgrPhone;
	private Long companyEmp;
	private String companySize;
	private String companySector;
	private String companyYear;
}
