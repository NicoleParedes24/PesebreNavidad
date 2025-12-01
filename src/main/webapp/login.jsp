<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- TU CSS -->
    <link rel="stylesheet" href="css/login.css">
</head>

<body>

<!-- FONDO BORROSO -->
<div class="fondo-f1-blur"></div>
<div class="fondo-extra-blur"></div>

<!-- MENÚ -->
<%@ include file="includes/menu.jsp" %>

<!-- =============================== -->
<!-- CONTENEDOR IZQUIERDA / DERECHA -->
<!-- =============================== -->
<div class="contenedor-login">

    <!-- IMAGEN DEL ÁRBOL -->
    <div class="arbol-box">
        <img src="img/arbol.png" class="arbol-img">
    </div>

    <!-- TARJETA DE LOGIN -->
    <div class="login-box card shadow-lg">
        <h3 class="text-center fw-bold titulo-login">🎄 Ingreso al Sistema</h3>

        <!-- FORMULARIO -->
        <form action="validarLogin.jsp" method="post">

            <!-- CORREO -->
            <div class="mb-3 mt-3">
                <label class="form-label fw-semibold">Correo electrónico</label>
                <input type="email" class="form-control input-navidad" name="correo" required />
            </div>

            <!-- CLAVE -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Clave</label>
                <input type="password" class="form-control input-navidad" name="clave" required />
            </div>

            <!-- BOTONES -->
            <div class="text-center mt-4">
                <button type="submit" class="btn boton-navidad px-4">Ingresar</button>
                <button type="reset" class="btn boton-secundario px-4 ms-2">Limpiar</button>
            </div>
        </form>

        <!-- MOSTRAR ERROR -->
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center mt-3">
                <%= request.getParameter("error") %>
            </div>
        <% } %>

    </div> <!-- FIN LOGIN BOX -->

</div> <!-- FIN CONTENEDOR PRINCIPAL -->

<!-- ESTRELLAS ANIMADAS -->
<div id="estrellas-container"></div>
<script src="js/login.js"></script>

</body>
</html>
