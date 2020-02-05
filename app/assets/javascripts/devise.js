$(document).ready(function(){
  $(".checkbox-icon").click(function(){
    $('.delete-button').attr('disabled', false);
    $('.delete-button').removeClass('disabled');
  })
});
