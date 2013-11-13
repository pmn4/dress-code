var HomeView = Backbone.View.extend({
  initialize: function() {
    // Fetch dress JSON for display
    this.collection = new DressCollection();
    this.collection.fetch();
    this.collection.bind('reset', this.render, this);

    console.log('Home view initialized.');
  }
, render: function() {
    $(this.el).html(this.template());
    this.collection.each(function(idx, item) {
      $(this.el).append('<ul>' + item.get('lengths') + '</ul>');
    });
    return this;
  }
});

