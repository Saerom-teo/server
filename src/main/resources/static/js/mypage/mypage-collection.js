$(document).ready(function() {
    function formatDate(timestamp) {
        var date = new Date(timestamp);
        return date.getFullYear() + '.' + (date.getMonth() + 1).toString().padStart(2, '0') + '.' + date.getDate().toString().padStart(2, '0');
    }

    function renderTable(data) {
        var tableBody = $('#collection-table tbody');
        tableBody.empty(); // Clear the existing table body

        data.forEach(function(item, index) {
            var weight = item.weight !== null ? item.weight + 'kg' : '-';
            var point = item.point !== null ? '+' + item.point + 'P' : '-';
            var cancelDisabled = item.collectionStatus ? '' : 'disabled';

            var dataRow = `
                <tr class="data">
                    <td>${index + 1}</td>
                    <td>${formatDate(item.requestedDate)}</td>
                    <td>${weight}</td>
                    <td>${point}</td>
                    <td>${item.status}</td>
                    <td><img src="/app/static/icon/arrow.svg" class="arrow"></td>
                </tr>
                <tr class="detail" data-highlight="${item.highlight}" data-id="${item.collectionId}"
                    data-resultimage1="${item.resultImage1 || ''}" data-resultimage2="${item.resultImage2 || ''}"
                    data-resultimage3="${item.resultImage3 || ''}" data-resultimage4="${item.resultImage4 || ''}"
                    data-collectionstatus="${item.collectionStatus}">
                    <td colspan="6">
                        <div class="detail-wrapper">
                            <div class="detail-content">
                                <div class="container">
                                    <div class="line"></div>
                                    <div class="green-line"></div>
                                    <div class="circle">
                                        <div class="number">접수</div>
                                    </div>
                                    <div class="circle">
                                        <div class="number">검사완료</div>
                                    </div>
                                    <div class="circle">
                                        <div class="number">승인완료</div>
                                    </div>
                                    <div class="circle">
                                        <div class="number">수거완료</div>
                                    </div>
                                    <div class="circle">
                                        <div class="number">포인트 지급</div>
                                    </div>
                                </div>
                                <div class="container-footer">
                                    <button class="result-btn">검사 결과 보기</button>
                                    <button class="cancel-btn" ${cancelDisabled}>취소하기</button>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            `;
            tableBody.append(dataRow);
        });

        attachRowClickHandlers();
        attachCancelBtnHandlers();
        attachResultBtnHandlers(); // Add this line
    }

    function attachRowClickHandlers() {
        $('.data').off('click').on('click', function() {
            var arrow = $(this).find('.arrow');
            var detailWrapper = $(this).next('.detail').find('.detail-wrapper');

            // 현재 열려 있는 detail 행을 닫기
            $('.detail .detail-wrapper').not(detailWrapper).css('max-height', '0px');
            $('.arrow').not(arrow).removeClass('rotate');

            arrow.toggleClass('rotate');

            if (detailWrapper.css('max-height') === '0px' || detailWrapper.css('max-height') === 'none') {
                var contentHeight = detailWrapper.find('.detail-content').outerHeight();
                detailWrapper.css('max-height', contentHeight + 'px');
            } else {
                detailWrapper.css('max-height', '0px');
            }

            var highlightNum = $(this).next('.detail').data('highlight');
            detailWrapper.find('.container').each(function() {
                positionCircles($(this), highlightNum);
            });
        });
    }

    function attachCancelBtnHandlers() {
        $('.cancel-btn').off('click').on('click', function() {
            var detailRow = $(this).closest('.detail');
            var collectionId = detailRow.data('id');
            var highlightNum = detailRow.data('highlight');
            var collectionStatus = detailRow.data('collectionstatus');

            if (!collectionStatus) {
                alert('취소가 불가능한 상태입니다.');
                return;
            }

            if (highlightNum <= 3) {
                if (confirm('정말로 취소하시겠습니까?')) {
                    window.location.href = '/app/mypage/collection/cancel?collectionId=' + collectionId;
                }
            } else {
                alert('취소가 불가능한 단계입니다.');
            }
        });
    }

    function attachResultBtnHandlers() {
        $('.result-btn').off('click').on('click', function() {
            var detail = $(this).closest('.detail');
            var image1 = detail.data('resultimage1');
            var image2 = detail.data('resultimage2');
            var image3 = detail.data('resultimage3');
            var image4 = detail.data('resultimage4');

            var images = [image1, image2, image3, image4];
            var imagesContainer = $('#resultModal .result-images');
            imagesContainer.empty(); // Clear previous images

            var allImagesNull = true;

            images.forEach(function(image, index) {
                if (image) {
                    imagesContainer.append('<img src="' + image + '" alt="Result Image ' + (index + 1) + '">');
                    allImagesNull = false;
                }
            });

            if (allImagesNull) {
                imagesContainer.append('<div class="no-result">현재 검사가 진행 중입니다. 나중에 다시 확인해 주세요.</div>');
            }

            $('#resultModal').css('display', 'flex');
        });

        $('.close').off('click').on('click', function() {
            $('#resultModal').css('display', 'none');
        });

        $(window).off('click').on('click', function(event) {
            if (event.target.id === 'resultModal') {
                $('#resultModal').css('display', 'none');
            }
        });
    }

    function positionCircles(container, highlightNum) {
        const circles = container.find('.circle');
        const numbers = container.find('.number');
        const line = container.find('.line');
        const greenLine = container.find('.green-line');
        const containerWidth = container.width();
        const circleSize = parseInt(getComputedStyle(document.documentElement).getPropertyValue('--circle-size'));
        const gap = (containerWidth - circleSize - 5) / (circles.length - 1);

        circles.each(function(index) {
            $(this).css('left', `${index * gap}px`);
            if (index < highlightNum) {
                $(this).addClass('filled');
            } else {
                $(this).addClass('unfilled');
            }

            numbers.eq(index).removeClass('active-number');
        });

        if (highlightNum > 0 && highlightNum <= numbers.length) {
            numbers.eq(highlightNum - 1).addClass('active-number');
        }

        line.css({
            'left': `${circleSize / 2}px`,
            'width': `${containerWidth - circleSize}px`
        });

        greenLine.css({
            'left': `${circleSize / 2}px`,
            'width': `${(highlightNum - 1) * gap}px`
        });
    }

    window.addEventListener('load', function() {
        $('.container').each(function() {
            var highlightNum = $(this).closest('.detail').data('highlight');
            positionCircles($(this), highlightNum);
        });
    });

    window.addEventListener('resize', function() {
        $('.container').each(function() {
            var highlightNum = $(this).closest('.detail').data('highlight');
            positionCircles($(this), highlightNum);
        });
    });

    // AJAX call to get collectionData
    $.ajax({
        url: '../api/collection/read-collection',
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            renderTable(data);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data:', status, error);
        }
    });
});
