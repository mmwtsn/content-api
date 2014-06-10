$(window).load(function() {
  //
  // Stupid hacks to remedy a very broken page once everything has executed
  //

  // Ensure these only run for the preview view of the gaming scenario page
  if (document.location.pathname === '/cloud-computing/us/en/solutions-gaming.html') {

    // Assign proper IDs to the various gaming scenario <div> elements
    $('.ibm-band.ibm_cci-solutions-gaming.section1').attr('id', 'ibm-solutions-gaming-hero');
    $('.ibm-band.ibm_cci-solutions-gaming.section2').attr('id', 'ibm-solutions-gaming-intro');
    $('.ibm-band.ibm_cci-solutions-gaming.section3').attr('id', 'ibm-solutions-gaming-header');

    // Get the location of the user-uploaded header image
    var $pageHeader = $('.page-header');
    var src = 'url(' + $pageHeader.attr('src') + ')';

    // Swap out the user-uploaded header image for the IBM default
    $('#ibm-solutions-gaming-hero').css('background-image', src);

    // Remove the old image
    $pageHeader.remove();

    // Restrict the page width for those with obnoxiously large screens
    $('body').css({
      'margin': '0 auto',
      'max-width': '1440px'
    });
  }
});
