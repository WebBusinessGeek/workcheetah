$(document).ready(function(){
  $("#add-job").toggle(function(){
    $(".add-job").show(200);
    $(this).html("Hide job");
  }, function(){
    $(".add-job").hide(200);
    $(this).html("Add job");
  });

  $("#add-resume").toggle(function(){
    $(".add-resume").show(200);
    $(this).html("Hide resume");
  }, function(){
    $(".add-resume").hide(200);
    $(this).html("Add resume");
  });

  $('a.trigger').click(function() {
    $('a.trigger').hide(200);
    $('hr').hide(200);
    $('#new_advertiser_sign_up').show(200);
    return false;
  });

  $('#calendar').fullCalendar({
    header: {
      left: 'prevYear prev',
      center: 'title',
      right: 'next nextYear'
    },
    events: {
      url: "/events/ajax_events.json",
      cache: false
    },
    eventClick: function(calEvent, jsEvent, view) {
      $('#event_modal').modal({
        remote: '/events/' + calEvent.id
      });
    }
  });
});
