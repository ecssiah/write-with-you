$(document).on 'ready turbolinks:load', ->
  modal = $('#edit-story-modal')

  $('#edit-button').click -> modal.css('display', 'block')

  $(window).click (e) ->
    if e.target is modal[0]
      modal.css('display', 'none')

  $('#edit-story-form').submit (e) ->
    e.preventDefault()

    data = $(this).serialize() 

    req = $.ajax(
      url: this.action, 
      method: 'patch',
      data: data
    )

    req.done((data) ->
      console.log(data)
    )

  $('#toggle_links').change ->
    display = if this.checked then 'inline' else 'none'
    els = $('.snippet-new')

    for el in els
      el.style.display = display
