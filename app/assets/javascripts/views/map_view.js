App.MapView = Ember.View.extend({
  templateName: 'map',

  didInsertElement: function() {
    var _this = this;
    var id = $('#map').attr('id');

    return $('#map').mapSvg(id, {
      source: '/assets/usa.svg',
      cursor: 'pointer',
      loadingText: 'Loading Map...',
      multiSelect: true,
      responsive: true,
      colors: {
        background: '#F7F7E6',
        base: '#4C4440',
        selected: "#A0CC6F",
        hover: "#7ab03e"
      },
      onClick: function(event, map) {
        var stateElement = this,
            state = stateElement.id;
        if (stateElement.attrs.fill == "#A0CC6F") {
          return _this.get('controller').selectState(state);
        } else {
          return _this.get('controller').unselectState(state);
        }
      }
    });
  }
});