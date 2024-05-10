package com.job.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.job.dto.PostingDto;
import com.job.entity.Posting;
import com.job.repository.PostingRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MainService {

	@Autowired
	private PostingRepository postingRepository;

	public List<PostingDto> findByKeyword(String keyword) {
		List<Posting> postings = postingRepository.findByKeyword(keyword);
		return postings.stream().map(posting -> PostingDto.createPostingDto(posting)) // Posting 엔티티를 PostingDto로 변환
				.collect(Collectors.toList());
	}
	
    
}
