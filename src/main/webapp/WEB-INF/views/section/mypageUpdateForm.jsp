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
/* 추가적인 	SS 스타일링 */
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

		<div class="card card-info">
			<div class="card-header">
				<h3 class="card-title">회원정보 수정</h3>
			</div>


			<form class="form-horizontal" action="/mypageUpdate" method="POST">
				<div class="card-body">
				<input type="hidden" name="userIdx" value="${userIdx}">
				<input type="hidden" name="personIdx" value="${person.personIdx }">

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">아이디</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="id" placeholder="아이디"
								value="${userId}" name="userId"
								readonly="readonly">
						</div>
					</div>


					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">주소</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="address"
								placeholder="주소" value="${person.personAddress}"
								name="personAddress">
						</div>
					</div>

					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">생년월일</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="birth"
								placeholder="생년월일" value="${person.personBirth}"
								name="personBirth">
						</div>
					</div>

					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">학력</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edu" placeholder="학력"
								value="${person.personEducation}" name="personEducation">
						</div>
					</div>

					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="name"
								placeholder="이름" value="${person.personName}"
								name="personName">
						</div>
					</div>

					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">전화번호</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="phone"
								placeholder="전화번호" value="${person.personPhone}"
								name="personPhone">
						</div>
					</div>

					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">이메일</label>
						<div class="col-sm-10">
							<input type="email" class="form-control" id="email"
								placeholder="이메일" value="${userEmail}"
								name="userEmail">
						</div>
					</div>
					
					<br>
					<br>
					<br>
					
					<div class="form-group row">
					<c:forEach var="skill" items="${allSkills}">
						<div class="col-auto">
							<input type="checkbox" class="btn-check" name="skillIdx"
								id="skill_${skill.skillIdx }" value="${skill.skillIdx}"  
								<c:forEach var="userSkill" items="${userSkills}">
					             <c:if test="${skill.skillIdx == userSkill.skillIdx}">
					                   checked="checked"
					             </c:if>
					            </c:forEach>>
					    	<label class="btn btn-outline-primary" for="skill_${skill.skillIdx }">${skill.skillName}</label>
						</div>
					</c:forEach>
				 	</div>

				</div>


				<div class="card-footer">
					<button type="submit" class="btn btn-info">저장</button>
				</div>

			</form>
		</div>










	</section>
	<%@include file="/WEB-INF/layouts/footer.jsp"%>
	<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>