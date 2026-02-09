<%@ page import="com.pesebreNavidad.negocio.Mensaje" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Validar admin
    if (session.getAttribute("usuario") == null || 
        (Integer)session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=No tienes acceso");
        return;
    }

    Mensaje dao = new Mensaje();

    // --- Si el form ya se envió, actualizar ---
    if(request.getParameter("guardar") != null){
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String mensaje = request.getParameter("mensaje");

        Mensaje m = new Mensaje(id, nombre, mensaje);
        dao.actualizar(m);

        response.sendRedirect("mensajesAdmin.jsp?ok=1");
        return;
    }

    // --- Si NO se ha enviado, cargar datos ---
    int id = Integer.parseInt(request.getParameter("id"));
    Mensaje m = dao.obtener(id);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Mensaje</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4">
        <h3 class="mb-4">✏ Editar Mensaje</h3>

        <form method="post">

            <input type="hidden" name="id" value="<%= m.getId() %>">

            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <input type="text" name="nombre" class="form-control" 
                       value="<%= m.getNombre() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Mensaje</label>
                <textarea name="mensaje" class="form-control" rows="4" required><%= m.getMensaje() %></textarea>
            </div>

            <button class="btn btn-primary" name="guardar">Guardar Cambios</button>
            <a href="mensajesAdmin.jsp" class="btn btn-secondary">Cancelar</a>
        </form>

    </div>

</div>

</body>
</html>
