<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Eventos Navideños</title>

<!-- BOOTSTRAP -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- MODEL VIEWER -->
<script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

<!-- TU CSS -->
<link rel="stylesheet" href="css/eventos.css">
<link rel="stylesheet" href="css/login.css">
</head>

<body>

<!-- FONDO BORROSO -->
<div class="fondo-f1-blur"></div>

<!-- MENÚ -->
<%@ include file="includes/menu.jsp" %>

<!-- ============================ CONTENIDO ============================== -->

<div class="container mt-5">

    <h1 class="titulo text-center">🎄 Eventos Navideños 🎄</h1>
    <p class="text-center subtitulo mb-5">Explora música, tradiciones y actividades especiales</p>


    <!-- ========================== CALENDARIO =========================== -->

    <div class="calendario-navidad">

    <h2 class="titulo-calendario">🕯 Novena de Aguinaldos — Diciembre 2025</h2>

    <div class="calendar-grid">

        <!-- Nombres de días -->
        <div class="day-name">Lun</div>
        <div class="day-name">Mar</div>
        <div class="day-name">Mié</div>
        <div class="day-name">Jue</div>
        <div class="day-name">Vie</div>
        <div class="day-name">Sáb</div>
        <div class="day-name">Dom</div>

        <!-- Semana 1 (1 empieza lunes) -->
        <div class="day">1</div>
        <div class="day">2</div>
        <div class="day">3</div>
        <div class="day">4</div>
        <div class="day">5</div>
        <div class="day">6</div>
        <div class="day">7</div>

        <!-- Semana 2 -->
        <div class="day">8</div>
        <div class="day">9</div>
        <div class="day">10</div>
        <div class="day">11</div>
        <div class="day">12</div>
        <div class="day">13</div>
        <div class="day">14</div>

        <!-- Semana 3 -->
        <div class="day">15</div>

        <!-- NOVENAS INICIAN (16–24) -->
        <div class="day especial" data-evento="Día 1 – Novena">16</div> <!-- Martes -->
        <div class="day especial" data-evento="Día 2 – Novena">17</div>
        <div class="day especial" data-evento="Día 3 – Novena">18</div>
        <div class="day especial" data-evento="Día 4 – Novena">19</div>
        <div class="day especial" data-evento="Día 5 – Novena">20</div>
        <div class="day especial" data-evento="Día 6 – Novena">21</div>

        <!-- Semana 4 -->
        <div class="day especial" data-evento="Día 7 – Novena">22</div>
        <div class="day especial" data-evento="Día 8 – Novena">23</div>

        <!-- 24 — Noche Buena -->
        <div class="day especial" data-evento="Día 9 – Noche Buena 🎄✨">24</div>

        <div class="day">25</div>
        <div class="day">26</div>
        <div class="day">27</div>
        <div class="day">28</div>

        <!-- Semana 5 -->
        <div class="day">29</div>
        <div class="day">30</div>
        <div class="day">31</div>

    </div>
</div>

<!-- Tooltip -->
<div id="tooltip-calendario"></div>




    <!-- ======================== HORARIO NOVENAS ======================== -->

    <div class="tarjeta-seccion mt-5">
        <h2 class="titulo-sub">🕯 Horario de Novenas</h2>

        <ul class="list-group horario-list mx-auto">
            <li class="list-group-item">📌 *Día 1* — 7:00 PM</li>
            <li class="list-group-item">📌 *Día 2* — 7:00 PM</li>
            <li class="list-group-item">📌 *Día 3* — 7:00 PM</li>
            <li class="list-group-item">📌 *Día 4* — 7:00 PM</li>
            <li class="list-group-item">📌 *Día 5* — 7:00 PM</li>
            <li class="list-group-item">📌 *Día 6* — 7:00 PM</li>
            <li class="list-group-item">📌 *Día 7* — 7:00 PM</li>
            <li class="list-group-item">📌 *Día 8* — 7:00 PM</li>
            <li class="list-group-item">📌 *Día 9* — 7:00 PM</li>
        </ul>
    </div>


    <!-- ====================== VILLANCICOS ============================ -->

    <div class="tarjeta-seccion mt-5">
        <h2 class="titulo-sub">🎵 Villancicos Tradicionales</h2>
        <p class="texto">Disfruta de los villancicos más cantados en Navidad.</p>

        <div class="villancico">
            <h4>⭐ Noche de Paz</h4>
            <audio controls src="sonido/noche_de_paz.mp3"></audio>
        </div>

        <div class="villancico">
            <h4>⭐ Campana sobre campana</h4>
            <audio controls src="sonido/campana_sobre_campana.mp3"></audio>
        </div>

        <div class="villancico">
            <h4>⭐ Los peces en el río</h4>
            <audio controls src="sonido/los_peces_en_el_rio.mp3"></audio>
        </div>

        <div class="villancico">
            <h4>⭐ Burrito Sabanero</h4>
            <audio controls src="sonido/burrito_sabanero.mp3"></audio>
        </div>

       <div class="villancico">
    <h4>⭐ El Tamborilero</h4>
    <audio controls src="sonido/el_tamborilero.mp3"></audio>
</div>

    </div>


   

    <!-- ====================== NAVIDAD EN EL MUNDO ==================== -->



    <!-- ====================== REALIDAD VIRTUAL ======================== -->

    <div class="tarjeta-seccion mt-5">

    <h2 class="titulo-sub">🕶 Navidad en Realidad Virtual</h2>

    <p class="texto">Explora experiencias navideñas inmersivas en 360°:</p>
<!-- 🔥 EXPERIENCIA VR #1 -->
<div class="text-center mt-3">
    <model-viewer
        src="3D/boy.glb"
        alt="Modelo 3D de un niño"
        camera-controls
        auto-rotate
        ar
        ar-scale="fixed"
        touch-action="pan-y"
        shadow-intensity="1"
        skybox-image="img/n1.jpg"
        camera-orbit="0deg 75deg 10m"
        camera-target="0m 1m 0m"
        field-of-view="31deg"
        scale="10 10 10"
        style="
            width: 100%; 
            max-width: 700px;
            height: 350px;
            margin: 0 auto 20px auto; 
            border-radius: 20px;
        ">
    </model-viewer>
</div>

<!-- SEPARADOR BONITO -->
<h3 class="text-center mt-5 mb-3" style="color:#f5d7a1;">🎄 Otra experiencia 360°</h3>

<!-- 🔥 EXPERIENCIA VR #2 -->
<div class="text-center mt-3">
    <model-viewer
        src="3D/boy.glb"             
        alt="Modelo 3D"
        camera-controls
        auto-rotate
        ar
        ar-scale="fixed"
        touch-action="pan-y"
        shadow-intensity="1"
        skybox-image="img/n2.jpg"     
        camera-orbit="0deg 75deg 10m"
        camera-target="0m 1m 0m"
        field-of-view="31deg"
        scale="10 10 10"
        style="
            width: 100%; 
            max-width: 700px;
            height: 350px;
            margin: 0 auto 20px auto; 
            border-radius: 20px;
        ">
    </model-viewer>
</div>

</div>

    
    
    

</div>

<!-- Nieve -->
<script src="js/nieve.js"></script>
<script src="js/calendario.js"></script>



</body>
</html>
