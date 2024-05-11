package com.job.repository;


import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.job.entity.Posting;

public interface PostingRepository extends JpaRepository<Posting, Long> {
    
    Optional<Posting> findByPostingIdx(Long posting_idx);
    
    @Query("SELECT p FROM Posting p WHERE p.jobType LIKE %:keyword%")
    List<Posting> findJobTypeByKeyword(@Param("keyword") String keyword);
    
    @Query("SELECT p FROM Posting p WHERE p.jobType IN :selectedJobs AND p.postingAddress LIKE :region AND p.experience LIKE :experience AND p.id IN (SELECT ps.posting.id FROM PostingSkill ps WHERE ps.skill.id IN :selectedSkills)")
    List<Posting> findPostingByConditions(@Param("region") String region, @Param("experience") String experience, @Param("selectedSkills") List<Long> selectedSkills, @Param("selectedJobs") List<String> selectedJobs);
}
