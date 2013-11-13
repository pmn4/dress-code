var Dress = Backbone.Model.extend({
  initialize: function() {
    console.log('Dress model initialized.');
  }
});

var DressCollection = Backbone.Collection.extend({
  model: Dress
, url: '/womens/categories'
});

