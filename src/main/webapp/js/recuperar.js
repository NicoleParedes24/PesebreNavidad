/**
 * 
 */
const formulario = document.getElementById("formEstudiante");

formulario.addEventListener("submit", function(event) {
    const formData = new FormData(formulario);
    const datosFormulario = {};
    for (const [key, value] of formData) {
        datosFormulario[key] = value;
    }

    console.log("Datos del formulario (FormData):", datosFormulario);
    const nombre = document.getElementById("nombre").value;
    const email = document.getElementById("email").value;

    alert("Bienvenido al pesebre Navideño de Computación " + nombre + " " + email);
});