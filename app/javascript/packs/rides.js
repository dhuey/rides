document.addEventListener("turbolinks:load", () => {
  $("#which-vehicle").click(function() {
  $(this).hide();
  $("#vehicle-select").animate({
      height: 'show'
    });
  });

  $("#no-vehicle").click(function() {
    $("#vehicle-add").show();
  });
});