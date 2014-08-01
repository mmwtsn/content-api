//
// Handles the displaying of and submission of AJAX-ready #create forms
//

// Define Resource#create module
var create = (function() {

  // Define config object for later use
  var resources, $submit, $show, $form;

  // Initialize instance of module, calls setup()
  var init = function( resource ) {
    configure( resource );

    $show.on( 'click', toggle );
    $submit.on( 'click', submit );
  };

  // Build config object with jQuery obects and resources string
  var configure = function( resource ) {
    resources = resource;

    // Use singular form of resource for selector
    resource = singularize_resource( resource );

    $submit = $('#create_' + resource);
    $show   = $('#show_new_' + resource);
    $form   = $('#new_' + resource);
  };

  // Strip last character from plural resource
  var singularize_resource = function( resource ) {
    return resource.slice(0, -1);
  };

  // Toggle visibility of $form if hidden
  var toggle = function() {

    if( is_not_visible($form) ) {

      // Move $form into position
      $form.insertBefore( $show );

      // Update visibility and state
      $form
        .addClass( 'visible' )
        .slideDown( 600, swap_buttons );

    }

    // Ensure nothing happens when link or button is clicked
    return false;

  };

  // Check if a jQuery object has a "visible" class
  var is_not_visible = function( $form ) {
    return !$form.hasClass( 'visible' );
  };

  // Swaps the $show button for $submit after toggle() completes
  var swap_buttons = function() {

    setTimeout(function() {

      // Swap $show for $submit so the form still works
      $show.remove();
      $submit.show();

    }, 300);

  };

  // Attempt to submit the create resource form
  var submit = function() {
    return form_is_complete() ? ajax_submit() : submit_error();
  };

  // Checks to see if the create resource form is complete
  var form_is_complete = function() {
    var $input = $form.children( 'input[type="text"]' ).first();
    var value  = $input.val();

    return (value !== '');
  };

  // Displays an error to the user if the form is submitted prematurely
  var submit_error = function() {
    var error = '<p class="error">Whoa! Submit something.</p>';

    $form.prepend( error );

    return false;
  };

  // Submit the create resource form via an AJAX POST request
  var ajax_submit = function() {

    // Build submit path for current nested Rails resource
    var url = build_nested_path();

    // Build POST data from form
    var data = $form.serialize();

    // Submit via AJAX to save record
    $.post(url, data);

    // Clear submitted form input
    reset_form();

    // Ensure submit event is not triggered
    return false;

  };

  // Return the correct Rails RESTful resource path
  var build_nested_path = function() {
    var id = window.location.pathname;
    var url = id + '/' + resources;

    return url;
  };

  // Reset form to empty state upon successful POST
  var reset_form = function() {
    $form.children('input[type="text"]').val('');
  };

  // Expose public methods
  return {
    init: init
  };

});

// Assign instances of create module
var s = create();
var r = create();

// Initialize create module for Scenario and Resources
s.init( 'scenarios' );
r.init( 'resources' );
