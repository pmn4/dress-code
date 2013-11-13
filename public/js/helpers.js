// Asynchronously load templates located in different HTML files
var templateLoader = {
  load: function(views, callback) {
    var deferreds = [];
    $.each(views, function(index, view) {
      if (window[view]) {
        deferreds.push($.get('tpl/' + view + '.html', function(data) {
          window[view].prototype.template = _.template(data);
        }, 'html'));
      } else {
        console.log('Error: ' + view + ' not found.');
      }
    });

    $.when.apply(null, deferreds).done(callback);
  }
};

