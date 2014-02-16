Meteor.methods

  addStation: (opts) ->
    return Stations.insert opts

  addTrip: (opts) ->
    return Trips.insert opts