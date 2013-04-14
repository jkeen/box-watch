class BoxWatch.Routers.Main extends Backbone.Router
  initialize: (options) ->
    view = new BoxWatch.Views.App({model: options.shipment})
    $("body").html(view.render().el)
