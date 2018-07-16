$(document).one 'turbolinks:load', ->
  build_contribution_styles()

build_contribution_styles = ->
  req = $.get('/contributions/index')

  req.done (data) ->
    user_sheet = document.styleSheets[5]

    for contribution in data
      user_sheet.addRule(
        ".contrib-u" + contribution['user_id'] + "-s" + contribution['story_id'], 
        "color: #" + contribution['color']
      )
