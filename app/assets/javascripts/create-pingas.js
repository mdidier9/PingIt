var placeSearch, autocomplete;

var mapLogic = function() {

  var map = new google.maps.Map(document.getElementById('create-pinga-map'));

  var marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  autocomplete = new google.maps.places.Autocomplete(
    (document.getElementById('autocomplete')),
    { types: ['geocode'] }
  );

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    console.log(place);
    map.setCenter(place.geometry.location);
    map.setZoom(17);
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);
  });

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  };

}

$(document).on("page:load", mapLogic);

$(document).ready(mapLogic);