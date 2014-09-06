//
// Prevent user from submitting empty search queries;
//
var $submit = $( '.product-submit' );

$submit.on( 'click', function(e) {

  var $modal   = $( this ).parents( '.modal' )
  ,   $results = $modal.find( '.results-wrapper' )
  ,   $errors  = $modal.find( '.errors' )
  ,   query    = $modal.find( '.product-query' ).val();

  // Ensure results and errors are cleared between searches
  $results.removeClass('open').find('.product').remove();

  $errors.empty().hide();

  if ( query === '' ) {
    e.preventDefault();
    $errors.append('<li>Search query cannot be blank!</li>').slideDown();
  }
  else {
    $submit.addClass( 'loading' );
  }
});

//
// Allow user to clear search results and query
//
$('.product-reset').on('click', function( e ) {
  e.preventDefault();

  $('.results-wrapper .product').remove();

  $('#product').val('');

  $('.search-instructions').hide();

  $('.results-wrapper').removeClass('open');
});

//
// Remove deleted product upon successful POST
//
$( document ).on( 'ajax:success', '.delete-product', function() {

  var $product  = $( this ).parents( '.product' )
  ,   $products = $( this ).parents( '.products' );

  if( $products.children( '.product' ).length === 1 ) {
    $products.append('<div class="empty"><p>This scenario has no products!</p></div>');
  }

  $product.remove();

});
