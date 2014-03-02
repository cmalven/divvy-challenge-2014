Template.timeline.helpers

  foo: ->
    return "You're in the timeline view!"

Template.timeline.events
  'click .foo': (evt) ->
    # Event Callback