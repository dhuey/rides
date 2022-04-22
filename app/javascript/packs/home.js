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

const setPageElements = () => {
  navLinks.classList.remove("show");
  navl.classList.remove("mobile-nav-links");
  resizeIframe(internationalVideo);
  resizeIframe(driverVideo);
}

// Need this because turbolinks:load isn't firing on initial page load
document.addEventListener("DOMContentLoaded", () => {
  setPageElements();
});

document.addEventListener("turbo:render", () => {
  setPageElements();
});

window.addEventListener("resize", () => {
  resizeIframe(internationalVideo);
  resizeIframe(driverVideo);
});
