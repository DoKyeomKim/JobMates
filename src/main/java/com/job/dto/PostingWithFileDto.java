package com.job.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostingWithFileDto {
	private PostingDto postingDto;
    private CompanyFileDto companyFileDto;
    private CompanyDto companyDto;

    
    
}
