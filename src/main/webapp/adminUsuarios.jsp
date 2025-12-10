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
<html lang="es">

<head>
<meta charset="UTF-8">
<title>Administrar Usuarios</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="css/adminUsuario.css">

<link rel="stylesheet" href="css/footer.css">
</head>
<body class="bg-light">
<div class="fondo-f1-blur"></div>

<%@ include file="includes/menu.jsp" %>

<div class="container mt-4">

    

    <!-- CARD FORMULARIO -->
    <div class="card shadow-sm">
        <div class="card-header text-bg-success text-center fw-bold">
            <i class="bi bi-person-plus-fill me-2"></i> Registrar Nuevo Usuario
        </div>

        <div class="card-body">

            <form action="nuevoUsuario.jsp" method="post" class="row g-3 needs-validation" novalidate>

    <!-- Nombre -->
    <div class="col-md-4">
        <label for="nombre" class="form-label">Nombre</label>
        <input id="nombre" type="text" name="nombre" class="form-control" required>
        <div class="invalid-feedback">Ingrese un nombre válido.</div>
    </div>

    <!-- Cédula -->
    <div class="col-md-4">
        <label for="cedula" class="form-label">Cédula</label>
        <input id="cedula" type="text" name="cedula" class="form-control"
               maxlength="10" pattern="\d{10}" required>
        <div class="invalid-feedback">La cédula debe tener 10 números.</div>
    </div>

    <!-- Correo -->
    <div class="col-md-4">
        <label for="correo" class="form-label">Correo</label>
        <input id="correo" type="email" name="correo" class="form-control" required>
        <div class="invalid-feedback">Ingrese un correo válido.</div>
    </div>

    <!-- Clave -->
    <div class="col-md-4">
        <label for="clave" class="form-label">Clave</label>
        <input id="clave" type="password" name="clave" class="form-control" minlength="8" required>
        <div class="invalid-feedback">La clave debe tener mínimo 8 caracteres.</div>
    </div>

    <!-- Estado Civil -->
    <div class="col-md-4">
        <label for="estado" class="form-label">Estado Civil</label>
        <select id="estado" name="estado" class="form-select" required>
            <option value="" disabled selected>Seleccione</option>
            <option value="1">Casado</option>
            <option value="2">Soltero</option>
            <option value="3">Divorciado</option>
        </select>
        <div class="invalid-feedback">Seleccione una opción.</div>
    </div>

    <!-- Perfil -->
    <div class="col-md-4">
        <label for="perfil" class="form-label">Perfil</label>
        <select id="perfil" name="perfil" class="form-select" required>
            <option value="" disabled selected>Seleccione</option>
            <option value="1">Administrador</option>
            <option value="2">Estudiante</option>
        </select>
        <div class="invalid-feedback">Seleccione un perfil.</div>
    </div>

    <!-- BOTONES -->
    <div class="col-12 mt-4 text-center">
        <button class="btn btn-success btn-guardar px-4 fw-bold me-2">
    <span class="text-shadow-fix">
        <i class="bi bi-check-circle-fill text-white"></i> Guardar
    </span>
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
    <a href="editarUsuario.jsp?id=<%=rs.getInt("id_us")%>" 
       class="text-primary"
       aria-label="Editar usuario <%= rs.getString("nombre_us") %>">
        <i class="bi bi-pencil-square fs-5" aria-hidden="true"></i>
        <span class="visually-hidden">Editar</span>
    </a>
</td>

<!-- Bloquear / Activar -->
<td>
    <% if (activo) { %>
        <a href="bloquearUsuario.jsp?id=<%=rs.getInt("id_us")%>" 
           class="text-danger"
           aria-label="Bloquear usuario <%= rs.getString("nombre_us") %>">
            <i class="bi bi-lock-fill fs-5" aria-hidden="true"></i>
            <span class="visually-hidden">Bloquear</span>
        </a>
    <% } else { %>
        <a href="activarUsuario.jsp?id=<%=rs.getInt("id_us")%>" 
           class="text-success"
           aria-label="Activar usuario <%= rs.getString("nombre_us") %>">
            <i class="bi bi-unlock-fill fs-5" aria-hidden="true"></i>
            <span class="visually-hidden">Activar</span>
        </a>
    <% } %>
</td>

<!-- Eliminar -->
<td>
    <a href="eliminarUsuario.jsp?id=<%= rs.getInt("id_us") %>" 
       class="btn btn-danger btn-sm"
       aria-label="Eliminar usuario <%= rs.getString("nombre_us") %>"
       onclick="return confirm('¿Estás segura de eliminar este usuario?');">

        <i class="bi bi-trash" aria-hidden="true"></i>
        <span class="visually-hidden">Eliminar</span>

    </a>
</td>

            </tr>

            <% } %>
        </tbody>
    </table>

</div>
<div id="estrellas-container"></div>
<script src="js/login.js"></script>
<script>
function crearEstrella() {
    const estrella = document.createElement("div");
    estrella.classList.add("estrella");
    estrella.innerHTML = "⭐";

    estrella.style.left = Math.random() * 100 + "vw";
    estrella.style.fontSize = (Math.random() * 24 + 10) + "px";
    estrella.style.animationDuration = (Math.random() * 3 + 4) + "s";

    document.getElementById("estrellas-container").appendChild(estrella);

    setTimeout(() => estrella.remove(), 7000);
}

setInterval(crearEstrella, 300);
</script>
<script>
(() => {
  'use strict'
  const forms = document.querySelectorAll('.needs-validation')

  Array.from(forms).forEach(form => {
    form.addEventListener('submit', event => {
      if (!form.checkValidity()) {
        event.preventDefault()
        event.stopPropagation()
      }
      form.classList.add('was-validated')
    }, false)
  })
})()
</script>

<%@ include file="includes/footer.jsp" %>
</body>
</html>
