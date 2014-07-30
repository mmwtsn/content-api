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
  };

  // Build config object with jQuery obects and resources string
  var configure = function( resource ) {
    config['resource'] = resource

    // Use singular form of resource for selector
    resource = singularize_resource( resource );

    config['$submit'] = $('#create_' + resource);
    config['$show']   = $('#show_new_' + resource);
    config['$form']   = $('#new_' + resource);

    return config;
  };

  // Strip last character from plural resource
  var singularize_resource = function( resource ) {
    return resource.slice(0, -1);
  };

  // Toggle visibility of $form if hidden
  var toggle = function() {

    // Cache references for readability
    var $form   = config.$form;
    var $submit = config.$submit;

    // Check visibility of $form TODO - extract
    if( is_not_visible($form) ) {

      // Move $form into position
      $form.insertBefore( $submit );

      // Update visibility and state
      $form
        .slideDown( 600 )
        .addClass( 'visible' );

    }

    // Ensure nothing happens when link or button is clicked
    return false;

  };

  // Check if a jQuery object has a "visible" class
  var is_not_visible = function( $form ) {
    return !$form.hasClass( 'visible' );
  };

  // Expose public methods through create module
  return {
    init: init,
    config: config
  };

});

// Assign instances of create module
var s = create();
var r = create();

// Initialize create module for Scenario and Resources
create.init( 'scenarios' );
create.init( 'resources' );
