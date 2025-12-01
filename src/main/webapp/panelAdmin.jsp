<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>

<%
    if (session.getAttribute("usuario") == null || session.getAttribute("perfil") == null) {
        response.sendRedirect("login.jsp?error=Debe iniciar sesión");
        return;
    }

    int perfil = (Integer) session.getAttribute("perfil");

    if (perfil != 1) {
        response.sendRedirect("panelEstudiante.jsp");
        return;
    }

    String usuario = (String) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel del Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">🎄 Admin - Pesebre Navideño</span>
        <span class="text-white">Usuario: <%= usuario %></span>
        <a href="cerrarSesion.jsp" class="btn btn-danger">Cerrar Sesión</a>
    </div>
</nav>

<div class="container mt-4">

    <div class="row">
        <div class="col-md-4">
            <a href="adminUsuarios.jsp" class="btn btn-primary w-100 mb-3">👤 Administrar Usuarios</a>
        </div>

        <div class="col-md-4">
            <a href="bitacora.jsp" class="btn btn-warning w-100 mb-3">📘 Bitácora</a>
        </div>

        <div class="col-md-4">
            <a href="mensajes.jsp" class="btn btn-success w-100 mb-3">💬 Mensajes Navideños</a>
        </div>
    </div>

</div>

</body>
</html>
