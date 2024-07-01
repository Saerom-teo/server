function toggleAnswer(element) {
    var $faqItem = $(element).closest('.faqItem');
    if ($faqItem.length === 0) {
        console.error('faqItem을 찾을 수 없습니다.');
        return;
    }
    
    var $answer = $faqItem.find('.faqAnswer');
    var $toggleIcon = $faqItem.find('.toggleIcon');

    // contextPath가 정의되어 있는지 확인
    if (typeof contextPath === 'undefined') {
        console.error('contextPath가 정의되지 않았습니다.');
        return;
    }

    // 모든 faqAnswer 닫기
    $('.faqAnswer').not($answer).slideUp(400);
    $('.toggleIcon').not($toggleIcon).attr('src', contextPath + '/static/img/plusPointer.svg').attr('alt', '열기');
    $('.faqQuestion').not(element).css('backgroundColor', '').css('color', '');

    // 현재 항목 슬라이드 토글
    $answer.slideToggle(400, function() {
        if ($answer.is(':visible')) {
            $toggleIcon.attr('src', contextPath + '/static/img/minusPointer.svg').attr('alt', '닫기');
            $(element).css('backgroundColor', '#F2F8ED').css('color', '#333232');
        } else {
            $toggleIcon.attr('src', contextPath + '/static/img/plusPointer.svg').attr('alt', '열기');
            $(element).css('backgroundColor', '').css('color', '');
        }
    });
}