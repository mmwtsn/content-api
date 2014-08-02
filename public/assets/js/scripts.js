//
// Parent module for configuring create and toggle modules
//

// Returns an object with the Rails Controller name and relevant jQuery objects
var Config = (function() {

  // Public method for building the configuration object
  var configure = function( resource ) {
    var config = {};

    // Cache reference to Rails controller name
    config.resources = resource;

    // Use singular form of resource for selector
    resource = singularize_resource( resource );

    // Cache references to DOM elements
    config.$submit = $('#create_' + resource);
    config.$show   = $('#show_new_' + resource);
    config.$form   = $('#new_' + resource);

    // Return configuration object
    return config;
  };

  // Strip last character from plural resource
  var singularize_resource = function( resource ) {
    return resource.slice(0, -1);
  };

  // Expose public API
  return {
    configure: configure
  };

});

//
// Handles the submission of AJAX-ready Controller#create forms
//

// Returns an initializer for binding to the submit event
var create = (function() {

  // Cache local references to jQuery objects for use
  var $form, $show, $submit, resources;

  // Initialize instance of module, calls setup()
  var init = function( resource ) {
    var config = Config().configure( resource );

    // Expose objects from config to simplify reference
    $form     = config.$form;
    $show     = config.$show;
    $submit   = config.$submit;
    resources = config.resources;

    $show.on( 'click', toggle );
    $submit.on( 'click', submit );
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
