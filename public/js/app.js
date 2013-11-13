window.Router = Backbone.Router.extend({
  routes: {
    '': 'home'
  }
, initialize: function() {
    // Any special initialization magic will go here
  }
, home: function() {
    // Instantiate and render the home view
    this.homeView = new HomeView();
    this.homeView.render();
    $('#page-content').html(this.homeView.el);
  }
});

templateLoader.load(['HomeView'], function() {
  var app = new Router();
  Backbone.history.start();
});

