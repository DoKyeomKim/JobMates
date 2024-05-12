package com.job.service;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.job.dto.CompanyDto;
import com.job.dto.CompanyFileDto;
import com.job.dto.PersonDto;
import com.job.dto.PostingDto;
import com.job.dto.PostingScrapDto;
import com.job.dto.PostingWithFileDto;
import com.job.dto.SkillDto;
import com.job.entity.Company;
import com.job.entity.CompanyFile;
import com.job.entity.Person;
import com.job.entity.Posting;
import com.job.entity.PostingScrap;
import com.job.entity.Skill;
import com.job.entity.User;
import com.job.repository.PersonRepository;
import com.job.repository.PostingRepository;
import com.job.repository.PostingScrapRepository;
import com.job.repository.SkillRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MainService {

	@Autowired
	private PostingRepository postingRepository;

	@Autowired
	private PostingScrapRepository postingScrapRepository;

	@Autowired
	private SkillRepository skillRepository;

	@Autowired
	private PersonRepository personRepository;

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

	public List<PostingWithFileDto> findPostingBySearchResult(String region, String experience,
			List<Long> selectedSkills, List<String> selectedJobs) {
		CriteriaBuilder cb = entityManager.getCriteriaBuilder();
		CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);

		// Posting의 처리
		Root<Posting> postingRoot = cq.from(Posting.class);
		Join<Posting, User> postingUserJoin = postingRoot.join("user", JoinType.INNER);

		// Company와 CompanyFile의 처리
		Root<Company> companyRoot = cq.from(Company.class);
		Join<Company, User> companyUserJoin = companyRoot.join("user", JoinType.INNER);

		Root<CompanyFile> fileRoot = cq.from(CompanyFile.class);
		Join<CompanyFile, Company> fileCompanyJoin = fileRoot.join("company", JoinType.INNER);

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
			predicates.add(postingRoot.get("id").in(entityManager
					.createQuery("SELECT ps.posting.id FROM PostingSkill ps WHERE ps.skill.id IN :selectedSkills")
					.setParameter("selectedSkills", selectedSkills).getResultList()));
		}

		// selectedJobs 조건 처리
		if (selectedJobs != null && !selectedJobs.isEmpty()) {
			predicates.add(postingRoot.get("jobType").in(selectedJobs));
		}

		predicates.add(cb.equal(companyUserJoin.get("userIdx"), postingUserJoin.get("userIdx")));
		predicates.add(cb.equal(companyRoot.get("companyIdx"), fileCompanyJoin.get("companyIdx")));

		cq.multiselect(postingRoot, fileRoot, companyRoot).where(cb.and(predicates.toArray(new Predicate[0])));

		cq.where(cb.and(predicates.toArray(new Predicate[0])));
		List<Object[]> results = entityManager.createQuery(cq).getResultList();
		List<PostingWithFileDto> postingWithFileDtos = new ArrayList<>();
		for (Object[] result : results) {
			PostingWithFileDto postingWithFileDto = buildPostingWithFileDto(result);
			postingWithFileDtos.add(postingWithFileDto);
		}
		return postingWithFileDtos;
	}

	public List<PostingWithFileDto> findAllPosting() {
		CriteriaBuilder cb = entityManager.getCriteriaBuilder();
		CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);

		Root<Company> companyRoot = cq.from(Company.class);
		Join<Company, User> companyUserJoin = companyRoot.join("user", JoinType.INNER);

		Root<Posting> postingRoot = cq.from(Posting.class);
		Join<Posting, User> postingUserJoin = postingRoot.join("user", JoinType.INNER);

		// CompanyFile의 처리를 위한 Root 추가 (가정에 기반한 예시)
		Root<CompanyFile> fileRoot = cq.from(CompanyFile.class);
		Join<CompanyFile, Company> fileCompanyJoin = fileRoot.join("company", JoinType.INNER);

		cq.multiselect(postingRoot, fileRoot, companyRoot).where(
				cb.equal(companyUserJoin.get("userIdx"), postingUserJoin.get("userIdx")),
				cb.equal(companyRoot.get("companyIdx"), fileCompanyJoin.get("companyIdx"))); // Company와 CompanyFile을 연결

		List<Object[]> results = entityManager.createQuery(cq).getResultList();

		List<PostingWithFileDto> postingWithFileDtos = new ArrayList<>();
		for (Object[] result : results) {
			PostingWithFileDto postingWithFileDto = buildPostingWithFileDto(result);
			postingWithFileDtos.add(postingWithFileDto);
		}
		return postingWithFileDtos;
	}

	public List<PostingWithFileDto> findPostingByUserIdx(Long userIdx) {
		CriteriaBuilder cb = entityManager.getCriteriaBuilder();
		CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);

		Root<Company> companyRoot = cq.from(Company.class);
		Join<Company, User> companyUserJoin = companyRoot.join("user", JoinType.INNER);

		Root<Posting> postingRoot = cq.from(Posting.class);
		Join<Posting, User> postingUserJoin = postingRoot.join("user", JoinType.INNER);

		// CompanyFile의 처리를 위한 Root 추가 (가정에 기반한 예시)
		Root<CompanyFile> fileRoot = cq.from(CompanyFile.class);
		Join<CompanyFile, Company> fileCompanyJoin = fileRoot.join("company", JoinType.INNER);

		cq.multiselect(postingRoot, fileRoot, companyRoot).where(
				cb.equal(companyUserJoin.get("userIdx"), postingUserJoin.get("userIdx")),
				cb.equal(companyRoot.get("companyIdx"), fileCompanyJoin.get("companyIdx")),
				cb.equal(postingUserJoin.get("userIdx"), userIdx)); // Company와 CompanyFile을 연결

		List<Object[]> results = entityManager.createQuery(cq).getResultList();

		List<PostingWithFileDto> postingWithFileDtos = new ArrayList<>();
		for (Object[] result : results) {
			PostingWithFileDto postingWithFileDto = buildPostingWithFileDto(result);
			postingWithFileDtos.add(postingWithFileDto);
		}
		return postingWithFileDtos;
	}

	private PostingWithFileDto buildPostingWithFileDto(Object[] result) {
		Posting posting = (Posting) result[0];
		CompanyFile file = (CompanyFile) result[1];
		Company com = (Company) result[2];

		PostingDto postingDto = convertToPostingDto(posting);
		CompanyFileDto companyFileDto = convertToCompanyFileDto(file);
		CompanyDto companyDto = convertToCompanyDto(com);

		PostingWithFileDto postingWithFileDto = new PostingWithFileDto();
		postingWithFileDto.setPostingDto(postingDto);
		postingWithFileDto.setCompanyFileDto(companyFileDto);
		postingWithFileDto.setCompanyDto(companyDto);

		return postingWithFileDto;
	}

	private PostingDto convertToPostingDto(Posting posting) {
		PostingDto postingDto = new PostingDto();
		postingDto.setPostingIdx(posting.getPostingIdx());
		postingDto.setUserIdx(posting.getUser().getUserIdx());
		postingDto.setPostingTitle(posting.getPostingTitle());
		postingDto.setSalary(posting.getSalary());
		postingDto.setCreatedDate(posting.getCreatedDate());
		postingDto.setEmpType(posting.getEmpType());
		return postingDto;
	}

	private CompanyFileDto convertToCompanyFileDto(CompanyFile file) {
		CompanyFileDto companyFileDto = new CompanyFileDto();
		companyFileDto.setCompanyFileIdx(file.getCompanyFileIdx());
		companyFileDto.setCompanyIdx(file.getCompany().getCompanyIdx());
		companyFileDto.setOriginalName(file.getOriginalName());
		companyFileDto.setFilePath(file.getFilePath());
		companyFileDto.setFileSize(file.getFileSize());
		companyFileDto.setUploadDate(file.getUploadDate());
		return companyFileDto;
	}

	private CompanyDto convertToCompanyDto(Company com) {
		CompanyDto companyDto = new CompanyDto();
		companyDto.setCompanyName(com.getCompanyName());
		return companyDto;
	}

	public PersonDto findPersonByUserIdx(Long userIdx) {
		Optional<Person> personOpt = personRepository.findByUserUserIdx(userIdx);
		if (!personOpt.isPresent()) {
			return null; // 또는 예외 처리
		}
		Person person = personOpt.get();
		PersonDto personDto = new PersonDto(person.getPersonIdx(), person.getUser().getUserIdx(), // User 객체에서 Id 값을 가져옴
				person.getPersonName(), person.getPersonPhone(), person.getPersonAddress(), person.getPersonBirth(),
				person.getPersonEducation());
		return personDto;
	}

	public Long countPostingScrap(Long personIdx, Long postingIdx) {
		long postingScrapCount = postingScrapRepository.countByPersonPersonIdxAndPostingPostingIdx(personIdx,
				postingIdx);
		return postingScrapCount;
	}

	public void insertPostingScrap(PostingScrapDto postingScrapDto) {
		// personIdx와 postingIdx로 Person과 Posting 인스턴스 찾기
		Person person = personRepository.findById(postingScrapDto.getPersonIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Person을 찾을 수 없습니다."));
		Posting posting = postingRepository.findById(postingScrapDto.getPostingIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Posting을 찾을 수 없습니다."));

		// PostingScrap 인스턴스 생성 및 설정
		PostingScrap postingScrap = PostingScrap.builder().person(person).posting(posting).build();

		postingScrapRepository.save(postingScrap);
	}
	@Transactional
	public void deletePostingScrap(PostingScrapDto postingScrapDto) {
		Person person = personRepository.findById(postingScrapDto.getPersonIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Person을 찾을 수 없습니다."));
		
		Posting posting = postingRepository.findById(postingScrapDto.getPostingIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Posting을 찾을 수 없습니다."));
		
		// PostingScrap 인스턴스 생성 및 설정
		PostingScrap postingScrap = PostingScrap.builder().person(person).posting(posting).build();
		
		postingScrapRepository.delete(postingScrap);
	}

}
