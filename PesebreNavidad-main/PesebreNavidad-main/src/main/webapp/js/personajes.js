function toggleMenu() {
    document.querySelector(".menu").classList.toggle("show");
}

document.addEventListener("DOMContentLoaded", () => {
    const container = document.createElement("div");
    container.style.position = "fixed";
    container.style.top = "0";
    container.style.left = "0";
    container.style.width = "100%";
    container.style.height = "100%";
    container.style.pointerEvents = "none";
    container.style.overflow = "hidden";
    container.style.zIndex = "9000";

    document.body.appendChild(container);

    function createGlowBall() {
        const ball = document.createElement("div");
        const size = Math.random() * 6 + 6;

        ball.style.width = size + "px";
        ball.style.height = size + "px";
        ball.style.position = "absolute";
        ball.style.borderRadius = "50%";
        ball.style.background = "radial-gradient(circle, rgba(255,230,150,1), rgba(255,180,80,0.4))";
        ball.style.boxShadow = "0 0 10px rgba(255,220,140,0.9), 0 0 20px rgba(255,180,90,0.6)";
        ball.style.top = "-20px";
        ball.style.left = Math.random() * window.innerWidth + "px";
        ball.style.opacity = "1";
        ball.style.animation = `fall ${3 + Math.random() * 4}s linear`;

        container.appendChild(ball);

        setTimeout(() => ball.remove(), 7000);
    }

    setInterval(createGlowBall, 250);
});
