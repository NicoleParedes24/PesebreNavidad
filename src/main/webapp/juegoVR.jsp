<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<% if (session.getAttribute("usuario") == null) { response.sendRedirect("login.jsp"); return; } %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pesebre 3D • ChristMart</title>

  <script src="https://aframe.io/releases/1.5.0/aframe.min.js"></script>
  <script src="js/pesebreVR.js" defer></script>
    <style>
        body,html{
            margin:0; padding:0; height:100%;
            overflow:hidden; background:#000;
        }
        .menu{
            position:absolute; top:0; left:0; width:100%;
            background:rgba(0,0,0,0.7); padding:12px;
            text-align:center; z-index:999;
            color:white; font-family:Arial;
        }
        .menu a{
            color:#fff; margin:0 20px; text-decoration:none;
            font-weight:bold;
        }
        .menu a:hover{ color:#ffd700; }

        .info{
            position:absolute; bottom:120px; left:50%;
            transform:translateX(-50%);
            background:rgba(0,0,0,0.7); color:#fff;
            padding:10px 20px; border-radius:10px; z-index:999;
            font-family:Arial;
        }

        /*estilo de botones */
        .controls{
            position:absolute;
            bottom:20px;
            left:50%;
            transform:translateX(-50%);
            z-index:999;
            display:flex;
            flex-direction:column;
            align-items:center;
            gap:8px;
        }
        .row{
            display:flex;
            gap:10px;
        }
        .btn{
            width:60px;
            height:60px;
            background:rgba(255,255,255,0.25);
            border:2px solid #fff;
            border-radius:10px;
            display:flex;
            justify-content:center;
            align-items:center;
            color:#fff;
            font-size:24px;
            font-weight:bold;
            user-select:none;
        }
        .btn:active{
            background:rgba(255,255,255,0.4);
        }
        /* ===== MENU SUPERIOR FIJO ===== */
nav,
.navbar {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 60px;

    background: rgba(0, 0, 0, 0.75);
    backdrop-filter: blur(6px);

    z-index: 9999;
}

/* UL del menú */
.navbar-nav {
    display: flex !important;
    flex-direction: row !important;
    justify-content: center;
    align-items: center;

    width: 100%;
    height: 100%;

    margin: 0;
    padding: 0;
    list-style: none;
}

/* LI */
.nav-item {
    margin: 0 15px;
}

/* LINKS */
.nav-link {
    color: #ffffff !important;
    font-weight: bold;
    font-size: 16px;

    text-decoration: none;
    transition: color 0.3s, transform 0.3s;
}

.nav-link:hover {
    color: #ffd700 !important;
    transform: scale(1.08);
}

/* CERRAR SESIÓN */
.nav-link.text-danger {
    color: #ff5c5c !important;
}

.nav-link.text-danger:hover {
    color: #ff0000 !important;
}

/* ===== BAJAR CONTENIDO (A-FRAME) ===== */
a-scene[embedded] {
    position: absolute;
    top: 60px !important;
    left: 0;
    width: 100%;
    height: calc(100% - 60px);
}
        
    </style>
</head>

<body>
<%@ include file="includes/menu.jsp" %>



<!-- botones para el telefono -->
<div class="controls">
    <div class="row">
        <div class="btn" id="btnUp">▲</div>
    </div>
    <div class="row">
        <div class="btn" id="btnLeft">◀</div>
        <div class="btn" id="btnRight">▶</div>
    </div>
    <div class="row">
        <div class="btn" id="btnDown">▼</div>
    </div>
</div>



<a-scene embedded="true">

    <!-- fondo 360 -->
    <a-sky src="img/fondo3.jpg"></a-sky>

    <a-entity gltf-model="3D/pesebreVR.glb"
              scale="3 3 3"
              position="0 0 -5"
              rotation="0 180 0">
    </a-entity>

    <!-- Suelo -->
    <a-plane position="0 0 0"
             rotation="-90 0 0"
             width="50" height="50"
             color="#000000" visible="false">
    </a-plane>

    <!-- iluminacion -->
    <a-light type="ambient" intensity="0.7"></a-light>
    <a-light type="directional" color="#ffddaa" intensity="1.1" position="4 10 6"></a-light>


    <!-- controles del pesebre -->
    <a-entity id="camaraJugador"
              camera 
              look-controls
              position="0 1.6 -2">
        <a-cursor color="#ffd700"></a-cursor>
    </a-entity>

</a-scene>



</body>
</html>

