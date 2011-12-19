$(function(){
	$('td.status-load').each(function(index, element){
		$.get($(this).attr('rel'), '', function(req)
		{
			$('.element-' + req['id'] + ' .status-load').html(req.status)
			$('.element-' + req['id'] + ' .status-load').attr('detailed', req.log)
		});
	});
});