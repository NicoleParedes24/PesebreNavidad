const cam = document.getElementById("camaraJugador");

function mover(dx, dz) {
    let pos = cam.getAttribute("position");
    pos.x += dx;
    pos.z += dz;
    cam.setAttribute("position", pos);
}

document.getElementById("btnUp").onclick = () => mover(0, -0.3);
document.getElementById("btnDown").onclick = () => mover(0, 0.3);
document.getElementById("btnLeft").onclick = () => mover(-0.3, 0);
document.getElementById("btnRight").onclick = () => mover(0.3, 0);