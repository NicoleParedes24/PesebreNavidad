<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Personajes del Pesebre</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- MODEL VIEWER -->
<script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

<!-- TU CSS -->
<link rel="stylesheet" href="css/personajes.css">
</head>
<body>

<div class="fondo-f1-blur"></div>
<div class="fondo-naranja"></div>

<%@ include file="includes/menu.jsp" %>


<div class="container mt-5 text-center">

    <h1 class="titulo">Personajes del Pesebre</h1>
    <p class="subtitulo mb-5">Conoce a los personajes más representativos del nacimiento.</p>

    <!-- ======================================================
                        PERSONAJES PRINCIPALES
    ======================================================= -->
    <h2 class="titulo-sub">Personajes Principales</h2>

    <div class="row g-4 justify-content-center mt-3">

        <!-- NIÑO JESÚS -->
        <div class="col-md-3">
            <div class="card-personaje">
                <img src="img/jesus.png" class="foto">
                <h3>Niño Jesús</h3>
                <p>El centro del nacimiento, símbolo de esperanza y luz.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

        <!-- MARÍA -->
        <div class="col-md-3">
            <div class="card-personaje">
                <img src="img/maria.png" class="foto">
                <h3>María</h3>
                <p>Madre de Jesús, símbolo de amor y fe.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

        <!-- JOSÉ -->
        <div class="col-md-3">
            <div class="card-personaje">
                <img src="img/jose.png" class="foto">
                <h3>José</h3>
                <p>Padre terrenal de Jesús, protector del hogar.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

    </div>

    <!-- ======================================================
                        PERSONAJES IMPORTANTES
    ======================================================= -->
    <h2 class="titulo-sub" style="margin-top:60px;">Personajes Importantes</h2>

    <div class="row g-4 justify-content-center mt-3">

        <!-- ÁNGEL -->
        <div class="col-md-3">
            <div class="card-personaje">
                <img src="img/angel.png" class="foto">
                <h3>Ángel</h3>
                <p>Mensajero de Dios, anuncia el nacimiento.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

        <!-- PASTOR -->
        <div class="col-md-3">
            <div class="card-personaje">
                <img src="img/pastor.png" class="foto">
                <h3>Pastor</h3>
                <p>Simboliza la humildad y quienes primero recibieron la noticia.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

        <!-- MELCHOR -->
        <div class="col-md-3">
            <div class="card-personaje">
                <img src="img/melchor.png" class="foto">
                <h3>Melchor</h3>
                <p>Rey mago que ofrece oro, símbolo de realeza.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

        <!-- GASPAR -->
        <div class="col-md-3">
            <div class="card-personaje">
                <img src="img/gaspar.png" class="foto">
                <h3>Gaspar</h3>
                <p>Rey mago que trae incienso, símbolo divino.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

        <!-- BALTASAR -->
        <div class="col-md-3">
            <div class="card-personaje">
                <img src="img/baltazar.jpeg" class="foto">
                <h3>Baltasar</h3>
                <p>Rey mago que entrega mirra, símbolo de humanidad.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

    </div>

    <!-- ======================================================
                        ANIMALES DEL PESEBRE
    ======================================================= -->
    <h2 class="titulo-sub" style="margin-top:60px;">Animales del Pesebre</h2>

    <div class="row g-4 justify-content-center mt-3">

<!-- BUEY -->
<div class="col-md-3">
    <div class="card-personaje">
        <model-viewer 
            src="3D/buey.glb"
            camera-controls
            autoplay
            class="model-viewer">
        </model-viewer>
        <h3>Buey</h3>
        <p>Símbolo de paciencia, fuerza y trabajo.</p>
        <button class="btn-vermas">Ver más</button>
    </div>
</div>


        <!-- OVEJA -->
        <div class="col-md-3">
            <div class="card-personaje">
                <model-viewer 
                    src="3D/oveja.glb"
                    camera-controls 
                    auto-rotate
                    class="model-viewer">
                </model-viewer>
                <h3>Oveja</h3>
                <p>Acompaña a los pastores con serenidad y ternura.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

        <!-- MULA -->
        <div class="col-md-3">
            <div class="card-personaje">
                <model-viewer 
                    src="3D/burro.glb"
                    camera-controls
            autoplay
                    class="model-viewer">
                </model-viewer>
                <h3>Mula</h3>
                <p>Representa humildad, entrega y servicio.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

        <!-- CAMELLO -->
        <div class="col-md-3">
            <div class="card-personaje">
                <model-viewer 
                    src="3D/camello.glb"
                    camera-controls 
                    auto-rotate
                    class="model-viewer">
                </model-viewer>
                <h3>Camello</h3>
                <p>Animal de los Reyes Magos, símbolo de viaje y devoción.</p>
                <button class="btn-vermas">Ver más</button>
            </div>
        </div>

    </div>

</div>

<!-- TU JS -->
<script src="js/personajes.js"></script>

</body>
</html>
