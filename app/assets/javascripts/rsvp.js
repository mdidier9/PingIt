$(function() {

  $(document).on("click", 'div[class^=rsvp]', function(event){
    userPingaId = /\d*$/.exec(this.id)[0];
    var currentPingaDivClass = $(this).attr("class");
    var current = $($(this).find(':first-child')).html();
    if (current == "You are not going!") {
      var rsvp = "attending";
    } else if (current == "You are going!") {
      var rsvp = "not attending";
    } else {
      var rsvp = null;
    }

    if (rsvp) {
      $.ajax({
        url: '/user_pingas/' + userPingaId,
        type: 'PUT',
        data: { rsvp_status: rsvp},
        dataType: 'json',
        success: function (data) {
          if(data.attending == true) {
            $("."+currentPingaDivClass).html("<p>You are going!</p>");
            // RSVP count += 1 ON ALL VIEWS
          } else {
            $("."+currentPingaDivClass).html("<p>You are not going!</p>");
            // RSVP count -= 1 ON ALL VIEWS
          }
        }
      });
    }
  });

});