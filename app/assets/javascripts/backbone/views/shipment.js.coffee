class BoxWatch.Views.Shipment extends Backbone.View
  template: JST['backbone/templates/shipment']
  render: ->
    $(@el).html(@template({tracking_number: @model.get('tracking_number')}))
    this
    