$(document).ready(function () {
    $(window).scroll(function () {
        var scroll = $(window).scrollTop();
        if (scroll >= 100) {
            $(".menu").addClass("scrolling");
        } else {
            $(".menu").removeClass("scrolling");
        }
    });
});
