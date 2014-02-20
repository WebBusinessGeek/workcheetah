jQuery ->
  $("a[rel=popover]").popover({html: true})
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("#calculator").calculator()
  $(".collapse").collapse()
  $("input.date").datepicker
    dateFormat: "yy-mm-dd"
  $('#staff_color').simpleColorPicker()
