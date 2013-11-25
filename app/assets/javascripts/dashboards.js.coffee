$ ->
  $("a.trigger").click ->
    $("a.trigger").hide 200
    $("hr").hide 200
    $("#new_advertiser_sign_up").show 200
    false