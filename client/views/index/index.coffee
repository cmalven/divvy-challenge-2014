Template.index.helpers

  foo: ->
    return "You're in the index view!"

Template.index.events
  'click .foo': (evt) ->
    # Event Callback