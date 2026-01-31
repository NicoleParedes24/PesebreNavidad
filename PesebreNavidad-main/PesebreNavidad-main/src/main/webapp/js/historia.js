document.addEventListener("DOMContentLoaded", () => {

    const snowContainer = document.createElement("div");
    snowContainer.style.position = "fixed";
    snowContainer.style.top = "0";
    snowContainer.style.left = "0";
    snowContainer.style.width = "100%";
    snowContainer.style.height = "100%";
    snowContainer.style.pointerEvents = "none"; 
    snowContainer.style.overflow = "hidden";
    snowContainer.style.zIndex = "9999";

    document.body.appendChild(snowContainer);

    function crearCopo() {
        const copo = document.createElement("div");

        // Tamaño aleatorio
        const size = Math.random() * 6 + 4;

        // Copo visual
        copo.style.width = `${size}px`;
        copo.style.height = `${size}px`;
        copo.style.borderRadius = "50%";
        copo.style.background = "white";
        copo.style.position = "absolute";
        copo.style.top = "-20px";
        copo.style.left = `${Math.random() * window.innerWidth}px`;
        copo.style.opacity = Math.random() * 0.8 + 0.2;
        copo.style.boxShadow = "0 0 6px rgba(255,255,255,0.8)";

        // Animación de caída
        const duracion = Math.random() * 5 + 5; // velocidad 5 - 10s
        copo.style.animation = `caerNieve ${duracion}s linear`;

        snowContainer.appendChild(copo);

        // Eliminar para no saturar memoria
        setTimeout(() => copo.remove(), duracion * 1000);
    }

    // Crear copos continuamente
    setInterval(crearCopo, 120);

});

// Animación CSS en JS
const estiloAnimacion = document.createElement("style");
estiloAnimacion.innerHTML = `
@keyframes caerNieve {
    0% { transform: translateY(0); }
    100% { transform: translateY(120vh); }
}
`;
document.head.appendChild(estiloAnimacion);
