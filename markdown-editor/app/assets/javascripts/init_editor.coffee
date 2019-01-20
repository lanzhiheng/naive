document.addEventListener "DOMContentLoaded", (event) ->
  document.querySelectorAll('#page_part_editors textarea').forEach (element) ->
    new SimpleMDE
      element: element
