$.rails.allowAction = (element) ->
  message = element.data('confirm')
  return true unless message
  $link = element.clone()
    .removeAttr('class')
    .removeAttr('data-confirm')
    .addClass('btn').addClass('btn-danger')
    .html("Sim")

  modal_html = """
               <div class="modal" id="myModal">
                 <div class="modal-header">
                   <a class="close" data-dismiss="modal">×</a>
                   <h3>Confirmação</h3>
                 </div>
                 <div class="modal-body">
                   <p style="color: #666">#{message}</p>
                 </div>
                 <div class="modal-footer">
                   <a data-dismiss="modal" class="btn">Não</a>
                 </div>
               </div>
               """
  $modal_html = $(modal_html)
  $modal_html.find('.modal-footer').append($link)
  $modal_html.modal()
  return false