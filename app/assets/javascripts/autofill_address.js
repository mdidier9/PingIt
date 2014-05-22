var placeSearch, autocomplete;

$(document).on("page:load", function() {

  autocomplete = new google.maps.places.Autocomplete(
      (document.getElementById('autocomplete')),
      { types: ['geocode'] });
  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    fillInAddress();
  });

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }
  
})