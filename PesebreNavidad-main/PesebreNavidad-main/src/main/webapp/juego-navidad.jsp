<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Validación simple de sesión
    Object usuario = session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Juego de Memoria Navideña</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        /* ===================== ESTILOS COMPLETOS ====================== */
        body {
            background: 
                radial-gradient(circle at 10% 20%, rgba(255, 0, 0, 0.15) 0%, transparent 20%),
                radial-gradient(circle at 90% 80%, rgba(0, 255, 0, 0.15) 0%, transparent 20%),
                radial-gradient(circle at 50% 50%, rgba(255, 255, 0, 0.1) 0%, transparent 30%),
                linear-gradient(135deg, #0b3b2a 0%, #1a472a 25%, #2d5a27 50%, #1a472a 75%, #0b3b2a 100%);
            background-size: 400% 400%;
            animation: gradientBG 20s ease infinite;
            font-family: 'Comic Sans MS', 'Arial Rounded MT Bold', sans-serif;
            min-height: 100vh;
            margin: 0;
            overflow-x: hidden;
            position: relative;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Árbol de Navidad en el fondo */
        .christmas-tree {
            position: fixed;
            bottom: -50px;
            right: -50px;
            font-size: 20rem;
            opacity: 0.05;
            transform: rotate(15deg);
            z-index: 0;
            color: #2d5a27;
        }

        /* Luces navideñas */
        .luces-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 30px;
            pointer-events: none;
            z-index: 1000;
            overflow: hidden;
        }
        
        .luz {
            position: absolute;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            top: 5px;
            animation: parpadear 1.5s infinite alternate;
            box-shadow: 0 0 15px 5px currentColor;
            filter: blur(1px);
        }
        
        .luz::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 3px;
            background: currentColor;
            bottom: -3px;
            left: 0;
            border-radius: 2px;
            opacity: 0.7;
        }

        @keyframes parpadear {
            0%, 100% { 
                opacity: 0.3; 
                transform: scale(0.8); 
                box-shadow: 0 0 10px 3px currentColor;
            }
            50% { 
                opacity: 1; 
                transform: scale(1.1); 
                box-shadow: 0 0 20px 8px currentColor;
            }
        }

        /* Nieve mejorada */
        .nieve-container {
            position: fixed;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 999;
            overflow: hidden;
        }

        .copo {
            position: absolute;
            width: 15px;
            height: 15px;
            background: white;
            border-radius: 50%;
            filter: blur(1px);
            opacity: 0.9;
            box-shadow: 0 0 10px white;
            animation: caer linear infinite;
        }

        .copo:nth-child(odd) {
            background: #e6f7ff;
        }

        @keyframes caer {
            0% { 
                transform: translateY(-100px) translateX(0) rotate(0deg);
                opacity: 0;
            }
            10% { 
                opacity: 0.9;
            }
            90% { 
                opacity: 0.9;
            }
            100% { 
                transform: translateY(100vh) translateX(calc(50px * var(--wind))) rotate(360deg);
                opacity: 0;
            }
        }

        /* Tarjeta principal mejorada */
        .tarjeta-juego {
            background: linear-gradient(145deg, rgba(255, 255, 255, 0.98), rgba(230, 255, 230, 0.95));
            border-radius: 30px;
            padding: 40px;
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.3),
                0 0 50px rgba(220, 20, 60, 0.2),
                inset 0 0 30px rgba(255, 255, 255, 0.8);
            border: 6px solid;
            border-image: linear-gradient(45deg, #e63946, #ffd166, #4ecdc4) 1;
            position: relative;
            z-index: 1;
            backdrop-filter: blur(10px);
        }

        .tarjeta-juego::before {
            content: '🎄';
            position: absolute;
            top: -25px;
            left: -25px;
            font-size: 3rem;
            transform: rotate(-15deg);
            filter: drop-shadow(2px 2px 5px rgba(0,0,0,0.3));
        }

        .tarjeta-juego::after {
            content: '🎁';
            position: absolute;
            bottom: -25px;
            right: -25px;
            font-size: 3rem;
            transform: rotate(15deg);
            filter: drop-shadow(2px 2px 5px rgba(0,0,0,0.3));
        }

        /* ============ CARTAS CORREGIDAS - ESTO ES LO IMPORTANTE ============ */
        .tablero {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-template-rows: repeat(3, 1fr);
            gap: 15px;
            padding: 20px;
            background: rgba(255, 248, 220, 0.3);
            border-radius: 20px;
            box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.1);
            min-height: 420px;
        }

        .carta {
            height: 120px;
            cursor: pointer;
            perspective: 1000px;
            transition: transform 0.3s;
        }

        .carta:hover {
            transform: translateY(-5px) scale(1.05);
        }

        .carta-inner {
            width: 100%;
            height: 100%;
            position: relative;
            transform-style: preserve-3d;
            transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        /* GIRO CORREGIDO */
        .carta.volteada .carta-inner {
            transform: rotateY(180deg);
        }

        .carta.encontrada .carta-inner {
            transform: rotateY(180deg);
            box-shadow: 0 0 25px #2a9d8f, 0 0 35px rgba(42, 157, 143, 0.5);
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: rotateY(180deg) scale(1); }
            50% { transform: rotateY(180deg) scale(1.05); }
        }

        .cara {
            position: absolute;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
            backface-visibility: hidden;
            -webkit-backface-visibility: hidden; /* Para Safari */
            border-radius: 15px;
            user-select: none;
            overflow: hidden;
        }

        .frente {
            background: linear-gradient(145deg, #e63946, #ff6b6b);
            color: white;
            border: 4px solid #ffd166;
            box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.2);
            z-index: 2;
        }

        .reverso {
            background: linear-gradient(145deg, #2a9d8f, #4ecdc4);
            color: white;
            transform: rotateY(180deg);
            border: 4px solid #ffd166;
            font-size: 3.5rem;
            z-index: 1;
        }

        /* Asegurar que los emojis sean visibles */
        .reverso span {
            display: block;
            line-height: 1;
            font-family: "Segoe UI Emoji", "Apple Color Emoji", "Noto Color Emoji", sans-serif;
        }

        /* Música mejorada */
        .controles-musica {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.9);
            padding: 15px 20px;
            border-radius: 50px;
            display: flex;
            gap: 15px;
            align-items: center;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border: 3px solid #ffd166;
            z-index: 1000;
        }

        .controles-musica button {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: none;
            background: linear-gradient(145deg, #e63946, #ff6b6b);
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .controles-musica button:hover {
            transform: scale(1.1) rotate(10deg);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .controles-musica input[type="range"] {
            width: 100px;
            height: 10px;
            -webkit-appearance: none;
            background: linear-gradient(to right, #4ecdc4, #2a9d8f);
            border-radius: 5px;
            outline: none;
        }

        /* Modal victoria mejorado */
        .modal-victoria {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.95);
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }

        .mensaje-victoria {
            background: linear-gradient(135deg, #ffd166, #e63946, #4ecdc4);
            color: white;
            padding: 50px;
            border-radius: 30px;
            text-align: center;
            width: 90%;
            max-width: 500px;
            border: 6px solid gold;
            box-shadow: 
                0 0 60px gold,
                0 0 100px rgba(255, 215, 0, 0.5);
            animation: brillo 2s infinite alternate;
        }

        @keyframes brillo {
            from { box-shadow: 0 0 60px gold, 0 0 100px rgba(255, 215, 0, 0.5); }
            to { box-shadow: 0 0 80px gold, 0 0 120px rgba(255, 215, 0, 0.7); }
        }

        /* Títulos y textos */
        h2 {
            background: linear-gradient(45deg, #e63946, #ffd166);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
            position: relative;
            padding-bottom: 15px;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 25%;
            width: 50%;
            height: 4px;
            background: linear-gradient(90deg, transparent, #e63946, transparent);
            border-radius: 2px;
        }

        /* Botones */
        .btn-success {
            background: linear-gradient(145deg, #2a9d8f, #4ecdc4);
            border: 3px solid #ffd166;
            color: white;
            font-weight: bold;
            padding: 12px 30px;
            border-radius: 25px;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-success:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }

        /* Estadísticas - CORREGIDAS */
        .estadisticas-container {
            display: flex;
            justify-content: space-around;
            margin-bottom: 30px;
        }

        .estadistica-item {
            text-align: center;
            background: rgba(255, 255, 255, 0.9);
            padding: 15px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            min-width: 150px;
            border: 3px solid #ffd166;
        }

        .estadistica-titulo {
            color: #2a9d8f;
            font-weight: bold;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }

        .estadistica-valor {
            color: #e63946;
            font-size: 2.5rem;
            font-weight: bold;
            text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .tablero {
                grid-template-columns: repeat(4, 1fr);
                grid-template-rows: repeat(3, 1fr);
            }
            
            .carta {
                height: 100px;
            }
            
            .cara {
                font-size: 2.5rem;
            }
            
            .reverso {
                font-size: 2.5rem;
            }
            
            .tarjeta-juego {
                padding: 20px;
            }
            
            .estadisticas-container {
                flex-direction: column;
                gap: 15px;
            }
            
            .estadistica-item {
                min-width: auto;
            }
        }

        @media (max-width: 480px) {
            .carta {
                height: 80px;
            }
            
            .cara {
                font-size: 2rem;
            }
            
            .reverso {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>

<!-- Elementos decorativos -->
<div class="christmas-tree">🎄</div>
<div class="luces-container" id="luces"></div>
<div class="nieve-container" id="nieve"></div>

<!-- Audio con villancico -->
<audio id="musica" loop>
    <source src="https://assets.mixkit.co/music/preview/mixkit-christmas-is-coming-439.mp3" type="audio/mpeg">
    <!-- Villancico alternativo si el primero falla -->
    <source src="https://assets.mixkit.co/music/preview/mixkit-jingle-bells-311.mp3" type="audio/mpeg">
</audio>

<!-- Controles de música -->
<div class="controles-musica">
    <button id="btnMusica" class="btn btn-light">
        <i class="fas fa-play"></i>
    </button>
    <input type="range" id="volumen" min="0" max="1" step="0.1" value="0.5">
    <span style="color: #e63946; font-weight: bold;">🎵</span>
</div>

<div class="container py-5">
    <div class="tarjeta-juego mx-auto" style="max-width: 800px;">

        <h2 class="text-center fw-bold mb-4">
            🎅 ¡JUEGO DE MEMORIA NAVIDEÑO! 🎄
        </h2>

        <!-- Estadísticas CORREGIDAS -->
        <div class="estadisticas-container mb-4">
            <div class="estadistica-item">
                <div class="estadistica-titulo">
                    <i class="fas fa-shoe-prints me-2"></i>MOVIMIENTOS
                </div>
                <div class="estadistica-valor" id="contadorMovimientos">0</div>
            </div>
            
            <div class="estadistica-item">
                <div class="estadistica-titulo">
                    <i class="fas fa-gift me-2"></i>PARES ENCONTRADOS
                </div>
                <div class="estadistica-valor" id="contadorPares">
                    <span id="paresActual">0</span>/<span id="paresTotal">6</span>
                </div>
            </div>
            
            <div class="estadistica-item">
                <div class="estadistica-titulo">
                    <i class="fas fa-clock me-2"></i>TIEMPO
                </div>
                <div class="estadistica-valor" id="contadorTiempo">0s</div>
            </div>
        </div>

        <!-- Tablero -->
        <div id="tablero" class="tablero mb-4"></div>

        <div class="text-center mt-4">
            <button id="btnIniciar" class="btn btn-success px-5 py-3">
                <i class="fas fa-play-circle me-2"></i>INICIAR JUEGO
            </button>
            <button id="btnReiniciar" class="btn btn-warning px-5 py-3 ms-3">
                <i class="fas fa-redo-alt me-2"></i>REINICIAR
            </button>
        </div>
        
        <div class="text-center mt-4">
            <small class="text-muted">
                <i class="fas fa-info-circle me-1"></i>Encuentra los 6 pares en el menor tiempo posible
            </small>
        </div>
    </div>
</div>

<!-- Modal Victoria -->
<div class="modal-victoria" id="modalVictoria">
    <div class="mensaje-victoria">
        <h2 class="fw-bold display-4 mb-3">🎉 ¡FELICITACIONES! 🎉</h2>
        <p class="fs-4 mb-2">¡Has completado el juego de memoria navideño!</p>
        <div class="fs-5 mb-4" id="textoVictoria"></div>
        <button class="btn btn-dark btn-lg mt-3 px-5 py-3" onclick="location.reload();">
            <i class="fas fa-gamepad me-2"></i>JUGAR DE NUEVO
        </button>
        <button class="btn btn-light btn-lg mt-3 ms-3 px-5 py-3" onclick="document.getElementById('modalVictoria').style.display='none'">
            <i class="fas fa-times me-2"></i>CERRAR
        </button>
    </div>
</div>

<script>
/* Botones */
document.getElementById("btnIniciar").addEventListener("click", iniciarJuego);
document.getElementById("btnReiniciar").addEventListener("click", () => location.reload());

/* ================================================================
    Inicialización al cargar la página (NUEVO)
================================================================ */
document.addEventListener('DOMContentLoaded', () => {
    iniciarJuego(); // ¡Asegura que el tablero se dibuje al inicio!
    musica.volume = volumen.value; // Inicializa el volumen
});

/* ================================================================
   GENERACIÓN DE LUCES MEJORADA
================================================================ */
function crearLuces() {
    const cont = document.getElementById("luces");
    const colores = ["#ff0000", "#ffff00", "#00ff00", "#ff00ff", "#ff8800", "#00ffff"];
    
    for (let i = 0; i < 50; i++) {
        const luz = document.createElement("div");
        luz.className = "luz";
        luz.style.left = ((i * 2) + Math.random() * 1) + "%";
        luz.style.color = colores[Math.floor(Math.random() * colores.length)];
        luz.style.animationDelay = (Math.random() * 2) + "s";
        luz.style.animationDuration = (1 + Math.random()) + "s";
        cont.appendChild(luz);
    }
}
crearLuces();

/* ================================================================
   NIEVE MEJORADA
================================================================ */
function generarNieve() {
    const cont = document.getElementById("nieve");
    
    for (let i = 0; i < 150; i++) {
        const copo = document.createElement("div");
        copo.className = "copo";
        
        // Tamaño aleatorio
        const size = 5 + Math.random() * 15;
        copo.style.width = size + "px";
        copo.style.height = size + "px";
        
        // Posición inicial aleatoria
        copo.style.left = Math.random() * 100 + "%";
        copo.style.top = Math.random() * -100 + "px";
        
        // Velocidad aleatoria
        const duration = 5 + Math.random() * 10;
        copo.style.animationDuration = duration + "s";

        // Viento suave
        copo.style.setProperty("--wind", (Math.random() * 2 - 1).toFixed(2));

        cont.appendChild(copo);
    }
}
generarNieve();

/* ================================================================
    LÓGICA DEL JUEGO DE MEMORIA - VERSIÓN CORREGIDA
================================================================ */

let iconos = ["🎅", "🎄", "⛄", "🎁", "⭐", "🔔"];
let cartas = [];
let primeraCarta = null;
let segundaCarta = null;
let movimientos = 0;
let paresEncontrados = 0;
let temporizador;
let tiempo = 0;
let juegoIniciado = false;

function iniciarJuego() {
    resetearJuego();

    cartas = [...iconos, ...iconos]; // Duplicar iconos
    cartas = cartas.sort(() => Math.random() - 0.5); // Mezclar

    const tablero = document.getElementById("tablero");
    tablero.innerHTML = "";

    cartas.forEach((icono, index) => {
        const carta = document.createElement("div");
        carta.className = "carta";
        carta.dataset.icono = icono;
        carta.dataset.index = index;

        // Crear estructura usando DOM en lugar de innerHTML
        const cartaInner = document.createElement("div");
        cartaInner.className = "carta-inner";
        
        const frente = document.createElement("div");
        frente.className = "cara frente";
        frente.textContent = "❄️";
        
        const reverso = document.createElement("div");
        reverso.className = "cara reverso";
        
        // Crear un span para el emoji con estilos específicos
        const spanEmoji = document.createElement("span");
        spanEmoji.textContent = icono;
        spanEmoji.style.cssText = 'display: block; font-size: 3.5rem; line-height: 1;';
        reverso.appendChild(spanEmoji);
        
        cartaInner.appendChild(frente);
        cartaInner.appendChild(reverso);
        carta.appendChild(cartaInner);

        carta.addEventListener("click", () => voltearCarta(carta));
        tablero.appendChild(carta);
    });

    document.getElementById("paresTotal").textContent = iconos.length;
}

function voltearCarta(carta) {
    if (!juegoIniciado) iniciarTemporizador();

    if (carta.classList.contains("volteada") || 
        carta.classList.contains("encontrada") ||
        segundaCarta) return;

    carta.classList.add("volteada");

    if (!primeraCarta) {
        primeraCarta = carta;
    } else {
        segundaCarta = carta;
        movimientos++;
        document.getElementById("contadorMovimientos").textContent = movimientos;

        if (primeraCarta.dataset.icono === segundaCarta.dataset.icono) {
            primeraCarta.classList.add("encontrada");
            segundaCarta.classList.add("encontrada");

            paresEncontrados++;
            document.getElementById("paresActual").textContent = paresEncontrados;

            primeraCarta = null;
            segundaCarta = null;

            if (paresEncontrados === iconos.length) {
                victoria();
            }
        } else {
            setTimeout(() => {
                primeraCarta.classList.remove("volteada");
                segundaCarta.classList.remove("volteada");
                primeraCarta = null;
                segundaCarta = null;
            }, 800);
        }
    }
}

function iniciarTemporizador() {
    if (juegoIniciado) return;
    juegoIniciado = true;

    temporizador = setInterval(() => {
        tiempo++;
        document.getElementById("contadorTiempo").textContent = tiempo + "s";
    }, 1000);
}

function victoria() {
    clearInterval(temporizador);

    const mensaje = `
        Tiempo: <b>${tiempo}s</b><br>
        Movimientos: <b>${movimientos}</b><br>
        ¡Excelente trabajo!
    `;

    document.getElementById("textoVictoria").innerHTML = mensaje;
    document.getElementById("modalVictoria").style.display = "flex";
}

function resetearJuego() {
    clearInterval(temporizador);
    juegoIniciado = false;
    tiempo = 0;
    movimientos = 0;
    paresEncontrados = 0;
    primeraCarta = null;
    segundaCarta = null;

    document.getElementById("contadorTiempo").textContent = "0s";
    document.getElementById("contadorMovimientos").textContent = "0";
    document.getElementById("paresActual").textContent = "0";
}

/* ================================================================
    MÚSICA
================================================================ */

const musica = document.getElementById("musica");
const btnMusica = document.getElementById("btnMusica");
const volumen = document.getElementById("volumen");

btnMusica.addEventListener("click", () => {
    if (musica.paused) {
        musica.play();
        btnMusica.innerHTML = '<i class="fas fa-pause"></i>';
    } else {
        musica.pause();
        btnMusica.innerHTML = '<i class="fas fa-play"></i>';
    }
});

volumen.addEventListener("input", () => {
    musica.volume = volumen.value;
});

/* Botones */
document.getElementById("btnIniciar").addEventListener("click", iniciarJuego);
document.getElementById("btnReiniciar").addEventListener("click", () => location.reload());

// Añadir un pequeño retraso para asegurar que todo se cargue
setTimeout(() => {
    console.log("Juego cargado y listo. Emojis en cartas:", iconos);
}, 100);
</script>

</body>
</html>