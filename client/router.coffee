Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'

Router.map ->

  @route 'index',
    path: '/'
    action: ->
      Router.go('/2013-6-27')

  @route 'date',
    path: '/:date'
    template: 'map'
    yieldTemplates:
      'timeline': { to: 'foot' }
    subscriptions: ->
      return [
        Meteor.subscribe('stations')
        Meteor.subscribe('tripsForDate', @params.date)
      ]
    data: ->
      {
        stations: Stations.find()
        trips: Trips.find()
      }

#  @route 'foos_show',
#    path: '/foo/:_id',
#    template: 'foos_show'
#    waitOn: ->
#      return Meteor.subscribe('foos')
#    data: ->
#      return Foos.findOne({_id: @params._id})
