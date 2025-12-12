// ⭐ GENERADOR DE ESTRELLAS (ACCESIBLE PARA WAVE)
document.addEventListener("DOMContentLoaded", () => {
    const contenedor = document.querySelector(".stars");

    // Oculta todo este contenedor del árbol de accesibilidad
    contenedor.setAttribute("aria-hidden", "true");
    contenedor.setAttribute("role", "presentation");

    const simbolos = ["⭐", "❄"];
    const colores = ["#ffce00", "#ff0000"];

    for (let i = 0; i < 40; i++) {
        let span = document.createElement("span");

        // ❌ Importante: ocultar cada elemento para WAVE
        span.setAttribute("aria-hidden", "true");
        span.setAttribute("role", "presentation");

        let tipo = Math.floor(Math.random() * simbolos.length);
        let tamanio = tipo === 0
            ? Math.random() * 25 + 5
            : Math.random() * 35 + 10;

        span.textContent = simbolos[tipo];
        span.style.position = "absolute";
        span.style.fontSize = tamanio + "px";
        span.style.color = colores[tipo];
        span.style.left = Math.random() * 100 + "%";
        span.style.top = "-10vh";
        span.style.animation = `caer 8s linear infinite`;
        span.style.animationDelay = (Math.random() * 8) + "s";

        contenedor.appendChild(span);
    }
});
