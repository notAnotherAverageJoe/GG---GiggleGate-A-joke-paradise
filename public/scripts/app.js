document.addEventListener("DOMContentLoaded", () => {
  const cookieButton = document.getElementById("cookie-button");
  const cookieCount = document.getElementById("cookie-count");

  let count = 0;

  cookieButton.addEventListener("click", () => {
    count++;
    cookieCount.textContent = count;

    // Trigger bounce animation
    cookieButton.classList.add("bounce");

    // Remove the bounce class after the animation ends
    cookieButton.addEventListener("animationend", () => {
      cookieButton.classList.remove("bounce");
    });
  });
});
