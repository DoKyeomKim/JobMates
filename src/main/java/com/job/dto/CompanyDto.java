package com.job.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
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
	private String userEmail;
	private String userType;
}
