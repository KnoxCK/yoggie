$(window).scroll(function() {    
    var scroll = $(window).scrollTop();

    if (scroll > $(window).height() * 0.05) {
        $(".navbar-yoggie").addClass("hidden");
        $(".navbar-yoggie-scroll").removeClass("hidden");
    } else if (scroll < $(window).height()) {
        $(".navbar-yoggie").removeClass("hidden");
        $(".navbar-yoggie-scroll").addClass("hidden");
    }
});
