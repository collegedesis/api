Ember.Handlebars.registerBoundHelper('markdown', function(value) {
  if (value !== null) {
    var converter = new Showdown.converter({ extensions: ['video'] });
    return new Ember.Handlebars.SafeString(converter.makeHtml(value));
  } else {
    return "";
  }
});