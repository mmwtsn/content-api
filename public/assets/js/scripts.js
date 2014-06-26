$(document).ready(function() {
  //
  // Ensure search input field is empty on load
  //
  var $product = $('#product');
  $product.val('');

  //
  // Prevent user from submitting empty search queries;
  // Toggle display of search instructions to the user
  //
  var $search_input = $('#search input[type="submit"]');
  $search_input.on('click', function(e) {
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

    $('.search-instructions').show();
  });

  //
  // Allow user to clear search results and query
  //
  $('#clear-search').on('click', function() {
    $('.results').empty();

    // TODO
    // This selector is stupid--remove the ID or rename "product"
    $('#search #product').val('');

    $('.search-instructions').hide();
  });

});
