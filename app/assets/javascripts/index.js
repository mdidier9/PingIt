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
  $("#slider").slider(
    {
      value: 1.0,
      min: 0.5,
      max: 20,
      step: 0.5,
      slide: function(event, ui) {
          $("#slider-value").html(ui.value);
      }
    }
  );
  $("#slider-value").html($('#slider').slider('value'));
});

