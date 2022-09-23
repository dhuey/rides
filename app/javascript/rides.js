import $ from "jquery";

document.addEventListener("DOMContentLoaded", () => {
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
});

document.addEventListener("turbo:render", () => {
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
});
