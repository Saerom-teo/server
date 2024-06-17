 document.addEventListener('DOMContentLoaded', function () {
    var titles = document.querySelectorAll('#noticeTitle');
    titles.forEach(function (title) {
        title.addEventListener('click', function () {
            var content = this.nextElementSibling;
            if (content.id === 'noticeContent') {
                if (content.style.display === 'none' || content.style.display === '') {
                    content.style.display = 'table-row';
                } else {
                    content.style.display = 'none';
                }
            }
        });
    });
});