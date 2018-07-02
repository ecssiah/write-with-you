$(document).on 'ready turbolinks:load', ->
  $('#toggle_links').change -> toggle_links()
  $('#edit-button').click -> $('#story-edit-modal').css('display', 'block')
  $('#story-edit-form').submit (e) -> handle_story_edit_form(e, @)
  $(window).click (e) -> exit_story_edit_modal(e)

handle_story_edit_form = (e, form) ->
  e.preventDefault()

  req = $.ajax(
    url: this.action, 
    method: 'patch', 
    data: $(form).serialize() 
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
