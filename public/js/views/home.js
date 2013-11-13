var HomeView = Backbone.View.extend({
  initialize: function() {
    var self = this;

    // Fetch dress JSON for display
    this.collection = new DressCollection();
    this.collection.fetch({
      success: function(collection) {
        self.render();
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
    return this;
  }
});

