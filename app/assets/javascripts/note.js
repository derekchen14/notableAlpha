
$(document).ready(function() {
  $("ul#notes").sortable({
    axis: 'y',
    update: function() {
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  });
});


$(function() {
  $(".best_in_place").best_in_place()
  $("li").hover(function(event) {
    $(this).children(".remind").toggle();
  });
  $(".remind").click(function(e) {
    e.preventDefault();
    $(this).closest("li").children(".remind_times").toggle(300);
  });
  $(".badge").click(send_message);
});


$.rails.confirm = function(message, element) { 
  var state = element.data('state');
  var txt = element.text();
  if (!state) {
    element.data('state', 'last');
    element.text('Sure?');
    setTimeout(function() {
      element.data('state', null);
      element.text(txt);
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





