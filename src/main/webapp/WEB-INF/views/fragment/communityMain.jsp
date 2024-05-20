<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script>
    // 이전 페이지의 상태를 저장할 변수
    let previousPageState = null;
    
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
                                <p>` + comment.createdDate+ `</p> 
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
            // 새로운 페이지로 이동할 때 이전 페이지의 상태를 저장
            if (previousPageState) {
                history.pushState(previousPageState, '', window.location.href);
            }

            // 새로운 페이지의 상태를 설정하고 URL 업데이트
            const newState = { sort, page: page }; // 페이지 번호도 함께 저장
            const url = `/CommunitySort?sort=` + sort + `&page=` + page + `&size=5`;
            history.pushState(newState, '', url);

            const response = await fetch(url, {
                method: 'GET',
                headers: {
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
            // 새로운 페이지로 이동할 때 이전 페이지의 상태를 저장
            if (previousPageState) {
                history.pushState(previousPageState, '', window.location.href);
            }

            // 새로운 페이지의 상태를 설정하고 URL 업데이트
            const newState = { communityIdx: communityIdx };
            history.pushState(newState, '', `?communityIdx=` + communityIdx);

            const response = await fetch(`/CommunityDetail/` + communityIdx, {
                method: 'GET',
                headers: {
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

            } else {
                console.error('데이터를 가져오지 못했습니다 : ', response.status, response.statusText);
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }

    async function loadWrite(userIdx) {
        try {
            // 새로운 페이지로 이동할 때 이전 페이지의 상태를 저장
            if (previousPageState) {
                history.pushState(previousPageState, '', window.location.href);
            }

            // 새로운 페이지의 상태를 설정하고 URL 업데이트
            const newState = { userIdx: userIdx };
            history.pushState(newState, '', `?userIdx=` + userIdx);

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
    
    
    document.addEventListener('DOMContentLoaded', function () {
        window.addEventListener('popstate', (event) => {
            // 이전 페이지의 상태가 있는 경우 해당 상태로 페이지를 다시 렌더링
            if (event.state) {
                previousPageState = event.state;
                if (previousPageState.sort) {
                    loadContent(previousPageState.sort, 0);
                } else if (previousPageState.communityIdx) {
                    loadDetail(previousPageState.communityIdx);
                }
            } 
        });

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
            if (likeButton) {
                // 페이지 이동을 막음
                event.stopPropagation();
                const communityIdx = likeButton.getAttribute('data-community-idx');
                const userIdx = document.getElementById('userIdx').value;
                const isLiked = likeButton.getAttribute('data-liked') === 'true';
                const url = isLiked ? '/LikeDelete' : '/LikeAdd';
                const method = isLiked ? 'DELETE' : 'POST';

                try {
                    const response = await fetch(url, {
                        method: method,
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            communityIdx: communityIdx,
                            userIdx: userIdx
                        })
                    });

                    if (response.ok) {
                        updateLikeButtons();
                        const loadLikesResponse = await fetch('/LoadLikes', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'communityIdx=' + communityIdx + '&userIdx=' + userIdx
                        });

                        if (loadLikesResponse.ok) {
                            const loadlikes = await loadLikesResponse.text();
                            document.getElementById('communityIdx' + communityIdx).innerText = loadlikes;
                        } else {
                            alert('오류가 발생했습니다. 다시 시도해주세요.');
                        }
                    } else {
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                } catch (error) {
                    console.error('Error:', error);
                    alert('오류가 발생했습니다. 다시 시도해주세요.');
                }
            } else if (communityDetail) {
                // loadDetail 함수 호출
                const communityIdx = communityDetail.getAttribute('data-community-idx');
                loadDetail(communityIdx);
            } else if (writeBtn) {
            	const userIdx = document.getElementById('userIdx').value;
            	loadWrite(userIdx);
            }

        });

        document.addEventListener('keydown', function(event) {
            // .replyBox 요소에 해당하는지 확인
            if (event.target.classList.contains('replyBox')) {
                const isLoggedIn = document.getElementById('isLoggedIn').value == 'true';
                const communityIdx = event.target.getAttribute('data-community-idx');

                // 엔터키가 눌렸을 때
                if (event.keyCode == 13 && !event.shiftKey) { // Shift 키가 눌리지 않았을 때만 처리
                    event.preventDefault(); // 기본 동작(줄바꿈) 방지
                    if (!isLoggedIn) {
                        // 비 로그인 상태일 경우 로그인 페이지로 리다이렉트
                        window.location.href = '/personlogin';
                        return; // 이후의 코드 실행을 막기 위해 함수를 여기서 종료
                    }
                    var replyContent = event.target.value; // 댓글 내용을 가져옴
                    console.log(replyContent); // 댓글 내용 확인용(실제로는 댓글을 추가하는 로직을 구현)
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
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
                    event.target.value = ''; // 텍스트 에어리어 초기화
                }
            }
        });



        
    });
</script>
</head>
<body>
	<input type="hidden" id="userIdx" value="${user.userIdx}">
	<div class="container mt-4" id="communityMain"></div>
</body>
</html>