document.addEventListener("DOMContentLoaded", function() {
    // 초기화 함수 호출
    initialize();

    function initialize() {
        // 경력 슬라이더 초기화
        initializeExperienceSlider();

        // 지역 선택 초기화
        initializeRegionSelection();

        // 기본값 설정
        setDefaultValues();

        // 이벤트 리스너 등록
        registerEventListeners();
    }

    // 경력 슬라이더 초기화
    function initializeExperienceSlider() {
        var experienceSlider = document.getElementById('experienceSlider');
        var experienceValue = document.getElementById('experienceValue');
        var btnExperience = document.getElementById('btn_experience');

        // 초기화할 때 경력이 무관으로 설정되도록 함
        experienceValue.innerText = '무관';
        btnExperience.innerText = '경력 무관';

        experienceSlider.addEventListener('input', function() {
            var value = this.value;
            var label = getExperienceLabel(value);
            experienceValue.innerText = label;
            btnExperience.innerText = '경력 ' + label;
        });
    }

    // 경력 슬라이더 값에 따른 레이블 반환
    function getExperienceLabel(value) {
        return value === '-1' ? '무관' : value === '0' ? '신입' : value === '11' ? '10년차 이상' : value + '년차';
    }

    // 지역 선택 초기화
    function initializeRegionSelection() {
        var dropdownItems = document.querySelectorAll('.region-item');
        dropdownItems.forEach(function(item) {
            item.addEventListener('click', function() {
                var value = this.getAttribute('data-value');
                var dropdownButton = document.getElementById('btn-region');
                dropdownButton.textContent = '지역 ' + value;
            });
        });
    }

    // 기본값 설정
    function setDefaultValues() {
        document.getElementById('btn-region').textContent = '지역 전국';
        document.getElementById('btn_experience').innerText = '경력 무관';
    }

    // 이벤트 리스너 등록
    function registerEventListeners() {
        // 'X' 아이콘 클릭 이벤트 등록
        document.querySelectorAll(".clear-icon").forEach(function(clearIcon) {
            clearIcon.addEventListener("click", function(event) {
                // 이벤트 전파를 막습니다.
                event.stopPropagation();

                // input 요소를 찾아서 내용을 지우고 포커스를 줍니다.
                var input = this.parentNode.querySelector("input");
                if (input) {
                    input.value = "";
                    input.focus();
                }
                // 'X' 아이콘 숨기고 돋보기 아이콘을 표시합니다.
                document.querySelectorAll(".clear-icon").forEach(el => el.style.display = "none");
                document.querySelectorAll(".search-icon").forEach(el => el.style.display = "block");

                // SearchJobType의 목록도 초기화합니다.
                var searchResultList = document.querySelector("#SearchJobType");
                if (searchResultList) {
                    searchResultList.innerHTML = ''; // searchResult의 내용을 비웁니다.
                }
            });
        });

        // 입력란에 값 입력 시 'X' 아이콘 표시 이벤트 등록
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

        // 검색 버튼 클릭 이벤트 등록
        const searchPosting = document.getElementById('searchPosting');
        searchPosting.addEventListener('click', function() {
            sendData();
        });
    }

    // 데이터 전송 함수
    function sendData() {
        const region = document.getElementById('btn-region').textContent.replace('지역 ', '');
        const experience = document.getElementById('experienceValue').innerText;
        const selectedSkills = Array.from(document.querySelectorAll('.dropdown-menu input[type="checkbox"]:checked'))
            .map(item => item.value);
        const selectedJobs = Array.from(document.querySelectorAll('#selectedJobs .btn')).map(item => item.innerHTML);
        // 데이터를 객체로 구성
        const params = {
            region: region,
            experience: experience,
            selectedSkills: selectedSkills.join(','), // 배열을 콤마로 구분된 문자열로 변환
            selectedJobs: selectedJobs.join(',')
        };

        // URLSearchParams를 사용하여 자동으로 쿼리 스트링 생성
        const queryString = new URLSearchParams(params).toString();
        const url = `/SearchResult?` + queryString;

        fetch(url, {
            method: 'GET',
        })
            .then(response => response.text())
            .then(response => {
                document.querySelector("#result").innerHTML = response;
            })
            .catch(error => {
                console.error("Error: " + error);
                document.querySelector("#result").innerHTML = "검색 결과를 불러오는데 실패했습니다.";
            });
    }
});
