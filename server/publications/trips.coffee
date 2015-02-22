Meteor.publish 'trips', ->
  return Trips.find()

Meteor.publish 'tripsForDate', (dateString) ->
  splitDate = dateString.split('-')
  startDate = new Date(Number(splitDate[0]), Number(splitDate[1]), Number(splitDate[2]), 0)
  endDate = new Date()
  endDate.setTime(startDate.getTime())
  endDate.setHours(23)
  tripsForDate = Trips.find({starttime: {$gte: startDate.toISOString(), $lt: endDate.toISOString()}})
  console.log 'tripsForDate.count()', tripsForDate.count()
  return tripsForDate