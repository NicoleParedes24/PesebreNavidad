document.addEventListener("DOMContentLoaded", () => {
    const textarea = document.getElementById("mensaje");
    const contador = document.getElementById("contador");
    const max = 200;

    if (!textarea || !contador) return;

    // Actualiza al cargar la página
    contador.textContent = `Te quedan ${max} caracteres.`;

    textarea.addEventListener("input", () => {
        const usados = textarea.value.length;
        const restantes = max - usados;

        contador.textContent = `Te quedan ${restantes} caracteres.`;

        // Cambiar color según los caracteres restantes
        if (restantes > 100) {
            contador.style.color = "#6c757d";  // gris
        } else if (restantes > 40) {
            contador.style.color = "#c79207";  // amarillo
        } else {
            contador.style.color = "#d00000";  // rojo
        }
    });
});
