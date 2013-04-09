$(document).ready(function(){
  $("#side-notebooks").click(function(){
   // $("#side-user-tags").toggle();
  });
  $("#side-recent-notes").click(function(){
   $("#side-user-recent-notes").toggle();
  });
  $("#side-notes").click(function(){
   $("#side-user-notes").toggle();
  });
  $("#side-tags").click(function(){
   $("#side-user-tags").toggle();
  });

  $("div#sidr li a").click(function(){
    $("div#sidr li > a").removeClass("clicked");
    $(this).toggleClass("clicked");
  });

  $(".clear_filter").click(function(){
    $("div#sidr li > a").removeClass("clicked");
  });
});
