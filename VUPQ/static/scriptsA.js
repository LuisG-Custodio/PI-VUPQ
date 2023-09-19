/* Event listener para mostrar la ventana emergente del auto */

document.getElementById("btnAgregarAuto").addEventListener("click", function() {
    document.getElementById("autoPopup").style.display = "block";
  });

  function checkOtroOption(selectElement) {
    var otroTipoAutoInput = document.getElementById("otroTipoAuto");
    if (selectElement.value === "otro") {
      otroTipoAutoInput.style.display = "block";
    } else {
      otroTipoAutoInput.style.display = "none";
    }
  }
    