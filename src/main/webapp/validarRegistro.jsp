<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String nombre = request.getParameter("txtNombre");
    String cedula = request.getParameter("txtCedula");
    String estado = request.getParameter("cmbEstado");
    String residencia = request.getParameter("rdResidencia");
    String fecha = request.getParameter("mFecha");
    String color = request.getParameter("cColor");
    String email = request.getParameter("txtEmail");
    String clave = request.getParameter("txtClave");

    // ===== VALIDACIONES =====

    if (nombre == null || nombre.trim().isEmpty()) {
        response.sendRedirect("registro.jsp?error=Debe ingresar un nombre");
        return;
    }

    if (cedula == null || !cedula.matches("\\d{10}")) {
        response.sendRedirect("registro.jsp?error=Ingrese una cedula valida de 10 digitos");
        return;
    }

    if (estado == null || estado.isEmpty()) {
        response.sendRedirect("registro.jsp?error=Seleccione un estado civil");
        return;
    }

    if (residencia == null) {
        response.sendRedirect("registro.jsp?error=Seleccione el lugar de residencia");
        return;
    }

    if (fecha == null || fecha.isEmpty()) {
        response.sendRedirect("registro.jsp?error=Seleccione su fecha de nacimiento");
        return;
    }

    if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
        response.sendRedirect("registro.jsp?error=Ingrese un correo válido");
        return;
    }

    if (clave == null || clave.length() < 8) {
        response.sendRedirect("registro.jsp?error=La clave debe tener al menos 8 caracteres");
        return;
    }

    // ===== SI TODO ESTÁ BIEN =====
    request.setAttribute("nombre", nombre);
    request.setAttribute("cedula", cedula);
    request.setAttribute("estado", estado);
    request.setAttribute("residencia", residencia);
    request.setAttribute("fecha", fecha);
    request.setAttribute("color", color);
    request.setAttribute("email", email);
    request.setAttribute("clave", clave);

    request.getRequestDispatcher("nuevoEstudiante.jsp").forward(request, response);
%>
