document.addEventListener("DOMContentLoaded", () => {
    const cont = document.createElement("div");
    cont.style.position = "fixed";
    cont.style.top = 0;
    cont.style.left = 0;
    cont.style.width = "100%";
    cont.style.height = "100%";
    cont.style.pointerEvents = "none";
    cont.style.zIndex = 9999;
    document.body.appendChild(cont);

    function crearNieve() {
        const copo = document.createElement("span");
        copo.innerHTML = "❄";
        copo.style.position = "absolute";
        copo.style.left = Math.random() * 100 + "%";
        copo.style.top = "-10px";
        copo.style.fontSize = (Math.random() * 15 + 10) + "px";
        copo.style.color = "white";
        copo.style.opacity = Math.random();
        copo.style.animation = `caer ${4 + Math.random()*6}s linear`;

        cont.appendChild(copo);

        setTimeout(() => copo.remove(), 10000);
    }

    setInterval(crearNieve, 200);
});

const estilo = document.createElement("style");
estilo.innerHTML = `
@keyframes caer {
  0% { transform: translateY(0); }
  100% { transform: translateY(110vh); }
}`;
document.head.appendChild(estilo);
