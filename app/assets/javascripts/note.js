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
  var t = $(event.target).text();
  switch (t) {
    case "Next Week":
      var length = 10080; break;
    case "Tomorrow":
      var length = 1440; break;
    case "30 Minutes": 
      var length = 30; break;
    case "In an Hour":
      var length = 60; break;
    case "Right Now":
      var length = 0; break;
    default:
      var length = 1;
  }
  console.log("Sending a reminder in "+length+" minutes");
}