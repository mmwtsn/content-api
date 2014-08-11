//
// Prevent user from submitting empty search queries;
//
var $search_input = $('#search input[type="submit"]');

$search_input.on('click', function(e) {
  var query = $( '#product' ).val();
  var $results = $('.results');

  console.log( 'CLICK' );

  // Ensure results and errors are cleared between searches
  $results.empty();

  $('.error').slideUp();

  if (query === '') {
    e.preventDefault();
    $('main').prepend('<p class="error">Search query cannot be blank!</p>');
  }
  else {
    // Add "loading" class until products are returned
    $search_input.addClass('loading');
  }
});

//
// Allow user to clear search results and query
//
$('#clear-search').on('click', function( e ) {
  e.preventDefault();

  $('.results').empty();

  // This selector is stupid--remove the ID or rename "product"
  $('#product').val('');

  $('.search-instructions').hide();
});

//
// Remove deleted product upon successful POST
//
$('body').on('ajax:success', '.delete-product', function() {
  $(this).closest('.scenario-product').remove();

  var $products = $('.scenario-products');

  // Was that the last record present in the UI?
  if (!$products.find('.scenario-product').length) {
    $products.append(
      '<section class="scenario-product empty">' +
        '<p>no saved products…</p>' +
      '</section>'
    );
  }
});
