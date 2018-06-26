# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#new-button').click ->
    $('#new-story-dialog').dialog('open')

  $('#new-story-dialog').dialog({
    autoOpen: false,
    modal: true,
    draggable: false,
    resizable: false
  })
