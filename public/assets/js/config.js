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
