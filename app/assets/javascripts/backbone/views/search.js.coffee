class BoxWatch.Views.Search extends Backbone.Marionette.ItemView
  template: JST['backbone/templates/search']
  className: 'search'
  events:
   "keypress input": "show"
  initialize: ->
    BoxWatch.app.vent.on("search:success", @updateInput, this)
  updateInput: (model) ->
    $(@el).find('input').val(model.get('tracking_number'))
  show: (e) ->
    if (e.keyCode != 13) then return

    BoxWatch.app.vent.trigger("search", $(e.target).val())
  serializeData: ->
    return {} unless @model

    tracking_number: @model.get('tracking_number')
