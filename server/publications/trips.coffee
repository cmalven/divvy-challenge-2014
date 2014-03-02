Meteor.publish 'trips', ->
  start = new Date(2013, 5, 27).toISOString()
  end = new Date(2013, 5, 29).toISOString()
  allTrips = Trips.find({starttime: {$gte: start, $lt: end}})
  console.log 'allTrips.count()', allTrips.count()
  return allTrips