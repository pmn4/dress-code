var DressCodeEvent = Backbone.Model.extend({
  initialize: function() {
    console.log('Event model initialized.');
  }
});

var DressCodeEventCollection = Backbone.Collection.extend({
  model: DressCodeEvent
});

