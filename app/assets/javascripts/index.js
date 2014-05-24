
// click
$(document).ready(function() {
  $("#tabs").tabs();
});

// mouseover
// $(function() {
//   $( "#tabs" ).tabs({
//     event: "mouseover"
//   });
// });

// checkbox
$(function() {
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
});

