var CodeView = Backbone.View.extend({
  initialize: function() {
    var self = this;
    this.collection = new DressCodeEventCollection();
    this.collection.fetch({
      success: function() {
        self.render();
      }
    });
  }
, render: function() {
    $(this.el).html(this.template());
    return this;
  }
});

