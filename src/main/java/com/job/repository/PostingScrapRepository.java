package com.job.repository;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.job.entity.Person;
import com.job.entity.Posting;
import com.job.entity.PostingScrap;

public interface PostingScrapRepository extends JpaRepository<PostingScrap, Long> {
    
    Optional<PostingScrap> findByPostingPostingIdx(Long posting_idx);

	long countByPersonPersonIdxAndPostingPostingIdx(Long personIdx, Long postingIdx);

	void deleteByPostingPostingIdx(Long postingIdx);

	Optional<PostingScrap> findByPersonAndPosting(Person person, Posting posting);

	void deleteByPostingPostingIdxAndPersonPersonIdx(Long postingIdx, Long personIdx);

}
