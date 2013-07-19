$(document).ready(function() {
  $('a.trigger').click(function() {
    $('a.trigger').hide();
    $('#new_advertiser_sign_up').show();
    return false;
  });
});
