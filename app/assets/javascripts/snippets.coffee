$(document).on 'ready turbolinks:load', ->
  $('.snippet-new').click (e) -> handle_new_click(e)
  $('.snippet-edit').click (e) -> handle_edit_click(e, @)
  $('#snippet-form').submit (e) -> handle_snippet_form(e, @)

  $(window).click (e) ->
    modal = $('#snippet-modal') 
    if e.target is modal[0] 
      modal.css('display', 'none')

handle_new_click = (e) ->
  e.preventDefault()
  $('#content').val('')
  $('#new').val(true)
  $('#snippet-modal').css('display', 'block')

handle_edit_click = (e, link) ->
  e.preventDefault()
  $('#new').val(false)
  $('#snippet-modal').css('display', 'block')

  req = $.get($(link).data('story-id') + '/snippets/' + $(link).data('id'))

  req.done (data) ->
    $('#snippet-id').val($(link).data('id'))
    $('#content').val(data['content'])
    $('#paragraph_begin').prop('checked', data['paragraph_begin'])
    $('#paragraph_end').prop('checked', data['paragraph_end'])

handle_snippet_form = (e, form) ->
  e.preventDefault()
  data = $(form).serialize()

  if $('#new').val() is "true"
    new_snippet_action()
  else
    edit_snippet_action()

new_snippet_action = () ->
  console.log("NEW")

edit_snippet_action = () ->
  console.log("EDIT")

  # req = $.ajax(
  #   url: this.action, 
  #   method: 'patch',
  #   data: data
  # )

  # req.done (data) ->
  #   debugger

