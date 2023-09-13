var map;
var polyline;

/* Función para inicializar el mapa */

function initMap() {
  map = L.map('map').setView([0, 0], 2);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors'
  }).addTo(map);

  polyline = L.polyline([], { color: 'red' }).addTo(map);

  map.on('click', function(event) {
    polyline.addLatLng(event.latlng);
    document.getElementById("trayectoria").value = JSON.stringify(polyline.getLatLngs());
  });
}

/* Event listener para mostrar la ventana emergente de la ruta */

document.getElementById("btnAgregarRuta").addEventListener("click", function() {
  document.getElementById("rutaPopup").style.display = "block";
  initMap();
});

