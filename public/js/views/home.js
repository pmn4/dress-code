var HomeView = Backbone.View.extend({
  initialize: function(options) {
    var self = this;
    this.secondCollection = options.collection;

    this.collection = new DressCollection();
    this.secondCollection = new MensWearCollection();

    // Don't render the page until both dresses AND menswear are ready
    this.collection.fetch({
      success: function() {
        self.secondCollection.fetch({
          success: function() {
            self.render();
          }
        });
      }
    });

    this.collection.bind('reset', this.render, this);
  }
, render: function() {
    $(this.el).html(this.template());
    var occasions = this.collection['models'][0]['attributes']['occasion'];
    _.each(occasions, function(element, index, list) {
      $('#dresses').append('<li>' + element + '</li>');
    });
    var categories = this.secondCollection['models'][0]['attributes']['categories'];
    _.each(categories, function(element, index, list) {
      $('#menswear').append('<li>' + element + '</li>');
    });
    return this;
  }
});

