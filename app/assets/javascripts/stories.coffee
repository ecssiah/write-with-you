# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.toggleNewSnippetLinks = (checkbox) ->
  vis = if checkbox.checked then 'inline' else 'none'
  els = document.querySelectorAll('.new-snippet-link')

  for el in els 
    el.style.display = vis
