document.addEventListener("DOMContentLoaded", function () {
    const avatarInput = document.getElementById("avatar-input");
    const avatarPreview = document.getElementById("avatar-preview");

    avatarInput.addEventListener("change", function () {
        const file = avatarInput.files[0];
        if (file) {
            const reader = new FileReader();

            reader.addEventListener("load", function () {
                const previewImage = document.createElement("img");
                previewImage.src = reader.result;
                previewImage.classList.add("avatar-preview-img");

                if (avatarPreview.firstChild) {
                    avatarPreview.replaceChild(previewImage, avatarPreview.firstChild);
                } else {
                    avatarPreview.appendChild(previewImage);
                }
            });

            reader.readAsDataURL(file);
        } else {
            avatarPreview.innerHTML = "";
        }
    });
});
