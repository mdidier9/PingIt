$(function() { 
 $("#form").submit(function(event){
    event.preventDefault();
    $("#errors").empty();
		var title = $('input[name="pinga[title]"]').val();
    var description = $('textarea[name="pinga[description]"]').val();
    var address = $('input[name="pinga[address]"]').val();
		validate_form(title, description, address);
		$("#form").unbind("submit");
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
		$("#form").submit();
	}
}
