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
/* 	position: fixed; */
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
			

			<form class="form-horizontal" action="/mypageCompanyUpdate" method="POST" enctype="multipart/form-data">
			
					<div>
						<img src="${companyFile.filePath}" id="imagePreview" style="width:250px; height: 310px;" class="mb-2 border border-tertiary">
							<div class="row justify-content-center ">
								<div class="col-md-14 mx-auto mb-4">
									<input type="file" name="file" id="uploadInput" class="form-control mt-2" onchange="chooseImage(this)"/>
								</div>
							</div>
					</div>
			
				<div class="card-body">
				<input type="hidden" name="userIdx" value="${userIdx}">
				<input type="hidden" name="companyIdx" value="${companyIdx}">
				
					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-2 col-form-label">아이디</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="id" placeholder="아이디"
								value="${userId}" name="userId"
								readonly="readonly">
						</div>
					</div>


					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">기업이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companyName"
								placeholder="기업이름" value="${company.companyName}"
								name="companyName">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">대표이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companyRepName"
								placeholder="대표이름" value="${company.companyRepName}"
								name="companyRepName">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">회사주소</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companyAddress"
								placeholder="회사주소" value="${company.companyAddress}"
								name="companyAddress">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">회사전화번호</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companyPhone"
								placeholder="회사전화번호" value="${company.companyPhone}"
								name="companyPhone">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">채용담당자이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companyMgrName"
								placeholder="채용담당자이름" value="${company.companyMgrName}"
								name="companyMgrName">
						</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">채용담당자전화번호</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companyMgrPhone"
								placeholder="채용담당자전화번호" value="${company.companyMgrPhone}"
								name="companyMgrPhone">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">회사직원수</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companyEmp"
								placeholder="회사직원수" value="${company.companyEmp}"
								name="companyEmp">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">회사규모</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companySize"
								placeholder="회사규모" value="${company.companySize}"
								name="companySize">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">회사직종</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companySector"
								placeholder="회사직종" value="${company.companySector}"
								name="companySector">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-2 col-form-label">설립연도</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="companyYear"
								placeholder="설립연도" value="${company.companyYear}"
								name="companyYear">
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
					


				</div>


				<div class="card-footer">
					<button type="submit" class="btn btn-info">저장</button>
				</div>
			</div>
			</form>
		</div>










	</section>
	<%@include file="/WEB-INF/layouts/footer.jsp"%>
	<script src="/js/bootstrap.bundle.min.js"></script>
<script>
function chooseImage(input) {
    const fileInput = input.files[0];
    const imagePreview = document.getElementById('imagePreview');
    const currentImage = imagePreview.src;

    if (fileInput) {
        const reader = new FileReader();

        reader.onload = function(e) {
            imagePreview.src = e.target.result;
        }
     // 파일을 읽어 데이터 URL로 변환
        reader.readAsDataURL(fileInput); 
    } else {
    	// 파일이 선택되지 않았을 때는 현재 이미지 유지
        imagePreview.src = currentImage; 
    }
}
</script>
</body>
</html>