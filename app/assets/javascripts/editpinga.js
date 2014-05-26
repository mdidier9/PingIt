// $(document).ready(function(){
//   $(document).on("click", '.edit-pinga-link', function(event) {
//     event.preventDefault();
//     $.ajax({
//       url: '/pingas/' + this.id + '/edit',
//       type: 'GET',
//       data: {id: this.id},
//       dataType: "json",
//       success: function (data) {
//         console.log(data);
//         $("#edit-pinga").html(data.edit);
//         $("#edit-pinga").css('display', 'block');
//         $('#show').css('display', 'none');
//         $('#index_list').css('display', 'none');
//         $('#new').css('display', 'none');
//         $('#show_user').css('display', 'none');
//       }
//     });
//   });

//   // not working
//   $(document).on("click", ".update-pinga", function(event){
//     event.preventDefault();
//     data = 
//     $.ajax({
//       url: '/pingas/' + this.id,
//       type: 'put',
//       data: {id: this.id},
//       dataType: "json",
//       success: function (data) {
//         console.log(data);
//         $("#edit-pinga").html(data.edit);
//         $("#edit-pinga").css('display', 'none');
//         $('#show').css('display', 'none');
//         $('#index_list').css('display', 'none');
//         $('#new').css('display', 'none');
//         $('#show_user').css('display', 'none');
//       }
//     });
//   });

// });