$(document).ready(function(){
  $(".read-more").on('click', function(e) {
    e.preventDefault()
    $(this).parent().html('#{escape_javascript @book.description}')
  })
});
