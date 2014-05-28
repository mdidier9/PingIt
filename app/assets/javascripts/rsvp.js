$(function() {


  $(document).on("click", 'div[class^=rsvp]', function(event){
    var currentDiv = this;
    var userPingaId = /\d*$/.exec(this.id)[0];
    var currentPingaDivClass = $(this).attr("class");
    var pingaId = /\d*$/.exec(currentPingaDivClass)[0];
    var currentStatus = $($(this).find(':first-child')).html();
    if (currentStatus == "You are not going!") {
      var rsvp = "attending";
    } else if (currentStatus == "You are going!") {
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
          var rsvpSpan = $('span[class=rsvp-count-' + pingaId + ']')
          var currentCount = parseFloat(rsvpSpan.html());
          if(data.attending == true) {
            $("."+currentPingaDivClass).html("<p>You are going!</p>");
            rsvpSpan.html(currentCount+1);
            var newShit = $($($(currentDiv).parent()).clone()).removeClass('main_list');
            $('ul[id=rsvp]').prepend(newShit);
          } else {
            $("."+currentPingaDivClass).html("<p>You are not going!</p>");
            rsvpSpan.html(currentCount-1);
            $("#rsvp .ping." + pingaId).remove();
          }
        }
      });
    }
  });

});