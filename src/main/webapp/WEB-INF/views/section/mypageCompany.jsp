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
/* 	position: fixed;
 */	bottom: 0;
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
				<h3 class="card-title">기업회원정보 보기</h3>
			</div>

				<div class="card-body">
					<div>
						<img src="${companyFile.filePath}" id="imagePreview" style="width:250px; height: 310px;" class="mb-2 border border-tertiary">
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">아이디</label>
						<div class="col-sm-10">
							<span>${userId}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">기업이름</label>
						<div class="col-sm-10">
							<span>${company.companyName}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">대표이름</label>
						<div class="col-sm-10">
							<span>${company.companyRepName}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">회사주소</label>
						<div class="col-sm-10">
							<span>${company.companyAddress}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">회사전화번호</label>
						<div class="col-sm-10">
							<span>${company.companyPhone}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">채용담당자이름</label>
						<div class="col-sm-10">
							<span>${company.companyMgrName}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">채용담당자전화번호</label>
						<div class="col-sm-10">
							<span>${company.companyMgrPhone}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">회사직원수</label>
						<div class="col-sm-10">
							<span>${company.companyEmp}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">회사규모</label>
						<div class="col-sm-10">
							<span>${company.companySize}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">회사직종</label>
						<div class="col-sm-10">
							<span>${company.companySector}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">설립연도</label>
						<div class="col-sm-10">
							<span>${company.companyYear}</span>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">회사이메일</label>
						<div class="col-sm-10">
							<span>${userEmail}</span>
						</div>
					</div>

				</div>


				<div class="card-footer">
					<a href="/mypageCompanyUpdateForm" class="btn btn-info">수정하기</a>
				</div>

		</div>


	</section>
	<%@include file="/WEB-INF/layouts/footer.jsp"%>
	<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>