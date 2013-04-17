class BoxWatch.Routers.Main extends Backbone.Marionette.AppRouter
  controller: BoxWatch.Controllers.Main
  routes:
    "*path": "track"
  track: ->
    console.log("blah")
