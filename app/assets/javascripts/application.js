// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require best_in_place.purr
//= require best_in_place
//= require bootstrap
//= require_tree .

$(function() {
	$(".alert").delay(7000).fadeOut(1400);
});

$(document).ajaxComplete(function(event, request) {
  var x_flash = request.getResponseHeader('x-flash');
  var x_flash_type = request.getResponseHeader('x-flash-type');
  var msg = '<div class="alert alert-'+x_flash_type+'">'+x_flash+'</div>';
  if (x_flash) {
  	$("#main_container").prepend(msg);
  	$(".alert").delay(7000).fadeOut(1400);
  };
});


