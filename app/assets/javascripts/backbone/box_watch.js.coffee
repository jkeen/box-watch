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
    @app = new BoxWatch.Routers.Main()

$(document).ready ->
  BoxWatch.init()