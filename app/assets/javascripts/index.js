$(function() {  
// click
  $("#tabs").tabs();

// checkbox
  $( "#check" ).button();
  $( "#format" ).buttonset();

	$('#format :checkbox').click(function() {
    var $this = $(this);
    if ($this.is(':checked')) {
      var category = this.id;
      $("."+category).hide();
    } else {
      var category = this.id;
      $("."+category).show();     
    }
	});

// slider (not on html currently)

});

