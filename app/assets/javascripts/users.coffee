$(document).on 'turbolinks:load', ->
  $('#new-button').click -> handle_new_button() 
  $('#new-story-form').submit (e) -> handle_new_story_form(e, @) 
  $('#show_all_contributions').change -> handle_contributions_display(@)
  $(window).click (e) -> exit_new_story_modal(e)

class Story
  constructor: (data) ->
    @id = data['id']
    @title = data['title']
    @subtitle = data['subtitle']
    @rank = data['rank']

  display_title: ->
    output = @title
    if @subtitle isnt "" then output += ": <em>" + @subtitle + "</em>"
    new Handlebars.SafeString(output)

  display_rank: ->
    parseFloat(@rank).toFixed(1)


handle_contributions_display = (checkbox) ->
  if checkbox.checked
    console.log("CHECKED")
  else
    console.log("UNCHECKED")


handle_new_button = ->
  $('#story_snippet_length').val(255)
  $('#new-story-modal').css('display', 'block')


build_new_story_element = (data) ->
  src = $('#story-entry-template').html() 
  template = Handlebars.compile(src)

  story = new Story(data)

  context = {
    id: story.id,
    title: story.display_title(),
    rank: story.display_rank() 
  }
  
  html = template(context)
  $('.story-list-container').append(html)
  $('#new-story-modal').css('display', 'none')


handle_new_story_form = (e, form) ->
  e.preventDefault()
  req = $.post('/stories', $(form).serialize())

  req.done (data) -> build_new_story_element(data)


exit_new_story_modal = (e) ->
  modal = $('#new-story-modal')

  if e.target is modal[0]
    modal.css('display', 'none')

