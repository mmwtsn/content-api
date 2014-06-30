$(document).ready(function() {
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

  //
  // Drop down #create forms for nested resources on pages#show
  //
  // REFACTOR
  $('.show_new_scenario').on('click', function(e) {
    var $new_scenario = $('.new_scenario');
    e.preventDefault();

    if ($new_scenario.hasClass('visible')) {

      // Build POST url from page id
      var page_id = window.location.pathname;
      var url  = page_id + '/scenarios'

      // Build POST data from $new_scenario form
      var data = $new_scenario.serialize();

      // Submit via AJAX to save record
      $.post(url, data);

    } else {

      // The form must be moved from the bottom of the page because
      // each form_for calls .build which will throw errors if it
      // is called before the @scenarios.each loop is entered
      $('.admin_bar.scenarios').append($('.new_scenario'));
      $('.new_scenario').slideDown('slow').addClass('visible');

    }
  });

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

    $('.' + submit_selector).on('click', function(e) {
      // Prevent default behavior of submit button
      e.preventDefault();

      // Cache form object
      var $form = $('.' + form_selector);

      // Check current state of form
      if ($form.hasClass('visible')) {
        // Form is visible and presumably complete

        // Build nested resource path for AJAX POST
        var url = build_nested_path('resources');

        // Build POST data from form
        var data = $form.serialize();

        // Submit via AJAX to save record
        $.post(url, data);

      } else {
        // Form is not visible

        // Move form from into place
        $('.admin_bar.resources').append($form);

        // Toggle visibility and update state
        $form.slideDown('slow').addClass('visible');

      }
    });

  }

  toggle_and_post('new_scenario', 'submit_new_scenario', 'scenarios');

});
