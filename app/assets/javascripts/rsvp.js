$(function() {

  $(document).on("click", '.rsvp', function(event){
    userPingaId = /\d*$/.exec(this.id)[0];
    var correctDiv = this;
    var current = $($(this).find(':first-child')).html();
    if (current == "You are not going!") {
      var rsvp = "attending";
      console.log("switch will be to attending");
    } else if (current == "You are going!") {
      var rsvp = "not attending";
      console.log("switch will be to not attending");
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
            $($(correctDiv).find(':first-child')).html("You are going!");
          } else {
            $($(correctDiv).find(':first-child')).html("You are not going!");
          }
        }
      });
    }
  });

});