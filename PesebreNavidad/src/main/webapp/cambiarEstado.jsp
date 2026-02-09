<%@ page import="com.pesebreNavidad.negocio.Mensaje" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    boolean nuevoEstado = request.getParameter("estado").equals("1");

    Mensaje m = new Mensaje();
    m.cambiarEstado(id, nuevoEstado);

    response.sendRedirect("mensajesAdmin.jsp?ok=1");
%>
