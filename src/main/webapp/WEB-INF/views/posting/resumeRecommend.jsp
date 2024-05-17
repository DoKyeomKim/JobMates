<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <link rel="icon" type="image/x-icon" href="/images/favicon.png">
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <style>
    section {
	margin-bottom : 100px;
}
        .posting-box {
            border: 1px solid #ccc;
            border-radius: 10px;
            margin: 0 auto;
            margin-left: 20%;
            margin-right: 20%;
            height: 100px;
            position: relative;
            transition: transform 0.3s ease;
        }
		
		
		.posting-box:hover {
		    transform: scale(1.015); /* 마우스를 올렸을 때 커지는 효과 */
		}
        
	
        .posting-box p {
            display: inline-block;
            margin: 0;
        }

        .posting-box button,
        .posting-box a {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
        }

        .posting-box button {
            right: 100px; /* 버튼 사이 간격 조정 */
        }

        .posting-box a {
            right: 10px; /* 오른쪽 여백 조정 */
        }

        .posting-write-container {
            text-align: center;
        }
        
        
        .resume-container {
            border: 1px solid #ccc; /* 테두리 추가 */
			border-top:none;
            margin: 0px auto; /* 위아래 마진 추가 */
            padding: 20px; /* 내부 여백 추가 */
            width: 58%; /* 너비 설정 */
            background-color : #f8f9fa;
        }
        
         .resume-box {
            border: 1px solid #ccc;
            border-radius: 10px;
            margin: 0 auto;
            height: 100px;
            position: relative;
            transition: transform 0.3s ease;
            background-color : white;
        }
		
		
		.resume-box:hover {
		    transform: scale(1.015); /* 마우스를 올렸을 때 커지는 효과 */
		}
        

        .resume-box p {
            display: inline-block;
            margin: 0;
        }

        .resume-box button,
        .resume-box a {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
        }

        .resume-box button {
            right: 100px; /* 버튼 사이 간격 조정 */
        }

        .resume-box a {
            right: 10px; /* 오른쪽 여백 조정 */
        }

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
    
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>

<section>
	<h3 class="mb-3 mt-3" style="text-align:center;"> 공고별 추천 인재 </h3>
	<hr>

    <article>
        <div class="mt-5">
            <div id="postings-container">
                <c:forEach var="entry" items="${resumeRecMap}">
                    <c:set var="postingIdx" value="${entry.key}"/>
                    <c:set var="resumeRecList" value="${entry.value}"/>
                    <c:if test="${not empty resumeRecList}">
                        <div class="posting-box mt-4" data-postings-idx="${postingIdx}" style="cursor: pointer;">
                            <input type="hidden" name="postingIdx" value="${postingIdx}">
                            <div class="m-4">${resumeRecList[0].postingTitle}</div>
                            <div class="m-4">마감일: ${resumeRecList[0].postingDeadline}</div>
                            <a class="btn btn-primary posting-view" href="/postingView?postingIdx=${postingIdx}">공고 확인</a>
                        </div>
                        
                        <!-- 현재 공고에 해당하는 이력서 목록 표시 -->
                        <div class="resume-container" style="display: none; ">
                            <c:forEach var="resumeItem" items="${resumeRecList}">
								<div class="resume-box mb-3" data-resume-idx="${resumeItem.resumeIdx}" data-person-idx="${resumeItem.personIdx}">
									<input type="hidden" name="personIdx" value="${resumeItem.personIdx}">
									<input type="hidden" name="resumeIdx" value="${resumeItem.resumeIdx}">
									<p class="m-4">${resumeItem.personName}</p>
									<p class="m-4">${resumeItem.resumeTitle}</p>
																
									<button id="btn-scrap" class="btn btn-outline-primary mx-1">
										스크랩버튼
									</button>
								</div>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <br>
        </div>
    </article>
</section>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
<script src="/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var postingBoxes = document.querySelectorAll('.posting-box');

        postingBoxes.forEach(function(box) {
            box.addEventListener('click', function() {
                var resumeContainer = this.nextElementSibling;
                var displayStatus = resumeContainer.style.display;

                resumeContainer.style.display = displayStatus === 'block' ? 'none' : 'block';
            });
        });
    });
    
    document.addEventListener('DOMContentLoaded', function() {
        // document 전체에 클릭 이벤트 리스너를 추가합니다.
        document.addEventListener('click', function(event) {
            // 스크랩 버튼 클릭 시 함수 종료
            if (event.target.id === 'btn-scrap') {
                return;
            }

            // 클릭된 요소가 resume-box 내부의 요소인지 확인합니다.
            var clickedElement = event.target.closest('.resume-box');
            if (!clickedElement) return; // 클릭된 요소가 resume-box 내부의 요소가 아니면 함수 종료

            // 클릭된 resume-box 요소에서 data-resume-idx와 data-person-idx 값을 읽어옵니다.
            var resumeIdx = clickedElement.getAttribute('data-resume-idx');
            var personIdx = clickedElement.getAttribute('data-person-idx');

            // resumeIdx와 personIdx를 URL 파라미터로 포함하여 페이지 이동합니다.
            window.location.href = '/resumeRecommendView?resumeIdx=' + resumeIdx + '&personIdx=' + personIdx;
        });
    });

</script>
</body>
</html>
