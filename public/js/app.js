var Router = Backbone.Router.extend({
  routes: {
    'index.html': 'home'
  }
, initialize: function() {
    // So I decided to just use the Mongo ID alone as the identifier
    // for the route, which means we gotta match on any number
    this.route(/\d+/, 'code');
  }
, home: function() {
    // Instantiate the home view; it'll render after
    // it fetches all the JSON it needs from RTR & Gilt
    // this.homeView = new HomeView({ collection: MensWearCollection });
    this.homeView = new HomeView();
    $('#page-content').html(this.homeView.el);
  }
, code: function() {
    // Show the user his/her event summary (should probably give this a better name)
    this.codeView = new CodeView();
    $('#page-content').html(this.codeView.el);
  }
});

templateLoader.load(['HomeView', 'CodeView'], function() {
  var app = new Router();
  Backbone.history.start({
    // This is apparently necessary for routing to work as intended
    pushState: true
  });
});

$(document).delegate(".style-tile", "click", function() {
  var $this = $(this), $input = $this.find("input"), input = $input.get(0);
  $this.toggleClass("selected", !input.checked);
  $input.prop('checked', !input.checked);
  $("#dress-code-header").toggleClass("submittable", !!($(".style-tile input:checked").length));
});

$("#submit-dress-code").click(function(e) {
  e.preventDefault();

  localStorage.dressCode = $(this).closest("form").serialize();

  window.location.href = "/facebook/login";
});

// Stop default action, let Backbone re-render the view
// $(document).delegate('.btn-filter', 'click', function(e) {
//   e.preventDefault();
// });

