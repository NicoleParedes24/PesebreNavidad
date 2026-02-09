<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Historia del Pesebre</title>

<!-- CSS -->
<link rel="stylesheet" href="css/histo.css">

<!-- Bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<!-- MODEL VIEWER -->
<script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
<link rel="stylesheet" href="css/footer.css">
</head>

<body>

<div class="fondo-f1-blur"></div>
<div class="fondo-naranja"></div>

<%@ include file="includes/menu.jsp" %>


<div class="container mt-5">

    <h1 class="titulo text-center">Historia del Pesebre</h1>
    <p class="subtitulo text-center">Un recorrido por el origen, tradición y significado del nacimiento.</p>


    <!-- =============================== VIDEO + LÍNEA DE TIEMPO =============================== -->

    <div class="row mt-5 align-items-start">

        <!-- VIDEO -->
        
        
        
        
        <div class="col-lg-6 col-md-12 mb-4">
            <div class="video-container">
               
        <iframe 
				  src="https://www.youtube.com/embed/m_geqHwKRQ8" 
				  title="Video sobre la historia del pesebre"
				  allowfullscreen>
				</iframe>
            </div>
        </div>

        <!-- LÍNEA DE TIEMPO -->
        <div class="col-lg-6 col-md-12">
            <h2 class="titulo-sub text-center">Línea de Tiempo</h2>

            <div class="timeline">

                <div class="timeline-item left">
                    <h3>🎚 1223</h3>
                    <p>San Francisco de Asís crea el primer pesebre viviente en Greccio, Italia.</p>
                </div>

                <div class="timeline-item right">
                    <h3>⛪ Siglo XV</h3>
                    <p>Los pesebres se extienden por Europa, especialmente España y Francia.</p>
                </div>

                <div class="timeline-item left">
                    <h3>🎄 América</h3>
                    <p>Llega la tradición con los misioneros, quienes enseñan el simbolismo.</p>
                </div>

                <div class="timeline-item right">
                    <h3>✨ Actualidad</h3>
                    <p>Hoy existen pesebres artesanales, modernos, animados y hasta en 3D.</p>
                </div>

            </div>
        </div>

    </div>



    <!-- =============================== MODELOS 3D =============================== -->

    <h2 class="titulo-sub text-center mt-5">Pesebres y Decoración en 3D</h2>


    <div class="row text-center justify-content-center">

        <div class="col-md-4 mb-4">
            <model-viewer src="3D/belen-v1.glb" camera-controls auto-rotate class="model-3d"></model-viewer>
            <p class="model-title" role="heading" aria-level="3">Pesebre Tradicional</p>

        </div>

        <div class="col-md-4 mb-4">
            <model-viewer src="3D/tree.glb" camera-controls auto-rotate class="model-3d"></model-viewer>
            <p class="model-title" role="heading" aria-level="3">Arbol de navidad</p>

        </div>

        <div class="col-md-4 mb-4">
            <model-viewer src="3D/pesebre.glb" camera-controls auto-rotate class="model-3d"></model-viewer>
           <p class="model-title" role="heading" aria-level="3">Nacimiento 3D</p>

        </div>

    </div>

</div>

<!-- <script src="js/historia.js"></script> -->
<%@ include file="includes/footer.jsp" %>
</body>
</html>
