$(window).load(function(){
  // status loading
  $('td.status-load').each(function(index, element){
    $.get($(this).attr('rel'), '', function(req)
    {
      $('.element-' + req['id'] + ' .status-load').html('<img src="' + $('body').attr('root_path') + req.status + '.png" alt="' + req.status + '" />')
      $('.element-' + req['id'] + ' .status-load').attr('detailed', req.log)
    });
  });

  // submit on enter
  $('form.form-stacked input').keypress(function(e)
  {
    if(e.which == 13)
    {
      $(this).closest('form').submit();
      e.preventDefault(); 
      return false;
    }
  });


  // magic with show-hide
  $('.show_detailed').click(function(){
    $(this).closest('form').find('.hidden').toggle();
    return false;
  });
  


});