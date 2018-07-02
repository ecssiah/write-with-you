$(document).on 'ready turbolinks:load', ->
  $('#new-button').click -> $('#new-story-modal').css('display', 'block')
  $('#new-story-form').submit (e) -> handle_new_story_form(e, @)
  $(window).click (e) -> exit_new_story_modal(e)

handle_new_story_form = (e, form) ->
  e.preventDefault()
  req = $.post('/stories', $(form).serialize())

exit_new_story_modal = (e) ->
  modal = $('#new-story-modal')

  if e.target is modal[0]
    modal.css('display', 'none')
