var element_wrap = document.getElementById('wrap');

function foldDaumPostcode() {
    element_wrap.style.display = 'none';
}

function sample3_execDaumPostcode() {
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function (data) {
            var addr = '';

            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }

            document.getElementById("address").value = addr;
            document.getElementById("detailAddress").focus();

            element_wrap.style.display = 'none';
            $("#address-modal").fadeOut();

            document.body.scrollTop = currentScroll;
        },
        onresize: function (size) {
            element_wrap.style.height = size.height + 'px';
        },
        width: '100%',
        height: '100%'
    }).embed(element_wrap);

    element_wrap.style.display = 'block';
}

$(document).ready(function () {
    var time = 100;
    $("#open-modal-btn").click(function () {
        $("#address-modal").fadeIn(time);
        sample3_execDaumPostcode();
    });

    $(".close").click(function () {
        $("#address-modal").fadeOut(time);
    });

    $(window).click(function (event) {
        if ($(event.target).is("#address-modal")) {
            $("#address-modal").fadeOut(time);
        }
    });
});
