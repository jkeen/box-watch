class BoxWatch.Views.Shipment extends Backbone.Marionette.Layout
  template: JST['backbone/templates/shipment']
  regions:
    "locations": ".locations"
  serializeData: ->
    tracking_number: @model.get('tracking_number')
    debug: @model.attributes
  onRender: ->
    @locations.show(new BoxWatch.Views.Locations({collection: @model.locations}))
