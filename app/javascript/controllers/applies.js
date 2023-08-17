// app/assets/javascripts/applies.js
document.addEventListener('DOMContentLoaded', function () {
    const submitBtn = document.getElementById('submitBtn');
    const loader = document.getElementById('loader');

    if (submitBtn) {
        submitBtn.addEventListener('click', function (event) {
            event.preventDefault();
            loader.style.display = 'block'; // Mostrar el loader

            const form = submitBtn.closest('form');
            const formData = new FormData(form);

            fetch(form.action, {
                method: form.method,
                body: formData,
                headers: { 'X-Requested-With': 'XMLHttpRequest' } // Indicar que es una petición AJAX
            })
                .then(response => response.json())
                .then(data => {
                    // Procesar la respuesta según tus necesidades
                    loader.style.display = 'none'; // Ocultar el loader
                })
                .catch(error => {
                    console.error('Error:', error);
                    loader.style.display = 'none'; // Ocultar el loader en caso de error
                });
        });
    }
});
