class BoxWatch.Controllers.Main extends Marionette.Controller
  initialize: (options) ->
    BoxWatch.app.vent.on("search", @search, this)
  search: (tracking) ->
    $.getJSON tracking, (data) =>
      model = new BoxWatch.Models.Shipment(data)
      BoxWatch.app.vent.trigger("search:success", model)
    .fail ->
      BoxWatch.app.vent.trigger("search:failure")
