<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.pesebreNavidad.seguridad.Usuario" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");

    Usuario u = new Usuario();

    boolean correoExiste = false;
    boolean estaActivo = false;

    try {
        com.pesebreNavidad.datos.Conexion con = new com.pesebreNavidad.datos.Conexion();
        String sql = "SELECT activo FROM tb_usuario WHERE correo_us='" + correo + "'";
        ResultSet rs = con.Consulta(sql);

        if (rs.next()) {
            correoExiste = true;
            estaActivo = rs.getBoolean("activo");
        }

    } catch (Exception e) {}

    boolean loginCorrecto = u.verificarUsuario(correo, clave);

    if (loginCorrecto) {

        // DATOS NORMALES QUE YA TENÍAS
        session.setAttribute("usuario", u.getNombre());
        session.setAttribute("perfil", u.getPerfil());
        session.setAttribute("correo", u.getCorreo());
        session.setAttribute("id", u.getId());

        // ⭐ NUEVO → Para escribirMensajes.jsp
        session.setAttribute("nombreUsuario", u.getNombre());

        // ⭐⭐ GUARDAR EL ROL PARA EL MENÚ ⭐⭐
        if (u.getPerfil() == 1) { 
            session.setAttribute("rol", "admin");
        } else { 
            session.setAttribute("rol", "estudiante");
        }

        // REDIRECCIÓN NORMAL
        if (u.getPerfil() == 1) {
            response.sendRedirect("panelAdmin.jsp");
        } else {
            response.sendRedirect("panelEstudiante.jsp");
        }

    } else {

        if (correoExiste && !estaActivo) {
            response.sendRedirect("login.jsp?error=Su cuenta esta bloqueada. Consulte al administrador.");
        } else {
            response.sendRedirect("login.jsp?error=Correo o clave incorrectos.");
        }

    }
%>
