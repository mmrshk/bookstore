$(document).ready(function(){
  if ($('#address_form div div').hasClass('form-group-invalid')) {
    var inputs = document.querySelectorAll(".form-group");
    for(var index in inputs) {
      document.getElementsByClassName('form-group-invalid')[index].classList.add('has-error');
      document.getElementsByClassName('invalid-feedback')[index].style.color = '#d75345';
    }
  }

  if ($('#credit_card_form div div').hasClass('form-group-invalid')) {
    var inputs = document.querySelectorAll(".form-group");
    for(var index in inputs) {
      document.getElementsByClassName('form-group-invalid')[index].classList.add('has-error');
      document.getElementsByClassName('invalid-feedback')[index].style.color = '#d75345';
    }
  }
});
