$(function(){
	$('td.status-load').each(function(index, element){
		$.get($(this).attr('rel'), '', function(req)
		{
			$('.element-' + req['id'] + ' .status-load').html('<img src="' + req.status + '.png" />')
			$('.element-' + req['id'] + ' .status-load').attr('detailed', req.log)
		});
	});
});