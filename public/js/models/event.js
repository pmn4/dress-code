var DressCodeEvent = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks TK
  }
});

var DressCodeEventCollection = Backbone.Collection.extend({
  model: DressCodeEvent
, url: '/code'
, initialize: function() {
    // Even more initialization magicks TK
  }
});

