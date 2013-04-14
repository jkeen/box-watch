class BoxWatch.Models.Event extends Backbone.Model
  initialize: ->
    @location = new BoxWatch.Models.Location({city: @get('city'), state: @get('state'), postal_code: @get('postal_code'), country: @get('country')})


class BoxWatch.Collections.Events extends Backbone.Collection
  model: BoxWatch.Models.Event
  comparator: (event, _event) ->
    first = new Date(event.get('occurred_at'))
    second = new Date(_event.get('occurred_at'))
    first > second
