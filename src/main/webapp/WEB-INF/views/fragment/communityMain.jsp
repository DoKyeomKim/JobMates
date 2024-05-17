<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
.text-truncate-2 {
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	max-height: 3em; /* Assuming line-height is 1.5 */
	line-height: 1.5; /* Adjust this value based on your line height */
}

.text-truncate-2::after {
	content: '...'; /* 말 줄임표 추가 */
}

.search-box {
	position: relative;
	display: flex;
	align-items: center;
}

.search-box input {
	padding-left: 35px; /* 왼쪽에 아이콘을 위한 여백 */
	padding-right: 35px; /* 'X' 버튼을 위한 여백 */
}

.search-icon, .clear-icon {
	position: absolute;
	width: 20px;
	height: 20px;
	z-index: 10;
}

.search-icon {
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
}

.clear-icon {
	right: 10px; /* 입력란 바깥쪽에 위치 */
	top: 50%;
	cursor: pointer;
	transform: translateY(-50%);
	display: none; /* 초기 상태에서 숨김 */
}

/* 입력란에 값이 있을 때만 X 아이콘 표시 */
.search-box input:not(:placeholder-shown) ~ .clear-icon {
	display: block;
}
</style>
</head>
<body>
	<div class="container mt-4">
	<div class="container">
		<div class="d-flex justify-content-between align-items-center">
			<ul class="nav nav-tabs d-flex justify-content-center" id="myTab"
				role="tablist" style="border: none; flex-grow: 1;">
				<li class="nav-item" role="presentation"><a
					class="nav-link text-secondary" id="popular-tab"
					data-bs-toggle="tab" data-bs-target="#popular" type="button"
					role="tab" aria-controls="popular" aria-selected="true"
					href="#popular" data-toggle="tab">인기</a></li>
				<li class="nav-item ms-2" role="presentation"><a
					class="nav-link text-secondary" id="likes-tab" data-bs-toggle="tab"
					data-bs-target="#likes" type="button" role="tab"
					aria-controls="likes" aria-selected="false" href="#likes"
					tabindex="-1">좋아요</a></li>
				<li class="nav-item ms-2" role="presentation"><a
					class="nav-link text-secondary" id="comments-tab"
					data-bs-toggle="tab" data-bs-target="#comments" type="button"
					role="tab" aria-controls="comments" aria-selected="false"
					href="#comments" tabindex="-1">댓글순</a></li>
				<li class="nav-item ms-2" role="presentation"><a
					class="nav-link text-secondary  active" id="recent-tab"
					data-bs-toggle="tab" data-bs-target="#recent" type="button"
					role="tab" aria-controls="recent" aria-selected="false"
					href="#recent" tabindex="-1">전체</a></li>
			</ul>
			<div class="search-box">
				<input type="text" class="form-control search-input"
					placeholder="직무 검색"> <img alt="검색 아이콘"
					src="/images/search.svg" class="search-icon"> <img
					alt="삭제 아이콘" src="/images/x-circle.svg" class="clear-icon">
			</div>
		</div>
	</div>
	<div class="tab-content d-flex justify-content-center mt-2"
		id="myTabContent">
		<div class="tab-pane fade show" id="popular" role="tabpanel"
			aria-labelledby="posts-tab">
			<ul class="list-group">
				<li class="list-group-item list-group-item-action py-3">
					<div class="container">
						<p class="fs-5 container" id="communityTitle">신입 인테리어 디자이너 초봉
							및 복지 좀 봐주세요</p>
						<div class="fs-6 text-truncate-2 container" id="communityContent">
							안녕하세요. 현재 한 회사에서 면접 보고 잡오퍼를 받은 상태입니다. 간단히 제 스펙을 먼저 말씀드려보면, - 4년제
							경기도권(but, 안유명) 공간디자인과 졸업 - 뉴욕에서 인테리어 디자인 석사 학위 취득 및 논문제출 - 뉴욕에서
							파트타임 인턴 근무경험 - 뉴욕에서 대학원 졸업 후 이름있는 회사에서 5개월 풀타임 인테리어 디자이너로 인턴 경험 -
							한국 공모전 높은 상 수상 1개, 국제적인 공모전에서 수상 3개 및 그에따른 잡지사 인터뷰 경험 1회 - 영어 원어민
							수준 능통 - 캐드, 스케치업, 맥스, 레빗, 모든 어도비 툴 ... 웬만한 인테리어 디자이너로서 다루어야할 툴은 다
							할 줄 알아요. - 포폴도 상 이렇게 입니다. 회사측에서 신입연봉 3000을 제시했고 상여금 (200% -
							300%)을 보통 연말에 받아 주로 신입은 연말에 3500-3800 이정도로 가져간다고 합니다. 야근비 있고,
							주말근무비, 야근시 택시비 지급 돈적인 면에 있어서는 이렇게 말하는데요, 어떤지 봐주시면 감사하겠습니다.
							한국사회생활은 처음이라 감잡기 힘드네요. 감사합니다.</div>
						<div class="container d-flex my-2">
							<div>
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-eye"
										viewBox="0 0 16 16">
		 					 	<path
											d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
		 					 	<path
											d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-hand-thumbs-up"
										viewBox="0 0 16 16">
		 					 <path
											d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2 2 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a10 10 0 0 0-.443.05 9.4 9.4 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a9 9 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.2 2.2 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.9.9 0 0 1-.121.416c-.165.288-.503.56-1.066.56z" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-chat"
										viewBox="0 0 16 16">
		  						<path
											d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> 9분 전 </span>
							</div>

						</div>
					</div>
				</li>
			</ul>
		</div>
		<div class="tab-pane fade show" id="likes" role="tabpanel"
			aria-labelledby="likes-tab">
			<ul class="list-group">
				<li class="list-group-item list-group-item-action py-3">
					<div class="container">
						<p class="fs-5 container" id="communityTitle">신입 인테리어 디자이너 초봉
							및 복지 좀 봐주세요</p>
						<div class="fs-6 text-truncate-2 container" id="communityContent">
							안녕하세요. 현재 한 회사에서 면접 보고 잡오퍼를 받은 상태입니다. 간단히 제 스펙을 먼저 말씀드려보면, - 4년제
							경기도권(but, 안유명) 공간디자인과 졸업 - 뉴욕에서 인테리어 디자인 석사 학위 취득 및 논문제출 - 뉴욕에서
							파트타임 인턴 근무경험 - 뉴욕에서 대학원 졸업 후 이름있는 회사에서 5개월 풀타임 인테리어 디자이너로 인턴 경험 -
							한국 공모전 높은 상 수상 1개, 국제적인 공모전에서 수상 3개 및 그에따른 잡지사 인터뷰 경험 1회 - 영어 원어민
							수준 능통 - 캐드, 스케치업, 맥스, 레빗, 모든 어도비 툴 ... 웬만한 인테리어 디자이너로서 다루어야할 툴은 다
							할 줄 알아요. - 포폴도 상 이렇게 입니다. 회사측에서 신입연봉 3000을 제시했고 상여금 (200% -
							300%)을 보통 연말에 받아 주로 신입은 연말에 3500-3800 이정도로 가져간다고 합니다. 야근비 있고,
							주말근무비, 야근시 택시비 지급 돈적인 면에 있어서는 이렇게 말하는데요, 어떤지 봐주시면 감사하겠습니다.
							한국사회생활은 처음이라 감잡기 힘드네요. 감사합니다.</div>
						<div class="container d-flex my-2">
							<div>
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-eye"
										viewBox="0 0 16 16">
		 					 	<path
											d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
		 					 	<path
											d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-hand-thumbs-up"
										viewBox="0 0 16 16">
		 					 <path
											d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2 2 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a10 10 0 0 0-.443.05 9.4 9.4 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a9 9 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.2 2.2 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.9.9 0 0 1-.121.416c-.165.288-.503.56-1.066.56z" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-chat"
										viewBox="0 0 16 16">
		  						<path
											d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> 9분 전 </span>
							</div>

						</div>
					</div>
				</li>
			</ul>
		</div>
		<div class="tab-pane fade show" id="comments" role="tabpanel"
			aria-labelledby="comments-tab">
			<ul class="list-group">
				<li class="list-group-item list-group-item-action py-3">
					<div class="container">
						<p class="fs-5 container" id="communityTitle">신입 인테리어 디자이너 초봉
							및 복지 좀 봐주세요</p>
						<div class="fs-6 text-truncate-2 container" id="communityContent">
							안녕하세요. 현재 한 회사에서 면접 보고 잡오퍼를 받은 상태입니다. 간단히 제 스펙을 먼저 말씀드려보면, - 4년제
							경기도권(but, 안유명) 공간디자인과 졸업 - 뉴욕에서 인테리어 디자인 석사 학위 취득 및 논문제출 - 뉴욕에서
							파트타임 인턴 근무경험 - 뉴욕에서 대학원 졸업 후 이름있는 회사에서 5개월 풀타임 인테리어 디자이너로 인턴 경험 -
							한국 공모전 높은 상 수상 1개, 국제적인 공모전에서 수상 3개 및 그에따른 잡지사 인터뷰 경험 1회 - 영어 원어민
							수준 능통 - 캐드, 스케치업, 맥스, 레빗, 모든 어도비 툴 ... 웬만한 인테리어 디자이너로서 다루어야할 툴은 다
							할 줄 알아요. - 포폴도 상 이렇게 입니다. 회사측에서 신입연봉 3000을 제시했고 상여금 (200% -
							300%)을 보통 연말에 받아 주로 신입은 연말에 3500-3800 이정도로 가져간다고 합니다. 야근비 있고,
							주말근무비, 야근시 택시비 지급 돈적인 면에 있어서는 이렇게 말하는데요, 어떤지 봐주시면 감사하겠습니다.
							한국사회생활은 처음이라 감잡기 힘드네요. 감사합니다.</div>
						<div class="container d-flex my-2">
							<div>
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-eye"
										viewBox="0 0 16 16">
		 					 	<path
											d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
		 					 	<path
											d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-hand-thumbs-up"
										viewBox="0 0 16 16">
		 					 <path
											d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2 2 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a10 10 0 0 0-.443.05 9.4 9.4 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a9 9 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.2 2.2 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.9.9 0 0 1-.121.416c-.165.288-.503.56-1.066.56z" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-chat"
										viewBox="0 0 16 16">
		  						<path
											d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> 9분 전 </span>
							</div>

						</div>
					</div>
				</li>
			</ul>
		</div>
		<div class="tab-pane fade show active" id="recent" role="tabpanel"
			aria-labelledby="recent-tab">
			<ul class="list-group">
				<li class="list-group-item list-group-item-action py-3">
					<div class="container">
						<p class="fs-5 container" id="communityTitle">신입 인테리어 디자이너 초봉
							및 복지 좀 봐주세요</p>
						<div class="fs-6 text-truncate-2 container" id="communityContent">
							안녕하세요. 현재 한 회사에서 면접 보고 잡오퍼를 받은 상태입니다. 간단히 제 스펙을 먼저 말씀드려보면, - 4년제
							경기도권(but, 안유명) 공간디자인과 졸업 - 뉴욕에서 인테리어 디자인 석사 학위 취득 및 논문제출 - 뉴욕에서
							파트타임 인턴 근무경험 - 뉴욕에서 대학원 졸업 후 이름있는 회사에서 5개월 풀타임 인테리어 디자이너로 인턴 경험 -
							한국 공모전 높은 상 수상 1개, 국제적인 공모전에서 수상 3개 및 그에따른 잡지사 인터뷰 경험 1회 - 영어 원어민
							수준 능통 - 캐드, 스케치업, 맥스, 레빗, 모든 어도비 툴 ... 웬만한 인테리어 디자이너로서 다루어야할 툴은 다
							할 줄 알아요. - 포폴도 상 이렇게 입니다. 회사측에서 신입연봉 3000을 제시했고 상여금 (200% -
							300%)을 보통 연말에 받아 주로 신입은 연말에 3500-3800 이정도로 가져간다고 합니다. 야근비 있고,
							주말근무비, 야근시 택시비 지급 돈적인 면에 있어서는 이렇게 말하는데요, 어떤지 봐주시면 감사하겠습니다.
							한국사회생활은 처음이라 감잡기 힘드네요. 감사합니다.</div>
						<div class="container d-flex my-2">
							<div>
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-eye"
										viewBox="0 0 16 16">
		 					 	<path
											d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
		 					 	<path
											d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-hand-thumbs-up"
										viewBox="0 0 16 16">
		 					 <path
											d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2 2 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a10 10 0 0 0-.443.05 9.4 9.4 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a9 9 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.2 2.2 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.9.9 0 0 1-.121.416c-.165.288-.503.56-1.066.56z" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-chat"
										viewBox="0 0 16 16">
		  						<path
											d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105" />
							</svg>
								</span> <span>0</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> 9분 전 </span>
							</div>

						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>
</body>
</html>