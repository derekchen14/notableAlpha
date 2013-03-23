/*****************
  Move Notes
*****************/

$(document).ready(function() {
  $("ul#notes").sortable({
    axis: 'y',
    handle: '.handle',
    update: function() {
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
      if (navigator.userAgent.indexOf("Firefox")!=-1)
        $(".handle").hide();
    }
  });
  $(".best_in_place").best_in_place()
});

$(function() {
  $("li").hover(function(event) {
    $(this).children(".handle").toggle();
  });
});

/*****************
  Trash
*****************/

$.rails.confirm = function(message, element) { 
  var state = element.data('state');
  var txt = element.html();
  if (!state) {
    element.data('state', 'last');
    element.text('Sure?');
    $(".handle").hide();
    setTimeout(function() {
      element.data('state', null);
      element.html(txt);
    }, 2000);
    return false;
  } else {
    return true;
  }
};

$.rails.allowAction = function(element) {
  var message = element.data('confirm');
  var answer = false, callback;
  
  if (!message) { return true; }
  if ($.rails.fire(element, 'confirm')) {
    answer = $.rails.confirm(message, element);
    callback = $.rails.fire(element, 'confirm:complete', [answer]);
  }
  return answer && callback;
};

/*****************
  Remind Me
*****************/

$(function() {
  $(".remind").click(function(e) {
    e.preventDefault();
    $(this).closest("li").children(".remind_times").toggle(300);
  });
  $(".badge").click(send_message);
});

function send_message(event) {
  var $t = $(event.target)
  var btn_text = $t.text().toLowerCase();
  var content = $t.closest("li").children("span.content").text();
  switch (btn_text) {
    case "tomorrow":
      var time_ahead = 86390; break;
    case "later today":
      var time_ahead = 14000; break;
    case "in an hour": 
      var time_ahead = 3590; break;
    case "30 minutes":
      var time_ahead = 1790; break;
    case "right now":
      var time_ahead = 0; break;
    default:
      var time_ahead = 1;
  }

  $.ajax({
    url: "reminders/create.json",
    dataType: "json",
    data: {reminder: {content: content, 
      time_ahead: time_ahead, 
      timing: btn_text }},
    type: "GET"
  });

}

/*****************
  FilePicker
*****************/


$(function() {
  $(".fptest").click(function(e) {
    e.preventDefault();
    console.log(JSON.stringify(fpfiles));
    //Add some way to grab the URL from fpfiles
    $(this).closest("li").find(".best_in_place").append(" URL");
    // Add some way to save the note
  });
});






