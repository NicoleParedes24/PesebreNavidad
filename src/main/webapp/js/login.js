console.log("Registro JS cargado ✔✔✔");

window.onload = function(){

    function crearEstrella() {
        const contenedor = document.getElementById("estrellas-container");
        if (!contenedor) return;

        const estrella = document.createElement("div");

        // ⭐ ESTRELLA UNICODE SEGURA
        estrella.innerHTML = "\u2605";

        estrella.classList.add("estrella");

        // Posición horizontal aleatoria
        estrella.style.left = Math.random() * 100 + "vw";

        // Tamaño entre 8 y 28 px
        const tamaño = Math.random() * 20 + 8;
        estrella.style.fontSize = tamaño + "px";

        // Duración entre 4 y 8 s
        const duracion = Math.random() * 4 + 4;
        estrella.style.animationDuration = duracion + "s";

        contenedor.appendChild(estrella);

        setTimeout(() => estrella.remove(), duracion * 1000);
    }

    setInterval(crearEstrella, 400);
};
