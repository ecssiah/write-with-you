# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.toggleLinks = (checkbox) ->
  display = if checkbox.checked then 'inline' else 'none'
  els = document.querySelectorAll('.snippet-new')

  for el in els 
    el.style.display = display
