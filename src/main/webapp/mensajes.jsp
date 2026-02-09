<%@ page import="com.pesebreNavidad.negocio.Mensaje, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Usuario en sesión (solo mostrar, no escribir)
    String usuarioActual = (String) session.getAttribute("nombreUsuario");
    if(usuarioActual == null){
        usuarioActual = "Invitado";
    }

    Mensaje dao = new Mensaje();
    List<Mensaje> lista = dao.listar();
%>

<html>
<head>
    <title>Mensajes Navideños</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="css/msj.css">

<link rel="stylesheet" href="css/footer.css">
    <!-- JS EXTERNO -->
    <script src="js/estrellas.js" defer></script>

</head>

<body class="bg-light">

    
    <div class="seccion-fondo">
    <!-- ⭐ ANIMACIÓN ESTRELLAS -->
    <div class="stars"></div>
    

<div class="fondo-f1-blur"></div>
<div class="fondo-extra-blur"></div>


<%@ include file="includes/menu.jsp" %>


<div class="container mt-5">

    <h2 class="text-center text-white mb-4">

        🎄 Mensajes Navideños 🎄
    </h2>

    <% if(request.getParameter("ok") != null){ %>
        <div class="alert alert-success text-center mb-4">
            ¡Listo! Tu mensaje fue guardado. Solo falta la aprobación del administrador para que sea visible 🎁
        </div>
    <% } %>

    <!-- LISTA DE MENSAJES -->
    </br>

	<div class="grid-bombillos">
	<% for(Mensaje m : lista){ 
     if(!m.isAprobado()) continue;   // ❗ Saltar mensajes NO aprobados
	%>
	
	    <div class="bombillo-navidad">
	        <div class="bombillo-contenido">
	            <strong><%= m.getNombre() %></strong>
	            <p><%= m.getMensaje() %></p>
	            <small><%= m.getFecha() %></small>
	        </div>
	    </div>
	
	<% } %>

	</div>




   

</div>

<%@ include file="includes/footer.jsp" %>
</body>
</html>
