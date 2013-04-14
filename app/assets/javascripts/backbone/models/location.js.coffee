class BoxWatch.Models.Location extends Backbone.Model
  initialize: (options) ->
    @events = new BoxWatch.Collections.Events

class BoxWatch.Collections.Locations extends Backbone.Collection
  model: BoxWatch.Models.Location
  addByEvent: (event) ->
    attrs = {city: event.get('city'), state: event.get('state'), country: event.get('country')}
    location = @findWhere(attrs);
    if location
      location.events.add(event)
    else
      location = new BoxWatch.Models.Location(attrs) unless location
      location.events.add(event)
      @add(location)
