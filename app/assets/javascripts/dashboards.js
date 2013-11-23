$ ->
  $("#add-job").toggle (->
    $(".add-job").show 200
    $(this).html "Hide job"
  ), ->
    $(".add-job").hide 200
    $(this).html "Add job"

  $("#add-resume").toggle (->
    $(".add-resume").show 200
    $(this).html "Hide resume"
  ), ->
    $(".add-resume").hide 200
    $(this).html "Add resume"

  $("a.trigger").click ->
    $("a.trigger").hide 200
    $("hr").hide 200
    $("#new_advertiser_sign_up").show 200
    false

  $("#calendar").fullCalendar
    header:
      left: "prevYear prev"
      center: "title"
      right: "next nextYear"

    events:
      url: "/events/ajax_events.json"
      cache: false

    eventClick: (calEvent, jsEvent, view) ->
      $("#event_modal").modal remote: "/events/" + calEvent.id

