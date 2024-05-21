<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크랩 기능 구현</title>
    <link rel="icon" type="image/x-icon" href="/images/favicon.png">
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
/* 스타일 설정 */
main {
   display: flex;
   justify-content: center;
   height: 800px;
}

.content {
   display: flex;
   justify-content: center; /* 중앙 정렬 */
}



.content .left {
   flex: 1;
   padding: 20px;
   margin-top: 75px;
}

.content .right {
   flex: 3;
   padding: 20px;
}

.content .tabs {
   display: flex;
}

.content .tab {
   background-color: #f7faf9;
   border: none;
   padding: 10px 20px;
   cursor: pointer;
}

.content .tab:hover {
   background-color: #ccc;
   font-weight: bold;
}

.content .tab.active {
   font-weight: bold;
}

.content .tab-panel {
   display: none;
}

.content .tab-panel.active {
   display: block;
}

table {
   border-collapse: collapse;
   width: 100%;
}

th, td {
   padding: 10px;
   border: 1px solid #ddd;
   text-align: center;
}

.pagination {
   display: flex;
   justify-content: center;
   margin-top: 20px;
}

.pagination .page-link {
   color: black;
}

main button {
   background-color: inherit;
   border: none;
   padding: 0;
}

main button.bookmark {
   background: url("/img/bookmark-check.svg");
   background-size: cover;
   display: inline-block;
   width: 30px;
   height: 30px;
   margin-top: 2px;
}

main button.bookmark:hover {
   background: url("/img/bookmark-check-fill.svg");
   background-size: cover;
}

main button.bookmarkOn {
   background: url("/img/bookmark-check-fill.svg");
   background-size: cover;
}

li {
   list-style: none;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<div class="tab-panel" id="book-id">
  <table id="scrap">
    <h2>관심기업</h2>
    <ul class="job-list">
      <li>
        <thead>
          <tr>
            <th>회사명</th>
            <th>공고 제목</th>
            <th>분야</th>
            <th>마감일자</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${book}" varStatus="loop">
            <tr>
              <td>${item.company_name}</td>
              <td>${item.posting_title}</td>
              <td>${item.job_type}</td>
              <td>${item.posting_deadline}</td>
            </tr>
          </c:forEach>
        </tbody>
      </li>
    </ul>
  </table>
</div>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
<script src="/js/bootstrap.bundle.min.js"></script>
<script>
</script>
</body>
</html>