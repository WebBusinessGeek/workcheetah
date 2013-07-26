$ ->
  $('ul.nav.nav-list > li').click ->
    $('ul.nav.nav-list li').each ->
      $(this).removeClass("active")
    $(this).addClass("active")