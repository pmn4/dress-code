var DressCodeEvent = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks TK
  }
});

var DressCodeEventCollection = Backbone.Collection.extend({
  model: DressCodeEvent
, initialize: function(options) {
    this.id = options.id;
  }
, url: function() {
    return '/code/' + this.id;
  }
});

