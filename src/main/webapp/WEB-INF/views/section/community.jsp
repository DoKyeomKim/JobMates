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
	<section id="section">
		<%@ include file="/WEB-INF/views/fragment/communityMain.jsp"%>
	</section>
	<%@include file="/WEB-INF/layouts/footer.jsp"%>
	<script src="/js/bootstrap.bundle.min.js"></script>
</body>

</html>