var placeSearch, autocomplete, geocoder;

function initialize() {
  var pingItCoords = JSON.parse($('#pingit-coords').text());
  var lat = pingItCoords.lat
  var lng = pingItCoords.lng
  var map_style = [{featureType:"water",elementType:"geometry",stylers:[{color:"#a2daf2"}]},{featureType:"landscape.man_made",elementType:"geometry",stylers:[{color:"#f7f1df"}]},{featureType:"landscape.natural",elementType:"geometry",stylers:[{color:"#d0e3b4"}]},{featureType:"landscape.natural.terrain",elementType:"geometry",stylers:[{visibility:"off"}]},{featureType:"poi.park",elementType:"geometry",stylers:[{color:"#bde6ab"}]},{featureType:"poi",elementType:"labels",stylers:[{visibility:"off"}]},{featureType:"poi.medical",elementType:"geometry",stylers:[{color:"#fbd3da"}]},{featureType:"poi.business",stylers:[{visibility:"off"}]},{featureType:"road",elementType:"geometry.stroke",stylers:[{visibility:"off"}]},{featureType:"road",elementType:"labels",stylers:[{visibility:"off"}]},{featureType:"road.highway",elementType:"geometry.fill",stylers:[{color:"#ffe15f"}]},{featureType:"road.highway",elementType:"geometry.stroke",stylers:[{color:"#efd151"}]},{featureType:"road.arterial",elementType:"geometry.fill",stylers:[{color:"#ffffff"}]},{featureType:"road.local",elementType:"geometry.fill",stylers:[{color:"black"}]},{featureType:"transit.station.airport",elementType:"geometry.fill",stylers:[{color:"#cfb2db"}]}]

  var mapOptions = {
    zoom: 17,
    center: new google.maps.LatLng(lat, lng),
    styles: map_style // this needs to be the user's location, or the location of the last pinga in an incorrectly submitted form
  };

  var map = new google.maps.Map(document.getElementById('pingit-show-map'),
      mapOptions);

  var geocoder = new google.maps.Geocoder();

  var userMarker = new google.maps.Marker({
    position: map.getCenter(), // this should be the user's location
    map: map,
    title: 'Your current location',
    draggable: true
  });

  google.maps.event.addListener(userMarker, 'dragend', function() {
    var latLng = userMarker.getPosition();
    geocoder.geocode({'latLng': latLng}, function(results, status) {
      $('#autocomplete').val(results[0].formatted_address);
    });
  });

  autocomplete = new google.maps.places.Autocomplete(
    (document.getElementById('autocomplete')),
    { types: ['geocode'] }
  );

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var place = autocomplete.getPlace();
    map.panTo(place.geometry.location);
    map.setZoom(17);
    userMarker.setPosition(place.geometry.location);
    userMarker.setVisible(true);
  });

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  };

  google.maps.event.addListener(map, 'center_changed', function() {
    // 3 seconds after the center of the map has changed, pan back to the
    // marker.
    window.setTimeout(function() {
      map.panTo(userMarker.getPosition());
    }, 3000);
  });

  google.maps.event.addListener(userMarker, 'click', function() {
    map.setZoom(18);
    map.setCenter(userMarker.getPosition());
  });
}

google.maps.event.addDomListener(window, 'load', initialize);