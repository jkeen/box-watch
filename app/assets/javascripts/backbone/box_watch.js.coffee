#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./controllers
#= require_tree ./routers

window.BoxWatch =
  Models: {}
  Collections: {}
  Controllers: {}
  Routers: {}
  Views: {}

BoxWatch.app = new Backbone.Marionette.Application()
BoxWatch.app.addRegions container: "#container"
BoxWatch.app.addInitializer (options) ->
  if ($("[data-json]").length > 0)
    @data = JSON.parse($("[data-json]").attr("data-json"))

  @controller = new BoxWatch.Controllers.Main()
  @router = new BoxWatch.Routers.Main({controller: @controller})
  @container.show(new BoxWatch.Views.App())

  @vent.on "search:success", (model) =>
    @router.navigate model.get('tracking_number')


  Backbone.history.start({pushState: true});


BoxWatch.app.addInitializer (options) ->
  if (@data)
    BoxWatch.app.vent.trigger("search:success", new BoxWatch.Models.Shipment(@data))


$(document).ready ->
  BoxWatch.app.start()

