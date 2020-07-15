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
  flatpickr(".timepicker", {
    enableTime: true,
    dateFormat: "M d, Y at h:i K",
    minDate: "today",
    minTime: Date.now(),
    appendTo: window.document.querySelector('#time-wrap')
  })
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
