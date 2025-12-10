document.addEventListener("DOMContentLoaded", () => {
    const contenedor = document.querySelector(".stars");

    contenedor.setAttribute("aria-hidden", "true");
    contenedor.setAttribute("role", "presentation");

    for (let i = 0; i < 40; i++) {
        let span = document.createElement("span");

        // Accesibilidad
        span.setAttribute("aria-hidden", "true");
        span.setAttribute("role", "presentation");

        // Tipo aleatorio
        let tipo = Math.random() > 0.5 ? "star" : "snow";
        span.classList.add(tipo);

        // Tamaño CSS variable
        let size = Math.floor(Math.random() * 25) + 15; // 15 a 40 px
        span.style.setProperty("--size", size + "px");

        // Agregar contenido directamente (evita conflictos con Bootstrap)
        if (tipo === "snow") {
            span.textContent = "❄";       // Copo rojo
            span.style.color = "#ff0000"; // 🔴 ROJO REAL
        } else {
            span.textContent = "⭐";       // Estrella amarilla
            span.style.color = "#ffce00"; // 🟡 AMARILLO REAL
        }

        // Posiciones
        span.style.left = Math.random() * 100 + "%";
        span.style.top = "-10vh";
        span.style.fontSize = size + "px";

        span.style.animation = `caer 8s linear infinite`;
        span.style.animationDelay = (Math.random() * 8) + "s";

        contenedor.appendChild(span);
    }
});
