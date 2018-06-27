# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load', ->
  modal = $('#new-story-modal')

  $('#new-button').click ->
    modal.css('display', 'block')

  $(window).click (e) ->
    if e.target == modal[0]
      modal.css('display', 'none')

  $('#new-story-form').submit (e) ->
    e.preventDefault()

    values = $(this).serialize() 

    req = $.post('/stories', values)

    # req.done -> modal.css('display', 'none')
