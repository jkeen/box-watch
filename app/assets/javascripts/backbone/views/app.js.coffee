class BoxWatch.Views.App extends Backbone.Marionette.Layout
  template: JST['backbone/templates/index']
  modelEvents:
    "search": "load"
  regions:
    "search": ".search-container",
    "body": ".container"
  load: (tracking) ->
    $.getJSON tracking, (data) =>
        model = new BoxWatch.Models.Shipment(data)
        @body.show(new BoxWatch.Views.Shipment({model: model}))
    .fail ->
      console.log("Failure")
  onRender: ->
    @search.show(new BoxWatch.Views.Search({model: @model}))
    @body.show(new BoxWatch.Views.Shipment({model: @model}))
