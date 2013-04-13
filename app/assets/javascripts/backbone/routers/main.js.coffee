class BoxWatch.Routers.Main extends Backbone.Router
  initialize: ->
    view = new BoxWatch.Views.Search()
    $("#container").html(view.render().el)