//
// Returns a valid Rails route for a nested resource from the current path.
// On articles/1, build_nested_path('comments') -> '/articles/1/comments'
//
function build_nested_path(resource) {
  var id  = window.location.pathname;
  var url = id + '/' + resource;

  return url;
}

//
// Binds visibility toggle and AJAX POST to nested resource form..
//
function toggle_and_post(form_selector, submit_selector, resource) {

  $(submit_selector).on('click', function(e) {
    // Prevent default behavior of submit button
    e.preventDefault();

    // Cache form object
    var $form = $(form_selector);

    // Check current state of form
    if ($form.hasClass('visible')) {
      // Form is visible; is it complete?
      var value  = $form.children('input[type="text"]').val();


      if (value === '') {
        $form.prepend('<p class="error">Whoa! Submit something.</p>');
      }
      else
      {
        // Build nested resource path for AJAX POST
        var url = build_nested_path(resource);

        // Build POST data from form
        var data = $form.serialize();

        // Submit via AJAX to save record
        $.post(url, data);

        // Clear form data
        $form.children('input[type="text"]').val('');
      }

    } else {
      // Form is not visible

      // Move form from into place
      $(submit_selector).after($form);

      // Toggle visibility and update state
      $form.slideDown('slow').addClass('visible');

      // Update button value
      setTimeout(function() {
        $(submit_selector).text('save');
      }, 500);
    }
  });

}

$(document).ready(function() {
  //
  // Bind click and submit to 'add (scenario|resource)' buttons
  //
  toggle_and_post('.new_resource', '.show_new_resource', 'resources');
  toggle_and_post('.new_scenario', '.show_new_scenario', 'scenarios');

  //
  // Ensure search input field is empty on load
  //
  var $product = $('#product');
  $product.val('');

  //
  // Prevent user from submitting empty search queries;
  // Toggle display of search instructions to the user
  //
  var $search_input = $('#search input[type="submit"]');
  $search_input.on('click', function(e) {
    var query = $product.val();
    var $results = $('.results');

    // Ensure results and errors are cleared between searches
    $results.empty();
    $('.error').slideUp();

    if (query === '') {
      e.preventDefault();
      $('main').prepend('<p class="error">Search query cannot be blank!</p>');
    }

    $('.search-instructions').show();
  });

  //
  // Allow user to clear search results and query
  //
  $('#clear-search').on('click', function() {
    $('.results').empty();

    // TODO
    // This selector is stupid--remove the ID or rename "product"
    $('#search #product').val('');

    $('.search-instructions').hide();
  });

});
