jQuery ->
  $("a[rel=popover]").popover({html: true})
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $(".dropdown").hover (->
    $(this).find(".dropdown-menu").stop(true, true).delay(200).fadeIn()
  ), ->
    $(this).find(".dropdown-menu").stop(true, true).delay(200).fadeOut()
