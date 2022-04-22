const toggleButton = document.getElementById("navbar-toggle-button");
const navLinks = document.getElementById("navbar-toggle-menu");

toggleButton.addEventListener("click", () => {
  navLinks.classList.toggle("show");
  navLinks.classList.toggle("mobile-nav-links");
});

const internationalVideo = document.getElementById("international-tutorial");
const driverVideo = document.getElementById("driver-tutorial");

const resizeIframe = (iframe) => {
  let width = iframe.clientWidth;
  let newHeight = width * 0.625 + "px";

  iframe.style.height = newHeight;
};

// Need this because turbolinks:load isn't firing on initial page load
document.addEventListener("DOMContentLoaded", () => {
  resizeIframe(internationalVideo);
  resizeIframe(driverVideo);
});

document.addEventListener("turbo:render", () => {
  resizeIframe(internationalVideo);
  resizeIframe(driverVideo);
});

window.addEventListener("resize", () => {
  resizeIframe(internationalVideo);
  resizeIframe(driverVideo);
});
