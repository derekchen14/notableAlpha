$(document).ready(function(){
  $("#side-notebooks").click(function(){
   // $("#side-user-tags").toggle();
  });
  $("#side-recent-notes").click(function(){
    $("#side-recent-notes span").toggleClass("arrow_right_icon", "arrow_down_icon");
    $("#side-user-recent-notes").toggle("slow");
  });
  $("#side-notes").click(function(){
    $("#side-notes span").toggleClass("arrow_right_icon", "arrow_down_icon");
   $("#side-user-notes").toggle("slow");
  });
  $("#side-tags").click(function(){
    $("#side-tags span").toggleClass("arrow_right_icon", "arrow_down_icon");
   $("#side-user-tags").toggle("slow");
  });

  $("div#sidr li a").click(function(){
    $("div#sidr li > a").removeClass("clicked");
    $(this).toggleClass("clicked");
  });

  $(".clear_filter").click(function(){
    $("div#sidr li > a").removeClass("clicked");
  });


});
