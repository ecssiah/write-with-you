$(document).on 'ready turbolinks:load', ->
  modal = $('#new-story-modal')

  $('#new-button').click -> modal.css('display', 'block')

  $(window).click (e) ->
    if e.target is modal[0]
      modal.css('display', 'none')

  $('#new-story-form').submit (e) ->
    e.preventDefault()

    data = $(this).serialize() 

    req = $.post('/stories', data)
