document.addEventListener('DOMContentLoaded', function () {
    // Intersection Observer 초기화
    initIntersectionObserver();

    // 카테고리 하이라이트 초기화
    highlightCategory();

    // 숫자 증가 애니메이션 초기화
    initCountUp('#collection-amoount span', 0, 24811, 100);
});

// Intersection Observer 초기화 함수
function initIntersectionObserver() {
    let options = {
        threshold: 0.1 // 요소가 10% 이상 뷰포트에 들어왔을 때 콜백 실행
    };

    let observer = new IntersectionObserver(function (entries, observer) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible'); // 요소가 보이기 시작하면 'visible' 클래스 추가
                observer.unobserve(entry.target); // 한 번 관찰 후 더 이상 관찰하지 않음
            }
        });
    }, options);

    // 모든 .container 요소를 관찰 대상으로 설정
    document.querySelectorAll('.container').forEach(container => {
        observer.observe(container);
    });
}

// 카테고리 하이라이트 초기화 함수
function highlightCategory() {
    var categoryNo = document.body.getAttribute('category-no');
    var navLinks = document.querySelectorAll('.semi-header a');

    if (categoryNo && navLinks[categoryNo]) {
        navLinks[categoryNo].classList.add('black'); // 해당 카테고리 번호에 해당하는 링크에 'black' 클래스 추가
    }
}

// 숫자 증가 애니메이션 함수
function initCountUp(target, start, end, duration) {
    var current = start;
    var increment = end > start ? 251 : -251; // 증가할 값의 단위
    var stepTime = Math.abs(Math.floor(duration / ((end - start) / 10))); // 애니메이션의 각 스텝 시간 계산

    var timer = setInterval(function () {
        current += increment;
        $(target).text(current); // 현재 숫자를 요소에 표시
        if ((increment > 0 && current >= end) || (increment < 0 && current <= end)) {
            clearInterval(timer); // 목표 값에 도달하면 타이머 종료
            $(target).text(end); // 최종 값을 요소에 설정
        }
    }, stepTime);
}
