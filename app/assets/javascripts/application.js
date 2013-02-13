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
//= require bootstrap
//= require colorbox-rails
//= require_tree .

$(function() {
	$(".alert").fadeTo(7000, 1.0).fadeOut(1400);
	$(".remind").click(function(e) {
		e.preventDefault();
		$(this).closest("li").children(".remind_times").toggle(300);
	});
  //$(".badge").click(clearAll);
});


//function clearAll(event) {
//	var $t = $(event.target);
//	What you want to have happen when someone
//	clicks on the object with an id = "clear";
//}

