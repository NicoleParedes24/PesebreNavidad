<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Estudiante</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/registro.css">
      <link rel="stylesheet" href="css/footer.css">
</head>

<body class="bg-light">

<div class="fondo-f1-blur"></div>

<%@ include file="includes/menu.jsp" %>

<!-- MENSAJES -->
<div class="container mt-3">
    <% if(request.getParameter("error") != null){ %>
        <div class="alert alert-danger text-center">
            ❌ <%= request.getParameter("error") %>
        </div>
    <% } %>
</div>

<div class="container mt-4">
    <div class="card shadow-lg p-4 mx-auto" style="max-width: 700px;">

        <h2 class="text-center mb-4 text-success fw-bold">
            🎄 Registro de nuevo Estudiante
        </h2>

        <form action="validarRegistro.jsp" method="post">

            <!-- Nombre -->
            <div class="mb-3">
                <label for="txtNombre" class="form-label fw-semibold">Nombre</label>
                <input type="text" class="form-control" id="txtNombre" name="txtNombre" required>
            </div>

            <!-- Cédula -->
            <div class="mb-3">
                <label for="txtCedula" class="form-label fw-semibold">Cédula</label>
                <input type="text" class="form-control" id="txtCedula" name="txtCedula"
                       maxlength="10" minlength="10"
                       pattern="[0-9]{10}"
                       required
                       placeholder="10 dígitos"
                       oninvalid="this.setCustomValidity('La cédula debe tener exactamente 10 dígitos')"
                       oninput="this.setCustomValidity('')">
            </div>

            <!-- Estado Civil -->
            <div class="mb-3">
                <label for="cmbEstado" class="form-label fw-semibold">Estado Civil</label>
                <select class="form-select" id="cmbEstado" name="cmbEstado" required>
                    <option value="">Seleccione...</option>
                    <option>Soltero</option>
                    <option>Casado</option>
                    <option>Divorciado</option>
                </select>
            </div>

            <!-- Residencia -->
           <!-- Residencia -->
<fieldset class="mb-3">
    <legend class="form-label fw-semibold">Lugar de residencia</legend>

    <div class="form-check form-check-inline">
        <input class="form-check-input" id="resSur" type="radio" name="rdResidencia" value="Sur" required>
        <label class="form-check-label" for="resSur">Sur</label>
    </div>

    <div class="form-check form-check-inline">
        <input class="form-check-input" id="resNorte" type="radio" name="rdResidencia" value="Norte">
        <label class="form-check-label" for="resNorte">Norte</label>
    </div>

    <div class="form-check form-check-inline">
        <input class="form-check-input" id="resCentro" type="radio" name="rdResidencia" value="Centro">
        <label class="form-check-label" for="resCentro">Centro</label>
    </div>
</fieldset>
           

            <!-- Fecha nacimiento -->
            <div class="mb-3">
                <label for="mFecha" class="form-label fw-semibold">Mes y año de nacimiento</label>
                <input type="month" class="form-control" id="mFecha" name="mFecha" required>
            </div>

            <!-- Color -->
            <div class="mb-3">
                <label for="cColor" class="form-label fw-semibold">Color favorito</label><br>
                <input type="color" id="cColor" name="cColor" value="#0088ff"
                       class="form-control form-control-color" style="width: 80px;">
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label for="txtEmail" class="form-label fw-semibold">Correo electrónico</label>
                <input type="email" class="form-control" id="txtEmail" name="txtEmail" required>
            </div>

            <!-- Clave -->
            <div class="mb-3">
                <label for="txtClave" class="form-label fw-semibold">Clave</label>
                <input type="password" class="form-control" id="txtClave" name="txtClave" required minlength="8">
            </div>

            <!-- Botones -->
            <div class="text-center mt-4">
                <button type="submit" class="btn btn-success px-4">Registrar</button>
                <button type="reset" class="btn btn-secondary px-4 ms-2">Limpiar</button>
            </div>

        </form>

    </div>
</div>

<%@ include file="includes/footer.jsp" %>

</body>
</html>
