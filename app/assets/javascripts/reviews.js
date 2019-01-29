$(document).ready(function () {
  $('input.rate-input').on('click', function() {
     $('.hidden-rate-value').val($(this).data('val'));
  })
});
