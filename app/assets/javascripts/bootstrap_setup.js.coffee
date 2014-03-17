jQuery ->
  $("a[rel=popover]").popover({html: true})
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("#calculator").calculator()
  $(".collapse").collapse()
  $("input.date").datepicker
    dateFormat: "yy-mm-dd"
  $('#staff_color').simpleColorPicker()
  $("input.phone").mask("(999) 999-9999? x9999", {placeholder:" "})
  $("input.website").mask("http://%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%", {placeholder:" "})
  $("input.twitter").mask("@?***************", {placeholder:" "})
