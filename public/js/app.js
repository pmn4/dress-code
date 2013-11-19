var Router = Backbone.Router.extend({
  routes: {
    'index.html': 'home'
  },
  initialize: function() {
    // So I decided to just use the Mongo ID alone as the identifier
    // for the route, which means we gotta match on any number
    this.route(/\d+/, 'code');
  },
  home: function() {
    // Instantiate the home view; it'll render after
    this.homeView = new HomeView({el: $("#styles-container")});
    $('#page-content').html(this.homeView.el);
    this.filterView = new FilterView({el: $("body")});
    $("body").prepend(this.filterView.el);
  },
  code: function() {
    // Show the user his/her event summary (should probably give this a better name)
    this.codeView = new CodeView();
    $('#page-content').html(this.codeView.el);
  }
});

templateLoader.load(['HomeView', 'CodeView', 'FilterView'], function() {
  var app = new Router();
  Backbone.history.start({
    // This is apparently necessary for routing to work as intended
    pushState: true
  });
});

var AjaxLoading = {
  count: 0,
  _toggleClass: function() {
    $("body").toggleClass("ajaxing", !!this.count);
  },
  ajaxing: function() {
    this.count++;
    this._toggleClass();
  },
  ajaxed: function() {
    if(this.count > 0) this.count--;
    this._toggleClass();
  }
};

$("#submit-dress-code").click(function(e) {
  e.preventDefault();

  AjaxLoading.ajaxing();
  localStorage.dressCode = $(this).closest("form").serialize();

  window.location.href = "/facebook/login";
});

$(document).delegate("button.event-dress-code", "click", function(e) {
  e.preventDefault();
  AjaxLoading.ajaxing();
  var fbJson = $(this).val(), fbObj = JSON.parse(fbJson);
  $.post("/facebook/event/" + fbObj['id'] + "/simple", $(this).attr("name") + "=" + fbJson + "&" + localStorage.dressCode).complete(function(jqXhr, status){
    if(status === 'success') {
      localStorage.removeItem('dressCode');
      var url = "https://www.facebook.com/events/" + fbObj['id'];
      window.location.href = url;
    } else {
      if(console && typeof(console.log) === 'function') {
        console.log('failed to post simple facebook update.', jqXhr.statusText, jqXhr.responseText, arguments);
      }
    }
    AjaxLoading.ajaxed();
  });
});
