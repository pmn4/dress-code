var CodeView = Backbone.View.extend({
  initialize: function() {
    // Grab the ID off the URL and pass it to the collection
    // (this looks up the event with the corresponding Mongo ID)
    var id = window.location.pathname.substring(1)
      , self = this;

    this.collection = new DressCodeEventCollection({id: id});
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

