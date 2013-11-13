window.DressCodeEvent = Backbone.Model.extend({
  initialize: function() {
    // More TK here
  }
});

window.DressCodeEventCollection = Backbone.Collection.extend({
  model: DressCodeEvent
});

