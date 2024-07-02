 $(document).ready(function(){
    $("#user-icon").click(function(){
        $(".mypage-toggle-box").toggle();
        $(".noti-toggle-box").hide();
    });

    $("#noti-icon").click(function(){
        $(".mypage-toggle-box").hide();
        $(".noti-toggle-box").toggle();
    });
});