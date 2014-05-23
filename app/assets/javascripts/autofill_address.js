var placeSearch, autocomplete;

$(document).on("page:load", function() {

  autocomplete = new google.maps.places.Autocomplete(
      (document.getElementById('autocomplete')),
      { types: ['geocode'] });

  $('#autocomplete').on("change", function() {
    console.log("change here");
  })

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }

});

$(document).ready(function() {

  autocomplete = new google.maps.places.Autocomplete(
    (document.getElementById('autocomplete')),
    { types: ['geocode'] });

  var map = new google.maps.Map(document.getElementById('create-pinga-map'));

  var marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    console.log(place);
    map.setCenter(place.geometry.location);
    map.setZoom(17);
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);
  });

  $('form').on("submit", function(event) {
    event.preventDefault();

    var data = { // form redirection
      title: $($('input#pinga_title')[0]).val(),
      description: $($('#pinga_description')[0]).val(),
      address: $('#autocomplete').val(),
      start_time: $($('#pinga_start_time')[0]).val(),
      end_time: $($('#pinga_end_time')[0]).val()
    };

    $.post('/pingas', data, function(response) {
      console.log("response here!");
      console.log("response");
    });

  });

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }

});