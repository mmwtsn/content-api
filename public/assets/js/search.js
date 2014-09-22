//
// Prevent user from submitting empty search queries;
//
var $submit = $('.product_submit');

$submit.on('click', function(e) {

  var $modal   = $(this).parents('.modal')
  ,   $results = $modal.find('.results_wrapper')
  ,   $errors  = $modal.find('.errors')
  ,   query    = $modal.find('.product_query').val();

  // Ensure results and errors are cleared between searches
  $results.removeClass('open').find('.product').remove();

  $errors.empty().hide();

  if (query === '') {
    e.preventDefault();
    $errors.append('<li>Search query cannot be blank!</li>').slideDown();
  }
  else {
    $submit.addClass('loading');
  }
});

//
// Allow user to clear search results and query
//
$('.product_reset').on('click', function(e) {
  e.preventDefault();

  $('.results_wrapper .product').remove();

  $('#product').val('');

  $('.search_instructions').hide();

  $('.results_wrapper').removeClass('open');
});

//
// Remove deleted product upon successful POST
//
$(document).on('ajax:success', '.delete_product', function() {

  var $product  = $(this).parents('.product')
  ,   $products = $(this).parents('.products');

  if($products.children('.product').length === 1) {
    $products.append('<div class="empty"><p>This scenario has no products!</p></div>');
  }

  $product.remove();

});
