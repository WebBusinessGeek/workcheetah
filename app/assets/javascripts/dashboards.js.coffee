$ ->
  $("a.trigger").click ->
    $("a.trigger").hide 200
    $("hr").hide 200
    $("#new_advertiser_sign_up").show()
    false

  $('a.prev').click (e) ->
    e.preventDefault()
    date = new Date($('.todoDate').data('date'))
    date.setDate(date.getDate() - 1);
    updateToDo(date)

  $('a.next').click (e) ->
    e.preventDefault()
    date = new Date($('.todoDate').data('date'))
    date.setDate(date.getDate() + 1);
    updateToDo(date)

  # $('#notifications').on 'hidden.bs.popover', ->
  #   $('#notifications .badge').remove()

  $("#calendar").fullCalendar
    header:
      left: "prevYear prev"
      center: "title"
      right: "next nextYear"

    aspectRatio: 2.5

    events:
      url: "/events/ajax_events.json"
      cache: false

    eventClick: (calEvent, jsEvent, view) ->
      $("#event_modal").modal remote: "/events/" + calEvent.id

updateToDo = (date) ->
  $('.todoDate').data('date', date)
  $('.todoDate').html(date.yyyymmdd())
  $.ajax({
      type: "GET",
      url: "/todos",
      data: { date: date },
      success:(data) ->
        console.log "success"
        return false
      error:(data) ->
        return false
  })

Date::yyyymmdd = ->
  yyyy = @getFullYear().toString()
  mm = (@getMonth() + 1).toString()
  dd = @getDate().toString()
  yyyy + "-" + ((if mm[1] then mm else "0" + mm[0])) + "-" + ((if dd[1] then dd else "0" + dd[0]))