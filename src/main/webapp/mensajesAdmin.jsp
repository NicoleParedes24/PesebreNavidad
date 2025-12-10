<%@ page import="com.pesebreNavidad.negocio.Mensaje, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // PROTEGER SOLO ADMIN (perfil = 1)
    if (session.getAttribute("usuario") == null || 
        (Integer)session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=No tienes acceso");
        return;
    }

    String usuarioActual = (String) session.getAttribute("usuario");

    Mensaje dao = new Mensaje();
    List<Mensaje> lista = dao.listar();
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <title>Administrar Mensajes Navideños</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/mensajesAdmin.css">
</head>
<body class="bg-light">

<div class="fondo-f1-blur"></div>

<!-- MENÚ NAVIDEÑO -->
<%@ include file="includes/menu.jsp" %>

<!-- Usuario a la derecha -->


<div class="container mt-5">

    <h2 class="text-center text-white fw-bold mb-4">
        🎄 Administrar Mensajes Navideños 🎄
    </h2>

    <% if(request.getParameter("ok") != null){ %>
        <div class="alert alert-success text-center mb-4">
            Mensaje actualizado correctamente 🎁
        </div>
    <% } %>

    <% if(request.getParameter("del") != null){ %>
        <div class="alert alert-danger text-center mb-4">
            Mensaje eliminado ❌
        </div>
    <% } %>

    <div class="table-responsive">
        <table class="table table-bordered table-striped bg-white text-center align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Mensaje</th>
                    <th>Fecha</th>
                    <th>Editar</th>
                    <th>Eliminar</th>
                </tr>
            </thead>

            <tbody>
                <% for(Mensaje m : lista){ %>
                    <tr>
                        <td><%= m.getId() %></td>
                        <td><%= m.getNombre() %></td>
                        <td><%= m.getMensaje() %></td>
                        <td><%= m.getFecha() %></td>

                        <!-- EDITAR -->
                        <td>
                            <a href="editarMensaje.jsp?id=<%= m.getId() %>" class="btn btn-warning btn-sm">
                                ✏ Editar
                            </a>
                        </td>

                        <!-- ELIMINAR -->
                        <td>
                            <a href="eliminarMensaje.jsp?id=<%= m.getId() %>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Eliminar este mensaje?');">
                                🗑 Eliminar
                            </a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</div>

<%@ include file="includes/footer.jsp" %>


</body>
</html>
