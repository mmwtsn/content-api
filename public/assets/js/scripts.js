$(document).ready(function() {
  //
  // Test calls against the Product API for adding solutions to a scenario
  //
  var products = new Array();
  var names = new Array();

  // Get all IBM marketplace products
  $.getJSON('http://50.97.56.226:3002/products/api?callback=?', function(response) {
    products = response;
  });

    console.log(products);
  // Stash titles for user to filter from
  products.forEach(function(entry) {
    console.log(entry);
    product_names.push(entry.name);
  });

  // Test
  //console.log(product_names);
});
