$( document ).ready(function() {
    $(".js-tab").on("click", function(target) {
      console.log('clicked');
            $(this).addClass("tab--active").siblings().removeClass('tab--active');
            var dataLink = $(this).attr('data-tab');

            $(this).parents(".js-tabs-container").find(".js-tab-content").each(function() {
                var dataArticle = $(this).attr("data-tab");

                if (dataArticle == dataLink) {
                    $(this).addClass('tab-content--active').siblings(".js-tab-content").removeClass('tab-content--active');
                }
                else {
                    $(this).removeClass('tab-content--active');
                }
            });
    });
});
