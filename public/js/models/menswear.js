var MensWearCategory = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks will go here
  }
});

var MensWear = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks will go here
  }
});

var StylesModel = Backbone.Model.extend({
  initialize: function() {
    // Initialization magicks will go here
  }
});

var FiltersModel = Backbone.Model.extend({
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
  model: StylesModel,
  url: '/filter',
  initialize: function() {
    // Initialization magicks will go here
  }
});

var Filters = Backbone.Collection.extend({
  model: FiltersModel,
  url: '/filters',
  initialize: function() {
    // Initialization magicks will go here
  }
});

