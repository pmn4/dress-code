window.HomeView = Backbone.View.extend({
  initialize: function() {
    // Initialization magicks TK
  }
, render: function() {
    $(this.el).html(this.template());
    return this;
  }
});

