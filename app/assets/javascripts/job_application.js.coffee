jQuery ->
  $('select.application').change ->
    $(this).parent().parent().submit()