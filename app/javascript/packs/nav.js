const toggleButton = document.getElementById("navbar-toggle-button");
const navLinks = document.getElementById("navbar-toggle-menu");

toggleButton.addEventListener("click", ()=> {
  navLinks.classList.toggle("show");
  navLinks.classList.toggle("mobile-nav-links");
})