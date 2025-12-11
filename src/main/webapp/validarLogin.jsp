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

    // ────────────────────────────────────────────────
    // VERIFICAR SI EL CORREO EXISTE Y ESTÁ ACTIVO
    // ────────────────────────────────────────────────
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

    // ────────────────────────────────────────────────
    // LOGIN CORRECTO
    // ────────────────────────────────────────────────
    if (loginCorrecto) {
        // GUARDAR EN SESIÓN
        session.setAttribute("usuario", u.getNombre());
        session.setAttribute("perfil", u.getPerfil());
        session.setAttribute("correo", u.getCorreo());
        session.setAttribute("id", u.getId());
        session.setAttribute("id_usuario", u.getId());

        session.setAttribute("nombreUsuario", u.getNombre());

        if (u.getPerfil() == 1) 
            session.setAttribute("rol", "admin");
        else 
            session.setAttribute("rol", "estudiante");


        // ⭐⭐⭐ REGISTRAR EN BITÁCORA: LOGIN ⭐⭐⭐
        try {
			    // SOLO ESTUDIANTES (perfil 2)
			    if (u.getPerfil() == 2) {
			        Usuario au = new Usuario();
			        String nuevo = "{usuario:'" + u.getNombre() + "', accion:'login'}";
			        au.registrarAuditoria("login", "I", null, nuevo, u.getNombre());
			    }
			} catch (Exception e) {
			    System.out.println("❌ Error auditando login: " + e.getMessage());
			}



        // REDIRIGIR SEGÚN EL PERFIL
        if (u.getPerfil() == 1) {
            response.sendRedirect("panelAdmin.jsp");
        } else {
            response.sendRedirect("panelEstudiante.jsp");
        }

    } else {

        // ────────────────────────────────────────────────
        // CASOS DE ERROR
        // ────────────────────────────────────────────────

        if (correoExiste && !estaActivo) {
            response.sendRedirect("login.jsp?error=Su cuenta esta bloqueada. Consulte al administrador.");
        } else {
            response.sendRedirect("login.jsp?error=Correo o clave incorrectos.");
        }
    }
%>
