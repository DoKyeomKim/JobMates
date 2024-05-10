package com.job.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
public class ReplyDto {   
	private Long replyIdx;
	private Long communityIdx;
	private Long userIdx;
	private String replyName;
	private String replyContent;
	private String createdDate;
	private Long likeCount;
}
