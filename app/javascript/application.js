import "@hotwired/turbo-rails";
import "@popperjs/core";
import flatpickr from "flatpickr";
import "./home.js";
import "./profileUploader.js";
import "./rides.js";
import "jquery";

const loadDatePicker = () => {
  var coeff = 1000 * 60 * 5;
  var date = new Date(); //or use any other date
  var rounded = new Date(Math.ceil(date.getTime() / coeff) * coeff);
  const timePicker = document.getElementById("timepicker");

  flatpickr(timePicker, {
    enableTime: true,
    dateFormat: "M d, Y at h:i K",
    minDate: "today",
    defaultHour: date.getHours(),
    defaultMinute: rounded.getMinutes(),
    appendTo: window.document.querySelector("#time-wrap"),
  });
};

document.addEventListener("turbo:load", () => {
  loadDatePicker();
  const typeButtons = document.querySelectorAll(".type-select");

  typeButtons.forEach((typeButton) => {
    typeButton.parentElement.classList.add("type-label");
  });

  let checkedRadio = document.querySelector(".type-radio:checked");
  if (checkedRadio) {
    let labelDiv = document.querySelector(
      `[data-selected-id=${checkedRadio.dataset.id}]`
    );
    labelDiv.classList.add("type-selected");
  }

  document.addEventListener("turbo:render", () => {
    typeButtons.forEach((typeButton) => {
      typeButton.parentElement.classList.add("type-label");
    });

    if (checkedRadio) {
      checkedRadio.classList.add("type-selected");
    }
  });

  document.addEventListener("click", (e) => {
    let radioAncestor = e.target.closest(".type-select");
    if (radioAncestor && !radioAncestor.classList.contains("type-selected")) {
      if (document.querySelector(".type-selected")) {
        document
          .querySelector(".type-selected")
          .classList.remove("type-selected");
      }

      radioAncestor.classList.add("type-selected");
    }
  });
});
