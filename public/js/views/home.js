var HomeView = Backbone.View.extend({
  initialize: function(options) {
    this.styles = new Styles();

    this.render();

    var self = this;
    $(document).delegate(".btn-filter", "click", function(e) {
      self.render(e);
    });
    $(document).delegate(".style-tile", "click", function() {
      var $this = $(this), $input = $this.find("input"), input = $input.get(0);
      $this.toggleClass("selected", !input.checked);
      $input.prop('checked', !input.checked);
      $("#dress-code-header").toggleClass("submittable", !!($(".style-tile input:checked").length));
    });
  },
  render: function(e) {
    if(e) e.preventDefault();
    this.$el.html(this.template());

    var self = this;
    AjaxLoading.ajaxing();
    this.styles.fetch({
      data: {"shortlistId": e ? $(e.target).data("shortlistId") : ""},
      success: function() {
        var styles = self.styles['models'][0]['attributes']['styles'];
        if(self.$el.hasClass('isotope')) {
          self.$el.isotope('destroy');
        }
        self.$el.html(_.template($("#tpl-styles").html(), {styles: styles})).isotope({
          itemSelector : '.style-tile-wrapper',
          layoutMode : 'masonry',
          masonry: {
            columnWidth: 125,
            rowHeight: 125
          }
        });
      },
      complete: function() {
        AjaxLoading.ajaxed();
      }
    });

    return this;
  }
});

var FilterView = Backbone.View.extend({
  initialize: function(options) {
    this.filters = new Filters();

    this.render();
  },
  render: function(e) {
    if(e) e.preventDefault();
    var self = this;
    // Don't render the page until both dresses AND menswear are ready
    AjaxLoading.ajaxing();
    this.filters.fetch({
      success: function() {
        var filters = self.filters['models'][0]['attributes']['filters'];
        self.$el.prepend(_.template($("#tpl-filters").html(), {filters: filters})).addClass("initialized");
      },
      complete: function() {
        AjaxLoading.ajaxed();
      }
    });
  }
});