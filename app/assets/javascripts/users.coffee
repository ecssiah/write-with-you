$(document).on 'ready turbolinks:load', ->
  build_contribution_styles()

  $('#new-button').click -> handle_new_button() 
  $('#new-story-form').submit (e) -> handle_new_story_form(e, @) 
  $(window).click (e) -> exit_new_story_modal(e)

handle_new_button = ->
  $('#story_snippet_length').val(255)
  $('#new-story-modal').css('display', 'block')

handle_new_story_form = (e, form) ->
  e.preventDefault()
  req = $.post('/stories', $(form).serialize())

exit_new_story_modal = (e) ->
  modal = $('#new-story-modal')

  if e.target is modal[0]
    modal.css('display', 'none')

build_contribution_styles = ->
  req = $.get('/contributions')

  req.done (data) ->
    user_sheet = document.styleSheets[5]

    for contribution in data
      user_sheet.addRule(
        ".contrib-u" + contribution['user_id'] + "-s" + contribution['story_id'], 
        "color: #" + contribution['color']
      )
