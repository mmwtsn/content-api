$('.js-modal-toggle').on('click', function() {
  var scenario_name  = $(this).data('name');

  $('.modal[data-name="' + scenario_name + '"]').toggleClass('visible');
});

$(document).keyup(function(e) {
  var $modal = $('.modal');

  if (e.keyCode == 27) {
    if ($modal.hasClass('visible')) {
      $modal.removeClass('visible');
    }
  }
});
