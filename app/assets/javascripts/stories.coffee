$(document).on 'ready turbolinks:load', ->
  $('#toggle_links').change -> toggle_links()
  $('#edit-button').click -> handle_edit_buttton()
  $('#story-edit-form').submit (e) -> handle_story_edit_form(e, @)
  $('#snippet_color').change (e) -> handle_snippet_color_change(e, @)
  $(window).click (e) -> exit_story_edit_modal(e)

handle_edit_buttton = ->
  $('#story-edit-modal').css('display', 'block')

handle_story_edit_form = (e, form) ->
  e.preventDefault()

  req = $.ajax(
    url: this.action, 
    method: 'patch', 
    data: $(form).serialize() 
  )

handle_snippet_color_change = (e, input) ->
  data = {
    contribution: {
      story_id: $(input).data('story-id'),
      user_id: $(input).data('user-id'),
      color: $(input).val()
    }
  }

  req = $.post('/contributions/update', data)

  req.done (data) ->
    $('.contrib-u-' + data['user_id'] + '-s' + data['story_id']).css(
      'color', data['color']
    )
  
toggle_links = ->
  display = if this.checked then 'inline' else 'none'
  els = $('.snippet-new')

  for el in els
    el.style.display = display

exit_story_edit_modal = (e) ->
  modal = $('#story-edit-modal') 

  if e.target is modal[0]
    modal.css('display', 'none')
