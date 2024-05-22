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
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
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
    
    @SuppressWarnings("unchecked")
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
        // Mock 스킬 목록 생성
        List<Skill> mockSkillList = new ArrayList<>();
        mockSkillList.add(Skill.builder().skillIdx(1L).skillName("Digital Marketing").build());
        mockSkillList.add(Skill.builder().skillIdx(2L).skillName("Java").build());
        mockSkillList.add(Skill.builder().skillIdx(3L).skillName("JavaScript").build());
        mockSkillList.add(Skill.builder().skillIdx(4L).skillName("Python").build());
        mockSkillList.add(Skill.builder().skillIdx(5L).skillName("React").build());
        mockSkillList.add(Skill.builder().skillIdx(6L).skillName("SQL").build());

        // skillRepository.findAll()이 호출될 때 Mock 스킬 목록을 반환하도록 설정
        when(skillRepository.findAll()).thenReturn(mockSkillList);

        // 메인 서비스의 findAllSkills() 메서드 호출
        List<SkillDto> results = mainService.findAllSkills();
        
        System.out.println("results = "+results);
  
        // 결과가 null이 아닌지 확인
        assertNotNull(results);

        // 결과 리스트의 크기가 6인지 확인
        assertEquals(6, results.size());

        // 결과의 필드 값이 올바른지 확인
        for (int i = 0; i < 6; i++) {
            SkillDto skillDto = results.get(i);
            assertEquals((long) (i + 1), skillDto.getSkillIdx());
            assertEquals(mockSkillList.get(i).getSkillName(), skillDto.getSkillName());
        }
    }




    @Test
    public void testFindPostingBySearchResult() {
        String region = "부산";
        String experience = "신입";
        List<Long> selectedSkills = List.of(1L);
        List<String> selectedJobs = List.of("웹프로그래머");

        Posting mockPosting = mock(Posting.class);
        CompanyFile mockCompanyFile = mock(CompanyFile.class);
        Company mockCompany = mock(Company.class);
        
        
        List<Object[]> mockResults = new ArrayList<>();
        mockResults.add(new Object[]{mockPosting, mockCompanyFile, mockCompany});
        when(entityManager.createQuery(criteriaQuery).getResultList()).thenReturn(mockResults);
        List<PostingWithFileDto> results = mainService.findPostingBySearchResult(region, experience, selectedSkills, selectedJobs);
        assertNotNull(results);
        assertEquals(1, results.size()); 
        PostingWithFileDto dto = results.get(0);
        assertNotNull(dto.getPostingDto());
        assertNotNull(dto.getCompanyFileDto());
        assertNotNull(dto.getCompanyDto());
    }

    @Test
    public void testFindAllPosting() throws Exception {
    	
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
        assertEquals(1, results.size()); 
        PostingWithFileDto dto = results.get(0);
        assertNotNull(dto.getPostingDto());
        assertNotNull(dto.getCompanyFileDto());
        assertNotNull(dto.getCompanyDto());
    }
}