$(function() { 

	$('#change-start').on("click", function(event){
		event.preventDefault();
		$(this).hide();
		$('#now-default-msg').hide();
		$('#pinga_start_time').show();
		$('#now-start').show();
	});

	$('#now-start').on("click", function(event){
		event.preventDefault();
		$(this).hide();
		$('#pinga_start_time').hide();
		$('#now-default-msg').show();
		$('#change-start').show();
	});
	
	$('#pinga_start_time').on("change", function(){
		var selectedHour = parseFloat($('#pinga_start_time').val());
		var currentHour = (new Date()).getHours();
		var lastValidHour = currentHour - 11;
		if (selectedHour > lastValidHour && selectedHour < currentHour) {
			$('#start-time-validations').html("The start time of your event must be within 12 hours.");
		} else {
			$('#start-time-validations').html("");
		}

		var today = new Date();
		var tomorrow = new Date(today.getTime() + (24 * 60 * 60 * 1000));
		if (selectedHour < currentHour){
			var tomorrowString = /[a-zA-Z]{2,3} [a-zA-Z]* \d{1,2}/.exec(tomorrow);
			$('#today-tomorrow').html("Tomorrow: " + tomorrowString);
		} else {
			var todayString = /[a-zA-Z]{2,3} [a-zA-Z]* \d{1,2}/.exec(today)[0];
			$('#today-tomorrow').html("Today: " + todayString);
		}
	});

});