<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="d-flex justify-content-between mb-3">
	<p class="fs-3">자유게시판</p>
	<div class="search-box">
		<input type="text" class="form-control search-input" placeholder="검색">
		<img alt="검색 아이콘" src="/images/search.svg" class="search-icon">
		<img alt="삭제 아이콘" src="/images/x-circle.svg" class="clear-icon">
	</div>

</div>
<div>
	<ul class="nav nav-tabs d-flex justify-content-center" id="myTab"
		role="tablist">
		<li class="nav-item" role="presentation"><a
			class="nav-link text-secondary" id="popular-tab" data-bs-toggle="tab"
			href="#" onclick="loadContent('popular')">조회순</a></li>
		<li class="nav-item" role="presentation"><a
			class="nav-link text-secondary" id="likes-tab" data-bs-toggle="tab"
			href="#" onclick="loadContent('likes')">좋아요순</a></li>
		<li class="nav-item" role="presentation"><a
			class="nav-link text-secondary" id="comments-tab"
			data-bs-toggle="tab" href="#" onclick="loadContent('comments')">댓글순</a>
		</li>
		<li class="nav-item" role="presentation"><a
			class="nav-link text-secondary active" id="recent-tab"
			data-bs-toggle="tab" href="#" onclick="loadContent('recent')">전체</a>
		</li>
	</ul>
</div>
<div id="communityList" class="tab-content">
	<div class="tab-pane fade show active">
		<ul class="list-group mb-3">
			<c:forEach items="${community.content}" var="community">

				<li
					class="list-group-item list-group-item-action py-3 community-detail"
					data-community-idx="${community.communityIdx}">
					<div class="container">
						<p class="fs-5 container" id="communityTitle">${community.communityTitle}</p>
						<div class="fs-6 text-truncate-2 container" id="communityContent">${community.communityContent}</div>
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
								</span> <span id="view${community.communityIdx}">${community.viewCount}</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span class="like_btn"
									data-community-idx="${community.communityIdx}"> <svg
										xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-hand-thumbs-up"
										viewBox="0 0 16 16">
                                    <path
											d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2 2 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a10 10 0 0 0-.443.05 9.4 9.4 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a9 9 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.2 2.2 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.9.9 0 0 1-.121.416c-.165.288-.503.56-1.066.56z" />
                                </svg>
								</span> <span id="communityIdx${community.communityIdx}">${community.likeCount}</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
										height="16" fill="currentColor" class="bi bi-chat"
										viewBox="0 0 16 16">
                                    <path
											d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105" />
                                </svg>
								</span> <span>${community.replyCount}</span>
							</div>
							<span class="vr ms-3 align-self-center" style="height: 50%"></span>
							<div class="ms-3">
								<span>${community.createdDate}</span>
							</div>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<c:forEach begin="1" end="${pageCount}" var="i">
					<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
						<a class="page-link" href="#" data-sort="${sort }"
						onclick="loadPage(event, ${i - 1})">${i}</a>
					</li>
				</c:forEach>
			</ul>
		</nav>


	</div>
</div>
<div class="d-flex justify-content-end mb-3">
	<button class="btn btn-primary writeBtn">글쓰기</button>
</div>



