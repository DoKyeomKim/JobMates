package com.job.dto;

import com.job.entity.Posting;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostingDto {   
	private Long postingIdx;
	private Long userIdx;
	private String postingTitle;
	private String postingComment;
	private String experience;
	private String empType;
	private String salary;
	private String startTime;
	private String endTime;
	private String postingDeadline;
	private String jobType;
	private String createdDate;
	private String postingAddress;
	
	public static PostingDto createPostingDto(Posting posting) {
	    return new PostingDto(
	        posting.getPostingIdx(),
	        posting.getUser().getUserIdx(), // userIdx를 올바른 위치로 이동
	        posting.getPostingTitle(),
	        posting.getPostingComment(),
	        posting.getExperience(),
	        posting.getEmpType(),
	        posting.getSalary(),
	        posting.getStartTime(),
	        posting.getEndTime(),
	        posting.getPostingDeadline(),
	        posting.getJobType(),
	        posting.getCreatedDate(),
	        posting.getPostingAddress()
	    );
	}

}
