
$(document).ready(function() {
  $("a.toggle").click(function() {
    var toggleId = $(this).attr("data-toggle-id");
    var toggleEl = $("#" + toggleId);
    var newText;
    if (toggleEl.is(":visible")) {
      toggleEl.hide();
      newText = $(this).text().replace("Hide", "Show");
      $(this).text(newText);
    }
    else {
      toggleEl.show();      
      newText = $(this).text().replace("Show", "Hide");
      $(this).text(newText);
    }
  });
})