document.addEventListener("DOMContentLoaded", function() {
	var searchBox = document.querySelector(".search-box")
	var clearIcons = document.querySelectorAll(".clear-icon"); // 수정된 부분
	var searchInputs = document.querySelectorAll(".search-input"); // 수정된 부분
	var timer; // 타이머 전역 변수 선언
	
	// 'X' 아이콘 클릭 이벤트
	document.querySelectorAll(".clear-icon").forEach(function(clearIcon) {
		clearIcon.addEventListener("click", function() {
			// input 요소를 찾아서 내용을 지우고 포커스를 줍니다.
			var input = this.parentNode.querySelector("input");
			if (input) {
				input.value = "";
				input.focus();
			}
			// 'X' 아이콘 숨기고 돋보기 아이콘을 표시합니다.
			document.querySelectorAll(".clear-icon").forEach(el => el.style.display = "none");
			document.querySelectorAll(".search-icon").forEach(el => el.style.display = "block");
		});
	});

	// 입력란에 값 입력 시 'X' 아이콘 표시
	document.querySelectorAll(".search-box input").forEach(function(input) {
		input.addEventListener("input", function() {
			if (this.value == "") {
				// 입력란이 비었을 때 돋보기 아이콘 표시
				document.querySelectorAll(".clear-icon").forEach(el => el.style.display = "none");
				document.querySelectorAll(".search-icon").forEach(el => el.style.display = "block");
			} else {
				// 입력란에 텍스트가 있을 때 돋보기 아이콘 숨김
				document.querySelectorAll(".clear-icon").forEach(el => el.style.display = "block");
				document.querySelectorAll(".search-icon").forEach(el => el.style.display = "none");
			}
		});
	});

document.querySelector(".search-input").addEventListener("input", function() {
	clearTimeout(timer);
	var keyword = this.value;
	var input = this;

	if (keyword.length === 0) {
		document.querySelector("#searchResult").style.display = "none";
		return;
	}

	timer = setTimeout(function() {
		fetch("/SearchResult?keyword=" + encodeURIComponent(keyword))
			.then(response => response.text())
			.then(response => {
				document.querySelector("#searchResult").innerHTML = response;
				document.querySelector("#searchResult").style.display = "block"; // 검색 결과를 다시 표시
				input.focus();
				searchBox.style.display = "block"; // 이 줄은 searchBox가 검색 결과와 같은 컨테이너를 가리키는 경우에만 필요합니다.
			})
			.catch(error => {
				console.error("Error: " + error);
				document.querySelector("#searchResult").innerHTML = "검색 결과를 불러오는데 실패했습니다.";
				// 실패 메시지도 보여줘야 하므로 여기에도 display를 설정할 수 있습니다.
				document.querySelector("#searchResult").style.display = "block";
				input.focus();
			});
	}, 300);
});

});
