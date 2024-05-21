<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div class="container mt-4">
		<div id="result" class="mt-3 ms-5">
			<div class="d-flex flex-wrap">
				<!-- flex-wrap 추가 가능 -->
				<c:forEach items="${posts}" var="post">
					<div class="me-5">
						<!-- 각 포스트를 감싸는 div 추가 -->
						<img alt="기업 로고" src="${post.companyFileDto.filePath}"
							class="border" style="width: 250px;">
						<div class="d-flex justify-content-between">
							<!-- flex-direction 변경 및 가운데 정렬 -->
							<div class="d-flex flex-column">
								<span>${ post.postingDto.postingTitle }</span> <span>${ post.companyDto.companyName }</span> <span>${ post.postingDto.postingDeadline }</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>