$("#which-vehicle").click(function() {
  $(this).hide();
  $("#vehicle-select").animate({
    height: 'show'
  });
});

$("#no-vehicle").click(function() {
  $(this).hide();
  $("#vehicle-add").animate({
    height: 'show'
  });
});