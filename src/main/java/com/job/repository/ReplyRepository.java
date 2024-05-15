package com.job.repository;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.job.entity.Reply;

public interface ReplyRepository extends JpaRepository<Reply, Long> {
	
    Optional<Reply> findByReplyIdx(Long reply_idx); 
    
}