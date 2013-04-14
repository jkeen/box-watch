class BoxWatch.Views.Events extends Backbone.Marionette.CompositeView
  template: JST['backbone/templates/events']
  itemView: BoxWatch.Views.Event
  tagName: 'ul'
