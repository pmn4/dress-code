var Dress = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks will go here
  }
});

var DressCollection = Backbone.Collection.extend({
  model: Dress
, url: '/womens/categories'
, initialize: function() {
    // Initialization magicks will go here
  }
});

