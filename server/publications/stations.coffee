Meteor.publish 'stations', ->
  return Stations.find()