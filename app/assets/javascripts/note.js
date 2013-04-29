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
  
  $("#note_tag_list").tokenInput( '/tags.json',{
    theme: 'facebook',
    prePopulate: $("#note_tag_list").data('load')
  });

  $(".tags").hide();

  $(".icon-tags").click(function(e){
    e.preventDefault();
    $(this).closest("li").children(".tags").toggle(300);
  });

  $("li").hover(function(event) {
    $(this).children(".handle").toggle();
  });

  /*****************
   Mindmup Editor 
   *****************/
  $("[id^=item_]").wysiwyg({
    hotKeys: {
      'ctrl+b meta+b': 'bold',
      'ctrl+i meta+i': 'italic',
      'ctrl+u meta+u': 'underline',
      'ctrl+z meta+z': 'undo',
      'ctrl+y meta+y meta+shift+z': 'redo'
    }
  });

  /*****************
    Auto Save
   *****************/
  $("span#save-notification").hide();

  $("[id^=item_]").focus(function(){
    var item_id  = this.id.substring(5);
    var el = "#item_"+item_id
    $(el).idleTimer(5000);
    $(el).on( 'idle.idleTimer', function(event){
      var item_content = $("#item_"+item_id).html();
      var item_path = "/items/"+item_id+".json";

      save_items(item_path, item_id, item_content);
      console.log("saving1 " + el);
      $("span#save-notification").show().delay(2000).fadeOut();
    });
  });

  $("[id^=item_]").focusout(function(){
    var item_id  = this.id.substring(5);
    var el = "#item_"+item_id
    $(el).idleTimer("destroy");
    var item_content = $("#item_"+item_id).html();
    var item_path = "/items/"+item_id+".json";

    save_items(item_path, item_id, item_content)
  });

  function save_items(item_path, item_id, item_content) {
    $.ajax(item_path, {
      type: 'PUT',
      data: { item: {id: item_id, data: item_content }},
      dataType: 'json'
    });
  }
  
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
  $('input[type="filepicker"]').change(save_url);
});
    // $(this).closest("li").find(".content").append(url);
    // var out = '';
    // for(var i=0;i<event.fpfiles.length;i++){
    //   out += event.fpfiles[i].url;
    //   out+=' '};
    // alert(out);

