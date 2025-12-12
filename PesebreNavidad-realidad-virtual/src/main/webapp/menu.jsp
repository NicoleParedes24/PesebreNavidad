<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true" 
    import="com.pesebreNavidad.seguridad.*, java.time.*, java.time.format.*" %>

<%
    HttpSession sesion = request.getSession();

    // Si no hay usuario logueado → enviar al login
    if (sesion.getAttribute("usuario") == null || sesion.getAttribute("perfil") == null) {
%>
        <jsp:forward page="login.jsp">
            <jsp:param name="error" value="Debe iniciar sesión primero."/>
        </jsp:forward>
<%
        return;
    }

    String usuario = (String) sesion.getAttribute("usuario");
    int perfil = (Integer) sesion.getAttribute("perfil");

    // Fecha y hora
    LocalDateTime ahora = LocalDateTime.now();
    DateTimeFormatter formatoFecha = DateTimeFormatter.ofPattern("EEE, MMM dd yyyy");
    DateTimeFormatter formatoHora = DateTimeFormatter.ofPattern("HH:mm");

    String fecha = ahora.format(formatoFecha);
    String hora = ahora.format(formatoHora);

    // Instanciar clase Pagina para generar menú dinámico
    Pagina pag = new Pagina();
    String menuGenerado = pag.mostrarMenu(perfil);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel Privado</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<!-- MENÚ DINÁMICO -->
<%= menuGenerado %>

<!-- CUADRO DE BIENVENIDA -->
<div class="container mt-4">
    <div class="card shadow p-4" style="background:#f7f3e9;">
        <h2 class="text-center">🎄 Bienvenid@ al Pesebre Navideño 🎄</h2>
        <h4 class="text-center mt-3">Usuario: <%= usuario %></h4>
        <p class="text-center"><%= fecha %> — <%= hora %></p>
    </div>
</div>

</body>
</html>

