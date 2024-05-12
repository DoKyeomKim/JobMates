<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.search-box {
	position: relative;
	display: flex;
	align-items: center;
}

.search-box input {
	padding-left: 35px; /* 왼쪽에 아이콘을 위한 여백 */
	padding-right: 35px; /* 'X' 버튼을 위한 여백 */
}

.search-icon, .clear-icon {
	position: absolute;
	width: 20px;
	height: 20px;
	z-index: 10;
}

.search-icon {
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
}

.clear-icon {
	right: 10px; /* 입력란 바깥쪽에 위치 */
	top: 50%;
	cursor: pointer;
	transform: translateY(-50%);
	display: none; /* 초기 상태에서 숨김 */
}

/* 입력란에 값이 있을 때만 X 아이콘 표시 */
.search-box input:not(:placeholder-shown) ~ .clear-icon {
	display: block;
}

#searchBox {
	position: fixed; /* 또는 absolute, 화면 상단에 고정 */
	top: 0; /* 화면 상단에서부터의 위치 */
	left: 230px; /* 화면 왼쪽에서부터의 위치 */
	height: 100%;
	/* 전체 화면 너비를 차지하도록 설정 */
	width: 300px;
	height: 100%;
	display: none;
	cursor: pointer;
	/* 필요한 추가 스타일 */
}
</style>
</head>
<body>
	<div class="container mt-4">
		<form action="" class="ms-5 border-bottom pb-3">
			<div class="mb-3">
				<div class="dropdown ms-3">
					<div class="d-flex align-items-center">
						<span id="jobTypeText" class="me-3">직무 전체</span>
						<button
							class="btn btn-white border dropdown-toggle bg-transparent"
							type="button" id="searchButton" data-bs-toggle="dropdown"
							aria-expanded="false">직무 검색</button>
						<ul class="dropdown-menu pe-1" aria-labelledby="searchButton"
							style="width: 300px">
							<li>
								<div class="search-box mx-3 my-3">
									<input type="text" class="form-control search-input"
										placeholder="직무 검색"> <img alt="검색 아이콘"
										src="/images/search.svg" class="search-icon"> <img
										alt="삭제 아이콘" src="/images/x-circle.svg" class="clear-icon">
								</div>
							</li>
							<li>
								<div class="mx-3 my-3 border" id="SearchJobType">
									<%@ include file="/WEB-INF/views/fragment/searchBox.jsp"%>
								</div>
								<div id="selectedJobs"></div>
								<div class="d-flex justify-content-between mx-3 mb-3">
									<button id="resetButton" class="btn btn-warning" type="button">초기화</button>
									<button id="applyButton" class="btn btn-success" type="button">적용</button>
								</div>
							</li>
						</ul>
					</div>


				</div>
			</div>
			<div class="d-flex justify-content-between">
				<div class="d-flex">
					<div class="dropdown">
						<button
							class="btn btn-white border dropdown-toggle bg-transparent"
							type="button" id="btn-region" data-bs-toggle="dropdown"
							aria-expanded="false">지역</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							<li><a class="dropdown-item region-item" data-value="전국">전국</a></li>
							<li><a class="dropdown-item region-item" data-value="서울">서울</a></li>
							<li><a class="dropdown-item region-item" data-value="부산">부산</a></li>
							<li><a class="dropdown-item region-item" data-value="대구">대구</a></li>
							<li><a class="dropdown-item region-item" data-value="인천">인천</a></li>
							<li><a class="dropdown-item region-item" data-value="광주">광주</a></li>
							<li><a class="dropdown-item region-item" data-value="대전">대전</a></li>
							<li><a class="dropdown-item region-item" data-value="울산">울산</a></li>
							<li><a class="dropdown-item region-item" data-value="경기도">경기도</a></li>
							<li><a class="dropdown-item region-item" data-value="강원도">강원도</a></li>
							<li><a class="dropdown-item region-item" data-value="충청북도">충청북도</a></li>
							<li><a class="dropdown-item region-item" data-value="충청남도">충청남도</a></li>
							<li><a class="dropdown-item region-item" data-value="전라북도">전라북도</a></li>
							<li><a class="dropdown-item region-item" data-value="전라남도">전라남도</a></li>
							<li><a class="dropdown-item region-item" data-value="경상북도">경상북도</a></li>
							<li><a class="dropdown-item region-item" data-value="경상남도">경상남도</a></li>
							<li><a class="dropdown-item region-item" data-value="제주도">제주도</a></li>
						</ul>
					</div>
					<div class="dropdown ms-3">
						<button
							class="btn btn-white border dropdown-toggle bg-transparent"
							type="button" id="btn_experience" data-bs-toggle="dropdown"
							aria-expanded="false">경력</button>
						<div class="dropdown-menu px-5">
							<input type='range' id='experienceSlider' name='experience'
								value='-1' min='-1' max='11' step='1'>
							<p>
								<span id='experienceValue'>신입</span>
							</p>
						</div>
					</div>
					<div class="dropdown ms-3">
						<button
							class="btn btn-white border dropdown-toggle bg-transparent"
							type="button" id="techStackButton" data-bs-toggle="dropdown"
							aria-expanded="false">기술스택</button>
						<ul class="dropdown-menu pe-1" aria-labelledby="techStackButton"
							style="width: 300px">
							<c:forEach items="${skills}" var="skill">
								<li class="ms-1 mb-1"><input class="form-check-input"
									type="checkbox" value="${skill.skillIdx}"
									data-skill-name="${skill.skillName}">
									${skill.skillName}</li>
							</c:forEach>
							<!-- 여기에 더 많은 기술 스택 체크박스를 추가할 수 있습니다 -->
							<li><div id="selectedTechStacks" class="mt-3"></div></li>
						</ul>
					</div>
				</div>
				<div class="d-flex">
					<input type="text" class="form-control search-input"
						placeholder="기업명, 공고명 검색"> <input type="button"
						class="btn btn-primary ms-3" value="검색" id="searchPosting">
				</div>
			</div>
		</form>
		<div id="result" class="mt-3 ms-5">
			<%@include file="/WEB-INF/views/fragment/postResult.jsp"%>
		</div>
	</div>
	    <script src="/js/search.js"></script>
</body>
</html>