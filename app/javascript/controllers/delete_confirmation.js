document.querySelectorAll('form[data-confirm]').forEach(form => {
    form.addEventListener('submit', event => {
        const confirmation = form.getAttribute('data-confirm');
        if (!confirm(confirmation)) {
            event.preventDefault();
        }
    });
});