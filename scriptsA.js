/* Event listener para mostrar la ventana emergente del auto */

document.getElementById("btnAgregarAuto").addEventListener("click", function() {
    document.getElementById("autoPopup").style.display = "block";
  });
  
  /* Event listener para procesar el formulario del auto */
  
  document.getElementById("autoForm").addEventListener("submit", function(event) {
    event.preventDefault();
  
    // Obtener los valores del formulario
    var matricula = document.getElementById("matricula").value;
    var marca = document.getElementById("marca").value;
    var color = document.getElementById("color").value;
    var poliza = document.getElementById("poliza").value;
    var capacidad = document.getElementById("capacidad").value;
    var tipoAuto = document.getElementById("tipoAuto").value;
  
    // Realizar acciones con los datos ingresados, como enviarlos al servidor o procesarlos localmente
  
    // Cerrar la ventana emergente
    document.getElementById("autoPopup").style.display = "none";
  });
  function checkOtroOption(selectElement) {
    var otroTipoAutoInput = document.getElementById("otroTipoAuto");
    if (selectElement.value === "otro") {
      otroTipoAutoInput.style.display = "block";
    } else {
      otroTipoAutoInput.style.display = "none";
    }
  }
    