import $ from "jquery";

$("#which-vehicle").on("click", function () {
  $(this).hide();
  $("#vehicle-select").animate({
    height: "show",
  });
});

$("#no-vehicle").on("click", function () {
  $(this).hide();
  $("#vehicle-add").animate({
    height: "show",
  });
});
