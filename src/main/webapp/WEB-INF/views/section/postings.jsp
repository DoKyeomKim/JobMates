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
    <article>

        <div class="mt-5">
		   <div id="postings-container">		   
            <c:forEach var="posting" items="${posting}">
                <div class="posting-box mb-3"  data-postings-idx="${posting.postingIdx}">
	                <input type="hidden" name="postingIdx" value="${posting.postingIdx}">
	                    <div class="m-4">${posting.postingTitle}</div>
	                    <div class="m-4">마감일 : ${posting.postingDeadline }</div>
						
					<a class="btn btn-primary posting-delete" href="/postingDelete?postingIdx=${posting.postingIdx }">삭제</a>
					
                </div>
            </c:forEach>
		  </div>
            <br>
            <div class="posting-write-container">
                <a href="/postingWriteForm" class="btn btn-primary posting-write" >공고 작성</a>
            </div>
        </div>

    </article>
</section>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
<script src="/js/bootstrap.bundle.min.js"></script>

<!-- div 클릭시 이동  -->
<script>
$(document).ready(function() {
    // 게시물 박스 클릭 이벤트
    $('#postings-container').on('click', '.posting-box', function(e) {
        // 삭제 버튼 클릭 이벤트가 버블링되는 것을 방지
        if (!$(e.target).closest('.posting-delete').length) {
            var postingIdx = $(this).data('postings-idx'); // 게시물 인덱스 가져오기
            window.location.href = '/postingView?postingIdx=' + postingIdx; // 상세 페이지로 이동
        }
    });

});
</script>

<!-- 공고 삭제 -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 'posting-delete' 클래스를 가진 모든 요소를 선택합니다.
    var deleteButtons = document.querySelectorAll('.posting-delete');
    
    // 각 요소에 대해 클릭 이벤트 리스너를 추가합니다.
    deleteButtons.forEach(function(button) {
        button.addEventListener('click', function(event) {
            // 클릭 이벤트가 발생하면, 기본 동작(링크를 통한 페이지 이동)을 중단합니다.
            event.preventDefault();
            
            // 사용자에게 삭제 여부를 묻는 confirm 창을 띄웁니다.
            var confirmResult = confirm('정말로 삭제하시겠습니까?');
            
            // 사용자가 '예'를 선택한 경우에만, 링크의 href 속성에 따라 페이지를 이동시킵니다.
            if (confirmResult) {
                window.location.href = this.getAttribute('href');
            }
        });
    });
});
</script>

</body>
</html>
