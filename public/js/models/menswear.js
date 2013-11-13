var MensWear = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks will go here
  }
});

var MensWearCollection = Backbone.Collection.extend({
  model: MensWear
, url: '/mens/categories'
, initialize: function() {
    // Initialization magicks will go here
  }
});

