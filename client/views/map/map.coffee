Template.map.helpers

  foo: ->
    return "You're in the map view!"

Template.map.rendered = ->
  rendered = false
  unless rendered
    rendered = true
    # Create the map
    new Map()

    # Update the data when everything is loaded
    PubSub.publish('tripsUpdated')
  
Template.map.events
  'click .foo': (evt) ->
    # Event Callback