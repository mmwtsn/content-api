//
// Handles the displaying of and submission of AJAX-ready #create forms
//

// Define Resource#create module
var create = (function() {

  // Define config object for later use
  var config = {};

  // Initialize instance of module, calls setup()
  var init = function( resource ) {
    config = configure( resource );

    config.$show.on( 'click', toggle );
    config.$submit.on( 'click', submit );
  };

  // Build config object with jQuery obects and resources string
  var configure = function( resource ) {
    config.resource = resource;

    // Use singular form of resource for selector
    resource = singularize_resource( resource );

    config.$submit = $('#create_' + resource);
    config.$show   = $('#show_new_' + resource);
    config.$form   = $('#new_' + resource);

    return config;
  };

  // Strip last character from plural resource
  var singularize_resource = function( resource ) {
    return resource.slice(0, -1);
  };

  // Toggle visibility of $form if hidden
  var toggle = function() {

    // Cache references for readability
    var $form = config.$form;
    var $show = config.$show;

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
      config.$show.remove();
      config.$submit.show();

    }, 300);

  };

  // Attempt to submit the create resource form
  var submit = function() {
    return form_is_complete() ? ajax_submit() : submit_error();
  };

  // Checks to see if the create resource form is complete
  var form_is_complete = function() {
    var $input = config.$form.children( 'input[type="text"]' ).first();
    var value  = $input.val();

    return (value !== '');
  };

  // Displays an error to the user if the form is submitted prematurely
  var submit_error = function() {
    var error = '<p class="error">Whoa! Submit something.</p>';

    config.$form.prepend( error );

    return false;
  };

  // Submit the create resource form via an AJAX POST request
  var ajax_submit = function() {

    // Build submit path for current nested Rails resource
    var url = build_nested_path();

    // Build POST data from form
    var data = config.$form.serialize();

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
    var url = id + '/' + config.resource;

    return url;
  };

  // Reset form to empty state upon successful POST
  var reset_form = function() {
    config.$form.children('input[type="text"]').val('');
  };

  return {
    init: init,
    config: config
  };

});

// Assign instances of create module
var s = create();
var r = create();

// Initialize create module for Scenario and Resources
s.init( 'scenarios' );
r.init( 'resources' );
