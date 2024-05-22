package com.job;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.web.servlet.ModelAndView;

import com.job.controller.MainController;
import com.job.dto.PersonDto;
import com.job.dto.PostingWithFileDto;
import com.job.dto.SkillDto;
import com.job.dto.UserDto;
import com.job.entity.Company;
import com.job.entity.CompanyFile;
import com.job.entity.Posting;
import com.job.entity.Skill;
import com.job.repository.SkillRepository;
import com.job.service.MainService;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import jakarta.servlet.http.HttpSession;

@SpringBootTest
class JobMatesApplicationTests {
	@InjectMocks
    private MainController mainController;

    @Mock
    private MainService mainService;

    @Mock
    private SkillRepository skillRepository;
    @Mock
    private HttpSession session;

    @Mock
    private EntityManager entityManager;

    @Mock
    private CriteriaBuilder criteriaBuilder;

    @Mock
    private CriteriaQuery<Object[]> criteriaQuery;

    @Mock
    private Root<Posting> postingRoot;

    @Mock
    private Root<Company> companyRoot;

    @Mock
    private Root<CompanyFile> fileRoot;

    private TypedQuery<Object[]> typedQuery;
    
    @BeforeEach
    public void setUp() {
        when(entityManager.getCriteriaBuilder()).thenReturn(criteriaBuilder);
        when(criteriaBuilder.createQuery(Object[].class)).thenReturn(criteriaQuery);
        when(criteriaQuery.from(Posting.class)).thenReturn(postingRoot);
        when(criteriaQuery.from(Company.class)).thenReturn(companyRoot);
        when(criteriaQuery.from(CompanyFile.class)).thenReturn(fileRoot);

        // Create a mock TypedQuery
        typedQuery = mock(TypedQuery.class);
        when(entityManager.createQuery(criteriaQuery)).thenReturn(typedQuery);
    }

    @Test
    public void testMain_userLoggedInAndUserType1() {
        UserDto user = new UserDto();
        user.setUserType(1L);
        user.setUserIdx(1L);

        List<PostingWithFileDto> mockPostings = new ArrayList<>();
        mockPostings.add(new PostingWithFileDto());
        when(session.getAttribute("isLoggedIn")).thenReturn(true);
        when(session.getAttribute("login")).thenReturn(user);
        when(mainService.findPostingsByUserIdx(1L)).thenReturn(mockPostings);

        ModelAndView mv = mainController.main(session);

        assertEquals("section/main", mv.getViewName());
        assertEquals(1L, mv.getModel().get("userType"));
        assertNotNull(mv.getModel().get("posts"));
        assertEquals(1, ((List<?>) mv.getModel().get("posts")).size()); // 추가 검증: 리스트의 크기 확인
    }

    @Test
    public void testMain_userLoggedInAndUserTypeNot1() {
        UserDto user = new UserDto();
        user.setUserType(2L);
        user.setUserIdx(1L);

        PersonDto mockPerson = new PersonDto();
        List<PostingWithFileDto> mockPostings = new ArrayList<>();
        mockPostings.add(new PostingWithFileDto());
        List<SkillDto> mockSkills = new ArrayList<>();
        mockSkills.add(new SkillDto());
        when(session.getAttribute("isLoggedIn")).thenReturn(true);
        when(session.getAttribute("login")).thenReturn(user);
        when(mainService.findPersonByUserIdx(1L)).thenReturn(mockPerson);
        when(mainService.findAllPosting()).thenReturn(mockPostings);
        when(mainService.findAllSkills()).thenReturn(mockSkills);

        ModelAndView mv = mainController.main(session);

        assertEquals("section/main", mv.getViewName());
        assertEquals(2L, mv.getModel().get("userType"));
        assertNotNull(mv.getModel().get("person"));
        assertNotNull(mv.getModel().get("skills"));
        assertNotNull(mv.getModel().get("posts"));
        assertEquals(1, ((List<?>) mv.getModel().get("skills")).size()); // 추가 검증: 스킬 리스트의 크기 확인
        assertEquals(1, ((List<?>) mv.getModel().get("posts")).size());  // 추가 검증: 포스팅 리스트의 크기 확인
    }

    @Test
    public void testMain_userNotLoggedIn() {
        when(session.getAttribute("isLoggedIn")).thenReturn(false);
        when(mainService.findAllPosting()).thenReturn(new ArrayList<>());
        when(mainService.findAllSkills()).thenReturn(new ArrayList<>());

        ModelAndView mv = mainController.main(session);

        assertEquals("section/main", mv.getViewName());
        assertNotNull(mv.getModel().get("skills"));
        assertNotNull(mv.getModel().get("posts"));
    }

    @Test
    public void testFindPostingsByUserIdx() throws Exception {
        Long userIdx = 1L;

        // 리플렉션을 사용하여 Posting 객체 생성
        Constructor<Posting> constructor = Posting.class.getDeclaredConstructor();
        constructor.setAccessible(true);
        Posting posting = constructor.newInstance();

        CompanyFile file = new CompanyFile();
        Company company = new Company();

        List<Object[]> mockResults = new ArrayList<>();
        mockResults.add(new Object[] {posting, file, company});
        
        // Mocking the EntityManager and related objects...
        // ...

        List<PostingWithFileDto> results = mainService.findPostingsByUserIdx(userIdx);

        assertNotNull(results);
        assertEquals(1, results.size()); // 추가 검증: 결과 리스트의 크기 확인
        // 추가 검증: 결과의 필드 값 확인
        PostingWithFileDto dto = results.get(0);
        assertNotNull(dto.getPostingDto());
        assertNotNull(dto.getCompanyFileDto());
        assertNotNull(dto.getCompanyDto());
    }

    @Test
    public void testFindAllSkills() {
        List<Skill> skillList = new ArrayList<>();
        Skill skill = new Skill();
        skillList.add(skill);
        when(skillRepository.findAll()).thenReturn(skillList);

        List<SkillDto> results = mainService.findAllSkills();

        assertNotNull(results);
        assertEquals(1, results.size()); // 추가 검증: 결과 리스트의 크기 확인
        // 추가 검증: 결과의 필드 값 확인
        SkillDto skillDto = results.get(0);
        assertEquals(skill.getSkillIdx(), skillDto.getSkillIdx());
        // 다른 필드들에 대한 검증 추가...
    }

    @Test
    public void testFindPostingBySearchResult() throws Exception {
        String region = "Seoul";
        String experience = "3 years";
        List<Long> selectedSkills = List.of(1L, 2L);
        List<String> selectedJobs = List.of("Developer");

        // 리플렉션을 사용하여 Posting 객체 생성
        Constructor<Posting> postingConstructor = Posting.class.getDeclaredConstructor();
        postingConstructor.setAccessible(true);
        Posting posting = postingConstructor.newInstance();

        Constructor<CompanyFile> companyFileConstructor = CompanyFile.class.getDeclaredConstructor();
        companyFileConstructor.setAccessible(true);
        CompanyFile companyFile = companyFileConstructor.newInstance();

        Constructor<Company> companyConstructor = Company.class.getDeclaredConstructor();
        companyConstructor.setAccessible(true);
        Company company = companyConstructor.newInstance();

        List<Object[]> mockResults = new ArrayList<>();
        mockResults.add(new Object[]{posting, companyFile, company});
        when(entityManager.createQuery(criteriaQuery).getResultList()).thenReturn(mockResults);

        List<PostingWithFileDto> results = mainService.findPostingBySearchResult(region, experience, selectedSkills, selectedJobs);

        assertNotNull(results);
        assertEquals(1, results.size()); // 추가 검증: 결과 리스트의 크기 확인
        // 추가 검증: 결과의 필드 값 확인
        PostingWithFileDto dto = results.get(0);
        assertNotNull(dto.getPostingDto());
        assertNotNull(dto.getCompanyFileDto());
        assertNotNull(dto.getCompanyDto());
    }

    @Test
    public void testFindAllPosting() throws Exception {
        // Use reflection to create Posting, CompanyFile, and Company instances
        Constructor<Posting> postingConstructor = Posting.class.getDeclaredConstructor();
        postingConstructor.setAccessible(true);
        Posting posting = postingConstructor.newInstance();

        Constructor<CompanyFile> companyFileConstructor = CompanyFile.class.getDeclaredConstructor();
        companyFileConstructor.setAccessible(true);
        CompanyFile companyFile = companyFileConstructor.newInstance();

        Constructor<Company> companyConstructor = Company.class.getDeclaredConstructor();
        companyConstructor.setAccessible(true);
        Company company = companyConstructor.newInstance();

        List<Object[]> mockResults = new ArrayList<>();
        mockResults.add(new Object[]{posting, companyFile, company});
        when(typedQuery.getResultList()).thenReturn(mockResults);

        List<PostingWithFileDto> results = mainService.findAllPosting();

        assertNotNull(results);
        assertEquals(1, results.size()); // Verify the size of the result list
        // Verify the fields of the result
        PostingWithFileDto dto = results.get(0);
        assertNotNull(dto.getPostingDto());
        assertNotNull(dto.getCompanyFileDto());
        assertNotNull(dto.getCompanyDto());
    }
}