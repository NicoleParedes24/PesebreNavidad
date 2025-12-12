<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.*, com.pesebreNavidad.seguridad.*" %>

<%
    // ===================== CARGAR DATOS DEL CALENDARIO =====================
    Calendario cal = new Calendario();
    java.sql.Date hoy = new java.sql.Date(System.currentTimeMillis());

    List<Calendario> dias = cal.listarDisponibles(hoy);
    Map<Integer, Calendario> mapa = new HashMap<>();

    for (Calendario c : dias) {
        mapa.put(c.getDia(), c);
    }
%>

=======
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
>>>>>>> upstream/main
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Eventos Navideños</title>

<!-- BOOTSTRAP -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- MODEL VIEWER -->
<script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

<<<<<<< HEAD
<!-- CSS -->
<link rel="stylesheet" href="css/estilosEventos.css">
<link rel="stylesheet" href="css/footer.css">

<style>
/* Modal especial para calendario */
.modal-content {
    background: #fff7e6;
    border: 3px solid gold;
    border-radius: 15px;
}

.imagen-dia {
    width: 100%;
    max-width: 350px;     /* Tamaño ideal en celulares */
    height: auto;
    display: block;
    margin: 0 auto;       /* Centrada */
    border-radius: 12px;
    object-fit: contain;  /* No se deforma */
}
/* ======== FRASE DEL DÍA (texto principal) ======== */
.frase-dia {
    font-size: 1.3rem;
    font-weight: 600;
    color: #6b1d1d;          /* Vino navideño – legible y elegante */
    text-align: center;
    margin-bottom: 15px;
    padding: 10px 15px;
    background: #fff3e0;     /* Fondo suave */
    border-left: 4px solid #d43f3f;
    border-right: 4px solid #d43f3f;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
}


/* TABLET */
@media (min-width: 600px) {
    .imagen-dia {
        max-width: 450px;
    }
}

/* ESCRITORIO */
@media (min-width: 992px) {
    .imagen-dia {
        max-width: 550px;
    }
}


/* Estilos acordeón */
.accordion-button {
    background-color: #b22222 !important;
    color: white !important;
    font-weight: bold;
}

.accordion-body {
    background: #fff3dd;
    border-radius: 10px;
    white-space: pre-line;
}
</style>

=======
<!-- TU CSS -->
<link rel="stylesheet" href="css/estilosEventos.css">
<!-- <link rel="stylesheet" href="css/login.css"> -->
<link rel="stylesheet" href="css/footer.css">
>>>>>>> upstream/main
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

<<<<<<< HEAD
<!-- ========================== CALENDARIO DINÁMICO =========================== -->

<div class="calendario-navidad">
=======

    <!-- ========================== CALENDARIO =========================== -->

    <div class="calendario-navidad">
>>>>>>> upstream/main

    <h2 class="titulo-calendario">🕯 Novena de Aguinaldos — Diciembre 2025</h2>

    <div class="calendar-grid">

<<<<<<< HEAD
        <!-- Encabezados -->
=======
        <!-- Nombres de días -->
>>>>>>> upstream/main
        <div class="day-name">Lun</div>
        <div class="day-name">Mar</div>
        <div class="day-name">Mié</div>
        <div class="day-name">Jue</div>
        <div class="day-name">Vie</div>
        <div class="day-name">Sáb</div>
        <div class="day-name">Dom</div>

<<<<<<< HEAD
        <% 
            // Generar 1–31 utilizando el diseño de su compañero
            for (int d = 1; d <= 31; d++) {
                boolean desbloqueado = mapa.containsKey(d);
        %>

        <div class="day <%= desbloqueado ? "especial" : "" %>"
             <%= desbloqueado ? "onclick='abrirDia(" + d + ")'" : "" %>>
            <%= d %>
        </div>

        <% } %>
=======
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
>>>>>>> upstream/main

    </div>
</div>

<<<<<<< HEAD

<!-- ========================== MODAL DETALLE =========================== -->

<div class="modal fade" id="modalDia" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content p-3">

      <div class="modal-header">
        <h4 class="modal-title fw-bold text-danger">
            <i class="fa-solid fa-gift"></i> Día <span id="diaNumero"></span>
        </h4>
        <button class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

        <div id="fraseDia" class="frase-dia"></div>


        <img id="imgDia" class="imagen-dia d-none">

        <audio id="audioDia" controls class="d-none mt-3"></audio>

        <p id="villancicoDia" class="mt-3 fw-bold text-success"></p>

        <!-- LETRA EN ACORDEÓN -->
        <div id="acordeonLetra" class="accordion d-none mt-3">
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button" data-bs-toggle="collapse"
                        data-bs-target="#letraCollapse">
                        🎵 Mostrar letra del villancico
                    </button>
                </h2>
                <div id="letraCollapse" class="accordion-collapse collapse">
                    <div class="accordion-body" id="letraDia"></div>
                </div>
            </div>
        </div>

        <!-- PDF -->
        <a id="pdfBtn" class="btn btn-danger d-none mt-3" download>
            📄 Descargar Novena en PDF
        </a>

      </div>

    </div>
  </div>
</div>

<!-- ========================== REALIDAD VIRTUAL =========================== -->

<div class="tarjeta-seccion mt-5">

<h2 class="titulo-sub">🕶 Navidad en Realidad Virtual</h2>

<p class="texto">Explora experiencias navideñas inmersivas en 360°:</p>

=======
<!-- Tooltip -->
<div id="tooltip-calendario"></div>




<!--     ======================== HORARIO NOVENAS ======================== -->

<!--     <div class="tarjeta-seccion mt-5"> -->
<!--         <h2 class="titulo-sub">🕯 Horario de Novenas</h2> -->

<!--         <ul class="list-group horario-list mx-auto"> -->
<!--             <li class="list-group-item">📌 *Día 1* — 7:00 PM</li> -->
<!--             <li class="list-group-item">📌 *Día 2* — 7:00 PM</li> -->
<!--             <li class="list-group-item">📌 *Día 3* — 7:00 PM</li> -->
<!--             <li class="list-group-item">📌 *Día 4* — 7:00 PM</li> -->
<!--             <li class="list-group-item">📌 *Día 5* — 7:00 PM</li> -->
<!--             <li class="list-group-item">📌 *Día 6* — 7:00 PM</li> -->
<!--             <li class="list-group-item">📌 *Día 7* — 7:00 PM</li> -->
<!--             <li class="list-group-item">📌 *Día 8* — 7:00 PM</li> -->
<!--             <li class="list-group-item">📌 *Día 9* — 7:00 PM</li> -->
<!--         </ul> -->
<!--     </div> -->


    <!-- ====================== VILLANCICOS ============================ -->

    <div class="tarjeta-seccion mt-5">
        <h2 class="titulo-sub">🎵 Villancicos Tradicionales</h2>
        <p class="texto">Disfruta de los villancicos más cantados en Navidad.</p>

        <div class="villancico">
           <h4 role="heading" aria-level="3">⭐ Noche de Paz</h4>
           <div aria-hidden="true">
			    <audio controls src="sonido/noche_de_paz.mp3"></audio>
			</div>
           
<!--             <audio controls src="sonido/noche_de_paz.mp3"></audio> -->
        </div>

        <div class="villancico">
        <h4 role="heading" aria-level="3">⭐ Campana sobre campana</h4>
        
            <audio controls src="sonido/campana_sobre_campana.mp3"></audio>
        </div>

        <div class="villancico">
            <h4 role="heading" aria-level="3">⭐ Los peces en el rio</h4>

            <audio controls src="sonido/los_peces_en_el_rio.mp3"></audio>
        </div>

        <div class="villancico">
            <h4 role="heading" aria-level="3">⭐ Burrito Sabanero</h4>

            <audio controls src="sonido/burrito_sabanero.mp3"></audio>
        </div>

       <div class="villancico">
       <h4 role="heading" aria-level="3">⭐ El Tamborilero</h4>
       
    <audio controls src="sonido/el_tamborilero.mp3"></audio>
</div>

    </div>


   

    <!-- ====================== NAVIDAD EN EL MUNDO ==================== -->



    <!-- ====================== REALIDAD VIRTUAL ======================== -->

    <div class="tarjeta-seccion mt-5">

    <h2 class="titulo-sub">🕶 Navidad en Realidad Virtual</h2>

    <p class="texto">Explora experiencias navideñas inmersivas en 360°:</p>
<!-- 🔥 EXPERIENCIA VR #1 -->
>>>>>>> upstream/main
<div class="text-center mt-3">
    <model-viewer
        src="3D/boy.glb"
        alt="Modelo 3D de un niño"
<<<<<<< HEAD
        camera-controls auto-rotate ar ar-scale="fixed"
=======
        camera-controls
        auto-rotate
        ar
        ar-scale="fixed"
        touch-action="pan-y"
>>>>>>> upstream/main
        shadow-intensity="1"
        skybox-image="img/n1.jpg"
        camera-orbit="0deg 75deg 10m"
        camera-target="0m 1m 0m"
        field-of-view="31deg"
        scale="10 10 10"
<<<<<<< HEAD
        style="width:100%; max-width:700px; height:350px; margin:0 auto; border-radius:20px;">
    </model-viewer>
</div>

</div>


</div> <!-- FIN CONTAINER -->
=======
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
<!-- <h3 class="text-center mt-5 mb-3" style="color:#f5d7a1;">🎄 Otra experiencia 360°</h3> -->

<!-- 🔥 EXPERIENCIA VR #2 -->
<!-- <div class="text-center mt-3"> -->
<!--     <model-viewer -->
<!--         src="3D/boy.glb"              -->
<!--         alt="Modelo 3D" -->
<!--         camera-controls -->
<!--         auto-rotate -->
<!--         ar -->
<!--         ar-scale="fixed" -->
<!--         touch-action="pan-y" -->
<!--         shadow-intensity="1" -->
<!--         skybox-image="img/n2.jpg"      -->
<!--         camera-orbit="0deg 75deg 10m" -->
<!--         camera-target="0m 1m 0m" -->
<!--         field-of-view="31deg" -->
<!--         scale="10 10 10" -->
<!--         style=" -->
<!--              width: 100%;  */ -->
<!-- /*             max-width: 700px; */ -->
<!-- /*             height: 350px; */ -->
<!-- /*             margin: 0 auto 20px auto;  */ -->
<!-- /*             border-radius: 20px; */ -->
<!--         "> -->
<!--     </model-viewer> -->
<!-- </div> -->

</div>

    
    
    

</div>
>>>>>>> upstream/main

<!-- Nieve -->
<script src="js/nieve.js"></script>
<script src="js/calendario.js"></script>

<<<<<<< HEAD
<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

<!-- BOOTSTRAP JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- ========================== PASAR DATOS A JS =========================== -->

<script>

const datos = {
<%
    for(Calendario c : dias) {

        String letra = (c.getLetra()==null ? "" :
                         c.getLetra()
                            .replace("\\","\\\\")
                            .replace("\"","\\\"")
                            .replace("\r","")
                            .replace("\n","\\n"));
%>

    <%= c.getDia() %> : {
        frase: "<%= c.getFrase().replace("\"","\\\"") %>",
        imagen: "<%= c.getImagen() %>",
        audio: "<%= c.getAudio() %>",
        villancico: "<%= c.getVillancico() %>",
        letra: "<%= letra %>",
        pdf: "<%= c.getPdfNovena() %>"
    },

<% } %>
};



// ============================ ABRIR MODAL ===============================
function abrirDia(dia) {

    const info = datos[dia];
    if (!info) return;

    document.getElementById("diaNumero").textContent = dia;
    document.getElementById("fraseDia").textContent = info.frase;

    // IMAGEN
    const img = document.getElementById("imgDia");
    img.classList.toggle("d-none", !info.imagen);
    if (info.imagen) img.src = info.imagen;

    // AUDIO
    const audio = document.getElementById("audioDia");
    audio.classList.toggle("d-none", !info.audio);
    if (info.audio) audio.src = info.audio;

    // VILLANCICO
    document.getElementById("villancicoDia").textContent =
        info.villancico ? "🎵 " + info.villancico : "";

    // LETRA EN ACORDEÓN
    const acordeon = document.getElementById("acordeonLetra");
    const letraDiv = document.getElementById("letraDia");

    if (info.letra && info.letra.trim().length > 0) {
        letraDiv.textContent = info.letra;
        acordeon.classList.remove("d-none");
    } else {
        acordeon.classList.add("d-none");
    }

    // PDF NOVENA — SOLO DÍAS 16–24
    const pdfBtn = document.getElementById("pdfBtn");
    if (dia >= 12 && dia <= 20 && info.pdf && info.pdf !== "null") {
        pdfBtn.href = info.pdf;
        pdfBtn.classList.remove("d-none");
    } else {
        pdfBtn.classList.add("d-none");
    }

    new bootstrap.Modal(document.getElementById("modalDia")).show();
}

</script>

=======
<%@ include file="includes/footer.jsp" %>

>>>>>>> upstream/main
</body>
</html>
