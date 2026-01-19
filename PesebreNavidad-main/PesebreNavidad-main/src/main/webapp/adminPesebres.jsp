<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*,com.pesebreNavidad.datos.*,com.pesebreNavidad.seguridad.*"
	session="true"%>

<%
request.setCharacterEncoding("UTF-8");

HttpSession ses = request.getSession();
Integer perfil = (Integer) ses.getAttribute("perfil");

if (perfil == null || perfil != 1) {
	response.sendRedirect("../login.jsp");
	return;
}

Conexion con = new Conexion();

String action = request.getParameter("action");

if ("registrar".equals(action)) {
	con.Ejecutar("INSERT INTO tb_galeria (carrera, descripcion, imagen) VALUES (" + "'"
	+ request.getParameter("carrera") + "'," + "'" + request.getParameter("descripcion") + "'," + "'"
	+ request.getParameter("imagen") + "')");
}

if ("editar".equals(action)) {
	con.Ejecutar("UPDATE tb_galeria SET " + "carrera='" + request.getParameter("carrera") + "'," + "descripcion='"
	+ request.getParameter("descripcion") + "'," + "imagen='" + request.getParameter("imagen") + "'"
	+ " WHERE id_galeria=" + request.getParameter("id"));
}

if ("eliminar".equals(action)) {
	con.Ejecutar("DELETE FROM tb_galeria WHERE id_galeria=" + request.getParameter("id"));
}

String buscar = request.getParameter("buscar");
String filtro = " WHERE 1=1 ";

if (buscar != null && !buscar.trim().equals("")) {
	filtro += " AND (LOWER(carrera) LIKE LOWER('%" + buscar + "%') OR " + "LOWER(descripcion) LIKE LOWER('%" + buscar
	+ "%')) ";
}

ResultSet rs = con.Consulta("SELECT * FROM tb_galeria " + filtro + " ORDER BY id_galeria ASC");
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestión de Pesebres</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="css/mensajesAdmin.css">
<!-- ESTILOS INTERNOS (INDEPENDIENTES DEL LOGIN Y FOOTER) -->
<style>
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

.contenedor {
	max-width: 900px;
	margin: 40px auto;
	padding: 25px 30px;
	background: white;
	border-radius: 18px;
	box-shadow: 0 4px 18px rgba(0, 0, 0, 0.12);
}

.titulo-estrellas {
	text-align: center;
	font-size: 32px;
	margin-bottom: 25px;
	color: #333;
}

.card-nicole {
	background: #ffffff;
	padding: 20px;
	border-radius: 12px;
	margin-bottom: 25px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.10);
}

.subtitulo-estrellas {
	font-size: 20px;
	margin-bottom: 15px;
	color: #444;
	font-weight: bold;
}

input, textarea {
	width: 100%;
	padding: 10px;
	border-radius: 8px;
	border: 1px solid #ccc;
	margin-bottom: 10px;
	font-size: 14px;
	background: #fafafa;
}

.btn-primario {
	background: #2ecc71;
	color: white;
	padding: 10px 18px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
}

.btn-secundario {
	background: #3498db;
	color: white;
	padding: 8px 16px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
}

.btn-rojo {
	background: #e74c3c;
	color: white;
	padding: 8px 16px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
}

table {
	width: 100%;
	border-collapse: collapse;
	border-radius: 10px;
	overflow: hidden;
	background: white;
}

th {
	background: #f0f0f0;
	padding: 12px;
	text-align: left;
	font-size: 14px;
	border-bottom: 2px solid #e0e0e0;
}

td {
	padding: 10px;
	border-bottom: 1px solid #ececec;
	background: white;
}

tr:hover td {
	background: #fafafa;
}

.preview-img {
	width: 70px;
	height: 60px;
	object-fit: cover;
	border-radius: 6px;
	border: 1px solid #ddd;
	margin-top: 5px;
}
</style>

</head>

<body class="bg-light">

	<div class="fondo-f1-blur"></div>

	<!-- MENÚ NAVIDEÑO -->
	<jsp:include page="includes/menu.jsp" />
	<div class="contenedor">

		<h1 class="titulo-estrellas">✨ Gestión de Pesebres ✨</h1>

		<!-- BUSCAR -->
		<div class="card-nicole">
			<h2 class="subtitulo-estrellas">🔍 Buscar Pesebres</h2>

			<form method="GET">
				<input type="text" name="buscar"
					placeholder="Buscar por carrera o descripción"
					value="<%=buscar != null ? buscar : ""%>">
				<button class="btn-primario">Buscar</button>
			</form>
		</div>

		<!-- REGISTRAR -->
		<div class="card-nicole">
			<h2 class="subtitulo-estrellas">📝 Registrar Pesebre</h2>

			<form method="post">
				<input type="hidden" name="action" value="registrar"> <input
					type="text" name="carrera" placeholder="Carrera" required>

				<textarea name="descripcion" placeholder="Descripción" required></textarea>

				<input type="text" name="imagen"
					placeholder="URL de imagen (PostImage, ImgBB...)" required>

				<button class="btn-primario">Guardar</button>
			</form>
		</div>

		<!-- LISTA -->
		<div class="card-nicole">
			<h2 class="subtitulo-estrellas">📋 Lista de Pesebres</h2>

			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>Carrera</th>
						<th>Descripción</th>
						<th>Imagen</th>
						<th>Acciones</th>
					</tr>
				</thead>

				<tbody>
					<%
					while (rs.next()) {
					%>
					<tr>

						<form method="post">
							<input type="hidden" name="action" value="editar"> <input
								type="hidden" name="id" value="<%=rs.getInt("id_galeria")%>">

							<td><%=rs.getInt("id_galeria")%></td>

							<td><input type="text" name="carrera"
								value="<%=rs.getString("carrera")%>"></td>

							<td><textarea name="descripcion"><%=rs.getString("descripcion")%></textarea></td>

							<td><input type="text" name="imagen"
								value="<%=rs.getString("imagen")%>"> <img
								src="<%=rs.getString("imagen")%>" class="preview-img">
								class="preview-img"></td>

							<td>
								<button class="btn-secundario">Guardar</button>
						</form>

						<form method="post" style="display: inline;"
							onsubmit="return confirm('¿Eliminar este pesebre?');">
							<input type="hidden" name="action" value="eliminar"> <input
								type="hidden" name="id" value="<%=rs.getInt("id_galeria")%>">

							<button class="btn-rojo">Eliminar</button>
						</form>
						</td>

					</tr>
					<%
					}
					%>
				</tbody>
			</table>

		</div>

	</div>

</body>
</html>
