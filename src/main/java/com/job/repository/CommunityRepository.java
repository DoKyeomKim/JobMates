package com.job.repository;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.job.entity.Community;

public interface CommunityRepository extends JpaRepository<Community, Long> {
	
    Optional<Community> findByCommunityIdx(Long community_idx); 
    
}