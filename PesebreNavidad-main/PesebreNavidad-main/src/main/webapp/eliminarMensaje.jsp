<%@ page import="com.pesebreNavidad.negocio.Mensaje" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Validar admin
    if (session.getAttribute("usuario") == null || 
        (Integer)session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=No tienes acceso");
        return;
    }

    String idParam = request.getParameter("id");

    if(idParam != null){
        int id = Integer.parseInt(idParam);

        Mensaje dao = new Mensaje();
        dao.eliminar(id);  // 🔥 TU MÉTODO DE ELIMINAR EN LA BD
    }

    // Regresar a la lista
    response.sendRedirect("mensajesAdmin.jsp?del=1");
%>
