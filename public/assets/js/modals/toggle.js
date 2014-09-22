/*
 * Toggles the visibility of a modal window ("open" and "✗ close").
 */

; (function() {

  $('.js_modal_toggle').on('click', function() {

    var scenario_name = $(this).data('name')
    ,   $modal        = $('.modal[data-name="' + scenario_name + '"]');

    $modal.toggleClass('visible');

    setTimeout(function() {
      $modal.find('input[type="text"]').first().focus();
    }, 100);
  });

}());
