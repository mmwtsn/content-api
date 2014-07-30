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
  };

  // Build config object with jQuery obects and resources string
  var configure = function( resource ) {
    config['resource'] = resource

    // Use singular form of resource for selector
    resource = singularize_resource( resource );
    config['$submit']  = $('#create_' + resource);
    config['$show']    = $('#show_new_' + resource);
    config['$form']    = $('#new_' + resource);

    return config;
  };

  // Strip last character from plural resource
  var singularize_resource = function( resource ) {
    return resource.slice(0, -1);
  };

  // Expose public methods through create module
  return {
    init: init,
    config: config
  };

})();

// Initialize create module for Scenario and Resources
var s = create.init( 'scenarios' );
var r = create.init( 'resources' );
