class BoxWatch.Models.Shipment extends Backbone.Model
  initialize: (options) ->
    @events = new BoxWatch.Collections.Events
    @locations = new BoxWatch.Collections.Locations
    @build()
    @url = "/#{@get('tracking_number')}"
    @poll()

  build: ->
    @events.reset @get('events')
    @events.each (event) =>
      @locations.addByEvent(event)

  poll: ()->
    time = (@get('found?') ? 3000000 : 3000)
    window.clearTimeout(@poller);
    @poller = window.setTimeout =>
      @fetch(update: true)
      @build()
      @poll();
    ,time

class BoxWatch.Collections.Shipments extends Backbone.Collection
  url: '/shipments'
  model: BoxWatch.Models.Shipment
