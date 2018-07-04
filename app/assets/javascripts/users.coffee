$(document).on 'turbolinks:load', ->
  $('#new-button').click -> handle_new_button() 
  $('#new-story-form').submit (e) -> handle_new_story_form(e, @) 
  $(window).click (e) -> exit_new_story_modal(e)

class Story
  constructor: (@id, @title, @subtitle, @rank) ->

  display_title: ->
    output = @title
    if @subtitle isnt "" 
      output += ": <em>" + @subtitle + "</em>"
    output

  display_rank: ->
    parseFloat(@rank).toFixed(1)

handle_new_button = ->
  $('#story_snippet_length').val(255)
  $('#new-story-modal').css('display', 'block')

handle_new_story_form = (e, form) ->
  e.preventDefault()
  req = $.post('/stories', $(form).serialize())

  req.done (data) ->
    src = $('#story-entry-template').html() 
    template = Handlebars.compile(src)

    story = new Story(data['id'], data['title'], data['subtitle'], data['rank'])

    context = {
      id: story.id,
      title: new Handlebars.SafeString(story.display_title()),
      rank: story.display_rank() 
    }
    
    html = template(context)
    debugger
    $('.story-list-container').append(html)

    $('#new-story-modal').css('display', 'none')

exit_new_story_modal = (e) ->
  modal = $('#new-story-modal')

  if e.target is modal[0]
    modal.css('display', 'none')

