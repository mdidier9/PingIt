$(function() {  

    var allBoxes = $('input[type="checkbox"]:not([id^="my_"])');
    for (var i = 0; i < allBoxes.length; i++) {
        var category = allBoxes[i].id;
        if (allBoxes[i].checked) {
            $("."+category).hide();
        } else {
            $("."+category).show();
        }
    }

// click
    $("#tabs").tabs();
    $("#my_tabs").tabs();
  
// checkbox
  // $( "#check" ).button();
  // $( "#format" ).buttonset();
  // $( "#my_format" ).buttonset();

	$('#format :checkbox').click(function() {
    var $this = $(this);
    if ($this.is(':checked')) {
        console.log(this.id);
        var category = this.id;
        $("."+category).hide();
        findPingasWithCategory(this.id).forEach (function(pinga) {
            pinga.setMap(null);
        })

    } else {
        var category = this.id;
        $("."+category).show();
        console.log(findPingasWithCategory(this.id));
        findPingasWithCategory(this.id).forEach (function(pinga) {
            pinga.setMap(map);
        })
    }
	});

// slider

    $(document).on('click', '#settings', function(event){
        event.preventDefault();
        showSettings();
    });

    function showSettings() {
        newPingaMarker.setMap(null);
//        closeInfos();
        $('#show').css('display', 'none');
        $('#new').css('display', 'none');
        $('#index_list').css('display', 'none');
        $('#show_user').css('display', 'block');
        user_marker.setDraggable (true);
        map.panTo(user_marker.getPosition());
    }

});

function findPingasWithCategory(category) {
    var markers = [];
    for(var index = 0; index < pingaMarkers.length; index++)
    {
        if (pingaMarkers[index].category == category)
        {
            markers.push(pingaMarkers[index]);
        }
    }
    return markers;
}