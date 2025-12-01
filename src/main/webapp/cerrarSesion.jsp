<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sesion = request.getSession(false);

    if (sesion != null) {
        sesion.invalidate();
    }
%>

<jsp:forward page="login.jsp">
    <jsp:param name="error" value="Sesion cerrada correctamente."/>
</jsp:forward>
