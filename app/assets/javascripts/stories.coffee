$(document).on 'turbolinks:load', ->
  $('#toggle_links').change -> toggle_links(@)
  $('#edit-button').click -> handle_edit_button()
  $('#story-edit-form').submit (e) -> handle_story_edit_form(e, @)
  $('#snippet_color').change (e) -> handle_snippet_color_change(e, @)
  $('#next-button').click -> handle_next_button()
  $('#prev-button').click -> handle_prev_button()
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


window.build_story_index = ->
  req = $.get('/stories.json')    
  req.done (data) -> build_story_elements(data)


build_story_elements = (data) ->
  src = $('#story-entry-template').html() 
  template = Handlebars.compile(src)

  $('.story-list-container').html('')

  for story_data in data
    story = new Story(story_data)

    context = {
      id: story.id,
      title: story.display_title(),
      rank: story.display_rank() 
    }
    
    html = template(context)
    $('#story-list-container').append(html)


handle_edit_button = ->
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


handle_prev_button = ->
  stories_req = $.get('/stories.json')
  users_req = $.get('/users/all')

  $.when(stories_req, users_req).done (stories_data, users_data) ->
    cur_id = parseInt(window.location.pathname.split('/')[2])
    prev_id = null 

    for i in [0...stories_data[0].length]
      if stories_data[0][i].id is cur_id
        if i - 1 >= 0
          prev_id = i - 1

    if prev_id isnt null 
      $('#title').html(stories_data[0][prev_id].title)
      $('#subtitle').html(stories_data[0][prev_id].subtitle)

      creator = users_data[0].find (el) ->
        el.id is stories_data[0][prev_id].creator_id

      $('#creator').html(creator.username)

      window.history.pushState(null, null, '/stories/' + stories_data[0][prev_id].id)


handle_next_button = ->
  stories_req = $.get('/stories.json')
  users_req = $.get('/users/all')

  $.when(stories_req, users_req).done (stories_data, users_data) ->
    cur_id = parseInt(window.location.pathname.split('/')[2])
    next_id = null

    for i in [0...stories_data[0].length]
      if stories_data[0][i].id is cur_id
        if i + 1 < stories_data[0].length
          next_id = i + 1

    if next_id isnt null
      $('#title').html(stories_data[0][next_id].title)
      $('#subtitle').html(stories_data[0][next_id].subtitle)

      creator = users_data[0].find (el) ->
        el.id is stories_data[0][next_id].creator_id

      $('#creator').html(creator.username)

      window.history.pushState(null, null, '/stories/' + stories_data[0][next_id].id)


toggle_links = (checkbox) ->
  display = if checkbox.checked then 'inline' else 'none'
  els = $('.snippet-new')

  for el in els
    el.style.display = display


exit_story_edit_modal = (e) ->
  modal = $('#story-edit-modal') 

  if e.target is modal[0]
    modal.css('display', 'none')

