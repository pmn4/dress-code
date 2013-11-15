var CodeView = Backbone.View.extend({
  initialize: function() {
    var self = this;
    this.collection = new DressCodeEventCollection();
    this.collection.fetch({
      success: function() {
        self.render();
      }
    });
  }
, render: function() {
    $(this.el).html(this.template());
     var eventItem = JSON.parse(this.collection['models'][0]['attributes']['event_data']);
     _.each(eventItem, function(element, index, list) {
       $('#summary').append('<li>' + element + '</li>');
     });

    return this;
  }
});

