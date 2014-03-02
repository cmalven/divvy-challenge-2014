Template.controls.helpers

  foo: ->
    return "You're in the controls view!"

Template.controls.events
  'click .foo': (evt) ->
    # Event Callback