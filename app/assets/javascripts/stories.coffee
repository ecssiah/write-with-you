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

  $('#story-list-container').html('')

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

  reqs = $.when(stories_req, users_req)
  reqs.done (stories_data, users_data) ->
    cur_id = parseInt(window.location.pathname.split('/')[2])
    prev_id = null 

    for i in [0...stories_data[0].length]
      if stories_data[0][i].id is cur_id
        if i - 1 >= 0
          prev_id = i - 1

    if prev_id isnt null 
      update_theme(prev_id, stories_data[0])
      update_header(prev_id, stories_data[0], users_data[0])
      update_body(prev_id, stories_data[0], users_data[0])

      window.history.pushState(null, null, '/stories/' + stories_data[0][prev_id].id)


handle_next_button = ->
  stories_req = $.get('/stories.json')
  users_req = $.get('/users/all')

  reqs = $.when(stories_req, users_req)
  reqs.done (stories_data, users_data) ->
    cur_id = parseInt(window.location.pathname.split('/')[2])
    next_id = null

    for i in [0...stories_data[0].length]
      if stories_data[0][i].id is cur_id
        if i + 1 < stories_data[0].length
          next_id = i + 1

    if next_id isnt null
      update_theme(next_id, stories_data[0])
      update_header(next_id, stories_data[0], users_data[0])
      update_body(next_id, stories_data[0], users_data[0])

      window.history.pushState(null, null, '/stories/' + stories_data[0][next_id].id)


update_theme = (story_id, story_data) ->
  if story_data[story_id].dark_theme
    $('#main-content').attr('class', 'content-container-dark')
    $('#story-edit-dialog').attr('class', 'modal-content modal-dark')
    $('#snippet-dialog').attr('class', 'modal-content modal-dark')
  else
    $('#main-content').attr('class', 'content-container-light')
    $('#story-edit-dialog').attr('class', 'modal-content modal-light')
    $('#snippet-dialog').attr('class', 'modal-content modal-light')

  $('body').css('background-color', '#' + story_data[story_id].color)    


update_header = (story_id, story_data, user_data) ->
  $('#title').html(story_data[story_id].title)

  if story_data[story_id].subtitle?.length
    $('#subtitle').css('display', 'block')
    $('#subtitle').html("<em>" + story_data[story_id].subtitle + "</em>")
  else
    $('#subtitle').css('display', 'none')

  creator = user_data.find (el) ->
    el.id is story_data[story_id].creator_id

  $('#creator').html("by: " + creator.username)

  if window.user_id isnt undefined
    user = user_data.find (el) ->
      el.id is window.user_id

    contrib = user.contributions.find (el) ->
      el.story_id is story_data[story_id].id

    src = $('#story-vote-template').html()
    template = Handlebars.compile(src)
    
    context = { story_id: story_data[story_id].id }

    html = template(context)
    $('#story-ui-container').html(html)

    $('#vote_' + contrib.vote).prop('checked', true)  

    if creator.id is window.user_id
      src = $('#story-buttons-template').html()
      template = Handlebars.compile(src)

      html = template()
      $('#story-buttons-span').html(html)
    else
      $('#story-buttons-span').html('')

    $('#snippet_color')[0].jscolor.fromString(contrib.color)


update_body = (story_id, story_data, users_data) ->
  new_src = $('#story-new-snippet-template').html()
  new_template = Handlebars.compile(new_src)

  snippet_src = $('#story-snippet-template').html()
  snippet_template = Handlebars.compile(snippet_src)

  html = new_template({position: 0})

  req = $.get('/stories/' + story_data[story_id].id + '/body')
  req.done (data) ->
    for snippet in data
      context = {
        current_user: snippet.user.id is window.user_id,
        user_id: snippet.user.id,
        story_id: snippet.story.id,
        snippet_id: snippet.id,
        content: snippet.content,
        position: snippet.position
      }

      if snippet.paragraph_begin then html += "<p>"  
      html += snippet_template(context)
      if snippet.paragraph_end then html += "</p>"  
      html += new_template({position: snippet.position})

    $('#story-body').html(html)


toggle_links = (checkbox) ->
  display = if checkbox.checked then 'inline' else 'none'
  els = $('.snippet-new')

  for el in els
    el.style.display = display


exit_story_edit_modal = (e) ->
  modal = $('#story-edit-modal') 

  if e.target is modal[0]
    modal.css('display', 'none')

