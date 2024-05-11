<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	

<body>
	<c:if test="${not empty posts}">
		<c:forEach items="${posts}" var="post">
			<div class="border mt-3"
				id="jobDetailDiv${ post.postingIdx }">
				<!-- 공고 리스트 시작 -->
				<div class="d-flex justify-content-between">
					<div class="row">
						<input type="text"
							class="form-control border-0 shadow-none mb-2 ms-3"
							value="${ post.postingTitle }" id="title${ post.postingIdx }"
							readonly="readonly"> <input type="text"
							class="form-control border-0 shadow-none ms-3"
							value="마감기한 : ${ post.postingDeadline }"
							id="deadline${ post.postingIdx }" readonly="readonly">
					</div>
					<button id="btn-delete${ post.postingIdx }"
						class="btn btn-dark align-self-center float-end mx-3">삭제</button>
				</div>
			</div>
		</c:forEach>
	</c:if>
</body>
