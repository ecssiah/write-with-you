$(document).on 'ready turbolinks:load', ->
  modal = $('#snippet-modal')

  $('.snippet-new').click (e) -> 
    modal.css('display', 'block')
    $('#content').val('')
    e.preventDefault()
  
  $('.snippet-edit').click (e) ->
    modal.css('display', 'block')

    req = $.get($(this).data('story-id') + '/snippets/' + $(this).data('id'))

    req.done (data) ->
      $('#content').val(data['content'])
      $('#paragraph_begin').prop('checked', data['paragraph_begin'])
      $('#paragraph_end').prop('checked', data['paragraph_end'])

    e.preventDefault()

  $(window).click (e) ->
    if e.target is modal[0] 
      modal.css('display', 'none')
