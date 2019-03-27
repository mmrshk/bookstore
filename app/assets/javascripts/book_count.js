$(document).ready(function(){
  $('.fa-minus').parent('#minus').click(function(event){
    var input_el, quantity;
    event.preventDefault();
    input_el = $(this).siblings('.quantity-input');
    quantity = +input_el.val();
    if (quantity > 1) {
      return input_el.val(quantity - 1);
    }
  });

  $('.fa-plus').parent('#plus').click(function(event) {
    var input_el, quantity;
    event.preventDefault();
    input_el = $(this).siblings('.quantity-input');
    quantity = +input_el.val();
    return input_el.val(quantity + 1);
  });
});
