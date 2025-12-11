<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.pesebreNavidad.negocio.Votar,java.util.ArrayList"
    session="true"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Votar por el Mejor Pesebre</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">

<style>
/* ==========================================================
   CONFIGURACIÓN GLOBAL – FONDO NAVIDEÑO SUAVE
========================================================== */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
}

body {
    background-image: url("img/f1.png");
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
    background-attachment: fixed;
    color: white;
    font-family: "Georgia", serif;
}

/* 🔥 Fondo borroso suave (BLUR 2px) */
.fondo-f1-blur {
    position: fixed;
    top: 0; 
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url("img/f1.png");
    background-size: cover;
    filter: blur(2px) brightness(1.05);
    z-index: -1;
}

/* ==========================================================
   TARJETAS PESebres
========================================================== */

.tarjeta-pesebre {
    width: 260px;
    border-radius: 10px;
    overflow: hidden;
    background: white;
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    margin: 15px;
    text-align: center;
    transition: transform .2s ease-in-out;
}
.tarjeta-pesebre:hover {
    transform: scale(1.05);
}
.tarjeta-pesebre img {
    width: 100%;
    height: 180px;
    object-fit: cover;
}
.btn-votar {
    background: #198754;
    color: white;
    padding: 6px 15px;
    border-radius: 5px;
    display: inline-block;
    margin-bottom: 15px;
    text-decoration: none;
}
.btn-votar:hover {
    background: #146c43;
}
</style>

</head>

<body>

<!-- 🔥 Fondo borroso sin estrellas -->
<div class="fondo-f1-blur"></div>

<!-- Menú general -->
<%@ include file="includes/menu.jsp"%>

<div class="container mt-4">

<%
Integer idUsuario = (Integer) session.getAttribute("id_usuario");

if (idUsuario == null) {
%>
    <div class="alert alert-danger text-center mt-5">
        Debe iniciar sesión para votar.
    </div>
</div>
</body>
</html>
<%
    return;
}

Votar votar = new Votar();
boolean yaVoto = votar.yaVoto(idUsuario);

// Procesar voto
if (request.getParameter("id") != null && !yaVoto) {
    int idGaleria = Integer.parseInt(request.getParameter("id"));
    votar.registrarVoto(idUsuario, idGaleria);
    yaVoto = true;
}
%>

<h1 class="text-center fw-bold mt-4">🎄 Votar por el Mejor Pesebre 🎄</h1>

<div class="text-center mb-4">
<%
if (yaVoto) {
%>
    <div class="alert alert-success fw-bold">
        🎉 ¡Gracias por votar! Ya no puedes votar de nuevo.
    </div>
<%
} else {
    ArrayList<Votar.Pesebre> lista = votar.obtenerPesebres();
%>

<div class="d-flex flex-wrap justify-content-center">

<%
for (Votar.Pesebre p : lista) {
%>
    <div class="tarjeta-pesebre">
        <img src="<%= p.imagen %>" alt="Pesebre">
        <h4 class="mt-2"><%= p.carrera %></h4>
        <a href="votar.jsp?id=<%= p.id %>" class="btn-votar">Votar</a>
    </div>
<%
}
}
%>
</div>

<!-- RANKING -->
<hr class="my-5">

<h2 class="text-center mb-3">🏆 Ranking</h2>

<table class="table table-bordered text-center w-75 mx-auto shadow">
    <thead class="table-success">
        <tr>
            <th>Pesebre</th>
            <th>Votos</th>
        </tr>
    </thead>

    <tbody>
<%
ArrayList<Votar.Ranking> rank = votar.obtenerRanking();
for (Votar.Ranking r : rank) {
%>
        <tr>
            <td><%= r.carrera %></td>
            <td><%= r.votos %></td>
        </tr>
<%
}
%>
    </tbody>
</table>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
