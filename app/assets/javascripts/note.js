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