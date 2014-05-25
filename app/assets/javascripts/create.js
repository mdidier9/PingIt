$(function() { 

	$('#pinga_start_time').on("change", function(){
		var selectedHour = parseFloat($('#pinga_start_time').val());
		var currentHour = (new Date()).getHours();
		var lastValidHour = currentHour - 11;
		if (selectedHour > lastValidHour && selectedHour < currentHour) {
			$('#start-time-validations').html("invalid start time!");
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

 $("#form").submit(function(event){
    event.preventDefault();
    $("#errors").empty();
		var title = $('input[name="pinga[title]"]').val();
    var description = $('textarea[name="pinga[description]"]').val();
    var address = $('input[name="pinga[address]"]').val();
		validate_form(title, description, address);
		error_check();
	})
});

function validate_form(title, description, address) {
	if (!/\w+/.exec(title)) {
		$('#errors').append("<li>Please include a title!</li>")
	}
	if (!/\w+/.exec(description)) {
		$('#errors').append("<li>Please include a description!</li>")
	}
	if (!/\w+/.exec(address)) {
		$('#errors').append("<li>Please include an address!</li>")
	}
}

function error_check(){
	if ($("#errors").children().size() === 0){
		$("#form").unbind("submit");
		submit();
	}
}
		
function submit() {
	$("#form").submit();
}