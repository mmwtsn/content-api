//
// Handles the submission of AJAX-ready Controller#create forms
//

// Returns an initializer for binding to the submit event
var create = (function() {

  // Cache local references to jQuery objects for use
  var config = {};

  // Initialize instance of module, calls setup()
  var init = function( resource ) {
    config = Config().configure( resource );

    config.$submit.on( 'click', submit );
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
    var url = id + '/' + resources;

    return url;
  };

  // Reset form to empty state upon successful POST
  var reset_form = function() {
    config.$form.children('input[type="text"]').val('');
  };

  // Expose public methods
  return {
    init: init
  };

});
