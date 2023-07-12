document.getElementById("btnAgregarPersona").addEventListener("click", function() {
    document.getElementById("popup").style.display = "block";
  });
  
  document.getElementById("personaForm").addEventListener("submit", function(event) {
    event.preventDefault();
  
    // Obtener los valores del formulario
    var nombre = document.getElementById("nombre").value;
    var apellidoPaterno = document.getElementById("apellidoPaterno").value;
    var apellidoMaterno = document.getElementById("apellidoMaterno").value;
    var matricula = document.getElementById("matricula").value;
    var telefono = document.getElementById("telefono").value;
    var rol = document.getElementById("rol").value;
  
    // Realizar acciones con los datos ingresados, como enviarlos al servidor o procesarlos localmente
  
    // Cerrar la ventana emergente
    document.getElementById("popup").style.display = "none";
  });
  