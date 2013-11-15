var MensWearCategory = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks will go here
  }
});

var Styles = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks will go here
  }
});

var MensWear = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks will go here
  }
});

var MensWearCategoryCollection = Backbone.Collection.extend({
  model: MensWearCategory,
  url: '/mens/categories',
  initialize: function() {
    // Initialization magicks will go here
  }
});

var MensWearCollection = Backbone.Collection.extend({
  model: MensWear,
  url: '/mens',
  initialize: function() {
    // Initialization magicks will go here
  }
});

var Styles = Backbone.Collection.extend({
  model: MensWear,
  url: '/filter',
  initialize: function() {
    // Initialization magicks will go here
  }
});

