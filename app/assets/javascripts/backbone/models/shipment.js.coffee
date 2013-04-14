class BoxWatch.Models.Shipment extends Backbone.Model
  initialize: (options) ->
    @events = new BoxWatch.Collections.Events
    @locations = new BoxWatch.Collections.Locations
    @build()
    @url = "/#{@get('tracking_number')}"
    @adjustPollTime()
    @poll()

    this.on('change:found?', @adjustPollTime)
  adjustPollTime: ->
     @pollTime = if @get('found?') then 1800000 else 3000
  build: ->
    @events.reset @get('events')
    @events.each (event) =>
      @locations.addByEvent(event)

  poll: ()->
    @poller = window.setTimeout =>
      @fetch(update: true, success: =>
        @build()
        @poll();
      )
    ,@pollTime

class BoxWatch.Collections.Shipments extends Backbone.Collection
  url: '/shipments'
  model: BoxWatch.Models.Shipment
