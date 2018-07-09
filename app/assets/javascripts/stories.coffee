$(document).on 'turbolinks:load', ->
  $('#toggle_links').change -> toggle_links(@)
  $('#edit-button').click -> handle_edit_button()
  $('#delete-button').click -> handle_delete_button()
  $('#story-edit-form').submit (e) -> handle_story_edit_form(e, @)
  $('#snippet_color').change (e) -> handle_snippet_color_change(e, @)
  $('#next-button').click -> handle_next_button()
  $('#prev-button').click -> handle_prev_button()
  $(window).click (e) -> exit_modal(e)


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


handle_delete_button = ->
  $('#story-delete-modal').css('display', 'block')

  $('#confirm-delete').off().click (e) ->
    req = $.ajax(
      url: window.location.pathname,
      type: 'delete'
    )
    req.done (data) ->
      $('#story-delete-modal').css('display', 'none')

  $('#deny-delete').off().click (e) ->
    $('#story-delete-modal').css('display', 'none')


handle_story_edit_form = (e, form) ->
  e.preventDefault()

  req = $.ajax(
    url: form.action, 
    method: 'patch', 
    data: $(form).serialize() 
  )

  req.done (data) ->
    stories_req = $.get('/stories.json')

    stories_req.done (stories_data) ->
      cur_id = parseInt(window.location.pathname.split('/')[2])
      index = stories_data.findIndex (el) -> el.id is cur_id

      update_theme(index, stories_data)
      update_header(index, stories_data)

      $('#story-edit-modal').css('display', 'none')


handle_snippet_color_change = (e, input) ->
  post_data = {
    contribution: {
      story_id: $(input).data('story-id'),
      user_id: $(input).data('user-id'),
      color: $(input).val()
    }
  }

  success = (data) ->
    contrib = data.contributions.find (el) ->
      el.story_id is post_data.contribution.story_id

    if contrib
      req = $.post('/contributions/update', post_data)
      req.done (data) -> update_rules(data)

  req = $.get('/stories/' + post_data.contribution.story_id + '.json')
  req.done (data) -> success(data)
  

window.update_rules = (data) ->
  selector = '.contrib-u' + data['user_id'] + '-s' + data['story_id']
  sheet = document.styleSheets[5]
  rules = sheet.cssRules

  for i in [0...rules.length]
    index = i if rules[i].selectorText is selector 

  sheet.deleteRule(index) if index
  sheet.addRule(selector, "color: #" + data['color'])


handle_prev_button = ->
  stories_req = $.get('/stories.json')
  users_req = $.get('/users/all')

  reqs = $.when(stories_req, users_req)
  reqs.done (stories_data, users_data) ->
    cur_id = parseInt(window.location.pathname.split('/')[2])
    prev_index = null 

    for i in [0...stories_data[0].length]
      if stories_data[0][i].id is cur_id
        if i - 1 >= 0
          prev_index = i - 1

    if prev_index isnt null 
      update_theme(prev_index, stories_data[0])
      update_header(prev_index, stories_data[0])
      update_ui(prev_index, stories_data[0], users_data[0])
      update_body(prev_index, stories_data[0], users_data[0])
      update_contributors(prev_index, stories_data[0], users_data[0])

      window.history.pushState(null, null, '/stories/' + stories_data[0][prev_index].id)


handle_next_button = ->
  stories_req = $.get('/stories.json')
  users_req = $.get('/users/all')

  reqs = $.when(stories_req, users_req)
  reqs.done (stories_data, users_data) ->
    cur_id = parseInt(window.location.pathname.split('/')[2])
    next_index = null

    for i in [0...stories_data[0].length]
      if stories_data[0][i].id is cur_id
        if i + 1 < stories_data[0].length
          next_index = i + 1

    if next_index isnt null
      update_theme(next_index, stories_data[0])
      update_header(next_index, stories_data[0])
      update_ui(next_index, stories_data[0], users_data[0])
      update_body(next_index, stories_data[0], users_data[0])
      update_contributors(next_index, stories_data[0], users_data[0])

      window.history.pushState(null, null, '/stories/' + stories_data[0][next_index].id)


update_theme = (story_index, story_data) ->
  if story_data[story_index].dark_theme
    $('#main-content').attr('class', 'content-container-dark')
    $('#story-edit-dialog').attr('class', 'modal-content modal-dark')
    $('#story-delete-dialog').attr('class', 'modal-content modal-dark')
    $('#snippet-dialog').attr('class', 'modal-content modal-dark')
  else
    $('#main-content').attr('class', 'content-container-light')
    $('#story-edit-dialog').attr('class', 'modal-content modal-light')
    $('#story-delete-dialog').attr('class', 'modal-content modal-light')
    $('#snippet-dialog').attr('class', 'modal-content modal-light')

  $('body').css('background-color', '#' + story_data[story_index].color)    


update_header = (story_index, story_data) ->
  $('#title').html(story_data[story_index].title)

  if story_data[story_index].subtitle?.length
    $('#subtitle').css('display', 'block')
    $('#subtitle').html("<em>" + story_data[story_index].subtitle + "</em>")
  else
    $('#subtitle').css('display', 'none')

update_ui = (story_index, story_data, user_data) ->
  creator = user_data.find (el) ->
    el.id is story_data[story_index].creator_id

  $('#creator').html("by: " + creator.username)

  if window.user_id isnt undefined
    $('#snippet_color').data('user-id', window.user_id)
    $('#snippet_color').data('story-id', story_data[story_index].id)
    $('#toggle_links').prop('checked', false)

    path = '/stories/' + story_data[story_index].id

    $('#snippet-form').attr('action', path + '/snippets')

    user = user_data.find (el) ->
      el.id is window.user_id

    contrib = user.contributions.find (el) ->
      el.story_id is story_data[story_index].id

    if contrib.vote > 0
      $('#vote_' + contrib.vote).prop('checked', true)  
    else
      $('[name=vote]').removeAttr('checked')

    if contrib.color
      $('#snippet_color')[0].jscolor.fromString(contrib.color)
    else
      $('#snippet_color')[0].jscolor.fromString("FFFFFF")

    if creator.id is window.user_id
      src = $('#story-buttons-template').html()
      template = Handlebars.compile(src)

      html = template()
      $('#story-buttons-span').html(html)
      $('#story-edit-form').attr('action', path)
      $('#story_creator_id').val(story_data[story_index].creator_id)
      $('#story_title').val(story_data[story_index].title)
      $('#story_subtitle').val(story_data[story_index].subtitle)
      $('#story_snippet_length').val(story_data[story_index].snippet_length)
      $('#story_color')[0].jscolor.fromString(story_data[story_index].color)
      $('#story_dark_theme').prop('checked', story_data[story_index].dark_theme)

      $('#edit-button').click -> handle_edit_button()
      $('#delete-button').click -> handle_delete_button()
    else
      $('#story-buttons-span').html('')


window.update_body = (story_index, story_data, users_data) ->
  new_src = $('#story-new-snippet-template').html()
  new_template = Handlebars.compile(new_src)

  snippet_src = $('#story-snippet-template').html()
  snippet_template = Handlebars.compile(snippet_src)

  $('#story-body').html('')

  html = new_template({position: 0})

  req = $.get('/stories/' + story_data[story_index].id + '/body')
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

      if snippet.paragraph_begin then html += "<br><br>"  
      html += snippet_template(context)
      if snippet.paragraph_end then html += "<br><br>"  

      html += new_template({ position: snippet.position + 1 })

    $('#story-body').html(html)
    $('.snippet-new').click (e) -> handle_new_click(e, @)
    $('.snippet-edit').click (e) -> handle_edit_click(e, @)


update_contributors = (story_index, story_data, users_data) ->
  src = $('#story-contributor-template').html()
  template = Handlebars.compile(src)

  html = ""

  for user in users_data
    for contrib in user.contributions
      if contrib.story_id is story_data[story_index].id
        snippet = story_data[story_index].snippets.find (el) -> 
          el.user_id is user.id

        if snippet
          context = {
            user_id: user.id,
            story_id: contrib.story_id,
            contributor: user.username
          }

          html += template(context)  

  if html?.length then html = "<br><hr><h4>Contributors:</h4>" + html

  $('#story-legend-container').html(html)      


toggle_links = (checkbox) ->
  display = if checkbox.checked then 'inline' else 'none'
  els = $('.snippet-new')

  for el in els
    el.style.display = display


exit_modal = (e) ->
  edit_modal = $('#story-edit-modal') 

  if e.target is edit_modal[0]
    edit_modal.css('display', 'none')

  delete_modal = $('#story-delete-modal')

  if e.target is delete_modal[0]
    delete_modal.css('display', 'none')

