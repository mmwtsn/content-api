/*
 * Allow users to close modal windows by pressing ESC or clicking off screen.
 */

; (function() {

  $(document).keyup(function(e) {
    var $modal = $('.modal');

    if (e.keyCode == 27) {
      if ($modal.hasClass('visible')) {
        $modal.removeClass('visible');
      }
    }
  });

  $('.modal_overlay').on('click', function() {
    $('.modal').removeClass('visible');
  });

}());
