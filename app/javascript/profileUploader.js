const profileUploader = document.getElementById("user_profile_picture");
const profileImage = document.getElementById("profile-image");

if (profileUploader && profileImage) {
  profileUploader.addEventListener("change", () => {
    const file = profileUploader.files[0];

    if (file) {
      const reader = new FileReader();

      reader.addEventListener("load", () => {
        profileImage.setAttribute("src", reader.result);
      });

      reader.readAsDataURL(file);
    }
  });
}
