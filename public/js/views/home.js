var HomeView = Backbone.View.extend({
  initialize: function(options) {
    var self = this;
    this.secondCollection = options.collection;

    this.collection = new DressCollection();
    this.menswearCategories = new MensWearCategoryCollection();
    this.menswear = new MensWearCollection();

    // Don't render the page until both dresses AND menswear are ready
    var byref = {activeRequests: 0},
        fnSuccess = function() {
          byref.activeRequests--;
          if(!byref.activeRequests) {
            self.render();
          }
        };
    byref.activeRequests++;
    this.collection.fetch({
      success: fnSuccess
    });
    byref.activeRequests++;
    this.menswearCategories.fetch({
      success: fnSuccess
    });
    byref.activeRequests++;
    this.menswear.fetch({
      data: 'q[]=Belts',
      success: fnSuccess
    });

    this.collection.bind('reset', this.render, this);
  }
, render: function() {
    $(this.el).html(this.template());
    var occasions = this.collection['models'][0]['attributes']['occasion'];
    _.each(occasions, function(element, index, list) {
      $('#dresses').append('<li>' + element + '</li>');
    });
    var categories = this.menswearCategories['models'][0]['attributes']['categories'];
    _.each(categories, function(element, index, list) {
      $('#menswear-categories').append('<li>' + element + '</li>');
    });
    var menswear = this.menswear['models'][0]['attributes']['products'];
    $("#menswear").append(_.template($("#tpl-menswear").html(), {styles: menswear}));

    $('#menswear').isotope({
      // options
      itemSelector : '.style-tile-wrapper',
      layoutMode : 'fitRows'
    });

    return this;
  }
});

