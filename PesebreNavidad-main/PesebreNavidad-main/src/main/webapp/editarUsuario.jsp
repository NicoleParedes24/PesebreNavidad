<%@ page import="com.pesebreNavidad.datos.Conexion" %>
<%@ page import="com.pesebreNavidad.seguridad.Usuario" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("adminUsuarios.jsp?error=ID no recibido");
        return;
    }

    int idUsuario = Integer.parseInt(idStr);

    Usuario u = new Usuario();
    ResultSet rs = u.listarUsuarios();  // Lista completa

    // Buscar el usuario específico
    ResultSet usuarioRS = null;
    Conexion con = new Conexion();
    usuarioRS = con.Consulta("SELECT * FROM tb_usuario WHERE id_us=" + idUsuario);

    if (!usuarioRS.next()) {
        response.sendRedirect("adminUsuarios.jsp?error=Usuario no encontrado");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">
        <div class="card-header bg-primary text-white fw-bold text-center">
            Editar Usuario
        </div>

        <div class="card-body">

            <form action="actualizarUsuario.jsp" method="post" class="row g-3">

                <input type="hidden" name="id" value="<%= usuarioRS.getInt("id_us") %>">

                <div class="col-md-6">
                    <label class="form-label">Nombre</label>
                    <input type="text" name="nombre" class="form-control"
                           value="<%= usuarioRS.getString("nombre_us") %>" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Cédula</label>
                    <input type="text" name="cedula" class="form-control"
                           value="<%= usuarioRS.getString("cedula_us") %>" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Correo</label>
                    <input type="email" name="correo" class="form-control"
                           value="<%= usuarioRS.getString("correo_us") %>" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Clave</label>
                    <input type="password" name="clave" class="form-control"
                           value="<%= usuarioRS.getString("clave_us") %>" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Estado Civil</label>
                    <select name="estadoCivil" class="form-select" required>
                        <option value="1" <%= usuarioRS.getInt("id_est")==1?"selected":"" %>>Soltero</option>
                        <option value="2" <%= usuarioRS.getInt("id_est")==2?"selected":"" %>>Casado</option>
                        <option value="3" <%= usuarioRS.getInt("id_est")==3?"selected":"" %>>Divorciado</option>
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Perfil</label>
                    <select name="perfil" class="form-select" required>
                        <option value="1" <%= usuarioRS.getInt("id_per")==1?"selected":"" %>>Administrador</option>
                        <option value="2" <%= usuarioRS.getInt("id_per")==2?"selected":"" %>>Estudiante</option>
                    </select>
                </div>

                <div class="col-12 text-center mt-3">
                    <button type="submit" class="btn btn-primary px-4">Guardar Cambios</button>
                    <a href="adminUsuarios.jsp" class="btn btn-secondary px-4">Cancelar</a>
                </div>

            </form>

        </div>
    </div>

</div>

</body>
</html>
