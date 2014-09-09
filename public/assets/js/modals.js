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

var resultScroll = function( that, position ) {
  $( that ).siblings( '.results-container' ).animate({
    scrollTop: position
  }, 600);
}

$( '.modal-scroll.top' ).on( 'click', function() {
  resultScroll( this, 0 );
});

$( '.modal-scroll.bottom' ).on( 'click', function() {
  resultScroll( this, $('.results').height() );
});
