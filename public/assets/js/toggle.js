//
// Handles the displaying of AJAX-ready Controller#create forms
//

// Returns an initializer function
var toggle = (function() {

  // Cache local references to jQuery objects for use
  var config = {};

  // Initialize instance of module, calls setup()
  var init = function( resource ) {
    config = Config().configure( resource );

    config.$show.on( 'click', toggle );
  };

  // Toggle visibility of $form if hidden
  var toggle = function() {

    if( is_not_visible(config.$form) ) {

      // Move $form into position
      config.$form.insertBefore( config.$show );

      // Update visibility and state
      config.$form
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

  // Expose public methods
  return {
    init: init
  };
});
