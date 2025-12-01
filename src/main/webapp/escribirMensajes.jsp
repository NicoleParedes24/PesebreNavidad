<%@ page import="com.pesebreNavidad.negocio.Mensaje" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Obtener usuario en sesión
    String nombre = (String) session.getAttribute("nombreUsuario");
    if(nombre == null || nombre.trim().equals("")){
        nombre = "Invitado";
    }

    // Guardar mensaje si viene el POST
    String mensajeTxt = request.getParameter("mensaje");

    if(mensajeTxt != null){
        Mensaje m = new Mensaje();
        m.setNombre(nombre);
        m.setMensaje(mensajeTxt);

        if(m.guardar()){
            response.sendRedirect("mensajes.jsp?ok=1");
            return;
        } 
%>
        <div class="alert alert-danger text-center mt-3">
            Error al guardar mensaje.
        </div>
<%
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Escribir mensaje navideño</title>

    <!-- BOOTSTRAP -->
    <link 
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
      rel="stylesheet"
    >

    <!-- TU CSS -->
    <link rel="stylesheet" href="css/escribirMensajes.css">

    <!-- Estrellas -->
    <script src="js/estrellas.js" defer></script>

</head>

<body>

    <!-- FONDO -->
    <div class="fondo-f1-blur"></div>
    <div class="seccion-fondo"></div>

    <!-- ESTRELLAS -->
    <div class="stars"></div>

    <!-- MENÚ -->
    <%@ include file="includes/menu.jsp" %>

    <!-- CONTENIDO CENTRAL -->
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh; padding-top: 80px;">

        <div class="card shadow p-4" style="max-width:600px; width:100%; border-radius:20px;">

            <h3 class="text-center titulo-mensajes fw-bold mb-4">
                ✨ Escribe un mensaje navideño ✨
            </h3>

            <form method="post">

                <!-- NOMBRE -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Tu nombre</label>
                    <input class="form-control" type="text" value="<%= nombre %>" disabled>
                </div>

                <!-- MENSAJE -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Mensaje</label>
                    <textarea name="mensaje" rows="4" maxlength="300" class="form-control" required></textarea>
                </div>

                <!-- BOTONES -->
                <div class="d-flex justify-content-between">

                    <button class="btn btn-success px-4">Enviar 🎄</button>

                    <a href="mensajes.jsp" class="btn btn-secondary px-4">
                        Ver mensajes
                    </a>

                    <a href="panelEstudiante.jsp" class="btn btn-outline-danger px-4">
                        ⬅ Regresar
                    </a>

                </div>

            </form>

        </div>

    </div>

</body>
</html>
