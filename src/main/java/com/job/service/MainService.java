package com.job.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.job.dto.PostingDto;
import com.job.dto.SkillDto;
import com.job.entity.Posting;
import com.job.entity.Skill;
import com.job.repository.PostingRepository;
import com.job.repository.SkillRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MainService {

	@Autowired
	private PostingRepository postingRepository;
	@Autowired
	private SkillRepository skillRepository;
	
	@PersistenceContext
	private EntityManager entityManager;

	public List<PostingDto> findByKeyword(String keyword) {
		List<Posting> postings = postingRepository.findJobTypeByKeyword(keyword);
		return postings.stream().map(posting -> PostingDto.createPostingDto(posting)) // Posting 엔티티를 PostingDto로 변환
				.collect(Collectors.toList());
	}

	public List<SkillDto> findAllSkills() {
		List<Skill> skillList = skillRepository.findAll();
		return skillList.stream().map(skill -> SkillDto.createSkillDto(skill)).collect(Collectors.toList());
	}

	public List<PostingDto> findPostingBySearchResult(String region, String experience, List<Long> selectedSkills, List<String> selectedJobs) {
	    CriteriaBuilder cb = entityManager.getCriteriaBuilder();
	    CriteriaQuery<Posting> cq = cb.createQuery(Posting.class);

	    Root<Posting> postingRoot = cq.from(Posting.class);
	    List<Predicate> predicates = new ArrayList<>();

	    // 지역 조건 추가
	    if (region != null && !region.equals("전국")) {
	        predicates.add(cb.like(postingRoot.get("postingAddress"), "%" + region + "%"));
	    }

	    // 경험 조건 추가
	    if (experience != null && !experience.equals("무관")) {
	        predicates.add(cb.like(postingRoot.get("experience"), "%" + experience + "%"));
	    }

	    // selectedSkills 조건 처리
	    if (selectedSkills != null && !selectedSkills.isEmpty()) {
	        predicates.add(postingRoot.get("id").in(
	            entityManager.createQuery("SELECT ps.posting.id FROM PostingSkill ps WHERE ps.skill.id IN :selectedSkills")
	                .setParameter("selectedSkills", selectedSkills)
	                .getResultList()
	        ));
	    }

	    // selectedJobs 조건 처리
	    if (selectedJobs != null && !selectedJobs.isEmpty()) {
	        predicates.add(postingRoot.get("jobType").in(selectedJobs));
	    }

	    cq.where(cb.and(predicates.toArray(new Predicate[0])));
	    List<Posting> result = entityManager.createQuery(cq).getResultList();

	    // Posting 엔티티를 PostingDto 객체로 변환
	    List<PostingDto> dtoList = result.stream().map(posting -> PostingDto.createPostingDto(posting)).collect(Collectors.toList());

	    return dtoList;
	}



}
