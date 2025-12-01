<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
    import="com.pesebreNavidad.seguridad.Usuario, java.sql.*" %>

<%
    // PROTEGER LA PÁGINA — solo Admin (perfil 1)
    if (session.getAttribute("usuario") == null || (Integer)session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=No tienes acceso a esta área");
        return;
    }

    Usuario u = new Usuario();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Administrar Usuarios</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-4">

    <!-- NAV SIMPLE -->
    <nav class="mb-4 text-center">
        <a href="cerrarSesion.jsp" class="me-4 fw-bold text-danger">Cerrar Sesión</a>
        <a href="bitacora.jsp" class="me-4 fw-bold">Bitácora</a>
        <a href="adminUsuarios.jsp" class="fw-bold">Administrar Usuarios</a>
    </nav>

    <!-- CARD FORMULARIO -->
    <div class="card shadow-sm">
        <div class="card-header text-bg-success text-center fw-bold">
            <i class="bi bi-person-plus-fill me-2"></i> Registrar Nuevo Usuario
        </div>

        <div class="card-body">

            <form action="nuevoUsuario.jsp" method="post" class="row g-3">

                <div class="col-md-4">
                    <label class="form-label">Nombre</label>
                    <input type="text" name="nombre" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Cédula</label>
                    <input type="text" name="cedula" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Correo</label>
                    <input type="email" name="correo" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Clave</label>
                    <input type="password" name="clave" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Estado Civil</label>
                    <select name="estado" class="form-select" required>
                        <option value="" disabled selected>Seleccione</option>
                        <option value="1">Casado</option>
                        <option value="2">Soltero</option>
                        <option value="3">Divorciado</option>
                    </select>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Perfil</label>
                    <select name="perfil" class="form-select" required>
                        <option value="" disabled selected>Seleccione</option>
                        <option value="1">Administrador</option>
                        <option value="2">Estudiante</option>
                    </select>
                </div>

                <div class="col-12 mt-4 text-center">
                    <button class="btn btn-success px-4 fw-bold me-2">
                        <i class="bi bi-check-circle-fill"></i> Guardar
                    </button>
                    <a href="adminUsuarios.jsp" class="btn btn-danger px-4 fw-bold">
                        <i class="bi bi-x-circle-fill"></i> Cancelar
                    </a>
                </div>

            </form>

        </div>
    </div>

    <!-- TABLA USUARIOS -->
    <h4 class="text-center mt-5 mb-3 fw-bold">Usuarios Registrados</h4>

    <table class="table table-bordered table-striped text-center shadow-sm bg-white">
        <thead class="table-success">
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Correo</th>
                <th>Estado</th>
                <th>Editar</th>
                <th>Bloquear / Activar</th>
                <th>Eliminar</th>
            </tr>
        </thead>

        <tbody>
            <%
                ResultSet rs = u.listarUsuarios();
                while (rs != null && rs.next()) {
                    boolean activo = rs.getBoolean("activo");
            %>

            <tr>
                <td><%= rs.getInt("id_us") %></td>
                <td><%= rs.getString("nombre_us") %></td>
                <td><%= rs.getString("correo_us") %></td>

                <td>
                    <% if (activo) { %>
                        <span class="badge text-bg-success">Activo</span>
                    <% } else { %>
                        <span class="badge text-bg-danger">Bloqueado</span>
                    <% } %>
                </td>

                <!-- Editar -->
                <td>
                    <a href="editarUsuario.jsp?id=<%=rs.getInt("id_us")%>" class="text-primary">
                        <i class="bi bi-pencil-square fs-5"></i>
                    </a>
                </td>

                <!-- Bloquear / Activar -->
                <td>
                    <% if (activo) { %>
                        <a href="bloquearUsuario.jsp?id=<%=rs.getInt("id_us")%>" class="text-danger">
                            <i class="bi bi-lock-fill fs-5"></i>
                        </a>
                    <% } else { %>
                        <a href="activarUsuario.jsp?id=<%=rs.getInt("id_us")%>" class="text-success">
                            <i class="bi bi-unlock-fill fs-5"></i>
                        </a>
                    <% } %>
                </td>

                <!-- Eliminar -->
                <td>
                    <a href="eliminarUsuario.jsp?id=<%= rs.getInt("id_us") %>" 
				   class="btn btn-danger btn-sm"
				   onclick="return confirm('¿Estás segura de eliminar este usuario?');">
				   <i class="bi bi-trash"></i> 
				</a>

                </td>
            </tr>

            <% } %>
        </tbody>
    </table>

</div>

</body>
</html>
