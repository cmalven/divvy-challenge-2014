Template.map.helpers

Template.map.rendered = ->
  # Listen for New Trips to be fetched from server
  Trips.find().observe
    added: ->
      if Trips.find().count() % 20 is 0
        PubSub.publish('tripsUpdated')

  # Create the map
  new Map()
  
Template.map.events
  'click .foo': (evt) ->
    # Event Callback