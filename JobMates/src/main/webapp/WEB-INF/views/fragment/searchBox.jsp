<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="mt-3" id="searchResult">
    <c:choose>
        <c:when test="${results != null and results.isEmpty() and isSearched}">
            <p>검색 결과가 없습니다.</p>
        </c:when>
        <c:when test="${results != null and results.isEmpty() and !isSearched}">
            <p>검색 결과가 여기에 나타납니다.</p>
        </c:when>
        <c:when test="${results != null and !results.isEmpty()}">
            <!-- 검색 결과를 보여주는 로직 -->
            <c:forEach items="${results}" var="item">
                    <div class="search-item d-flex">
                        <div>
                            <p style="font-size: 0.85rem;">${item.jobType}</p>
                        </div>
                    </div>
            </c:forEach>
        </c:when>
    </c:choose>
</div>
</body>
</html>