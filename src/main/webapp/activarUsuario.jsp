<%@ page import="com.pesebreNavidad.seguridad.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String idStr = request.getParameter("id");

    if (idStr == null) {
        response.sendRedirect("adminUsuarios.jsp?error=ID no recibido");
        return;
    }

    int idUsuario = Integer.parseInt(idStr);

    Usuario u = new Usuario();
    boolean ok = u.activarUsuario(idUsuario);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Activando usuario...</title>

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>

<script>
    <% if (ok) { %>
        Swal.fire({
            title: "Usuario Activado",
            text: "El usuario ahora puede acceder nuevamente al sistema.",
            icon: "success",
            confirmButtonText: "Aceptar"
        }).then(() => {
            window.location.href = "adminUsuarios.jsp";
        });
    <% } else { %>
        Swal.fire({
            title: "❌ Error",
            text: "No se pudo activar el usuario.",
            icon: "error",
            confirmButtonText: "Volver"
        }).then(() => {
            window.location.href = "adminUsuarios.jsp";
        });
    <% } %>
</script>

</body>
</html>
