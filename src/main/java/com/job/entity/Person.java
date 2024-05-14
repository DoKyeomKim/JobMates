package com.job.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Builder;
import lombok.Getter;

@Table(name = "PERSON_TB")  //  table 이름과 클래스 이름이 다를때 사용 (oracle은 user table 못만듬)
@Getter
@Entity
@Builder
@SequenceGenerator(name="PERSON_SEQ_GENERATOR", 
sequenceName   = "PERSON_SEQ", 
initialValue   = 1,     // 초기값
allocationSize = 1 )   // 증가치
public class Person {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,
    generator = "PERSON_SEQ_GENERATOR")
    @Column(name = "person_idx", nullable = false, unique = true, updatable = false)
	private Long personIdx;

	@ManyToOne                      // 관계 : 다대일 설정 (USER <-> Company)  
	@JoinColumn(name="user_idx", nullable = false)  // 외래키 칼럼 (부모키 USER idx칼럼)
	private User user;
	
	@Column(name = "person_name", nullable = false)
	private String personName;
	
	@Column(name = "person_phone", nullable = false)
	private String personPhone;
	
	@Column(name = "person_address")
	private String personAddress;
	
	@Column(name = "person_birth")
	private String personBirth;
	
	@Column(name = "person_education")
	private String personEducation;
	

	}
	

	

