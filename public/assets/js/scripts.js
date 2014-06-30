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

  $('.show_new_resource').on('click', function(e) {
    var $new_resource = $('.new_resource');
    e.preventDefault();

    if ($new_resource.hasClass('visible')) {

      // Build POST url from page id
      var page_id = window.location.pathname;
      var url  = page_id + '/resources'

      // Build POST data from $new_resourceform
      var data = $new_resource.serialize();

      // Submit via AJAX to save record
      $.post(url, data);

    } else {

      $('.admin_bar.resources').append($new_resource);
      $new_resource.slideDown('slow').addClass('visible');

    }
  });

});
