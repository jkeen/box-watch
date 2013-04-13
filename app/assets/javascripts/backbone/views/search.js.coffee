class BoxWatch.Views.Search extends Backbone.View
  template: JST['backbone/templates/index']
  events: {
   "keypress input": "show"
  }
  show: (e) -> 
    if (e.keyCode != 13) then return
      
    this.load($(e.target).val());
  load: (tracking) -> 
    $.getJSON tracking, (data) => 
        model = new BoxWatch.Models.Shipment(data)
        $(@el).append(new BoxWatch.Views.Shipment({model: model}).render().el)  

    .fail ->
      console.log("Failure")
  
  render: ->
    $(@el).html(@template)
    this
    