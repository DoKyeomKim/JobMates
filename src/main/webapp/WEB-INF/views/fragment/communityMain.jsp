<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
/* 추가적인 CSS 스타일링 */
html, body {
	height: 100%;
	margin: 0;
	display: flex;
	flex-direction: column;
}

footer {
	background-color: #343a40;
	color: white;
	text-align: center;
	margin-top: auto;
	padding: 1rem;
	width: 100%;
}

header {
	background-color: #e0f7fa;
}

#section {
	flex-grow: 1;
}

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

.nav-tabs>li {
	flex: 1; /* flex-grow, flex-shrink 및 flex-basis를 1로 설정 */
	text-align: center; /* 텍스트를 중앙에 정렬 */
	border-top: 1px solid #dee2e6;
}
/* 모든 li 요소에 상단 테두리 추가 */
.nav-tabs>li {
	border-top: 1px solid #dee2e6;
}

/* 첫 번째 li에 왼쪽과 오른쪽 테두리 추가 */
.nav-tabs>li:first-child {
	border-left: 1px solid #dee2e6;
	border-right: 1px solid #dee2e6;
}

/* 두 번째 li에 오른쪽 테두리 추가 */
.nav-tabs>li:nth-child(2) {
	border-right: 1px solid #dee2e6;
}

/* 마지막 li에 왼쪽과 오른쪽 테두리 추가 */
.nav-tabs>li:last-child {
	border-left: 1px solid #dee2e6;
	border-right: 1px solid #dee2e6;
}

/* 추가적으로, 탭을 가운데 정렬 */
.nav-tabs {
	justify-content: center;
}
</style>
<link rel="icon" type="image/x-icon" href="/images/favicon.png">
<link href="/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<input type="hidden" id="userIdx" value="${user.userIdx}">
	
	<div class="container mt-4" id="communityMain">
		<%@ include file="/WEB-INF/views/fragment/communityList.jsp"%>
	</div>
	<script>
    function loadPage(event, page) {
        event.preventDefault(); // 기본 동작(링크 이동) 방지
        const sort = event.target.getAttribute('data-sort'); // 클릭된 링크의 sort 값 가져오기
        loadContent(sort, page); // loadContent 함수 호출
    }

    function loadReply(communityIdx) {
        fetch(`/LoadReply/` + communityIdx)
            .then(response => {
                if (!response.ok) {
                    throw new Error('댓글을 불러오는 데 실패했습니다.');
                }
                return response.json();
            })
            .then(comments => {
                let commentsHtml = '';
                comments.forEach(comment => {
                    commentsHtml += `
                        <div class="px-3 py-4">
                            <div class="d-flex justify-content-between">
                                <p>` + comment.replyName + `</p> 
                                <p>` + comment.createdDate + `</p> 
                            </div>
                            <p>` + comment.replyContent + `</p> 
                        </div>`;
                });
                // 특정 게시물의 댓글 섹션에 댓글 목록을 업데이트합니다.
                document.querySelector('.reply-container').innerHTML = commentsHtml;
            })
            .catch(error => {
                alert(error.message);
            });
    }

    async function loadContent(sort, page = 0) {
        try {
            const url = `/CommunitySort?sort=` + sort + `&page=` + page + `&size=5`;
            const response = await fetch(url, {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Content-Type': 'text/html'
                }
            });

            if (response.ok) {
                const data = await response.text();
                document.getElementById('communityMain').innerHTML = data;
                updateLikeButtons();
            } else {
                console.error('데이터를 가져오지 못했습니다 : ', response.status, response.statusText);
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }

    async function loadDetail(communityIdx) {
        try {
            const response = await fetch(`/CommunityDetail/` + communityIdx, {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Content-Type': 'text/html'
                }
            });

            if (response.ok) {
                const data = await response.text();
                document.getElementById('communityMain').innerHTML = data;

                // DOM 업데이트 후에 실행되도록 보장
                requestAnimationFrame(() => {
                    updateLikeButtons();
                    updateView(communityIdx);
                });

                // 페이지 상태를 히스토리에 추가
                history.pushState({ communityIdx: communityIdx }, '', `?communityIdx=` + communityIdx);

            } else {
                console.error('데이터를 가져오지 못했습니다 : ', response.status, response.statusText);
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }

    async function loadWrite(userIdx) {
        try {
            const response = await fetch(`/CommunityWrite`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'text/html'
                }
            });

            if (response.ok) {
                const data = await response.text();
                document.getElementById('communityMain').innerHTML = data;
            } else {
                console.error('데이터를 가져오지 못했습니다 : ', response.status, response.statusText);
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }

    async function updateLikeButtons() {
        document.querySelectorAll('.like_btn').forEach(async (button) => {
            const communityIdx = button.getAttribute('data-community-idx');
            const userIdx = document.getElementById('userIdx').value;
            const svg = button.querySelector('svg');

            try {
                const response = await fetch('/CheckLike/' + communityIdx + '/' + userIdx);
                const isLiked = await response.json();
                button.setAttribute('data-liked', isLiked);
                svg.setAttribute('fill', isLiked ? 'blue' : 'currentColor');
            } catch (error) {
                console.error('Error:', error);
            }
        });
    }

    async function updateView(communityIdx) {
        try {
            const userIdx = document.getElementById('userIdx').value;
            const view = { userIdx: userIdx, communityIdx: communityIdx };
            const response = await fetch('/ViewAdd', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(view),
            });

            if (response.ok) {
                await LoadView(communityIdx); // 성공 시 LoadView 호출
            } else {
                console.error('View 추가에 실패했습니다.');
            }
        } catch (error) {
            console.error('View 추가 중 에러 발생:', error);
        }
    }

    async function LoadView(communityIdx) {
        try {
            const loadViewResponse = await fetch('/LoadView', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'communityIdx=' + communityIdx
            });

            if (loadViewResponse.ok) {
                const loadView = await loadViewResponse.text();
                document.getElementById('view' + communityIdx).innerText = loadView;
            } else {
                alert('오류가 발생했습니다. 다시 시도해주세요.');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('오류가 발생했습니다. 다시 시도해주세요.');
        }
    }
    async function UpdateReply(communityIdx) {
        try {
            const UpdateReplyResponse = await fetch('/UpdateReply', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'communityIdx=' + communityIdx
            });

            if (UpdateReplyResponse.ok) {
                const UpdateReply = await UpdateReplyResponse.text();
                document.getElementById('reply' + communityIdx).innerText = UpdateReply;
            } else {
                alert('오류가 발생했습니다. 다시 시도해주세요.');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('오류가 발생했습니다. 다시 시도해주세요.');
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        const urlParams = new URLSearchParams(window.location.search);
        const sort = urlParams.get('sort');
        const communityIdx = urlParams.get('communityIdx');

        if (communityIdx) {
            loadDetail(communityIdx);
        } else {
            loadContent(sort || 'recent', 0);
        }

        document.body.addEventListener('click', async (event) => {
            const likeButton = event.target.closest('.like_btn');
            const communityDetail = event.target.closest('.community-detail');
            const writeBtn = event.target.closest('.writeBtn');
            const clearIcon = event.target.closest('.clear-icon');

            if (clearIcon) { // 삭제 아이콘 클릭 시
                event.stopPropagation();
                const input = clearIcon.parentNode.querySelector('.search-input');
                input.value = ''; // 검색 입력란의 내용을 비웁니다.
                clearIcon.style.display = 'none'; // 삭제 아이콘 숨깁니다.
                const searchIcon = clearIcon.parentNode.querySelector('.search-icon');
                searchIcon.style.display = 'block'; // 검색 아이콘 표시합니다.
            } else if (likeButton) {
                // 좋아요 버튼 클릭 시의 로직
            } else if (communityDetail) {
                // 커뮤니티 디테일 클릭 시의 로직
            } else if (writeBtn) {
                // 글쓰기 버튼 클릭 시의 로직
            } else {
                const searchInput = document.querySelector('.search-input');
                if (searchInput && searchInput.value !== '') {
                    // 검색 입력란에 내용이 있는 경우
                    const searchIcon = searchInput.parentNode.querySelector('.search-icon');
                    searchIcon.style.display = 'none'; // 검색 아이콘 숨깁니다.
                }
                
                document.querySelectorAll(".search-box input").forEach(function (input) {
                    input.addEventListener("input", function () {
                        const clearIcon = input.parentNode.querySelector('.clear-icon');
                        const searchIcon = input.parentNode.querySelector('.search-icon');
                        
                        if (this.value == "") {
                            // 입력값이 없는 경우
                            clearIcon.style.display = "none"; // 'X' 아이콘 숨기기
                            searchIcon.style.display = "block"; // 검색 아이콘 표시
                        } else {
                            // 입력값이 있는 경우
                            clearIcon.style.display = "block"; // 'X' 아이콘 표시
                            searchIcon.style.display = "none"; // 검색 아이콘 숨기기
                        }
                    });
                });
                
            }
        });

 
        
        document.addEventListener('keydown', function (event) {
            if (event.key === 'Enter') {
                const searchInput = document.querySelector('.search-input');
                const replyBox = document.querySelector('.replyBox');

                if (searchInput === document.activeElement) {
                    // 검색 입력란에서 Enter 키가 눌렸을 때
                    event.preventDefault(); // 폼 제출을 방지합니다.
                    var keyword = searchInput.value.trim(); // 입력된 검색어를 가져옵니다.
                    if (keyword !== '') {
                    	
                        // 검색어가 비어있지 않다면 검색 요청을 보냅니다.
                    	fetch("/SearchCommunity?keyword=" + keyword, {
                    	    method: 'GET',
                    	    headers: {
                    	    	'X-Requested-With': 'XMLHttpRequest',
                    	        'Content-Type': 'text/html'
                    	        
                    	    }
                    	})
                    	.then(response => response.text()) // 텍스트 형식의 데이터로 변환
                        .then(data => {
                            // 검색 결과를 처리하고 화면에 표시하는 로직을 작성합니다.
                            document.getElementById('communityMain').innerHTML = data;
                        })
                        .catch(error => {
                            console.error("Error: " + error);
                            // 에러 처리 로직을 작성합니다.
                        });
                    }
                } else if (replyBox === document.activeElement) {
                    // 댓글 입력란에서 Enter 키가 눌렸을 때
                    const isLoggedIn = document.getElementById('isLoggedIn').value == 'true';
                    const communityIdx = replyBox.getAttribute('data-community-idx');

                    if (!event.shiftKey) {
                        event.preventDefault();
                        if (!isLoggedIn) {
                            window.location.href = '/personlogin';
                            return;
                        }
                        var replyContent = replyBox.value;
                        const replyData = {
                            replyContent: replyContent,
                            communityIdx: communityIdx
                        }
                        fetch('/ReplyInsert', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify(replyData),
                        })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('댓글 추가에 실패했습니다.');
                                }
                            })
                            .then(data => {
                                loadReply(communityIdx);
                                UpdateReply(communityIdx);
                            })
                            .catch(error => {
                                console.error('Error:', error);
                            });
                        replyBox.value = '';
                    }
                }
            }
        });

        window.addEventListener('popstate', function (event) {
            if (event.state && event.state.communityIdx) {
                loadDetail(event.state.communityIdx);
            } else {
                loadContent(sort || 'recent', 0);
            }
        });
        
       
        
    });
</script>
	

	<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>