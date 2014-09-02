// Initialize toggle module for Scenarios and Resources controllers
//var toggle_resource = toggle().init( 'resources' );
//var toggle_scenario = toggle().init( 'scenarios');

// Initialize create module for Scenarios and Resources controllers
//var create_resource = create().init( 'resources' );
//var create_scenario = create().init( 'scenarios' );

$('.delete-product').bind('ajax:success', function() {

  // Remove closest node with "resource" class
  $(this).parents('.product').remove();

  // If user just deleted the last resource, don't blow a hole in the page
  if (!$('.products .product').length) {
    // TODO - abstract this into a partial
    $('.products').append(
      '<section class="empty">'
    +   '<p>no saved products&#133;</p>'
    + '</section>'
    );
  }
});
