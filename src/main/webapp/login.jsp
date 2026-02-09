<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión - Pesebre 3D</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/footer.css">

    <script src="https://unpkg.com/three@0.146.0/build/three.min.js"></script>
    <script src="https://unpkg.com/three@0.146.0/examples/js/controls/OrbitControls.js"></script>
    <script src="https://unpkg.com/three@0.146.0/examples/js/libs/draco/draco_decoder.js"></script>
    <script src="https://unpkg.com/three@0.146.0/examples/js/loaders/DRACOLoader.js"></script>
    <script src="https://unpkg.com/three@0.146.0/examples/js/loaders/GLTFLoader.js"></script>
    
    <style>
        #pesebre-container {
            width: 100%;
            height: 550px;
            cursor: grab;
        }
        canvas { outline: none; }
    </style>
</head>

<body>

<div class="fondo-f1-blur"></div>
<div class="fondo-extra-blur"></div>

<%@ include file="includes/menu.jsp" %>

<div class="contenedor-login">

    <div class="arbol-box">
        <div id="pesebre-container"></div>
    </div>

    <div class="login-box card shadow-lg">
        <h3 class="text-center fw-bold titulo-login">🎄 Ingreso al Sistema</h3>

        <form action="validarLogin.jsp" method="post">
            <div class="mb-3 mt-3">
                <label for="correo" class="form-label fw-semibold">Correo electrónico</label>
                <input type="email" id="correo" class="form-control input-navidad" name="correo" required>
            </div>

            <div class="mb-3">
                <label for="clave" class="form-label fw-semibold">Clave</label>
                <input type="password" id="clave" class="form-control input-navidad" name="clave" required>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn boton-navidad px-4">Ingresar</button>
                <button type="reset" class="btn boton-secundario px-4 ms-2">Limpiar</button>
            </div>
        </form>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center mt-3">
                <%= request.getParameter("error") %>
            </div>
        <% } %>
    </div> 

</div>

<div id="estrellas-container"></div>

<script src="js/login.js"></script>

<script>
/** * LÓGICA DEL PESEBRE 3D PRO - EFECTOS ESPECIALES 
 */
let scene, camera, renderer, controls;
let nieveSistema; 
const container = document.getElementById('pesebre-container');

init3D();
animate3D();

function init3D() {
    scene = new THREE.Scene();

    camera = new THREE.PerspectiveCamera(50, container.clientWidth / container.clientHeight, 0.1, 1000);
    camera.position.set(0, 4, 18); 

    renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    renderer.setSize(container.clientWidth, container.clientHeight);
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.shadowMap.enabled = true;
    renderer.outputEncoding = THREE.sRGBEncoding; 
    container.appendChild(renderer.domElement);

    controls = new THREE.OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.enableZoom = false; 
    controls.autoRotate = true;
    controls.autoRotateSpeed = 0.5; 
    controls.target.set(0, 3, 0);

    // --- LUCES AMBIENTALES ---
    scene.add(new THREE.AmbientLight(0xffffff, 0.4));
    
    // Luz de "Luna" (Azulada suave)
    const moonLight = new THREE.DirectionalLight(0x99bbff, 0.8);
    moonLight.position.set(-10, 10, 5);
    scene.add(moonLight);

    // Luz dorada central (Cálida para los personajes)
    const warmLight = new THREE.PointLight(0xffd700, 1.5, 15);
    warmLight.position.set(0, 3, 2);
    scene.add(warmLight);

    crearBolaYBaseCompleta();
    cargarPesebreCompleto();
    crearEstrellaBelenLogin();
    crearNieveInterna(); // <-- NUEVO EFECTO
 // Luz frontal para crear el brillo de "vidrio"
    const luzFrente = new THREE.PointLight(0xffffff, 1, 20);
    luzFrente.position.set(5, 5, 10);
    scene.add(luzFrente);
 // Luz trasera para definir la silueta del cristal
    const luzAtras = new THREE.PointLight(0xffffff, 0.5, 20);
    luzAtras.position.set(-5, 5, -5);
    scene.add(luzAtras);
}

function crearBolaYBaseCompleta() {
    const texLoader = new THREE.TextureLoader();
    const pathTex = "<%= request.getContextPath() %>/texturas/";

    // --- BOLA DE CRISTAL MEJORADA ---
    const bolaGeom = new THREE.SphereGeometry(5, 64, 64); 
    const bolaMat = new THREE.MeshPhysicalMaterial({
        color: 0xffffff,
        metalness: 0.1,
        roughness: 0.05,       
        transparent: true,
        opacity: 0.25,         
        transmission: 0.95,    
        thickness: 0.5,        
        ior: 1.5,              
        clearcoat: 1.0,        
        clearcoatRoughness: 0
    });
    
    const bola = new THREE.Mesh(bolaGeom, bolaMat);
    bola.position.set(0, 3, 0);
    scene.add(bola);

    // --- BASE DORADA Y MADERA ---
    
    const texBase = texLoader.load(pathTex + "base_dorada.jpg");
    const baseTop = new THREE.Mesh(
        new THREE.CylinderGeometry(4.4, 4.4, 0.6, 64),
        new THREE.MeshStandardMaterial({ map: texBase, metalness: 0.8, roughness: 0.2 })
    );
    baseTop.position.set(0, 0.7, 0);
    scene.add(baseTop);

    const baseBottom = new THREE.Mesh(
        new THREE.CylinderGeometry(5.2, 5.8, 1.2, 64),
        new THREE.MeshStandardMaterial({ color: 0x3d2b1f })
    );
    baseBottom.position.set(0, -0.2, 0);
    scene.add(baseBottom);
}

function crearEstrellaBelenLogin() {
   
    const estrella = new THREE.Mesh(
        new THREE.OctahedronGeometry(0.7),
        new THREE.MeshStandardMaterial({ color: 0xfff7b0, emissive: 0xffcc00, emissiveIntensity: 2 })
    );
    estrella.position.set(0, 7.8, 0);
    scene.add(estrella);

    const luzE = new THREE.PointLight(0xfff1c1, 2, 12);
    luzE.position.set(0, 8, 0);
    scene.add(luzE);
}

function crearNieveInterna() {
    const particulasCant = 400;
    const geo = new THREE.BufferGeometry();
    const positions = [];

    for (let i = 0; i < particulasCant; i++) {
        
        const r = 4.5 * Math.pow(Math.random(), 1/3);
        const theta = Math.random() * 2 * Math.PI;
        const phi = Math.acos(2 * Math.random() - 1);
        
        positions.push(
            r * Math.sin(phi) * Math.cos(theta),
            r * Math.sin(phi) * Math.sin(theta) + 3, 
            r * Math.cos(phi)
        );
    }

    geo.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));
    const mat = new THREE.PointsMaterial({ color: 0xffffff, size: 0.08, transparent: true, opacity: 0.8 });
    nieveSistema = new THREE.Points(geo, mat);
    scene.add(nieveSistema);
}

function cargarPesebreCompleto() {
    const loader = new THREE.GLTFLoader();
    const draco = new THREE.DRACOLoader();
    draco.setDecoderPath("https://unpkg.com/three@0.146.0/examples/js/libs/draco/");
    loader.setDRACOLoader(draco);

    const texLoader = new THREE.TextureLoader();
    const path3D = "<%= request.getContextPath() %>/3D/";
    const pathTex = "<%= request.getContextPath() %>/texturas/";

    const grupoPesebre = new THREE.Group();
    grupoPesebre.position.set(0, 2.8, 0);
    scene.add(grupoPesebre);

    const texPaja = texLoader.load(pathTex + "paja.jpg");
    const montana = new THREE.Mesh(
        new THREE.SphereGeometry(1.8, 32, 32),
        new THREE.MeshStandardMaterial({ map: texPaja, roughness: 1 })
    );
    montana.scale.set(1.75, 0.4, 1.75);
    montana.position.set(0, -0.72, 0.15);
    grupoPesebre.add(montana);

    const modelos = [
        { name: 'casita.glb', scale: 3.2, pos: [0, -0.15, 0.2] },
        { name: 'maria.glb', scale: 0.75, pos: [-0.50, -0.10, 0.40], rotY: Math.PI / 2 },
        { name: 'jose.glb', scale: 1.15, pos: [0.55, -0.10, 0.40], rotY: -Math.PI / 2 },
        { name: 'nino.glb', scale: 0.55, pos: [0, 0.18, 0.50] }
    ];

    modelos.forEach(mod => {
        loader.load(path3D + mod.name, g => {
            const m = g.scene;
            m.scale.set(mod.scale, mod.scale, mod.scale);
            m.position.set(...mod.pos);
            if(mod.rotY) m.rotation.y = mod.rotY;
            
            m.traverse(node => { if(node.isMesh) node.castShadow = true; });
            grupoPesebre.add(m);
        });
    });
}

function animate3D() {
    requestAnimationFrame(animate3D);
   
    if (nieveSistema) {
        const positions = nieveSistema.geometry.attributes.position.array;
        for (let i = 1; i < positions.length; i += 3) {
            positions[i] -= 0.02; 
            if (positions[i] < -1) positions[i] = 7; 
        }
        nieveSistema.geometry.attributes.position.needsUpdate = true;
    }

    if(controls) controls.update();
    renderer.render(scene, camera);
}

window.addEventListener('resize', () => {
    if (!container) return;
    camera.aspect = container.clientWidth / container.clientHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(container.clientWidth, container.clientHeight);
});
</script>

<%@ include file="includes/footer.jsp" %>
</body>
</html>