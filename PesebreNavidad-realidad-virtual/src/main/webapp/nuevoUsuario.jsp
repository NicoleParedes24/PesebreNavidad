<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.pesebreNavidad.seguridad.Usuario" %>

<%
    // 1️⃣ Capturar datos del formulario
    String nombre = request.getParameter("nombre");
    String cedula = request.getParameter("cedula");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");

    int estadoCivil = Integer.parseInt(request.getParameter("estado"));
    int perfil = Integer.parseInt(request.getParameter("perfil"));

    // 2️⃣ Crear objeto usuario
    Usuario u = new Usuario();
    u.setNombre(nombre);
    u.setCedula(cedula);
    u.setCorreo(correo);
    u.setClave(clave);
    u.setEstadoCivil(estadoCivil);
    u.setPerfil(perfil);

    // 3️⃣ Ejecutar registro
    String resultado = u.ingresarUsuarioAdmin();
    boolean ok = resultado.equals("OK");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registrando...</title>

<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>

<script>
    <% if (ok) { %>
        Swal.fire({
            title: "Usuario Registrado",
            text: "El usuario se registró correctamente.",
            icon: "success",
            confirmButtonText: "Aceptar"
        }).then(() => {
            window.location.href = "adminUsuarios.jsp";
        });
    <% } else { %>
        Swal.fire({
            title: "Error",
            text: "No se pudo registrar el usuario. <%= resultado %>",
            icon: "error",
            confirmButtonText: "Volver"
        }).then(() => {
            window.location.href = "adminUsuarios.jsp";
        });
    <% } %>
</script>

</body>
</html>
