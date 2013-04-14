class BoxWatch.Views.Search extends Backbone.Marionette.ItemView
  template: JST['backbone/templates/search']
  events:
   "keypress input": "show"
  show: (e) ->
    if (e.keyCode != 13) then return
    @model.trigger("search", $(e.target).val())
  serializeData: ->
    tracking_number: @model.get('tracking_number')
