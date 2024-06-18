function toggleAnswer(element) {
    var faqItem = element.closest('.faqItem');
    var answer = faqItem.querySelector('.faqAnswer');
    var toggleIcon = faqItem.querySelector('.toggleIcon');

    if (answer.style.display === 'none' || answer.style.display === '') {
        answer.style.display = 'block';
        toggleIcon.src = contextPath + "/static/img/minusPointer.svg";
        toggleIcon.alt = '닫기';
        element.style.backgroundColor = '#F2F8ED';
        element.style.color = '#333232';
    } else {
        answer.style.display = 'none';
        toggleIcon.src = contextPath + '/static/img/plusPointer.svg';
        toggleIcon.alt = '열기';
        element.style.backgroundColor = '';
        element.style.color = '';
    }
}
