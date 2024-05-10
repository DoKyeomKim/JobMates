<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="icon" type="image/x-icon" href="/images/favicon.png">
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
/* 추가적인 CSS 스타일링 */
footer {
	position: fixed;
	bottom: 0;
	width: 100%;
	padding: 20px 0;
	text-align: center;
}

header {
	background-color: #e0f7fa;
}
</style>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		document.getElementById('experienceSlider').addEventListener('input', function() {
			var value = this.value;
			var label = value === '0' ? '신입' : value === '11' ? '10년차 이상' : value + '년차';
			document.getElementById('experienceValue').innerText = label;
			document.getElementById('btn_experience').innerText = '경력 ' + label; // 버튼 텍스트를 업데이트하는 부분을 수정했습니다.
		});
		  var dropdownItems = document.querySelectorAll('.region-item');
		  dropdownItems.forEach(function(item) {
		    item.addEventListener('click', function() {
		      var value = this.getAttribute('data-value');
		      var dropdownButton = document.getElementById('btn-region');
		      dropdownButton.textContent = '지역: ' + value;
		    });
		  });
	       const selectedTechStacksDiv = document.getElementById('selectedTechStacks');
	        const techStackButton = document.getElementById('techStackButton');
	        document.querySelectorAll('.dropdown-menu input[type="checkbox"]').forEach(item => {
	            item.addEventListener('change', function () {
	                let selectedItems = document.querySelectorAll('.dropdown-menu input[type="checkbox"]:checked');
	                let selectedNames = Array.from(selectedItems).map(item => item.value);
	                let textToShow = selectedNames.length > 1 ? `${selectedNames[0]} 외 ${selectedNames.length - 1}` : selectedNames[0] || '기술스택';
	                techStackButton.textContent = textToShow;
	                selectedTechStacksDiv.textContent = (selectedNames.join(', ') || '없음');
	            });
	        });
	});
</script>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<section>
		<div class="container-fluid mt-4">
			<form action="">

				<div class="mb-3">
					<input type="text" class="form-control" id="jobType"
						placeholder="직무 선택">
					<div id="jobTypeContainer" class="ms-3 mt-2"></div>
				</div>
				<div class="d-flex">
					<div class="dropdown">
						<button class="btn btn-secondary dropdown-toggle" type="button"
							id="btn-region" data-bs-toggle="dropdown" aria-expanded="false">지역</button>
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
						<button class="btn btn-primary dropdown-toggle" type="button"
							id="btn_experience" data-bs-toggle="dropdown"
							aria-expanded="false">경력</button>
						<div class="dropdown-menu px-5">
							<input type='range' id='experienceSlider' name='experience'
								value='0' min='0' max='11' step='1'>
							<p>
								<span id='experienceValue'>신입</span>
							</p>
						</div>
					</div>
						<div class="dropdown ms-3">
							<button class="btn btn-secondary dropdown-toggle" type="button"
								id="techStackButton" data-bs-toggle="dropdown"
								aria-expanded="false">기술스택</button>
							<ul class="dropdown-menu pe-1" aria-labelledby="techStackButton" style="width: 300px">
								<li><input class="form-check-input me-1" type="checkbox"
									value="React" id="techReact">React</li>
								<li><input class="form-check-input me-1" type="checkbox"
									value="Vue.js" id="techVue">Vue.js</li>
								<li><input class="form-check-input me-1" type="checkbox"
									value="Angular" id="techAngular">Angular</li>
								<!-- 여기에 더 많은 기술 스택 체크박스를 추가할 수 있습니다 -->
								<li><div id="selectedTechStacks" class="mt-3"></div></li>
							</ul>
						</div>
				</div>

			</form>
		</div>
	</section>
	<%@include file="/WEB-INF/layouts/footer.jsp"%>
		<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>