<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.pesebre.datos.UsuarioDetalleDAO" %>
<%@ page import="com.pesebre.modelo.Usuario" %>

<%
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    boolean haySesion = (usuarioSesion != null);

    boolean historiaVista = false;
    if (haySesion) {
        try {
            UsuarioDetalleDAO dao = new UsuarioDetalleDAO();
            historiaVista = dao.historiaVista(usuarioSesion.getId_usuario());
            session.setAttribute("historiaVista", historiaVista);
        } catch (Exception e) {
            System.out.println("Error historiaVista index: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Bola Navideña - Pesebre 3D</title>

<link href="https://fonts.googleapis.com/css2?family=Great+Vibes&display=swap" rel="stylesheet">

<style>
body {
    margin: 0;
    overflow: hidden;
    background-image: url("<%= request.getContextPath() %>/texturas/fondo.png");
    background-repeat: no-repeat;
    background-position: center center;
    background-size: 100%;
    background-color: #000;
    font-family: 'Segoe UI', sans-serif;
    color: white;
}

/* ====================== MENÚ DESBLOQUEADO ======================= */
.menu-container {
    position: fixed;
    top: 15px;
    right: 25px;
    z-index: 200;
}

.menu-liberado {
    display: flex;
    gap: 18px;
    background: rgba(0,0,0,0.45);
    padding: 10px 20px;
    border-radius: 12px;
    backdrop-filter: blur(8px);
}

.menu-liberado a {
    color: #ffe29f;
    text-decoration: none;
    font-weight: 600;
    font-size: 15px;
}

.menu-liberado a:hover {
    color: white;
}

.logout {
    color: #ff7676 !important;
}

canvas { display: block; }

/* TÍTULO DEL PESEBRE */
.title-pesebre {
    position: fixed;
    top: 90px;
    left: 50%;
    transform: translateX(-50%);
    font-family: 'Great Vibes', cursive;
    font-size: 85px;
    color: #fff6d5;
    -webkit-text-stroke: 1.6px rgba(80, 40, 0, 0.55);
    text-shadow:
        0 0 10px rgba(255, 220, 130, 0.9),
        0 0 20px rgba(255, 165, 80, 0.7),
        3px 3px 2px rgba(0,0,0,0.45);
    z-index: 10;
    user-select: none;
    animation: glow 3s infinite ease-in-out;
    transition: opacity 0.8s ease-in-out;
}

.ui-container {
    position: fixed;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    z-index: 5;
    display: flex;
    gap: 20px;
}

#btnToggleCam {
    padding: 10px 22px;
    border-radius: 999px;
    border: none;
    cursor: pointer;
    font-size: 15px;
    font-weight: 600;
    background: linear-gradient(135deg, #ffb347, #ff6f61);
    color: #1b1b1b;
}

#btnHistoria {
    padding: 12px 26px;
    border-radius: 999px;
    border: none;
    cursor: pointer;
    font-size: 17px;
    font-weight: 700;
    background: linear-gradient(135deg, #fff3b0, #ffe066);
    color: #503800;
    box-shadow: 0 0 20px rgba(255, 240, 150, 0.9);
    animation: titilar 1s infinite alternate;
    display: none;
}

.fade-out {
    animation: fadeOutPage 1.2s forwards;
}
</style>

<script src="https://unpkg.com/three@0.146.0/build/three.min.js"></script>
<script src="https://unpkg.com/three@0.146.0/examples/js/controls/OrbitControls.js"></script>
<script src="https://unpkg.com/three@0.146.0/examples/js/libs/draco/draco_decoder.js"></script>
<script src="https://unpkg.com/three@0.146.0/examples/js/loaders/DRACOLoader.js"></script>
<script src="https://unpkg.com/three@0.146.0/examples/js/loaders/GLTFLoader.js"></script>

</head>
<body>
<%@ include file="componentes/menuAdmin.jsp" %>

<div class="menu-container">
<% if (haySesion && historiaVista) { %>
    <nav class="menu-liberado">
        <a href="index.jsp">Inicio</a>
        <a href="historia.jsp">Historia</a>	
        <a href="juego.jsp">Juego</a>
        <a href="resultadoScore.jsp">Tabla de clasificación</a>
        <a href="cartas.jsp">Cartas</a>
        <a href="Logout" class="logout">Salir</a>
    </nav>
<% } %>
</div>

<div class="title-pesebre" id="tituloPesebre">El Pesebre</div>

<div class="ui-container">
    <button id="btnToggleCam" aria-label="Cambiar la vista de cámara del pesebre 3D">Observar Pesebre</button>
    <button id="btnHistoria" aria-label="Iniciar la historia narrada del pesebre">Iniciar Historia</button>
</div>

<script>
// (El resto del script de Three.js se mantiene exactamente igual que en tu código original)
let scene, camera, renderer, controls;
const camOutsidePos = new THREE.Vector3(0, 3, 18);
const camInsidePos  = new THREE.Vector3(0, 4.5, 4);

let isInside = false;
let isAnimating = false;
let camAnimT = 0;
let camStart = new THREE.Vector3();
let camEnd   = new THREE.Vector3();

let estrellaBelen, luzEstrella;
let sonidoPesebre;

const btnHistoria = document.getElementById("btnHistoria");
const tituloPesebre = document.getElementById("tituloPesebre");

init();
animate();

function init() {
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.1, 100);
    camera.position.copy(camOutsidePos);

    const listener = new THREE.AudioListener();
    camera.add(listener);
    sonidoPesebre = new THREE.PositionalAudio(listener);

    const audioLoader = new THREE.AudioLoader();
    audioLoader.load("<%= request.getContextPath() %>/audio/musica.mp3", buffer => {
        sonidoPesebre.setBuffer(buffer);
        sonidoPesebre.setRefDistance(4);
        sonidoPesebre.setMaxDistance(20);
        sonidoPesebre.setRolloffFactor(2.0);
        sonidoPesebre.setLoop(true);
        sonidoPesebre.setVolume(0.25);
        sonidoPesebre.play();
    });

    document.body.addEventListener("click", () => {
        const ctx = listener.context;
        if (ctx.state === "suspended") ctx.resume();
    }, { once: true });

    renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    renderer.setClearColor(0x000000, 0);
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.shadowMap.enabled = true;
    document.body.appendChild(renderer.domElement);

    controls = new THREE.OrbitControls(camera, renderer.domElement);
    controls.target.set(0, 3, 0);
    controls.enableDamping = true;
    controls.minDistance = 6;
    controls.maxDistance = 20;

    const dirLight = new THREE.DirectionalLight(0xffffff, 1.2);
    dirLight.position.set(8, 12, 6);
    dirLight.castShadow = true;
    scene.add(dirLight);
    scene.add(new THREE.AmbientLight(0xffffff, 0.45));

    crearBola();
    crearPesebre();
    crearEstrellaBelen();

    sonidoPesebre.position.set(0, 3, 0);
    scene.add(sonidoPesebre);

    document.getElementById("btnToggleCam").onclick = toggleCamMove;
    window.addEventListener("resize", onResize);
}

function crearBola() {
    const tex = new THREE.TextureLoader();
    const texBase = tex.load("<%= request.getContextPath() %>/texturas/base_dorada.jpg");

    const bola = new THREE.Mesh(
        new THREE.SphereGeometry(5, 48, 48),
        new THREE.MeshPhysicalMaterial({
            color: 0xffffff,
            roughness: 0.05,
            metalness: 0.1,
            transparent: true,
            opacity: 0.18,
            clearcoat: 1
        })
    );
    bola.position.set(0, 3, 0);
    scene.add(bola);

    const baseTop = new THREE.Mesh(
        new THREE.CylinderGeometry(4.4, 4.4, 0.55, 64),
        new THREE.MeshStandardMaterial({ map: texBase, metalness: 0.65, roughness: 0.32 })
    );
    baseTop.position.set(0, 0.70, 0);
    scene.add(baseTop);

    const baseMiddle = new THREE.Mesh(
        new THREE.CylinderGeometry(5.0, 5.3, 0.6, 64),
        new THREE.MeshStandardMaterial({ color: 0xc88b30, metalness: 0.85, roughness: 0.25 })
    );
    baseMiddle.position.set(0, 0.25, 0);
    scene.add(baseMiddle);

    const baseBottom = new THREE.Mesh(
        new THREE.CylinderGeometry(5.5, 6.0, 1.4, 64),
        new THREE.MeshStandardMaterial({ color: 0xa26622, metalness: 0.75, roughness: 0.35 })
    );
    baseBottom.position.set(0, -0.60, 0);
    scene.add(baseBottom);
}

function crearEstrellaBelen() {
    estrellaBelen = new THREE.Mesh(
        new THREE.OctahedronGeometry(0.8),
        new THREE.MeshStandardMaterial({ color: 0xfff7b0, emissive: 0xffe9a0, emissiveIntensity: 1.4 })
    );
    estrellaBelen.position.set(0, 7.8, 0);
    scene.add(estrellaBelen);

    luzEstrella = new THREE.PointLight(0xfff1c1, 1.8, 14);
    luzEstrella.position.set(0, 8.0, 0);
    scene.add(luzEstrella);
}

function crearPesebre() {
    const group = new THREE.Group();
    group.position.set(0, 2.8, 0);

    const loader = new THREE.GLTFLoader();
    const draco = new THREE.DRACOLoader();
    draco.setDecoderPath("https://unpkg.com/three@0.146.0/examples/js/libs/draco/");
    loader.setDRACOLoader(draco);

    const texPaja = new THREE.TextureLoader().load("<%= request.getContextPath() %>/texturas/paja.jpg");

    const montana = new THREE.Mesh(
        new THREE.SphereGeometry(1.8, 32, 32),
        new THREE.MeshStandardMaterial({ map: texPaja })
    );
    montana.scale.set(1.75, 0.35, 1.75);
    montana.position.set(0, -0.72, 0.15);
    group.add(montana);

    loader.load("<%= request.getContextPath() %>/modelos/casita.glb", g => {
        const m = g.scene;
        m.scale.set(3.2, 3.2, 3.2);
        m.position.set(0, -0.15, 0.2);
        group.add(m);
    });

    loader.load("<%= request.getContextPath() %>/modelos/maria.glb", g => {
        const m = g.scene;
        m.scale.set(0.75, 0.75, 0.75);
        m.position.set(-0.50, -0.10, 0.40);
        m.rotation.y = Math.PI / 2;
        group.add(m);
    });

    loader.load("<%= request.getContextPath() %>/modelos/jose.glb", g => {
        const j = g.scene;
        j.scale.set(1.15, 1.15, 1.15);
        j.position.set(0.55, -0.10, 0.40);
        j.rotation.y = -Math.PI / 2;
        group.add(j);
    });

    loader.load("<%= request.getContextPath() %>/modelos/nino.glb", g => {
        const n = g.scene;
        n.scale.set(0.55, 0.55, 0.55);
        n.position.set(0, 0.18, 0.50);
        group.add(n);
    });

    scene.add(group);
}

function toggleCamMove() {
    if (isAnimating) return;
    isAnimating = true;
    camAnimT = 0;
    if (!isInside) {
        tituloPesebre.style.opacity = "0";
        camStart.copy(camOutsidePos);
        camEnd.copy(camInsidePos);
        setTimeout(() => { btnHistoria.style.display = "inline-block"; }, 1500);
    } else {
        tituloPesebre.style.opacity = "1";
        camStart.copy(camInsidePos);
        camEnd.copy(camOutsidePos);
        btnHistoria.style.display = "none";
    }
    isInside = !isInside;
    updateControlLimits();
}

function updateControlLimits() {
    if (isInside) {
        controls.minDistance = 1.0;
        controls.maxDistance = 4.5;
        controls.enablePan = false;
        controls.enableZoom = false;
    } else {
        controls.minDistance = 6;
        controls.maxDistance = 20;
        controls.enablePan = true;
        controls.enableZoom = true;
    }
}

function animate() {
    requestAnimationFrame(animate);
    if (isAnimating) {
        camAnimT += 0.015;
        const t = Math.min(camAnimT, 1);
        const smooth = t*t*(3 - 2*t);
        camera.position.lerpVectors(camStart, camEnd, smooth);
        if (t >= 1) isAnimating = false;
    }
    const speed = isInside ? 0.0016 : 0.0010;
    camera.position.applyAxisAngle(new THREE.Vector3(0,1,0), speed);
    controls.update();
    renderer.render(scene, camera);
}

function onResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
}

btnHistoria.addEventListener("click", () => {
    document.body.classList.add("fade-out");
    setTimeout(() => { window.location.href = "historia.jsp"; }, 1200);
});
</script>

</body>
</html>