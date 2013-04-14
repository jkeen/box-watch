#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.BoxWatch =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
    @shipment = new BoxWatch.Models.Shipment(JSON.parse($("[data-json]").attr("data-json")))
    @app = new BoxWatch.Routers.Main({shipment: @shipment})

$(document).ready ->
  BoxWatch.init()
