package com.job.service;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.job.dto.ApplyDto;
import com.job.dto.ApplyStatusDto;
import com.job.dto.CompanyDto;
import com.job.dto.CompanyFileDto;
import com.job.dto.PersonDto;
import com.job.dto.PostingDto;
import com.job.dto.PostingScrapDto;
import com.job.dto.PostingWithFileDto;
import com.job.dto.ResumeDto;
import com.job.dto.SkillDto;
import com.job.entity.Apply;
import com.job.entity.Company;
import com.job.entity.CompanyFile;
import com.job.entity.Person;
import com.job.entity.Posting;
import com.job.entity.PostingScrap;
import com.job.entity.PostingSkill;
import com.job.entity.Resume;
import com.job.entity.Skill;
import com.job.entity.User;
import com.job.repository.ApplyRepository;
import com.job.repository.CompanyRepository;
import com.job.repository.PersonRepository;
import com.job.repository.PostingRepository;
import com.job.repository.PostingScrapRepository;
import com.job.repository.PostingskillRepository;
import com.job.repository.ResumeRepository;
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
	private ResumeRepository resumeRepository;

	@Autowired
	private CompanyRepository companyRepository;

	@Autowired
	private PostingRepository postingRepository;

	@Autowired
	private PostingScrapRepository postingScrapRepository;

	@Autowired
	private SkillRepository skillRepository;

	@Autowired
	private PersonRepository personRepository;

	@Autowired
	private PostingskillRepository postingSkillRepository;

	@Autowired
	private ApplyRepository applyRepository;

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
		Join<CompanyFile, Company> fileCompanyJoin = fileRoot.join("company", JoinType.RIGHT);

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

	public List<PostingWithFileDto> findPostingsByUserIdx(Long userIdx) {
		CriteriaBuilder cb = entityManager.getCriteriaBuilder();
		CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);

		Root<Posting> postingRoot = cq.from(Posting.class);
		Join<Posting, User> postingUserJoin = postingRoot.join("user", JoinType.INNER);
		Join<Posting, Company> postingCompanyJoin = postingRoot.join("user", JoinType.INNER);
		
		Root<Company> companyRoot = cq.from(Company.class);
		Join<Company, User> companyUserJoin = companyRoot.join("user", JoinType.INNER);

		// CompanyFile의 처리를 위한 Root 추가 (가정에 기반한 예시)
		Root<CompanyFile> fileRoot = cq.from(CompanyFile.class);
		Join<CompanyFile, Company> fileCompanyJoin = fileRoot.join("company", JoinType.RIGHT);

		cq.multiselect(postingRoot, fileRoot, companyRoot).where(
				cb.equal(companyRoot.get("companyIdx"), fileCompanyJoin.get("companyIdx")),
				cb.equal(companyUserJoin.get("userIdx"), userIdx),
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
	    CompanyFile file = null;
	    if(result[1] != null) {
	        file = (CompanyFile) result[1]; // result[1]이 null이 아닐 때만 캐스팅
	    }
	    Company com = (Company) result[2];

	    PostingDto postingDto = convertToPostingDto(posting);
	    CompanyFileDto companyFileDto = null;
	    if(file != null) {
	        companyFileDto = convertToCompanyFileDto(file); // file이 null이 아닐 때만 DTO 변환
	    }
	    CompanyDto companyDto = convertToCompanyDto(com);

	    PostingWithFileDto postingWithFileDto = new PostingWithFileDto();
	    postingWithFileDto.setPostingDto(postingDto);
	    postingWithFileDto.setCompanyFileDto(companyFileDto); // file이 null일 경우 companyFileDto도 null
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
		PersonDto personDto = PersonDto.createPersonDto(person);
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
	public void deleteScrap(PostingScrapDto postingScrapDto) {
		Person person = personRepository.findById(postingScrapDto.getPersonIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Person을 찾을 수 없습니다."));
		Posting posting = postingRepository.findById(postingScrapDto.getPostingIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Posting을 찾을 수 없습니다."));

		// PostingScrap 인스턴스 생성 및 설정
		PostingScrap postingScrap = PostingScrap.builder().person(person).posting(posting).build();

		postingScrapRepository.deleteByPostingPostingIdxAndPersonPersonIdx(postingScrap.getPosting().getPostingIdx(),
				postingScrap.getPerson().getPersonIdx());
	}

	public PostingDto findPostingByPostingIdx(Long postingIdx) {
		Optional<Posting> PostingOpt = postingRepository.findPostingByPostingIdx(postingIdx);
		if (!PostingOpt.isPresent()) {
			return null; // 또는 예외 처리
		}
		Posting posting = PostingOpt.get();
		PostingDto postingDto = PostingDto.createPostingDto(posting);
		return postingDto;
	}

	public CompanyDto findCompanyByUserIdx(Long userIdx) {
		Optional<Company> CompanyOpt = companyRepository.findCompanyByUserUserIdx(userIdx);
		if (!CompanyOpt.isPresent()) {
			return null; // 또는 예외 처리
		}
		CompanyDto companyDto = CompanyDto.createCompanyDto(CompanyOpt.get());
		return companyDto;
	}

	public List<SkillDto> findSkillListByPostingIdx(Long postingIdx) {
		List<PostingSkill> postingSkills = postingSkillRepository.findPostinSkillByPostingPostingIdx(postingIdx);
		List<SkillDto> skills = new ArrayList<>();
		for (PostingSkill postingSkill : postingSkills) {
			Skill skill = skillRepository.findById(postingSkill.getSkill().getSkillIdx()).orElse(null);
			if (skill != null) {

				SkillDto skillDto = SkillDto.createSkillDto(skill);
				skills.add(skillDto);
			}
		}
		return skills;
	}

	public List<ResumeDto> findResumeByUserIdx(Long userIdx) {
		List<Resume> resumes = resumeRepository.findByUserUserIdx(userIdx);
		return resumes.stream().map(resume -> ResumeDto.createResumeDto(resume)).collect(Collectors.toList());
	}

	public ResumeDto findResumeByResumeIdx(Long resumeIdx) {
		Optional<Resume> ResumeOpt = resumeRepository.findResumeByResumeIdx(resumeIdx);
		if (!ResumeOpt.isPresent()) {
			return null; // 또는 예외 처리
		}
		ResumeDto resumeDto = ResumeDto.createResumeDto(ResumeOpt.get());
		return resumeDto;
	}

	public void insertApply(ApplyDto applyDto) {
		// personIdx와 postingIdx로 Person과 Posting 인스턴스 찾기
		Resume resume = resumeRepository.findById(applyDto.getResumeIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Resume을 찾을 수 없습니다."));
		Posting posting = postingRepository.findById(applyDto.getPostingIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Posting을 찾을 수 없습니다."));
		Person person = personRepository.findById(applyDto.getPersonIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Person을 찾을 수 없습니다."));
		Company company = companyRepository.findById(applyDto.getCompanyIdx())
				.orElseThrow(() -> new NoSuchElementException("해당 Company를 찾을 수 없습니다."));

		Apply apply = Apply.builder().resume(resume).person(person).posting(posting).company(company)
				.applyStatus((long) 1).build();

		applyRepository.save(apply);
	}

	public List<ApplyStatusDto> findApplyList(Long personIdx) {
		CriteriaBuilder cb = entityManager.getCriteriaBuilder();
		CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);

		Root<Apply> applyRoot = cq.from(Apply.class);
		Join<Apply, Posting> postingJoin = applyRoot.join("posting", JoinType.INNER);
		Join<Apply, Resume> resumeJoin = applyRoot.join("resume", JoinType.INNER);
		Join<Apply, Person> personJoin = applyRoot.join("person", JoinType.INNER);
		Join<Apply, Company> companyJoin = applyRoot.join("company", JoinType.INNER);

		cq.multiselect(postingJoin.get("postingIdx"), postingJoin.get("postingTitle"), resumeJoin.get("resumeIdx"),
				resumeJoin.get("resumeTitle"), applyRoot.get("applyIdx"), applyRoot.get("applyStatus"),
				applyRoot.get("createdDate"), personJoin, companyJoin.get("companyName"))
				.where(cb.equal(personJoin.get("personIdx"), personIdx));

		List<Object[]> results = entityManager.createQuery(cq).getResultList();

		List<ApplyStatusDto> applyStatusDtos = results.stream().map(result -> {
			ApplyStatusDto applyStatusDto = new ApplyStatusDto();

			// 각 DTO 인스턴스 생성
			PostingDto postingDto = PostingDto.builder().postingIdx((Long) result[0]).postingTitle((String) result[1])
					.build();
			ResumeDto resumeDto = ResumeDto.builder().resumeIdx((Long) result[2]).resumeTitle((String) result[3])
					.build();
			ApplyDto applyDto = ApplyDto.builder().applyIdx((Long) result[4]).applyStatus((Long) result[5]).createdDate((String) result[6]).build();
			PersonDto personDto = PersonDto.createPersonDto((Person) result[7]);
			CompanyDto companyDto = CompanyDto.builder().companyName((String) result[8]).build();

			// ApplyStatusDto에 DTO 인스턴스 설정
			applyStatusDto.setApplyDto(applyDto);
			applyStatusDto.setPostingDto(postingDto);
			applyStatusDto.setResumeDto(resumeDto);
			applyStatusDto.setPersonDto(personDto);
			applyStatusDto.setCompanyDto(companyDto);

			return applyStatusDto;
		}).collect(Collectors.toList());

		return applyStatusDtos;
	}

	public void deleteAllByApplyIdxs(Long applyIdx) {
		
		 applyRepository.deleteById(applyIdx);
	}

	public List<ApplyStatusDto> findApplyListByCompanyIdx(Long companyIdx) {
		CriteriaBuilder cb = entityManager.getCriteriaBuilder();
		CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);

		Root<Apply> applyRoot = cq.from(Apply.class);
		Join<Apply, Posting> postingJoin = applyRoot.join("posting", JoinType.INNER);
		Join<Apply, Resume> resumeJoin = applyRoot.join("resume", JoinType.INNER);
		Join<Apply, Person> personJoin = applyRoot.join("person", JoinType.INNER);
		Join<Apply, Company> companyJoin = applyRoot.join("company", JoinType.INNER);

		cq.multiselect(postingJoin.get("postingIdx"), postingJoin.get("postingTitle"), resumeJoin.get("resumeIdx"),
				resumeJoin.get("resumeTitle"), applyRoot.get("applyIdx"), applyRoot.get("applyStatus"),
				applyRoot.get("createdDate"), personJoin, companyJoin.get("companyName"))
				.where(cb.equal(companyJoin.get("companyIdx"), companyIdx));

		List<Object[]> results = entityManager.createQuery(cq).getResultList();

		List<ApplyStatusDto> applyStatusDtos = results.stream().map(result -> {
			ApplyStatusDto applyStatusDto = new ApplyStatusDto();

			// 각 DTO 인스턴스 생성
			PostingDto postingDto = PostingDto.builder().postingIdx((Long) result[0]).postingTitle((String) result[1])
					.build();
			ResumeDto resumeDto = ResumeDto.builder().resumeIdx((Long) result[2]).resumeTitle((String) result[3])
					.build();
			ApplyDto applyDto = ApplyDto.builder().applyIdx((Long) result[4]).applyStatus((Long) result[5]).createdDate((String) result[6]).build();
			PersonDto personDto = PersonDto.createPersonDto((Person) result[7]);
			CompanyDto companyDto = CompanyDto.builder().companyName((String) result[8]).build();

			// ApplyStatusDto에 DTO 인스턴스 설정
			applyStatusDto.setApplyDto(applyDto);
			applyStatusDto.setPostingDto(postingDto);
			applyStatusDto.setResumeDto(resumeDto);
			applyStatusDto.setPersonDto(personDto);
			applyStatusDto.setCompanyDto(companyDto);

			return applyStatusDto;
		}).collect(Collectors.toList());

		return applyStatusDtos;
	}

}
