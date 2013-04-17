class BoxWatch.Views.App extends Backbone.Marionette.Layout
  template: JST['backbone/templates/index']
  className: 'full-screen'
  regions:
    "search": ".search-container",
    "body": ".content"
  initialize: ->
    BoxWatch.app.vent.on("search:success", @load, this)
    BoxWatch.app.vent.on("search:success", =>
      $(@el).removeClass('full-screen')
    )

    BoxWatch.app.vent.on("search:failure", @load, this)
  load: (model) ->
    @body.show(new BoxWatch.Views.Shipment({ model: model }))
  failure: (model) ->

  onRender: ->
    @search.show(new BoxWatch.Views.Search({model: @model}))
