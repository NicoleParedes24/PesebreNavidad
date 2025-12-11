<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pesebre Navideño</title>

    <!-- CSS EXTERNO -->
    <link rel="stylesheet" href="css/in.css">

    <!-- JS EXTERNO -->
    <script src="js/estrellas.js" defer></script>

</head>
<body>

    <!-- ⭐ ANIMACIÓN ESTRELLAS -->
    <div class="stars"></div>

    <div class="seccion-fondo">
<!-- BOTÓN SOLO PARA MÓVIL -->
<button class="menu-btn" onclick="document.querySelector('.menu').classList.toggle('show')">
    ☰ Menú
</button>

<!-- MENÚ ORIGINAL -->
<div class="menu">
    <a href="index.jsp">Inicio</a>
    <a href="personajes.jsp">Personajes</a>
    <a href="historia.jsp">Historia</a>
    <a href="eventos.jsp">Eventos</a>
    <a href="mensajes.jsp">Mensajes Navideños</a>
    <a href="registro.jsp">Registrarse</a>
    <a href="login.jsp">Iniciar Sesión</a>
</div>


        <!-- TITULO PRINCIPAL -->
        <div class="titulo">
            <h1>Bienvenido al pesebre navideño</h1>
            <p>Que la luz de la Navidad ilumine tu hogar con paz, amor y esperanza.</p>
        </div>

        <!-- IMAGEN DEL PESEBRE -->
        <div class="contenedor-superior">
            <img src="img/encima2.png" alt="pesebre">
        </div>
    </div>

</body>
</html>
