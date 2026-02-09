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
    boolean ok = u.eliminarUsuario(idUsuario);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminando usuario...</title>

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>

<script>
    <% if (ok) { %>
        Swal.fire({
            title: "Usuario Eliminado",
            text: "El usuario fue eliminado correctamente.",
            icon: "success",
            confirmButtonText: "Aceptar"
        }).then(() => {
            window.location.href = "adminUsuarios.jsp";
        });
    <% } else { %>
        Swal.fire({
            title: "❌ Error",
            text: "No se pudo eliminar el usuario.",
            icon: "error",
            confirmButtonText: "Intentar de nuevo"
        }).then(() => {
            window.location.href = "adminUsuarios.jsp";
        });
    <% } %>
</script>

</body>
</html>
