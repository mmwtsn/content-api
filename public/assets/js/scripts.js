//
// Handles the displaying of and submission of AJAX-ready #create forms
//

// Define Resource#create module
var create = (function() {

  // Define config object for later use
  var config = {};

  // Initialize instance of module, calls setup()
  var init = function( resource ) {
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
