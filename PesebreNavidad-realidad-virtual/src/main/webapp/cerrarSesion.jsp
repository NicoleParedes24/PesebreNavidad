<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pesebreNavidad.seguridad.Usuario" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sesion = request.getSession(false);

    // Obtener usuario antes de invalidar
    String usuario = (sesion != null) ? (String) sesion.getAttribute("usuario") : "Desconocido";

    if (sesion != null) {
        sesion.invalidate();
    }

    // ⭐ Registrar CIERRE DE SESIÓN EN LA BITÁCORA ⭐
    try {
        Usuario u = new Usuario();
        String nuevoValor = "{usuario:'" + usuario + "', accion:'logout'}";
        u.registrarAuditoria("login", "U", null, nuevoValor, usuario);
    } catch (Exception e) {
        System.out.println("❌ Error registrando logout en auditoría: " + e.getMessage());
    }
%>

<jsp:forward page="login.jsp">
    <jsp:param name="error" value="Sesion cerrada correctamente."/>
</jsp:forward>
