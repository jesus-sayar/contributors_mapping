$(document).ready(function(){
  if($("#map_canvas").length > 0){
    configure_map();
  }
});

function configure_map(){
  var cartodb_table_name = $("#map_canvas").data("cartodb-table-name");
  var cartodb_username = $("#map_canvas").data("cartodb-username");

  var map = new L.Map('map_canvas', {
    center: [0,0],
    zoom: 2
  });

  // Add layer with basemap
  L.tileLayer('http://{s}.api.cartocdn.com/base-light/{z}/{x}/{y}.png', {
    attribution: 'cartoDB'
  }).addTo(map);
 
 // Add layer with data
  cartodb.createLayer(map, {
    user_name: cartodb_username,
    type: 'cartodb',
    infowindow: true,
    sublayers: [{
      sql: "SELECT * FROM " + cartodb_table_name,
      cartocss: "\
        #rails_rails_contributors { \
          marker-fill-opacity: 0.8; \
          marker-line-color: #555; \
          marker-line-width: 1; \
          marker-line-opacity: 1; \
          marker-placement: point; \
          marker-multi-policy: largest; \
          marker-type: ellipse; \
          marker-fill: #48cfad; \
          marker-allow-overlap: true; \
          marker-clip: false;  \
        } \
        #rails_rails_contributors { \
          marker-width: 10; \
        }"
    }]
  }).addTo(map)
  .done(function(layer) {
    cdb.vis.Vis.addInfowindow(map, layer.getSubLayer(0), ['username', 'location', 'contributions'])
  });
}