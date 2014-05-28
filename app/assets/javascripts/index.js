function showPingasAccordingToPrefs () {
    var allBoxes = $('input[type="checkbox"]:not([id^="my_"])');
    for (var i = 0; i < allBoxes.length; i++) {
        var category = allBoxes[i].id;
        if (allBoxes[i].checked) {
            $(".main_list."+category).hide();
        } else {
            $(".main_list."+category).show();
        }
    }
}

$(function() {  

    // viewing preferences default on homepage load
    showPingasAccordingToPrefs();

    // click
    $("#tabs").tabs();
    $("#my_tabs").tabs();
  
	$('#format :checkbox').click(function(event) {
        var $this = $(this);
        if ($this.is(':checked')) {
            var category = this.id;
            $("."+category).hide();
            findPingasWithCategory(this.id).forEach (function(pinga) {
                pinga.setMap(null);
            })
        } else {
            var category = this.id;
            $("."+category).show();
            findPingasWithCategory(this.id).forEach (function(pinga) {
                pinga.setMap(map);
            })
        }
	});

    $('input[id^="my_"]').on('click', function(event){
        console.log("correct item clicked yo");
        var listening = !(event.target.checked);
        var ucId = $(this).val();

        $.ajax({
            url: '/user_categories/' + ucId,
            type: 'PUT',
            data: { new_listening_status: listening},
            dataType: 'json',
            success: function (data) {
                if (data.listening) {
                    // they are listening. we need to uncheck the boxes.
                    $('input[type="checkbox"][id="' + data.category + '"]').prop("checked", false);
                    findPingasWithCategory(data.category).forEach (function(pinga) {
                        pinga.setMap(map);
                    })
                } else {
                    // they are not listening. we need to check the boxes.
                    $('input[type="checkbox"][id="' + data.category + '"]').prop("checked", true);
                    findPingasWithCategory(data.category).forEach (function(pinga) {
                        pinga.setMap(null);
                    })
                }
                showPingasAccordingToPrefs();
            }
        });
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