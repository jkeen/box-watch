class BoxWatch.Views.Shipment extends Backbone.Marionette.Layout
  className: 'shipment'
  template: JST['backbone/templates/shipment']
  regions:
    "locations": ".locations"
  modelEvents:
    "change": "update"
  serializeData: ->
    tracking_number: @model.get('tracking_number')
  update: ->
    if (@model.get('found?'))
      @locations.show(new BoxWatch.Views.Locations({collection: @model.locations}))
      $(@el).removeClass('loading')
    else if (@model.get('tracking_number'))
      @locations.close()
      $(@el).addClass('loading')
  onRender: ->
    @update()
