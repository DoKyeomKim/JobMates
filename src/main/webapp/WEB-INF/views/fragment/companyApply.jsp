<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<body>
	<div class="container mt-3">
		<table class="table" id="myTable">
			<thead class="table-secondary">
				<tr>
					<th><input type="checkbox" id="processAll" /></th>
					<th>지원자명</th>
					<th>이력서 제목</th>
					<th>지원일</th>
					<th>지원 공고</th>
					<th>지원 결과</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${apply}" var="apply">
					<tr data-apply-idx="${apply.applyDto.applyIdx}"
						data-apply-status="${apply.applyDto.applyStatus}">
						<td><input type="checkbox" class="processCheckbox" /></td>
						<td>${ apply.personDto.personName }</td>
						<td><a
							href="/ApplyResumeView/${ apply.resumeDto.resumeIdx }/${ apply.personDto.personIdx }"
							class="text-dark text-decoration-none">${ apply.resumeDto.resumeTitle }</a></td>
						<td>${ apply.applyDto.createdDate }</td>
						<td><a href="/MainPosting/${ apply.postingDto.postingIdx }"
							class="text-dark text-decoration-none">${ apply.postingDto.postingTitle }</a></td>
						<td class="processTd" data-resume-idx="${ apply.resumeDto.resumeIdx }" data-person-idx="${ apply.personDto.personIdx }" data-posting-idx="${apply.postingDto.postingIdx}"  style="cursor: pointer;"><c:choose>
								<c:when test="${apply.applyDto.applyStatus == 1}">
                                    미처리
                                </c:when>
								<c:when test="${apply.applyDto.applyStatus == 2}">
                                    합격
                                </c:when>
								<c:when test="${apply.applyDto.applyStatus == 3}">
                                    불합격
                                </c:when>
								<c:otherwise>
                                    상태 미정
                                </c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="d-flex flex-row-reverse">
			<button id="processApply" class="btn btn-outline-danger">지원
				취소</button>
		</div>
	</div>

	<script>
document.addEventListener('DOMContentLoaded', function() {
    var processAll = document.getElementById('processAll');
    var processCheckboxes = document.querySelectorAll('.processCheckbox');
    var processApply = document.getElementById('processApply');
    const btnPass = document.getElementById('btnPass');
    const btnFail = document.getElementById('btnFail');

    // '모두 선택' 체크박스 클릭 이벤트
    processAll.addEventListener('click', function() {
        var isChecked = this.checked;
        processCheckboxes.forEach(function(checkbox) {
            checkbox.checked = isChecked;
        });
    });

    // '일괄 처리' 버튼 클릭 이벤트
    processApply.addEventListener('click', function() {
        processCheckboxes.forEach(function(checkbox) {
            if (checkbox.checked) {
                var tr = checkbox.closest('tr');
                var applyIdx = tr.getAttribute('data-apply-idx');
                var applyStatus = tr.getAttribute('data-apply-status');
                
                // 서버로 지원 상태 처리 요청을 보냄
                fetch('/ApplyProcess/' + applyIdx + '/' + applyStatus, {
                    method: 'PATCH',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                })
                .then(data => {
                    const url = '/ApplyPage';

                    fetch(url, {
                        method: 'GET',
                    })
                    .then(response => response.text())
                    .then(response => {
                        document.querySelector("#section").innerHTML = response;
                    })
                    .catch(error => {
                        console.error("Error: " + error);
                    });
                })
                .catch((error) => {
                    console.error('Error:', error);
                });
            }
        });
    });

    // 'processTd' 클래스를 가진 모든 요소에 대해 이벤트 리스너를 추가
    document.querySelectorAll('.processTd').forEach(function(td) {
        td.addEventListener('click', function() {
            var resumeIdx = this.getAttribute('data-resume-idx');
            var personIdx = this.getAttribute('data-person-idx');
            var postingIdx = this.getAttribute('data-posting-idx');

            // 팝업창(또는 모달)을 만들어서 표시하는 함수를 호출
            openPopup(`/ApplyResumeView/`+resumeIdx+`/`+personIdx+`/`+postingIdx);
        });
    });

    btnPass.addEventListener('click', () => handleButtonClick(btnPass));
    btnFail.addEventListener('click', () => handleButtonClick(btnFail));

    function handleButtonClick(button) {
        const applyStatus = button.getAttribute('data-apply-status');
        const applyIdx = button.getAttribute('data-apply-idx');

        fetch('/ApplyProcess/'+applyIdx+'/'+applyStatus, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                applyIdx: applyIdx,
                applyStatus: applyStatus
            })
        })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => { throw new Error(text) });
            }
            return response.text();
        })
        .then(data => {
            alert('처리가 완료되었습니다.');
            const url = '/ApplyPage';
            window.close();
            fetch(url, {
                method: 'GET',
            })
            .then(response => response.text())
            .then(response => {
                window.opener.document.querySelector("#section").innerHTML = response;
            })
            .catch(error => {
                console.error("Error: " + error);
            });
        })
        .catch((error) => {
            console.error('Error:', error);
            alert('처리 중 오류가 발생했습니다: ' + error.message);
        });
    }

    function openPopup(url) {
        const screenWidth = window.screen.width;
        const screenHeight = window.screen.height;
        const windowWidth = screenWidth * 0.7;
        const windowHeight = screenHeight * 0.7;
        const left = (screenWidth - windowWidth) / 2;
        const top = (screenHeight - windowHeight) / 2;

        const options = 'width=' + windowWidth + ',height=' + windowHeight + ',left=' + left + ',top=' + top;

        window.open(url, 'ResumeView', options);
    }
});
</script>
</body>
