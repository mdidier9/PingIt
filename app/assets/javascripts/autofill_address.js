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

  $('#autocomplete').on("change", function() {
    console.log("change here");
  })

  $('form').on("submit", function(event) {
    event.preventDefault();

    var data = {
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