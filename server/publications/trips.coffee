Meteor.publish 'trips', ->
  return Trips.find()