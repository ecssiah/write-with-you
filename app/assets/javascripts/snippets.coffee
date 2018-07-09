$(document).on 'turbolinks:load', ->
  $('.snippet-new').click (e) -> handle_new_click(e, @)
  $('.snippet-edit').click (e) -> handle_edit_click(e, @)
  $('#snippet-form').submit (e) -> handle_snippet_form(e, @)
  $('#snippet-delete-button').click (e) -> handle_snippet_delete(e, @)
  $(window).click (e) -> exit_snippet_modal(e)


window.handle_new_click = (e, link) ->
  e.preventDefault()
  $('#new').val(true)
  $('#snippet-modal').css('display', 'block')

  $('#contribution_color').val($('#snippet_color').val())

  $('#snippet_content').val('')
  $('#snippet_position').val($(link).data('position'))
  $('#snippet_paragraph_begin').prop('checked', false)
  $('#snippet_paragraph_end').prop('checked', false)


window.handle_edit_click = (e, link) ->
  e.preventDefault()
  $('#new').val(false)
  $('#snippet-modal').css('display', 'block')
  $('#snippet-delete-button').data('id', $(link).data('id'))

  $('#snippet_position').val($(link).data('position'))

  req = $.get($(link).data('story-id') + '/snippets/' + $(link).data('id'))

  req.done (data) ->
    $('#snippet_id').val($(link).data('id'))
    $('#snippet_content').val(data['content'])
    $('#snippet_paragraph_begin').prop('checked', data['paragraph_begin'])
    $('#snippet_paragraph_end').prop('checked', data['paragraph_end'])


handle_snippet_form = (e, form) ->
  e.preventDefault()

  if $('#new').val() is "true"
    new_snippet_action(form)
  else
    edit_snippet_action(form)


new_snippet_action = (form) ->
  req = $.post(form.action, $(form).serialize())
  req.done (data) ->
    stories_req = $.get('/stories.json')
    users_req = $.get('/users/all')

    update_rules({
      story_id: $('#snippet_story_id').val(),
      user_id: $('#snippet_user_id').val(),
      color: $('#contribution_color').val()
    })

    reqs = $.when(stories_req, users_req)
    reqs.done (stories_data, users_data) ->
      cur_id = parseInt(window.location.pathname.split('/')[2])
      index = stories_data[0].findIndex (el) -> el.id is cur_id

      update_body(index, stories_data[0], users_data[0])

      $('#toggle_links').attr('checked', false)
      $('#snippet-modal').css('display', 'none')


edit_snippet_action = (form) ->
  req = $.ajax(
    url: form.action + '/' + $('#snippet_id').val(), 
    method: 'patch',
    data: $(form).serialize()
  )

  req.done (data) ->
    stories_req = $.get('/stories.json')
    users_req = $.get('/users/all')

    reqs = $.when(stories_req, users_req)
    reqs.done (stories_data, users_data) ->
      cur_id = parseInt(window.location.pathname.split('/')[2])
      index = stories_data[0].findIndex (el) -> el.id is cur_id

      update_body(index, stories_data[0], users_data[0])

      $('#toggle_links').attr('checked', false)
      $('#snippet-modal').css('display', 'none')

handle_snippet_delete = (e, button) ->
  req = $.ajax(
    url: window.location.pathname + '/snippets/' + $(button).data('id'),
    method: 'delete'
  )
  req.done (data) ->
    $('#snippet-modal').css('display', 'none')


exit_snippet_modal = (e) ->
  modal = $('#snippet-modal') 

  if e.target is modal[0] 
    modal.css('display', 'none')

