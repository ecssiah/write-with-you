$(document).on 'turbolinks:load', ->
  $('#toggle_links').change -> toggle_links(@)
  $('#edit-button').click -> handle_edit_buttton()
  $('#story-edit-form').submit (e) -> handle_story_edit_form(e, @)
  $('#snippet_color').change (e) -> handle_snippet_color_change(e, @)
  $(window).click (e) -> exit_story_edit_modal(e)

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


window.build_index = ->
  req = $.get('/stories.json')    
  req.done (data) ->
    src = $('#story-entry-template').html() 
    template = Handlebars.compile(src)

    for story_data in data
      story = new Story(story_data)

      context = {
        id: story.id,
        title: story.display_title(),
        rank: story.display_rank() 
      }
      
      html = template(context)
      $('.story-list-container').append(html)


handle_edit_buttton = ->
  $('#story-edit-modal').css('display', 'block')


handle_story_edit_form = (e, form) ->
  e.preventDefault()

  req = $.ajax(
    url: form.action, 
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
  req.done (data) -> update_rules(data)
  

update_rules = (data) ->
  selector = '.contrib-u' + data['user_id'] + '-s' + data['story_id']
  sheet = document.styleSheets[5]
  rules = sheet.cssRules

  for i in [0...rules.length]
    if rules[i].selectorText is selector
      sheet.deleteRule(i)
      sheet.addRule(selector, "color: #" + data['color'])


toggle_links = (checkbox) ->
  display = if checkbox.checked then 'inline' else 'none'
  els = $('.snippet-new')

  for el in els
    el.style.display = display


exit_story_edit_modal = (e) ->
  modal = $('#story-edit-modal') 

  if e.target is modal[0]
    modal.css('display', 'none')

