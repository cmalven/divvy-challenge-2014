Meteor.publish 'trips', ->
  return Trips.find()

Meteor.publish 'tripsForDate', (dateString) ->
  splitDate = dateString.split('-')
  startDate = new Date(Number(splitDate[0]), Number(splitDate[1]) - 1, Number(splitDate[2]), 0)
  endDate = new Date()
  endDate.setTime(startDate.getTime())
  endDate.setHours(24)

  chicagoOffset = 5 * 60 * 60000
  userOffset = startDate.getTimezoneOffset() * 60000
  startDate = new Date(startDate.getTime() + userOffset + chicagoOffset)
  endDate = new Date(endDate.getTime() + userOffset + chicagoOffset)

  tripsForDate = Trips.find({starttime: {$gte: startDate.toISOString(), $lt: endDate.toISOString()}})

  return tripsForDate