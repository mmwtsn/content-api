$(document).ready(function() {
  //
  // Ensure search input field is empty on load
  //
  var $product = $('#product');
  $product.val('');

  //
  // Prevent user from submitting empty search queries
  //
  $('#search input[type="submit"]').on('click', function(e) {
    var query = $product.val();
    var $results = $('.results');

    // Ensure results and errors are cleared between searches
    $results.empty();
    $('.error').slideUp();

    // TODO
    // Display AJAX loading GIF while request is being processed

    if (query === '') {
      e.preventDefault();
      $('main').prepend('<p class="error">Search query cannot be blank!</p>');
    }
  });
});
