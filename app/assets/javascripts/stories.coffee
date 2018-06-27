# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load', ->
  modal = $('#edit-story-modal')

  $('#edit-button').click ->
    modal.css('display', 'block')

  $(window).click (e) ->
    if e.target == modal[0]
      modal.css('display', 'none')

  $('#edit-story-form').submit (e) ->
    e.preventDefault()

    values = $(this).serialize() 

    req = $.ajax(
      url: $(this)['context']['action'], 
      method: 'patch',
      data: values
    )

    req.done((data) ->
      console.log(data)
    )

  $('#toggle_links').change ->
    display = if this.checked then 'inline' else 'none'
    els = $('.snippet-new')

    for el in els
      el.style.display = display

# window.toggleLinks = (checkbox) ->
#   display = if checkbox.checked then 'inline' else 'none'
#   els = document.querySelectorAll('.snippet-new')

#   for el in els 
#     el.style.display = display

