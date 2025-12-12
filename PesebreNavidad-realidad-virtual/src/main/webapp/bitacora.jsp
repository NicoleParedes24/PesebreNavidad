<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, com.pesebreNavidad.seguridad.Usuario" %>

<%
    // PROTEGER SOLO ADMIN
    if (session.getAttribute("usuario") == null || (Integer)session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=No tienes acceso");
        return;
    }

    Usuario u = new Usuario();

    String usuarioNombre = (String) session.getAttribute("usuario");

    String filtroTabla = request.getParameter("tabla");
    String filtroOp = request.getParameter("op");
    String filtroFecha = request.getParameter("fecha");

    ResultSet rs = u.filtrarAuditoria(filtroTabla, filtroOp, filtroFecha);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bitácora - Auditoría</title>

<link rel="stylesheet" href="css/adminUsuario.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="css/footer.css">

</head>
<body class="bg-light">


<div class="fondo-f1-blur"></div>
<!-- ⭐ MENÚ (SIN FONDO NAVIDEÑO) -->

 
<%@ include file="includes/menu.jsp" %>

    <!-- Usuario a la derecha -->
<!--     <span class="ms-auto me-4 fw-bold text-white"> -->
<%--         👤 <%= usuarioNombre %> --%>
<!--     </span> -->
</div>


<div class="container mt-5">

    <!-- TÍTULO -->
    <h2 class="mb-4 fw-bold"><i class="bi bi-journal-text"></i> Bitácora del Sistema</h2>

    <!-- FILTROS -->
    <form method="get" class="row g-3 mb-4">

        <!-- TABLA -->
<div class="col-md-4">
    <label for="filtroTabla" class="form-label fw-bold">Tabla</label>
    <select id="filtroTabla" name="tabla" class="form-select">
        <option value="">Todas</option>
        <option value="tb_usuario" <%= "tb_usuario".equals(filtroTabla) ? "selected" : "" %>>tb_usuario</option>
        <option value="mensajes_navidad" <%= "mensajes_navidad".equals(filtroTabla) ? "selected" : "" %>>mensajes_navidad</option>
    </select>
</div>

<!-- OPERACIÓN -->
<div class="col-md-4">
    <label for="filtroOperacion" class="form-label fw-bold">Operación</label>
    <select id="filtroOperacion" name="op" class="form-select">
        <option value="">Todas</option>
        <option value="I" <%= "I".equals(filtroOp) ? "selected" : "" %>>INSERT</option>
        <option value="U" <%= "U".equals(filtroOp) ? "selected" : "" %>>UPDATE</option>
        <option value="D" <%= "D".equals(filtroOp) ? "selected" : "" %>>DELETE</option>
    </select>
</div>

<!-- FECHA -->
<div class="col-md-4">
    <label for="filtroFecha" class="form-label fw-bold">Fecha</label>
    <input id="filtroFecha" type="date" name="fecha"
           value="<%= (filtroFecha != null ? filtroFecha : "") %>"
           class="form-control">
</div>


        <!-- BOTÓN -->
        <div class="col-12 text-end">
            <button class="btn btn-primary px-4">Filtrar</button>
        </div>
    </form>

    <!-- TABLA -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped bg-white text-center align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tabla</th>
                    <th>Operación</th>
                    <th>Valor Anterior</th>
                    <th>Valor Nuevo</th>
                    <th>Fecha</th>
                    <th>Usuario</th>
                </tr>
            </thead>

            <tbody>
            <%
                while (rs != null && rs.next()) {

                    String op = rs.getString("operacion_aud");
                    String opTexto = "SIN OPERACIÓN";

                    if (op != null) {
                        if (op.equals("I")) opTexto = "INSERT";
                        else if (op.equals("U")) opTexto = "UPDATE";
                        else if (op.equals("D")) opTexto = "DELETE";
                    }

                    String badgeColor =
                        (op == null) ? "bg-secondary" :
                        op.equals("I") ? "bg-success" :
                        op.equals("U") ? "bg-warning text-dark" :
                        op.equals("D") ? "bg-danger" : "bg-secondary";

                    // JSON FORMATEADO
                    String jsonAnterior = rs.getString("valoranterior_aud");
                    if (jsonAnterior != null) {
                        jsonAnterior = jsonAnterior.replace(",", ",<br>")
                                                   .replace("{", "{<br>")
                                                   .replace("}", "<br>}");
                    }

                    String jsonNuevo = rs.getString("valornuevo_aud");
                    if (jsonNuevo != null) {
                        jsonNuevo = jsonNuevo.replace(",", ",<br>")
                                             .replace("{", "{<br>")
                                             .replace("}", "<br>}");
                    }
            %>

            <tr>
                <td><%= rs.getInt("id_aud") %></td>

                <td><%= rs.getString("tabla_aud") %></td>

                <td><span class="badge <%= badgeColor %> px-3 py-2"><%= opTexto %></span></td>

                <td style="text-align:left"><div class="json-box"><%= (jsonAnterior == null ? "—" : jsonAnterior) %></div></td>

                <td style="text-align:left"><div class="json-box"><%= (jsonNuevo == null ? "—" : jsonNuevo) %></div></td>

                <td><%= rs.getString("fecha_aud") %></td>

                <td><%= rs.getString("usuario_aud") %></td>
            </tr>

            <% } %>
            </tbody>
        </table>
    </div>

</div>
<%@ include file="includes/footer.jsp" %>
</body>
</html>
