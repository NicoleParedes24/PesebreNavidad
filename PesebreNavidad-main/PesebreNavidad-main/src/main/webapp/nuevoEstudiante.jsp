<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="com.pesebreNavidad.seguridad.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registro Estudiante</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<main>

<%
    // ====== 1️⃣ Capturar datos del formulario ======
    String nombre = request.getParameter("txtNombre");
    String cedula = request.getParameter("txtCedula");
    String estadoCivil = request.getParameter("cmbEstado");
    String residencia = request.getParameter("rdResidencia");
    String foto = request.getParameter("fotoNombre");
    String color = request.getParameter("cColor");
    String fecha = request.getParameter("mFecha");
    String correo = request.getParameter("txtEmail");
    String clave = request.getParameter("txtClave");

    // ====== 2️⃣ Crear objeto Usuario y asignar valores ======
    Usuario nuevo = new Usuario();
    nuevo.setNombre(nombre);
    nuevo.setCedula(cedula);
    nuevo.setCorreo(correo);
    nuevo.setClave(clave);

    // Convertir estado civil a número (según tu tabla)
    int estado = 2; // Soltero por defecto
    if ("Casado".equalsIgnoreCase(estadoCivil)) estado = 1;
    else if ("Divorciado".equalsIgnoreCase(estadoCivil)) estado = 3;

    // Asignar el estado civil
    nuevo.setEstadoCivil(estado);

    // Insertar en la base de datos
    String resultado = nuevo.ingresarEstudiante();
%>

<div class="container mt-5">
  <div class="card shadow p-4">
    <h2 class="text-center text-primary mb-4">Datos del Estudiante Registrado</h2>

    <%-- ====== 3️⃣ Mensaje de resultado ====== --%>
    <% if (resultado.equals("OK")) { %>
        <div class="alert alert-success text-center">
            ✅ El estudiante fue registrado correctamente. Serás redirigido al inicio de sesión.
        </div>
        <meta http-equiv="refresh" content="4;url=login.jsp">
    <% } else { %>
        <div class="alert alert-danger text-center">
            ❌ Ocurrió un error al registrar el estudiante: <%= resultado %>
        </div>
    <% } %>

    <%-- ====== 4️⃣ Tabla con datos ingresados ====== --%>
    <table class="table table-bordered mt-4">
      <thead class="table-light">
        <tr>
          <th colspan="2" class="text-center">Información Personal</th>
        </tr>
      </thead>
      <tbody>
        <tr><td><strong>Nombre:</strong></td><td><%= nombre %></td></tr>
        <tr><td><strong>Cédula:</strong></td><td><%= cedula %></td></tr>
        <tr><td><strong>Estado Civil:</strong></td><td><%= estadoCivil %></td></tr>
        <tr><td><strong>Residencia:</strong></td><td><%= residencia %></td></tr>
        <tr><td><strong>Foto:</strong></td><td><u><%= foto %></u></td></tr>
        <tr><td><strong>Fecha de Nacimiento:</strong></td><td><%= fecha %></td></tr>
        <tr><td><strong>Color Favorito:</strong></td><td><font color="<%= color %>">Este es tu color favorito</font></td></tr>
        <tr><td><strong>Correo Electrónico:</strong></td><td><%= correo %></td></tr>
        <tr><td><strong>Clave:</strong></td><td><%= clave %></td></tr>
      </tbody>
    </table>

    <% if (!resultado.equals("OK")) { %>
      <div class="text-center mt-3">
        <a href="registro.jsp" class="btn btn-outline-primary">Volver al Registro</a>
      </div>
    <% } %>

  </div>
</div>

</main>

</body>
</html>
