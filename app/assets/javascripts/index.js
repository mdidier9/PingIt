$(function() {  
// click
  $("#tabs").tabs();

// checkbox
  $( "#check" ).button();
  $( "#format" ).buttonset();

	$('#format :checkbox').click(function() {
        console.log(this.id);
    console.log(findPingasWithCategory(this.id));
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

// slider (not on html currently)

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