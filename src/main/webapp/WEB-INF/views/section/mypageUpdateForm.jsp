<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

.card-body {
    width: 60%;
    margin: 0 auto;
    margin-top: 60px; 
    margin-left:450px;
    border: 1px solid #ccc;
    padding: 0;
    box-sizing: border-box;
}


label {
    border-left: none;
    border-right: none;
    background-color: #e0f7fa; 
    height: 60px;
    display: flex;
    align-items: center; /* 상하 가운데 정렬 */
    padding-left: 10px;
    padding-right: 10px;
    box-sizing: border-box;
    margin: 0;
    width: 100%;
}

.col-sm-7,
.col-auto {
    display: flex;
    align-items: center; /* 상하 가운데 정렬 */
    margin: 0;
    padding: 0 10px; 
    box-sizing: border-box;
}

.form-group {
    margin: 0;
    border-bottom: 1px solid #ccc;
}

/* 사이드바 스타일링 */
.sidenav {
    background-color: #f1f1f1;
    position: fixed;
    width: 200px;
    height: 100%;
    padding-top: 20px; /* padding 추가 */
}

.sidenav ul {
    list-style-type: none; /* 기본 리스트 스타일 제거 */
    padding: 0; /* 기본 패딩 제거 */
}

.sidenav li {
    margin: 10px 0; /* li 요소들 사이에 수직 간격 추가 */
}
.sidenav li a {
    display: block;
    text-align: center;
}

.sidenav a {
    text-decoration: none; /* 링크의 기본 밑줄 제거 */
    color: #000; /* 링크 텍스트 색상 설정 */
    display: block; /* 전체 너비를 클릭할 수 있도록 설정 */
    padding: 10px; /* 링크 요소에 패딩 추가 */
}

.sidenav a:hover {
    background-color: #ddd; /* 마우스 오버 시 배경색 변경 */
}

input {
border:none !important;
outline:none !important;
}

</style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/header.jsp"%>

    <!-- 사이드바 -->
    <aside>
        <nav class="col-sm-3 sidenav">
            <h4 class="mb-4 mt-4" style="text-align:center;">마이페이지</h4>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="/mypage">회원 정보</a></li>
                <li class="nav-item"><a class="nav-link" href="/mypageUpdateForm">정보 수정</a></li>
                <li class="nav-item"><a class="nav-link" href="#">회원 탈퇴</a></li>
            </ul>
        </nav>
    </aside>
    <!-- 사이드바 끝 -->
  <section>
        <div class="info">
            <div class="card-header">
                <h3 class="card-title mt-5" style="text-align:center;">회원정보 수정</h3>
            </div>            
            
            <form class="form-horizontal" action="/mypageUpdate" method="POST">
                <div class="card-body">
                <input type="hidden" name="userIdx" value="${userIdx}">
                <input type="hidden" name="personIdx" value="${person.personIdx }">
                
					 <div class="form-group row">
                        <label for="inputEmail3" class="col-sm-1 col-form-label">아이디</label>
                        <div class="col-sm-7"  style="width:80%; padding-left:30px;">
                            <span class="form-control" style="border:none; outline:none;">${userId}</span>
                        </div>
                    </div>
                    

                    <div class="form-group row">
                        <label for="inputPassword3" class="col-sm-1 col-form-label">주소</label>
                        <div class="col-sm-7"  style="width:80%; padding-left:30px;">
                            <input type="text" class="form-control" id="address"
                                placeholder="주소" value="${person.personAddress}"
                                name="personAddress">
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label for="inputPassword3" class="col-sm-1 col-form-label">생년월일</label>
                        <div class="col-sm-7" style="width:80%; padding-left:30px;">
                            <input type="text" class="form-control" id="birth"
                                placeholder="생년월일" value="${person.personBirth}"
                                name="personBirth">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="inputPassword3" class="col-sm-1 col-form-label">학력</label>
                        <div class="col-sm-7" style="width:80%; padding-left:30px;">
                            <input type="text" class="form-control" id="edu" placeholder="학력"
                                value="${person.personEducation}" name="personEducation">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="inputPassword3" class="col-sm-1 col-form-label">이름</label>
                        <div class="col-sm-7" style="width:80%; padding-left:30px;">
                            <input type="text" class="form-control" id="name"
                                placeholder="이름" value="${person.personName}"
                                name="personName">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="inputPassword3" class="col-sm-1 col-form-label">전화번호</label>
                        <div class="col-sm-7" style="width:80%; padding-left:30px;">
                            <input type="text" class="form-control" id="phone"
                                placeholder="전화번호" value="${person.personPhone}"
                                name="personPhone">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="inputPassword3" class="col-sm-1 col-form-label">이메일</label>
                        <div class="col-sm-7" style="width:80%; padding-left:30px;">
                            <input type="email" class="form-control" id="email"
                                placeholder="이메일" value="${userEmail}"
                                name="userEmail">
                        </div>
                    </div>
                   
                    
                    <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-1 col-form-label">기술스택</label>
                        <div class="col-auto" style="padding-left:20px;">
                    <c:forEach var="skill" items="${allSkills}">
                        <div class="col-auto">
                            <input type="checkbox" class="btn-check" name="skillIdx"
                                id="skill_${skill.skillIdx }" value="${skill.skillIdx}"  
                                <c:forEach var="userSkill" items="${userSkills}">
                                     <c:if test="${skill.skillIdx == userSkill.skillIdx}">
                                           checked="checked"
                                     </c:if>
                                </c:forEach>>
                            <label class="btn btn-outline-primary" style="height:40px;"for="skill_${skill.skillIdx }">${skill.skillName}</label>
                        </div>
                    </c:forEach>
                    </div>
                    </div>

                </div>
			    <div class="mt-5" style="text-align: center;">
                    <button type="submit" style="width:15%; margin-left:30px;" class="btn btn-outline-primary">저장</button>
                </div>


            </form>
        </div>
    </section>
    <%@include file="/WEB-INF/layouts/footer.jsp"%>
    <script src="/js/bootstrap.bundle.min.js"></script>
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        var saveButton = document.querySelector('button[type="submit"]');

        // '저장' 버튼 클릭 이벤트에 대한 핸들러를 추가합니다.
        saveButton.addEventListener("click", function(event) {
            event.preventDefault(); // 폼의 기본 제출 이벤트를 중단합니다.
            var confirmResult = confirm("회원정보를 수정하시겠습니까?"); // 확인 메시지를 표시합니다.

            if (confirmResult) {
                // 사용자가 '예'를 선택한 경우, 폼을 프로그래매틱하게 제출합니다.
                event.target.form.submit();
            }
        });
    });
</script>
</body>
</html>
