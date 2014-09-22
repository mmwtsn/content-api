/*
 * Responsibile for scrolling to the top or bottom of modal search results.
 */

(function() {

  var resultScroll = function(that, position) {
    $(that).siblings('.results_container').animate({
      scrollTop: position
    }, 600);
  }

  $('.modal_scroll.top').on('click', function() {
    resultScroll(this, 0);
  });

  $('.modal_scroll.bottom').on('click', function() {
    resultScroll(this, $('.results').height());
  });

}());
