<%@ page import="com.pesebreNavidad.seguridad.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");

    // Obtener parámetros
    int id = Integer.parseInt(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    String cedula = request.getParameter("cedula");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");
    int estadoCivil = Integer.parseInt(request.getParameter("estadoCivil"));
    int perfil = Integer.parseInt(request.getParameter("perfil"));

    // Crear usuario
    Usuario u = new Usuario();
    u.setId(id);
    u.setNombre(nombre);
    u.setCedula(cedula);
    u.setCorreo(correo);
    u.setClave(clave);
    u.setEstadoCivil(estadoCivil);
    u.setPerfil(perfil);

    boolean actualizado = u.actualizarUsuario();

    if (actualizado) {
        out.println("<script>alert('✅ Usuario actualizado correctamente'); window.location='adminUsuarios.jsp';</script>");
    } else {
        out.println("<script>alert('❌ No se pudo actualizar el usuario'); window.location='adminUsuarios.jsp';</script>");
    }
%>
