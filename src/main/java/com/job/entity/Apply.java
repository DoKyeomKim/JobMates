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
import lombok.Getter;

@Table(name = "APPLY_TB")  //  table 이름과 클래스 이름이 다를때 사용 (oracle은 user table 못만듬)
@Getter
@Entity
@SequenceGenerator(name="APPLY_SEQ_GENERATOR", 
sequenceName   = "APPLY_SEQ", 
initialValue   = 1,     // 초기값
allocationSize = 1 )   // 증가치

public class Apply {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,
    generator = "APPLY_SEQ_GENERATOR")
    @Column(name = "apply_idx", nullable = false, unique = true, updatable = false)
	private Long applyIdx;
	
	@ManyToOne                      // 관계 : 다대일 설정 (USER <-> Company)  
	@JoinColumn(name="person_idx", nullable = false)  // 외래키 칼럼 (부모키 USER idx칼럼)
	private Person person;
	
	@ManyToOne                      // 관계 : 다대일 설정 (USER <-> Company)  
	@JoinColumn(name="posting_idx", nullable = false)  // 외래키 칼럼 (부모키 USER idx칼럼)
	private Posting posting;
	
	@ManyToOne                      // 관계 : 다대일 설정 (USER <-> Company)  
	@JoinColumn(name="resume_idx", nullable = false)  // 외래키 칼럼 (부모키 USER idx칼럼)
	private Resume resume;
	
	@Column(name = "created_date", nullable = false)
	private String createdDate;
	
	@Column(name = "apply_status", nullable = false)
	private Long applyStatus;
}
