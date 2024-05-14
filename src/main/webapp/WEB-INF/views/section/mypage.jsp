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
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<section>



<div class="card card-info">

<div class="card-header">
<h3 class="card-title">회원정보 보기</h3>
</div>

<form class="form-horizontal" action="/mypageUpdateForm">
<div class="card-body">

<div class="form-group row">
<label for="inputEmail3" class="col-sm-2 col-form-label">아이디</label>
<div class="col-sm-10">
<span>${persondto.personIdx}</span>
</div>
</div>

<div class="form-group row">
<label for="inputPassword3" class="col-sm-2 col-form-label">주소</label>
<div class="col-sm-10">
<span>${persondto.personAddress}</span>
</div>
</div>

<div class="form-group row">
<label for="inputPassword3" class="col-sm-2 col-form-label">생년월일</label>
<div class="col-sm-10">
<span>${persondto.personBirth}</span>
</div>
</div>

<div class="form-group row">
<label for="inputPassword3" class="col-sm-2 col-form-label">학력</label>
<div class="col-sm-10">
<span>${persondto.personEducation}</span>
</div>
</div>

<div class="form-group row">
<label for="inputPassword3" class="col-sm-2 col-form-label">이름</label>
<div class="col-sm-10">
<span>${persondto.personName}</span>
</div>
</div>

<div class="form-group row">
<label for="inputPassword3" class="col-sm-2 col-form-label">전화번호</label>
<div class="col-sm-10">
<span>${persondto.personPhone}</span>
</div>
</div>

<div class="form-group row">
<label for="inputPassword3" class="col-sm-2 col-form-label">이메일</label>
<div class="col-sm-10">
<span>${persondto.userEmail}</span>
</div>
</div>

</div>


<div class="card-footer">
<button type="submit" class="btn btn-info">수정하기</button>
</div>

</form>
</div>


	</section>
	<%@include file="/WEB-INF/layouts/footer.jsp"%>
		<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>