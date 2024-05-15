package com.job.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
public class CommunityDto {   
	private Long communityIdx;
	private String communityTitle;
	private Long userIdx;
	private String communityName;
	private String communityContent;
	private String createdDate;
	private Long viewCount;
	private Long likeCount;
	private Long replyCount;
}
