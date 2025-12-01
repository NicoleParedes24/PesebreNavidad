<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Estudiante</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- TU CSS -->
<link rel="stylesheet" href="css/registro.css">

</head>

<body class="bg-light">

	<div class="fondo-f1-blur"></div>
	

	<%@ include file="includes/menu.jsp" %>

    <div class="container d-flex justify-content-center mt-5">

        <div class="card shadow-lg border-0 rounded-4 p-4" style="max-width: 650px; width: 100%;">

            <h2 class="text-center mb-4 text-success fw-bold">
                🎄 Registro de Estudiante
            </h2>

            <form action="nuevoEstudiante.jsp" method="post">

                <!-- Nombre -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Nombre</label>
                    <input type="text" name="txtNombre" class="form-control" required>
                </div>

                <!-- Cédula -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Cédula</label>
                    <input type="text" name="txtCedula" maxlength="10" pattern="\d{10}"
                           class="form-control" placeholder="10 dígitos" required>
                </div>

                <!-- Estado civil -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Estado civil</label>
                    <select name="cmbEstado" class="form-select" required>
                        <option value="">Seleccione...</option>
                        <option>Soltero</option>
                        <option>Casado</option>
                        <option>Divorciado</option>
                        <option>Viudo</option>
                    </select>
                </div>

                <!-- Residencia -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Lugar de residencia</label><br>

                    <div class="form-check form-check-inline">
                        <input type="radio" name="rdResidencia" value="Sur" class="form-check-input" required>
                        <label class="form-check-label">Sur</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" name="rdResidencia" value="Norte" class="form-check-input">
                        <label class="form-check-label">Norte</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" name="rdResidencia" value="Centro" class="form-check-input">
                        <label class="form-check-label">Centro</label>
                    </div>
                </div>

                <!-- Foto -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Foto</label>
                    <input type="file" class="form-control" accept=".jpg,.jpeg,.png">
                </div>

                <!-- Fecha de nacimiento -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Mes y año de nacimiento</label>
                    <input type="month" name="mFecha" class="form-control" required>
                </div>

                <!-- Color favorito -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Color favorito</label><br>
                    <input type="color" name="cColor" value="#0088ff" class="form-control form-control-color" style="width:80px;">
                </div>

                <!-- Email -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Correo electrónico</label>
                    <input type="email" name="txtEmail" class="form-control" required placeholder="usuario@correo.com">
                </div>

                <!-- Clave -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Clave</label>
                    <input type="password" name="txtClave" class="form-control" required minlength="8">
                </div>

                <!-- Botones -->
                <div class="text-center">
                    <button type="submit" class="btn btn-success px-4">Registrar</button>
                    <button type="reset" class="btn btn-outline-secondary px-4 ms-2">Limpiar</button>
                </div>

            </form>

        </div>
    </div>

    <!-- BOOTSTRAP JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- TU JS el mismo q persoanjes -->
<script src="js/registro.js"></script>

</body>
</html>
