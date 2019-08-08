// Testimonial section
$(document).on('click', '#faqs-first-heading', function(e) {
    $('.faqs-first-section').removeClass("hidden").toggle("slide");
  e.preventDefault();
});

$(document).on('click', '#faqs-second-heading', function(e) {
    $('.faqs-second-section').removeClass("hidden").toggle("slide");
  e.preventDefault();
});

$(document).on('click', '#faqs-third-heading', function(e) {
    $('.faqs-third-section').removeClass("hidden").toggle("slide");
  e.preventDefault();
});

$(document).on('click', '#faqs-fourth-heading', function(e) {
    $('.faqs-fourth-section').removeClass("hidden").toggle("slide");
  e.preventDefault();
});