$(function() {
  $(".expandable .expand-link").on("click", function(e) {
    e.preventDefault();
    var parent = $(this).parent(".expandable");
    parent.find(".content").removeClass("content");
    $(this).remove();
  });
});

