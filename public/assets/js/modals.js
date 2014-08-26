$('.js-modal-toggle').on('click', function() {
  $('.modal').toggleClass('visible');
  $('body').toggleClass('modal-open');
});

$(document).keyup(function(e) {
  var $modal = $('.modal');

  if (e.keyCode == 27) {
    if ($modal.hasClass('visible')) {
      $modal.removeClass('visible');
    }
  }
});
