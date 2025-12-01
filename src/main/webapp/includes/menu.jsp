<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page session="true" %>

<!-- BOTÓN SOLO EN CELULAR -->
<button class="menu-btn d-lg-none" onclick="toggleMenu()">☰ Menú</button>

<!-- MENÚ PRINCIPAL -->
<nav class="menu navbar-expand-lg">
    <ul class="navbar-nav mx-auto">

        <% 
            // Si NO hay usuario → es invitado
            if (session.getAttribute("perfil") == null) { 
        %>

            <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
            <li class="nav-item"><a class="nav-link" href="personajes.jsp">Personajes</a></li>
            <li class="nav-item"><a class="nav-link" href="historia.jsp">Historia</a></li>
            <li class="nav-item"><a class="nav-link" href="eventos.jsp">Eventos</a></li>
            <li class="nav-item"><a class="nav-link" href="mensajes.jsp">Mensajes Navideños</a></li>
            <li class="nav-item"><a class="nav-link" href="registro.jsp">Registrarse</a></li>
            <li class="nav-item"><a class="nav-link" href="login.jsp">Iniciar Sesión</a></li>

        <% 
            } else { 
                int perfil = Integer.parseInt(session.getAttribute("perfil").toString());

                if (perfil == 2) { // ESTUDIANTE
        %>

            <li class="nav-item"><a class="nav-link" href="personajes.jsp">Personajes</a></li>
            <li class="nav-item"><a class="nav-link" href="historia.jsp">Historia</a></li>
            <li class="nav-item"><a class="nav-link" href="eventos.jsp">Eventos</a></li>
            <li class="nav-item"><a class="nav-link" href="mensajes.jsp">Mensajes Navideños</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="cerrarSesion.jsp">Cerrar Sesión</a></li>

        <% 
                }
            } 
        %>

    </ul>
</nav>

<script>
function toggleMenu() {
    document.querySelector(".menu").classList.toggle("show");
}
</script>
