// function initialize() {
//     var mapOptions = {
//         zoom: 4,
//         center: new google.maps.LatLng(-25.363882, 131.044922)
//     };

//     var map = new google.maps.Map(document.getElementById('map'),
//         mapOptions);

//     var marker = new google.maps.Marker({
//         position: map.getCenter(),
//         map: map,
//         title: 'Click to zoom'
//     });

//     google.maps.event.addListener(map, 'center_changed', function() {
//         // 3 seconds after the center of the map has changed, pan back to the
//         // marker.
//         window.setTimeout(function() {
//             map.panTo(marker.getPosition());
//         }, 3000);
//     });

//     google.maps.event.addListener(marker, 'click', function() {
//         map.setZoom(8);
//         map.setCenter(marker.getPosition());
//     });
// }

// google.maps.event.addDomListener(window, 'load', initialize);

//map_style = [{featureType:"water",elementType:"geometry",stylers:[{color:"#a2daf2"}]},{featureType:"landscape.man_made",elementType:"geometry",stylers:[{color:"#f7f1df"}]},{featureType:"landscape.natural",elementType:"geometry",stylers:[{color:"#d0e3b4"}]},{featureType:"landscape.natural.terrain",elementType:"geometry",stylers:[{visibility:"off"}]},{featureType:"poi.park",elementType:"geometry",stylers:[{color:"#bde6ab"}]},{featureType:"poi",elementType:"labels",stylers:[{visibility:"off"}]},{featureType:"poi.medical",elementType:"geometry",stylers:[{color:"#fbd3da"}]},{featureType:"poi.business",stylers:[{visibility:"off"}]},{featureType:"road",elementType:"geometry.stroke",stylers:[{visibility:"off"}]},{featureType:"road",elementType:"labels",stylers:[{visibility:"off"}]},{featureType:"road.highway",elementType:"geometry.fill",stylers:[{color:"#ffe15f"}]},{featureType:"road.highway",elementType:"geometry.stroke",stylers:[{color:"#efd151"}]},{featureType:"road.arterial",elementType:"geometry.fill",stylers:[{color:"#ffffff"}]},{featureType:"road.local",elementType:"geometry.fill",stylers:[{color:"black"}]},{featureType:"transit.station.airport",elementType:"geometry.fill",stylers:[{color:"#cfb2db"}]}]
//map_options = { maxZoom: 15, styles: map_style };
//handler = Gmaps.build('Google');
//handler.buildMap({ provider: map_options, internal: {id: 'map'} }, function(){
////        SETS USER MARKER
//
//    user_marker = handler.addMarkers(<%= raw @user_marker.to_json %>, {draggable: true});
//
//    //        SETS USER RADIUS
//    user_radius = [{lng: <%= @user.longitude %>, lat: <%= @user.latitude %>, radius: <%= @user.listening_radius * 1609.344 %>  }];
//    radius_options = { strokeColor:"#0000FF",strokeOpacity: 1, strokeWeight: 0, fillColor: '#007d53' };
//
//
//    //        FILLS MAP WITH USER, RADIUS, AND PINGAS
//    handler.addCircles(user_radius, radius_options);
//    //        SETS PINGA MARKERS
//    active_pingas = handler.addMarkers(<%=raw @active_pinga_markers.to_json %>);
//        pending_pingas = handler.addMarkers(<%=raw @pending_pinga_markers.to_json %>);
//            grey_pingas = handler.addMarkers(<%=raw @grey_pinga_markers.to_json %>);
//
//                handler.bounds.extendWith(active_pingas);
//                handler.bounds.extendWith(pending_pingas);
//                handler.bounds.extendWith(user_marker);
//
//                handler.fitMapToBounds();
//                //        CENTERS ON USER
//                handler.map.centerOn({ lat: <%= @user.latitude %>, lng: <%= @user.longitude %> });
//
//                google.maps.event.addListener(user_marker[0].getServiceObject(), "dragend", function(event) {
//            $.ajax({
//                url: '/users/' + <%= @user.id %>,
//                type: 'PUT',
//                data: {latitude: event.latLng.k, longitude: event.latLng.A},
//                dataType: 'json',
//                success: function (data) {
//                    console.log(data);
//                    handler.addMarkers(data);
////                    handler.map.removeCircle();
//                    handler.map.centerOn({ lat: event.latLng.k, lng: event.latLng.A });
//                }
//            });
//        });
//    });