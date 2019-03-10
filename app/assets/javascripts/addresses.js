$(document).ready(function(){
  var checkbox = $('[name="addresses_form[use_billing]"]');

  if (checkbox.is(':checked')){
    $(".autoUpdate").hide();
    $(this).val('TRUE');
  } else {
    $(".autoUpdate").show();
    $(this).val('FALSE');
  }

  $(".checkbox-icon").click(function(){
    $('.autoUpdate').toggle();
  })
});
