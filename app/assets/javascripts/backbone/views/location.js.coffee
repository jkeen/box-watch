class BoxWatch.Views.Location extends Backbone.Marionette.Layout
  template: JST['backbone/templates/location']
  tagName: "li"
  regions:
    events: '.events'
  onRender: ->
    @events.show(new BoxWatch.Views.Events({collection: @model.events }));
