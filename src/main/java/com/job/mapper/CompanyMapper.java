package com.job.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.job.dto.CompanyDto;

@Mapper
public interface CompanyMapper {

	void insertCompany(CompanyDto companyDto);





}
