$(document).on 'turbolinks:load', ->
  $('#new-button').click -> handle_new_button() 
  $('#new-story-form').submit (e) -> handle_new_story_form(e, @) 
  $(window).click (e) -> exit_new_story_modal(e)

handle_new_button = ->
  $('#story_snippet_length').val(255)
  $('#new-story-modal').css('display', 'block')

handle_new_story_form = (e, form) ->
  e.preventDefault()
  req = $.post('/stories', $(form).serialize())

  req.done (data) ->
    src = $('#story-entry-template').html() 
    template = Handlebars.compile(src)

    context = {
      rank: data['rank'],
      story_id: data['id'],
      display_title: data['title']
    }
    
    html = template(context)

    $('.story-list-container').append(html)

    debugger

exit_new_story_modal = (e) ->
  modal = $('#new-story-modal')

  if e.target is modal[0]
    modal.css('display', 'none')

