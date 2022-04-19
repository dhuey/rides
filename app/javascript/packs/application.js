// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("jquery")
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


import flatpickr from "flatpickr"
require ("flatpickr/dist/flatpickr.css")

if (document.readyState === "interactive") {
  const event = document.createEvent("Event");
  event.initEvent("turbolinks:load", true, true);
  document.dispatchEvent(event);
}

document.addEventListener("turbolinks:load", () => {
   var coeff = 1000 * 60 * 5;
   var date = new Date();  //or use any other date
   var rounded = new Date(Math.ceil(date.getTime() / coeff) * coeff)

  flatpickr(".timepicker", {
    enableTime: true,
    dateFormat: "M d, Y at h:i K",
    minDate: "today",
    defaultHour: date.getHours(),
    defaultMinute: rounded.getMinutes(),
    appendTo: window.document.querySelector('#time-wrap')
  })

  let checkedRadio = document.querySelector('.type-radio:checked');
  if (checkedRadio) {
    checkedRadio.parentElement.classList.add('type-selected');
  };

  document.addEventListener("turbolinks:render", () => {
    if (checkedRadio) {
      checkedRadio.parentElement.classList.add('type-selected');
    }
  })

  document.addEventListener('click', e => {
    let radioAncestor = e.target.closest('.type-select');
    if (radioAncestor && !radioAncestor.classList.contains('type-selected')) {
      if (document.querySelector('.type-selected')) {
        document.querySelector('.type-selected').classList.remove('type-selected');
      }

      radioAncestor.classList.add('type-selected');
    }
  })
});