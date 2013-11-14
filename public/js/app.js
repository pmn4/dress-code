var Router = Backbone.Router.extend({
  routes: {
    '': 'home'
  }
, initialize: function() {
    // Any special initialization magic will go here
  }
, home: function() {
    // Instantiate the home view; it'll render after
    // it fetches all the JSON it needs from RTR & Gilt
    this.homeView = new HomeView({ collection: MensWearCollection });
    $('#page-content').html(this.homeView.el);
  }
});

templateLoader.load(['HomeView', 'MenswearView'], function() {
  var app = new Router();
  Backbone.history.start();
});

