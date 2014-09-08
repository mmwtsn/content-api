$('.js-modal-toggle').on('click', function() {
  var scenario_name  = $(this).data('name')
  ,   $modal         = $('.modal[data-name="' + scenario_name + '"]');

  $modal.toggleClass('visible');

  setTimeout(function() {
    $modal.find( 'input[type="text"]' ).first().focus();
  }, 100);
});

$(document).keyup(function(e) {
  var $modal = $('.modal');

  if (e.keyCode == 27) {
    if ($modal.hasClass('visible')) {
      $modal.removeClass('visible');
    }
  }
});

$('.modal-overlay').on('click', function() {
  $('.modal').removeClass('visible');
});
